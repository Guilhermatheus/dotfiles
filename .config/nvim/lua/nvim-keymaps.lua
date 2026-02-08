vim.keymap.set("n", "U", "<C-r>") -- Undo

-- Move selected lines
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

-- Faster movement
vim.keymap.set({"n", "v"}, "<S-Up>", "5k")
vim.keymap.set({"n", "v"}, "<S-Down>", "5j")
vim.keymap.set({"n", "v"}, "<S-Left>", "5h")
vim.keymap.set({"n", "v"}, "<S-Right>", "5l")
vim.keymap.set({"i"}, "<S-Up>", "<C-o>5k")
vim.keymap.set({"i"}, "<S-Down>", "<C-o>5j")
vim.keymap.set({"i"}, "<S-Left>", "<C-o>5h")
vim.keymap.set({"i"}, "<S-Right>", "<C-o>5l")

-- Better movement for wrapping lines
vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "E", ":Explore<CR>") -- Netrw keymap
vim.keymap.set("n", "<C-f>", "/<C-r><C-w>") -- Better find
vim.keymap.set("n", "<C-r>", ":%s/<C-r><C-w>/<C-r><C-w>/g") -- Better replace
vim.keymap.set("n", "<C-i>", "gg<CR>=G<CR>''<CR>") -- Tab Re-indent
vim.keymap.set("n", "<C-o>", ":%s/	/    /g<CR>") -- Space Re-indent

-- "Aliases"
vim.keymap.set({"n", "v"}, ";", ":")
vim.keymap.set({"n", "v"}, "!", ":!")
