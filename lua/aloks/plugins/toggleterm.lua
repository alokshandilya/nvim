return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  keys = {
    -- Horizontal Terminal Toggle
    {
      "<leader>th",
      function()
        local height = math.floor(vim.o.lines * 0.3) -- 30% of screen height
        vim.cmd(string.format("ToggleTerm size=%d direction=horizontal", height))
      end,
      mode = "n",
      desc = "Horizontal Terminal",
    },
    -- Vertical Terminal Toggle
    {
      "<leader>tv",
      function()
        local width = math.floor(vim.o.columns * 0.4) -- 40% of screen width
        vim.cmd(string.format("ToggleTerm size=%d direction=vertical", width))
      end,
      mode = "n",
      desc = "Vertical Terminal",
    },
    -- Floating Terminal Toggle
    {
      "<leader>tf",
      "<cmd>ToggleTerm direction=float<CR>",
      mode = "n",
      desc = "Floating Terminal",
    },
  },
  config = function()
    require("toggleterm").setup({
      -- General settings
      open_mapping = [[<C-\>]], -- Default mapping to open terminal
      hide_numbers = true, -- Hide line numbers in terminal buffers
      shade_filetypes = {}, -- Filetypes to shade when terminal is open
      shade_terminals = true, -- Shade the terminal background
      shading_factor = "1", -- Shading level (0-1)
      start_in_insert = true, -- Start terminal in insert mode
      insert_mappings = true, -- Enable mappings in insert mode
      persist_size = true, -- Persist terminal size across sessions
      direction = "float", -- Default direction (can be overridden)
      close_on_exit = true, -- Close terminal when shell exits
      shell = vim.o.shell, -- Use the default shell
      autochdir = false, -- Change directory to the file's directory
      highlights = {
        Normal = {
          guibg = "#1e222a", -- Background color
        },
        NormalFloat = {
          link = "Normal",
        },
      },
    })
  end,
}
