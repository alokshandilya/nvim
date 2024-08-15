return {
  "NeogitOrg/neogit",
  event = "BufRead",
  dependcies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
  },
  config = function()
    require("neogit").setup({})
    -- set keymaps
    local keymap = vim.keymap -- for concise code
    keymap.set("n", "<leader>ng", ":Neogit kind=vsplit<cr>")
    keymap.set("n", "<leader>ngc", ":Neogit commit<cr>")
  end,
}
