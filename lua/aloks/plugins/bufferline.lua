return {
  "akinsho/bufferline.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics = "nvim_lsp",
      diagnostics_update_on_event = true, -- use nvim's diagnostic handler
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text_align = "left",
          highlight = "Directory",
          separator = true,
          text = "  File Explorer",
        },
      },
      color_icons = true,
      show_buffer_icons = true,
    },
  },
}
