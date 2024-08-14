vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

-- format code using LSP
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("v", "<leader>lf", vim.lsp.buf.format)

-- codesnap for code screenshots
vim.api.nvim_set_keymap('v', '<leader>cs', ':CodeSnap<CR>', { noremap = true, silent = true })

-- toggleterm
vim.keymap.set("n", "<leader>th", ":ToggleTerm size=17 direction=horizontal name=horizontal<cr>")
vim.keymap.set("n", "<leader>tv", ":ToggleTerm size=70 direction=vertical name=vertical<cr>")

-- neogit
vim.keymap.set("n", "<leader>ng", ":Neogit kind=vsplit<cr>")
vim.keymap.set("n", "<leader>ngc", ":Neogit commit<cr>")
