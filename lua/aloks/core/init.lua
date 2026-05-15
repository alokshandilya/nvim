require("aloks.core.options")
require("aloks.core.keymaps")

-- Hyprlang LSP is managed via vim.lsp.config/enable in plugins; no manual autocmd here.
vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    ["hypr.*%.conf"] = "hyprlang",
  },
  extension = {
    hl = "hyprlang",
  },
})
