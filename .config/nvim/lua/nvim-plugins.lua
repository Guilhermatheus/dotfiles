vim.pack.add{
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
}

vim.cmd.colorscheme("moonfly")

require "nvim-autopairs".setup()
require "indent-o-matic".setup{}
require "colorizer".setup()
require "mason".setup()
require "mason-lspconfig".setup()
require "mason-tool-installer".setup{}
require "which-key".setup{
	opts = {
		delay = 0,
	}
}
require "fidget".setup{}
require "blink.cmp".setup{}
require "mini.statusline".setup()

require "gitsigns".setup{
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
		untracked = { text = '?' },
	},
	signs_staged = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
		untracked = { text = '?' },
	},
	current_line_blame = true,
	on_attach = function()
		local gitsigns = require "gitsigns"
		vim.keymap.set("n", "D", gitsigns.preview_hunk_inline)
	end
}

require "nvim-treesitter".setup{
	ensure_installed = {"python", "html", "css", "c_sharp"},
	highlight = {enable = true},
	indent = {enable = true}
}
