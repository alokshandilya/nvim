local function staged_diff()
  local diff = vim.fn.system({ "git", "diff", "--cached" })

  if vim.v.shell_error ~= 0 or diff == "" then
    diff = vim.fn.system({ "git", "diff" })
  end

  return diff
end

local function commit_prompt(diff)
  return table.concat({
    "Write a concise Conventional Commit message for this diff:",
    diff,
    "Return only the commit message.",
    "Use a subject line and include a short body only if it adds useful context.",
  }, "\n\n")
end

local function strip_ansi(text)
  return text:gsub("\27%[[0-9;?]*[ -/]*[@-~]", "")
end

local function clean_opencode_output(text)
  local lines = vim.split(strip_ansi(text), "\n", { trimempty = true })
  local output = {}

  for _, line in ipairs(lines) do
    if not line:match("^>%s") then
      table.insert(output, line)
    end
  end

  return vim.trim(table.concat(output, "\n"))
end

local function parse_opencode_json_output(text)
  local parts = {}
  local session_id

  for line in text:gmatch("[^\n]+") do
    local ok, event = pcall(vim.json.decode, line)

    if ok and event then
      session_id = session_id or event.sessionID

      if event.type == "text" and event.part and event.part.text then
        table.insert(parts, event.part.text)
      end
    end
  end

  return vim.trim(table.concat(parts, "")), session_id
end

local function delete_opencode_session(session_id)
  if not session_id then
    return
  end

  vim.system({ "opencode", "session", "delete", session_id }, { text = true }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify("Failed to delete temporary session: " .. session_id, vim.log.levels.WARN, { title = "opencode" })
      end)
    end
  end)
end

local function generate_commit_message()
  local diff = staged_diff()

  if diff == "" then
    vim.notify("No staged or unstaged git diff found", vim.log.levels.WARN, { title = "opencode" })
    return
  end

  vim.notify("Generating commit message...", vim.log.levels.INFO, { title = "opencode" })

  vim.system({ "opencode", "run", "--format", "json", commit_prompt(diff) }, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify(result.stderr or "Failed to generate commit message", vim.log.levels.ERROR, { title = "opencode" })
        return
      end

      local message, session_id = parse_opencode_json_output(result.stdout or "")

      if message == "" then
        message = clean_opencode_output(result.stdout or "")
      end

      if message == "" then
        vim.notify("OpenCode returned an empty commit message", vim.log.levels.WARN, { title = "opencode" })
        delete_opencode_session(session_id)
        return
      end

      vim.fn.setreg("+", message)
      vim.fn.setreg('"', message)
      delete_opencode_session(session_id)
      vim.notify("Commit message copied to clipboard", vim.log.levels.INFO, { title = "opencode" })
    end)
  end)
end

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
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
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
        require("opencode").toggle()
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

    local opencode_terminal = Terminal:new({
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
        require("opencode.terminal").setup(term.window)
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
