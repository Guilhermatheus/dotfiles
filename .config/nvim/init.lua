
-- -------------
-- -- Options --
-- -------------

vim.opt.termguicolors = true -- Support for more colors
vim.opt.showmode = false -- Don't show modes
vim.opt.number = true -- Line numbers
vim.opt.scrolloff = 69 -- Always center screen to cursor

-- Define default indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Visual tabs and spaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Smart search + Highlight
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.synmaxcol = 300 -- Limit so search doesn't lag

-- Line for recommended character limit visualization
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "81"

-- Popup size + recommendations/completions
vim.opt.inccommand = 'split'
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.lazyredraw = true

-- File stuff
vim.opt.confirm = true -- Ask to save (or not) files before closing
vim.opt.hidden = true -- Show hidden files
vim.opt.autochdir = true -- cd to newly open file folder
vim.opt.swapfile = false -- Don't creat swap file
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0
vim.opt.path:append("**") -- Consider this file on search

-- Consider more chars as part of words
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append(".")
vim.opt.iskeyword:append(":")
vim.opt.wildmode = "longest:full,full"

-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable mouse
vim.opt.mouse = "a"

-- Clipboard support
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Wrap around (like gui text editors)
vim.opt.whichwrap = "<,>,[,]"

-- Limit for less lagging
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000


-- -------------
-- -- Keymaps --
-- -------------

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', {desc = 'remove search highlight'})
vim.keymap.set("n", "U", "<C-r>", {desc = 'Change undo key'})

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", {silent = true, desc = 'Move line up'})
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", {silent = true, desc = 'Move selected up'})
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", {silent = true, desc = 'Move line down'})
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", {silent = true, desc = 'Move selected down'})

vim.keymap.set({"n", "v"}, "<S-Up>", "5k", {desc = 'Move 5 up'})
vim.keymap.set({"n", "v"}, "<S-Down>", "5j", {desc = 'Move 5 down'})
vim.keymap.set({"n", "v"}, "<S-Left>", "5h", {desc = 'Move 5 left'})
vim.keymap.set({"n", "v"}, "<S-Right>", "5l", {desc = 'Move 5 right'})
vim.keymap.set({"i"}, "<S-Up>", "<C-o>5k", {desc = 'Insert move 5 up'})
vim.keymap.set({"i"}, "<S-Down>", "<C-o>5j", {desc = 'Insert move 5 down'})
vim.keymap.set({"i"}, "<S-Left>", "<C-o>5h", {desc = 'Insert move 5 left'})
vim.keymap.set({"i"}, "<S-Right>", "<C-o>5l", {desc = 'Insert move 5 right'})

vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Wrapped line move up'})
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Wrapped line move down'})

vim.keymap.set("v", "<", "<gv", {desc = 'Remove indent'})
vim.keymap.set("v", ">", ">gv", {desc = 'Add indent'})

vim.keymap.set("n", "E", ":Explore<CR>", {silent = true, desc = 'Open Netrw'})
vim.keymap.set("n", "<C-f>", "/<C-r><C-w>", {desc = 'Find'})
vim.keymap.set("n", "<C-r>", ":%s/<C-r><C-w>/<C-r><C-w>/g", {desc = 'Replace'})
vim.keymap.set("n", "<C-i>", "gg<CR>=G<CR>''<CR>", {desc = 'Reindent'})

vim.keymap.set({"n", "v"}, ";", ":", {desc = 'Quick command'})
vim.keymap.set({"n", "v"}, "!", ":!", {desc = 'Quick terminal command'})

-- --------------
-- -- Autocmds --
-- --------------

local augroup = vim.api.nvim_create_augroup("UserConfig", {})


-- Highlight yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})


-- Create dirs if they don't exist
vim.api.nvim_create_autocmd("BufWrite", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand('<afile>:p:h')
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, 'p')
		end
	end,
})


-- Open file at the last position if it was edited earlier
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup,
	pattern = '*',
	command = 'silent! normal! g`"zv'
})


-- Start with Netrw when there isn't a input file
vim.api.nvim_create_autocmd({"VimEnter"}, {
	group = augroup,
	pattern = {"*"},
	callback = function()
		local current_file = vim.fn.expand("%")
		if current_file ~= "" then vim.cmd(":silent! edit " .. current_file)
		else vim.cmd(":silent! Explore") end
	end
})

-- --------------------
-- -- Plugin scripts --
-- --------------------

require('plugins')
require('lsp')
