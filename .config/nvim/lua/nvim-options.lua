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
vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = { 'lua/?.lua', 'lua/?/init.lua' },
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file('', true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
})
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
