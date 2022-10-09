local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "alok.lsp.mason"
require("alok.lsp.handlers").setup()
require "alok.lsp.null-ls"
