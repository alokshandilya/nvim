return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000, -- Ensure this loads early
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_transparent_background = 2
    vim.g.gruvbox_material_better_performance = 1

    vim.cmd("colorscheme gruvbox-material")

    local transparent_groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "EndOfBuffer",
      "FloatBorder",
      "SignColumn",
      "LineNr",
      "CursorLine",
      "CursorLineNr",
      "StatusLine",
      "StatusLineNC",
      "TabLine",
      "TabLineFill",
      "TelescopeNormal",
      "TelescopeBorder",
      "ToggleTermNormal",
      "ToggleTermNormalFloat",
    }

    local function apply_transparency()
      for _, group in ipairs(transparent_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.bg = nil
        hl.ctermbg = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
    end

    apply_transparency()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = apply_transparency,
    })
  end,
}
