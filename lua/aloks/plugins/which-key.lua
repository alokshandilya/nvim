return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code / colorizer" },
      { "<leader>e", group = "Explorer (nvim-tree)" },
      { "<leader>f", group = "Find (telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>l", group = "Lint / format" },
      { "<leader>m", group = "Markdown" },
      { "<leader>n", group = "Neogit" },
      { "<leader>t", group = "Terminal (toggleterm)" },
      { "<leader>x", group = "Trouble / diagnostics" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer local keymaps (which-key)",
    },
  },
}
