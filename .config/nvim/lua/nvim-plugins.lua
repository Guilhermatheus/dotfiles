vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/windwp/nvim-autopairs"},
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd.colorscheme("moonfly")

require "nvim-autopairs".setup()
require "colorizer".setup()

require "nvim-treesitter.configs".setup({
	ensure_installed = {"python", "html", "css", "c_sharp"},
	highlight = {enable = true},
	indent = {enable = true},
})
