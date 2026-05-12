return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
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
  },
  config = function()
    local width = function()
      return math.floor(vim.o.columns * 0.5)
    end

    vim.g.opencode_opts = {
      server = {
        start = function()
          require("opencode.terminal").open("opencode --port", {
            split = "right",
            width = width(),
          })
        end,
        toggle = function()
          require("opencode.terminal").toggle("opencode --port", {
            split = "right",
            width = width(),
          })
        end,
      },
    }
    vim.o.autoread = true
  end,
}
