-- -------------
-- -- Plugins --
-- -------------

vim.pack.add{
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}


vim.cmd.colorscheme("moonfly")

local miniclue = require('mini.clue')
miniclue.setup{
	triggers = {
		-- Leader triggers
		{ mode = { 'n', 'x' }, keys = '<Leader>' },

		-- `[` and `]` keys
		{ mode = 'n', keys = '[' },
		{ mode = 'n', keys = ']' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = { 'n', 'x' }, keys = 'g' },

		-- Marks
		{ mode = { 'n', 'x' }, keys = "'" },
		{ mode = { 'n', 'x' }, keys = '`' },

		-- Registers
		{ mode = { 'n', 'x' }, keys = '"' },
		{ mode = { 'i', 'c' }, keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = { 'n', 'x' }, keys = 'z' },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},

	window = {delay = 0},
}

require "mini.statusline".setup()
require "mini.pairs".setup()

require 'mini.files'.setup{
	mappings = {
		go_in = '<right>',
		go_out = '<left>'
	},
	windows = {
		preview = true,
		width_preview = 50
	},
}
vim.keymap.set("n", "E", ":lua MiniFiles.open()<CR>", {silent = true, desc = 'Open MiniFiles'})

local hipatterns = require 'mini.hipatterns'
hipatterns.setup{
	highlighters = {
		fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
		hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
		todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
		note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
}

require "fidget".setup{}
require "indent-o-matic".setup{}
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
		vim.keymap.set("n", "<leader>gs", gitsigns.preview_hunk_inline, {desc = '[S]ee hunk'})
		vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, {desc = '[A]dd hunk'})
		vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, {desc = '[R]estore hunk'})
		vim.keymap.set("n", "<leader>gba", gitsigns.stage_buffer, {desc = '[A]dd buffer'})
		vim.keymap.set("n", "<leader>gbr", gitsigns.reset_buffer, {desc = '[R]estore buffer'})
	end
}

