-- --------------------------
-- -- Efficiency (Plugins) --
-- --------------------------

vim.pack.add{
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
}


require "indent-o-matic".setup{}
require "nvim-autopairs".setup()

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
		vim.keymap.set("n", "<leader>d", gitsigns.preview_hunk_inline)
	end
}

require "fidget".setup{}
require "blink.cmp".setup{}
