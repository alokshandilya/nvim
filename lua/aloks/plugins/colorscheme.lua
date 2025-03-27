return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000, -- Ensure this loads early
  config = function()
    -- Define gruvbox settings in a table for clarity
    local gruvbox_settings = {
      terminal_colors = true, -- Enable Neovim terminal colors
      transparent_mode = true, -- Enable transparent background
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
      contrast = "hard", -- Options: "hard", "soft", or ""
    }

    -- Apply gruvbox settings
    require("gruvbox").setup(gruvbox_settings)

    -- Set the colorscheme
    vim.cmd("colorscheme gruvbox")
  end,
}
