-- -------------
-- -- Plugins --
-- -------------

vim.pack.add{
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/Darazaki/indent-o-matic.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}


vim.cmd.colorscheme("moonfly")

require "mini.statusline".setup()
require "mini.pairs".setup()
require 'mini.icons'.setup()
require "fidget".setup{}
require "indent-o-matic".setup{}


require 'mini.completion'.setup{
	delay = {
		completion = 0,
		info = 0,
		signature = 0
	}
}


local miniclue = require('mini.clue')
miniclue.setup{
	triggers = {
		{ mode = { 'n', 'x' }, keys = '<Leader>' },
		{ mode = 'n', keys = '[' },
		{ mode = 'n', keys = ']' },
		{ mode = 'i', keys = '<C-x>' },
		{ mode = { 'n', 'x' }, keys = 'g' },
		{ mode = { 'n', 'x' }, keys = "'" },
		{ mode = { 'n', 'x' }, keys = '`' },
		{ mode = { 'n', 'x' }, keys = '"' },
		{ mode = { 'i', 'c' }, keys = '<C-r>' },
		{ mode = 'n', keys = '<C-w>' },
		{ mode = { 'n', 'x' }, keys = 'z' },
	},

	clues = {
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


local minifiles = require 'mini.files'
minifiles.setup{
	mappings = {
		go_in = '<right>',
		go_out = '<left>'
	},
	windows = {
		preview = true,
		width_preview = 80
	},
}
vim.keymap.set("n", "<leader>e", minifiles.open, {silent = true, desc = 'Open MiniFiles'})

local augroup = vim.api.nvim_create_augroup('UserConfig', {clear = false})
vim.api.nvim_create_autocmd({"VimEnter"}, {
	group = augroup,
	pattern = {"*"},
	callback = function()
		local current_file = vim.fn.expand("%")
		if current_file ~= "" then vim.cmd(":silent! edit " .. current_file)
		else minifiles.open() end
	end
})


local minihipatterns = require 'mini.hipatterns'
minihipatterns.setup{
	highlighters = {
		fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
		hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
		todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
		note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

		hex_color = minihipatterns.gen_highlighter.hex_color(),
	},
}


local gitsigns = require "gitsigns"
gitsigns.setup{
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
}
vim.keymap.set("n", "<leader>gd", gitsigns.preview_hunk_inline, {desc = 'Hunk [D]iff'})
vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, {desc = '[A]dd hunk'})
vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, {desc = '[R]estore hunk'})
vim.keymap.set("n", "<leader>gba", gitsigns.stage_buffer, {desc = '[A]dd buffer'})
vim.keymap.set("n", "<leader>gbr", gitsigns.reset_buffer, {desc = '[R]estore buffer'})
