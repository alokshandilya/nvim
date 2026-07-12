return {
  "coder/claudecode.nvim",
  version = "*",
  opts = {
    auto_start = true,
    terminal = {
      provider = "native",
      split_side = "right",
      split_width_percentage = 0.45,
      auto_close = true,
    },
    diff_opts = {
      layout = "vertical",
      auto_resize_terminal = false,
    },
    git_repo_cwd = true,
  },
  keys = {
    { "<leader>a",  nil,                             desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",  desc = "Resume Claude session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude session" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add current buffer to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v",                           desc = "Send selection to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file to Claude context",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny Claude diff" },
  },
}
