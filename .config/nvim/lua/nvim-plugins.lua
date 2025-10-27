return {
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
		config = function ()
			vim.cmd.colorscheme("moonfly")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'master',
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {"lua", "python"},
				highlight = {enable = true},
				indent = {enable = true},
			})
		end
	},
}
