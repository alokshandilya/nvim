return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  keys = {
    {
      "<leader>th",
      "<cmd>ToggleTerm size=13 direction=horizontal name=horizontal<cr>",
      "n",
    },
    {
      "<leader>tv",
      "<cmd>ToggleTerm size=70 direction=vertical name=vertical<cr>",
      "n",
    },
  },
  config = true,
}
