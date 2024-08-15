return {
  "mistricky/codesnap.nvim",
  build = "make",
  event = "VeryLazy",
  config = function()
    require("codesnap").setup({
      has_breadcrumbs = true,
      show_workspace = true,
      bg_padding = 0,
      watermark = "",
      -- has_line_number = true,
    })

    -- set keymaps
    local keymap = vim.keymap -- for concise code
    keymap.set("v", "<leader>csp", ":CodeSnap py<cr>")
  end,
}
