return {
  {
    "NvChad/nvim-colorizer.lua",
    keys = {
      "<leader>cc",
      "<cmd>ColorizerToggle<cr>",
      mode = "n",
    },
  },
  { "github/copilot.vim" },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
