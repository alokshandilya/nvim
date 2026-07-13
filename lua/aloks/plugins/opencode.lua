local function staged_diff()
  local diff = vim.fn.system({ "git", "diff", "--cached" })

  if vim.v.shell_error ~= 0 or diff == "" then
    diff = vim.fn.system({ "git", "diff" })
  end

  return diff
end

local function commit_prompt(diff)
  local lines = vim.split(diff, "\n")
  local changed_lines = 0
  for _, line in ipairs(lines) do
    if (line:sub(1, 1) == "+" and line:sub(1, 3) ~= "+++") or (line:sub(1, 1) == "-" and line:sub(1, 3) ~= "---") then
      changed_lines = changed_lines + 1
    end
  end

  local prompt_body
  if changed_lines > 20 then
    prompt_body = "Include a detailed body describing the changes."
      .. " If there are several distinct changes, write the body as bullet points"
      .. " starting with '- '; if there is only one change, use a short prose"
      .. " paragraph instead."
  else
    prompt_body = "Include a short body only if it adds useful context;"
      .. " omit it entirely if the subject line is self-explanatory."
  end

  return table.concat({
    "Write a concise Conventional Commit message for this diff:",
    diff,
    "Return only the commit message, nothing else (no explanation, no code fences).",
    "The subject line MUST follow the format: type(optional scope): description",
    "where type is one of: feat, fix, refactor, perf, docs, style, test, build, ci, chore.",
    "Use imperative mood, lowercase description, and no trailing period.",
    "Keep the subject line under 50 characters.",
    "Leave one blank line between the subject and the body.",
    "In the body, wrap lines at 72 characters.",
    prompt_body,
  }, "\n\n")
end

local function generate_commit_message()
  local diff = staged_diff()

  if diff == "" then
    vim.notify("No staged or unstaged git diff found", vim.log.levels.WARN, { title = "claude" })
    return
  end

  vim.notify("Generating commit message...", vim.log.levels.INFO, { title = "claude" })

  vim.system(
    { "claude", "-p", "--model", "sonnet" },
    { text = true, stdin = commit_prompt(diff) },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify(result.stderr or "Failed to generate commit message", vim.log.levels.ERROR, { title = "claude" })
          return
        end

        local message = vim.trim(result.stdout or "")

        if message == "" then
          vim.notify("Claude returned an empty commit message", vim.log.levels.WARN, { title = "claude" })
          return
        end

        vim.fn.setreg("+", message)
        vim.fn.setreg('"', message)
        vim.notify("Commit message copied to clipboard", vim.log.levels.INFO, { title = "claude" })
      end)
    end
  )
end

-- Module-level so the keys callbacks can reference it after config() runs
local opencode_terminal

return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    "akinsho/toggleterm.nvim",
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
      },
    },
  },
  keys = {
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ")
      end,
      mode = { "n", "x" },
      desc = "Ask opencode",
    },
    {
      "<leader>ox",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Execute opencode action",
    },
    {
      "<leader>ot",
      function()
        if opencode_terminal then
          opencode_terminal:toggle(math.floor(vim.o.columns * 0.45), "vertical")
        end
      end,
      mode = "n",
      desc = "Toggle opencode",
    },
    {
      "<leader>or",
      function()
        return require("opencode").operator("@this ")
      end,
      mode = { "n", "x" },
      expr = true,
      desc = "Add range to opencode",
    },
    {
      "<leader>ol",
      function()
        return require("opencode").operator("@this ") .. "_"
      end,
      mode = "n",
      expr = true,
      desc = "Add line to opencode",
    },
    {
      "<leader>ou",
      function()
        require("opencode").command("session.half.page.up")
      end,
      mode = "n",
      desc = "Scroll opencode up",
    },
    {
      "<leader>od",
      function()
        require("opencode").command("session.half.page.down")
      end,
      mode = "n",
      desc = "Scroll opencode down",
    },
    {
      "<leader>oc",
      generate_commit_message,
      mode = "n",
      desc = "Copy commit message",
    },
  },
  config = function()
    local width = function()
      return math.floor(vim.o.columns * 0.45)
    end

    local Terminal = require("toggleterm.terminal").Terminal
    local configured_terminals = {}
    local set_terminal_keymaps = function(buf)
      local opts = { buffer = buf }

      vim.keymap.set(
        "t",
        "<C-h>",
        [[<C-\><C-n><C-w>h]],
        vim.tbl_extend("force", opts, {
          desc = "Move to left window",
        })
      )

      vim.keymap.set("n", "<C-u>", function()
        require("opencode").command("session.half.page.up")
      end, vim.tbl_extend("force", opts, { desc = "Scroll up half page" }))

      vim.keymap.set("n", "<C-d>", function()
        require("opencode").command("session.half.page.down")
      end, vim.tbl_extend("force", opts, { desc = "Scroll down half page" }))

      vim.keymap.set("n", "gg", function()
        require("opencode").command("session.first")
      end, vim.tbl_extend("force", opts, { desc = "Go to first message" }))

      vim.keymap.set("n", "G", function()
        require("opencode").command("session.last")
      end, vim.tbl_extend("force", opts, { desc = "Go to last message" }))

      vim.keymap.set("n", "<Esc>", function()
        require("opencode").command("session.interrupt")
      end, vim.tbl_extend("force", opts, { desc = "Interrupt current session" }))
    end

    opencode_terminal = Terminal:new({
      cmd = "opencode --port",
      direction = "vertical",
      display_name = "opencode",
      close_on_exit = true,
      env = {
        COLORTERM = "truecolor",
        TERM = "xterm-256color",
      },
      hidden = true,
      on_open = function(term)
        if configured_terminals[term.bufnr] then
          return
        end

        vim.api.nvim_set_option_value(
          "winhighlight",
          "Normal:ToggleTermNormal,NormalFloat:ToggleTermNormalFloat,FloatBorder:FloatBorder",
          { win = term.window }
        )
        configured_terminals[term.bufnr] = true
        set_terminal_keymaps(term.bufnr)
      end,
    })

    vim.g.opencode_opts = {
      server = {
        start = function()
          if not opencode_terminal:is_open() then
            opencode_terminal:open(width(), "vertical")
          end
        end,
        toggle = function()
          opencode_terminal:toggle(width(), "vertical")
        end,
        stop = function()
          opencode_terminal:shutdown()
        end,
      },
      contexts = {
        ["@staged_diff"] = staged_diff,
      },
      prompts = {
        commit = {
          prompt = table.concat({
            "Write a concise Conventional Commit message for this diff:",
            "@staged_diff",
            "Return only the commit message.",
            "Use a subject line and include a short body only if it adds useful context.",
          }, "\n\n"),
          submit = true,
        },
      },
    }
    vim.o.autoread = true
  end,
}
