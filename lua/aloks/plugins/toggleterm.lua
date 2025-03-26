return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  keys = {
    {
      "<leader>th",
      function()
        require("toggleterm.terminal").Terminal
          :new({ direction = "horizontal", size = 13 })
          :toggle()
      end,
      mode = "n",
      desc = "Horizontal Terminal",
    },
    {
      "<leader>tv",
      function()
        require("toggleterm.terminal").Terminal
          :new({ direction = "vertical", size = 70 })
          :toggle()
      end,
      mode = "n",
      desc = "Vertical Terminal",
    },
  },
  config = true,
}
