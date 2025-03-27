return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  keys = {
    -- Horizontal Terminal Toggle
    {
      "<leader>th",
      "<cmd>ToggleTerm size=13 direction=horizontal<CR>",
      mode = "n",
      desc = "Horizontal Terminal",
    },
    -- Vertical Terminal Toggle
    {
      "<leader>tv",
      "<cmd>ToggleTerm size=70 direction=vertical<CR>",
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
