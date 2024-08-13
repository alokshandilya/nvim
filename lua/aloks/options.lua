vim.g.python3_host_prog = os.getenv("HOME") .. ".pyenv/versions/3.12.0/bin/python" -- python code environment

vim.opt.encoding = "utf-8" -- set encoding
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true --relative line numbers

-- Set tab behavior
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.list = true -- Show some invisible characters (tabs...)

vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters

vim.opt.hlsearch = false -- do not highlight search results on previous search result
vim.opt.incsearch = true -- show search results as you type

vim.opt.termguicolors = true --enable true color support

vim.opt.scrolloff = 8 -- keep 8 lines above and below the cursor when scrolling
vim.opt.sidescrolloff = 8 -- keep 8 lines to the left and right of the cursor when scrolling horizontally

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		vim.opt.textwidth = 79
		vim.opt.colorcolumn = "79"
	end,
}) -- python formatting

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.js", "*.html", "*.css", "*.lua" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
	end,
}) -- javascript, html, css, lua formatting

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
}) -- return to last edit position when opening files
