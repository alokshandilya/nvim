return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
  keys = {
    {
      "<leader>ng",
      "<cmd>Neogit kind=vsplit<cr>",
      mode = "n",
    },
    {
      "<leader>ngc",
      "<cmd>Neogit commit<cr>",
      mode = "n",
    },
  },
  dependcies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
  },
  config = true,
}
