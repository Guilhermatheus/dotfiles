vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs"},
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd.colorscheme("moonfly")

require "oil".setup({
	keymaps = {
		["<BS>"] = {"actions.parent", mode = "n"}
	},
	view_options = {
		show_hidden = false,
	},
})

require "nvim-autopairs".setup()
require "colorizer".setup()

require "nvim-treesitter.configs".setup({
	ensure_installed = {"lua", "python", "html"},
	highlight = {enable = true},
	indent = {enable = true},
})
