return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      { "nvim-telescope/telescope.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest of available options
      window = {
        layout = "float", -- "float" | "split" | "top" | "right"
        relative = "editor", -- "editor" | "win" | "cursor" | "mouse"
        border = "rounded", -- "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[]
        width = 0.8, -- fractional width of parent
        height = 0.6, -- fractional height of parent
      },
      prompts = {
        Explain = {
          prompt = "Explain how this code works.",
          mapping = "<leader>cf",
          description = "Copilot Explain Code",
        },
        Refactor = {
          prompt = "Refactor this code to improve readability and performance.",
          mapping = "<leader>cr",
          description = "Copilot Refactor Code",
        },
        Docs = {
          prompt = "Generate documentation for this code.",
          mapping = "<leader>cd",
          description = "Copilot Document Code",
        },
      }
    },
    keys = {
      {
        "<leader>cp",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Toggle Copilot Chat",
      },
      {
        "<leader>ce",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Open Copilot Chat Prompts",
      },
      -- Visual mode mappings
      {
        "<leader>cv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "Copilot Chat Visual",
      },



    },
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatVisual",
      "CopilotChatInPlace",
    },
  }
}