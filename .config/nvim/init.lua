
-- General
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.showmode = false
vim.opt.number = true
vim.opt.scrolloff = 69
vim.opt.autochdir = true
vim.opt.splitright = true

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Visuals
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "81"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.pumheight = 10
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300
vim.opt.list = true


vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.o.confirm = true

-- File
vim.opt.swapfile = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0

-- Extras
vim.opt.hidden = true
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append(".")
vim.opt.iskeyword:append(":")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.opt.wildmode = "longest:full,full"
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.whichwrap = "<,>,[,]"

-- -------------
-- -- Keymaps --
-- -------------

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', {desc = 'remove search highlight'})
vim.keymap.set("n", "U", "<C-r>", {desc = 'Change undo key'})

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", {desc = 'Move line up'})
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", {desc = 'Move selected up'})
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", {desc = 'Move line down'})
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", {desc = 'Move selected down'})

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


-- Start with Netrw if no input file
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
require('appearance')
require('lsp')
