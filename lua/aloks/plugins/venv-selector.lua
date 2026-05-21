return {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv" },
  },
  opts = {},
}
