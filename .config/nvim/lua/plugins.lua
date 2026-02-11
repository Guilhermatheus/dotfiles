-- -------------------
-- -- Other Plugins --
-- -------------------

vim.pack.add{
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}


require "indent-o-matic".setup{}
require "nvim-autopairs".setup()
require "blink.cmp".setup{}

require "gitsigns".setup{
	signs = {
		add = { text = '+' },
		change = { text = '•' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '•' },
		untracked = { text = '?' },
	},
	signs_staged = {
		add = { text = '+' },
		change = { text = '•' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '•' },
		untracked = { text = '?' },
	},
	current_line_blame = true,
	on_attach = function()
		local gitsigns = require "gitsigns"
		vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk_inline, {desc = 'Preview hunk'})
		vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, {desc = 'Stage hunk'})
		vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, {desc = 'Reset hunk'})
		vim.keymap.set("n", "<leader>gbs", gitsigns.stage_buffer, {desc = 'Stage buffer'})
		vim.keymap.set("n", "<leader>gbr", gitsigns.reset_buffer, {desc = 'Reset buffer'})
	end
}

