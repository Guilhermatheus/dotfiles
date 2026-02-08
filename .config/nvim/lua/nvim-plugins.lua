vim.pack.add{
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
}

vim.cmd.colorscheme("moonfly")

require "nvim-autopairs".setup()
require "indent-o-matic".setup{}
require "colorizer".setup()

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

require "nvim-treesitter.configs".setup{
	ensure_installed = {"python", "html", "css", "c_sharp"},
	highlight = {enable = true},
	indent = {enable = true}
}
