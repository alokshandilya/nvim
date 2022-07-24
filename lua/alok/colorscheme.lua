-- -- #######################################
-- -- ########### gruvbox-material ##########
-- -- #######################################
vim.cmd [[
try
  set background=dark
  let g:gruvbox_material_better_performance=1
  let g:gruvbox_material_background = 'hard' " soft, medium(default), hard
  let g:gruvbox_material_foreground = 'material' " material(default), mix, original
  let g:gruvbox_material_enable_bold=1
  let g:gruvbox_material_enable_italic=1
  let g:gruvbox_material_transparent_background=1
  colorscheme gruvbox-material
endtry
]]
