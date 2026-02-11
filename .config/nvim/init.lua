
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
vim.diagnostic.config{
	update_in_insert = false,
	virtual_text = true,
}
vim.opt.list = true


vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

vim.g.python_recommended_style = 0


vim.keymap.set("n", "U", "<C-r>") -- Undo

-- Move selected lines
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

-- Faster movement
vim.keymap.set({"n", "v"}, "<S-Up>", "5k")
vim.keymap.set({"n", "v"}, "<S-Down>", "5j")
vim.keymap.set({"n", "v"}, "<S-Left>", "5h")
vim.keymap.set({"n", "v"}, "<S-Right>", "5l")
vim.keymap.set({"i"}, "<S-Up>", "<C-o>5k")
vim.keymap.set({"i"}, "<S-Down>", "<C-o>5j")
vim.keymap.set({"i"}, "<S-Left>", "<C-o>5h")
vim.keymap.set({"i"}, "<S-Right>", "<C-o>5l")

-- Better movement for wrapping lines
vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "E", ":Explore<CR>") -- Netrw keymap
vim.keymap.set("n", "<C-f>", "/<C-r><C-w>") -- Better find
vim.keymap.set("n", "<C-r>", ":%s/<C-r><C-w>/<C-r><C-w>/g") -- Better replace
vim.keymap.set("n", "<C-i>", "gg<CR>=G<CR>''<CR>") -- Tab Re-indent

-- "Aliases"
vim.keymap.set({"n", "v"}, ";", ":")
vim.keymap.set({"n", "v"}, "!", ":!")



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

require('appearance')
require('plugins')
require('lsp')
