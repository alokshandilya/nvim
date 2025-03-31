return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    -- vim.g.mkdp_browser = "firefox"
  end,
  ft = { "markdown" },

  -- keymaps
  vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>"),
}
