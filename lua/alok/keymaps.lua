-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Save, Exit
keymap("n", "<leader>w", "<cmd>w!<CR>", opts)
keymap("n", "<leader>q", "<cmd>q!<CR>", opts)
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Alpha
keymap("n", "<leader>a", "<cmd>Alpha<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- format selected buffer
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
keymap("v", "lf", ":lua vim.lsp.buf.range_formatting()<CR>", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>Er", ":NvimTreeRefresh<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts) -- lazygit
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", opts) -- next hunk
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", opts) -- prev hunk
keymap("n", "<leader>gll", "<cmd>lua require 'gitsigns'.blame_line()<CR>", opts) -- blame
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", opts) -- preview hunk
keymap("n", "<leader>grr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", opts) -- reset hunk
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", opts) -- reset buffer
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", opts) -- stage hunk
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", opts) -- undo stage hunk
keymap("n", "<leader>go", "<cmd>Telescope git_status<CR>", opts) -- open changed file
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts) -- checkout branch
keymap("n", "<leader>gcc", "<cmd>Telescope git_commits<CR>", opts) -- checkout commits
keymap("n", "<leader>gcm", "<cmd>Git commit<CR>", opts) -- checkout commits
keymap("n", "<leader>gdd", "<cmd>Gitsigns diffthis HEAD<CR>", opts) -- git diff <leader>q to exit
keymap("n", "<leader>gds", "<cmd>Git diff --staged<CR>", opts) -- git diff staged
keymap("n", "<leader>gP", "<cmd>Git push<CR>", opts) -- git push

-- Colorizer
keymap("n", "<leader>cc", ":ColorizerToggle<CR>")

-- Icon Picker
keymap("n", "<leader><leader>i", "<cmd>IconPickerNormal alt_font symbols nerd_font emoji<cr>", opts)
keymap("n", "<Leader><Leader>y", "<cmd>IconPickerYank alt_font symbols nerd_font emoji<cr>", opts) --> Yank the selected icon into register

-- Markdown Preview
keymap("n", "<leader>mp", ":MarkdownPreview<CR>")

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Terminal [Toggle term]
keymap("n", "<leader>th", "<cmd>ToggleTerm size=13 direction=horizontal<cr>", opts)
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=55 direction=vertical<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
