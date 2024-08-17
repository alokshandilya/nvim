return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      contrast = "hard", -- can be "hard", "soft" or empty string
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
