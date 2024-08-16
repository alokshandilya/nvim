-- space bar as leader key
vim.g.mapleader = " "

local keymap = vim.keymap

-- buffers
keymap.set("n", "<leader>bn", ":bn<cr>")
keymap.set("n", "<leader>bp", ":bp<cr>")
keymap.set("n", "<leader>bd", ":bd<cr>")

-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
