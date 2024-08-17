return {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    {
      "<leader>ss",
      "<cmd>CodeSnap<cr>",
      mode = "x",
    },
  },
  opts = {
    has_breadcrumbs = true,
    show_workspace = true,
    bg_padding = 0,
    watermark = "",
    -- has_line_number = true,
  },
}
