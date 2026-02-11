-- ----------------
-- -- Appearance --
-- ----------------

vim.pack.add{
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mks-h/treesitter-autoinstall.nvim.git" },
}


vim.cmd.colorscheme("moonfly")
require "colorizer".setup()
require "fidget".setup{}
require "mini.statusline".setup()
require "which-key".setup{opts = {delay = 0}}
require 'nvim-treesitter'.setup{}
require 'treesitter-autoinstall'.setup{highlight = true}

