return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- config here
    })

    -- set keymaps
    local keymap = vim.keymap -- for concise code
    keymap.set("n", "<leader>th", ":ToggleTerm size=13 direction=horizontal name=horizontal<cr>")
    keymap.set("n", "<leader>tv", ":ToggleTerm size=70 direction=vertical name=vertical<cr>")
  end,
}
