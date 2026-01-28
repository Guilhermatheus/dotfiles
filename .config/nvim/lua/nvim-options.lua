-- General
vim.opt.number = true
vim.opt.scrolloff = 69
vim.opt.autochdir = true

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Visuals
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "81"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.pumheight = 10
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- File
vim.opt.swapfile = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

-- Extras
vim.opt.hidden = true
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append(".")
vim.opt.iskeyword:append(":")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamed")
vim.opt.wildmode = "longest:full,full"
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.whichwrap = "<,>,[,]"

vim.g.python_recommended_style = 0
