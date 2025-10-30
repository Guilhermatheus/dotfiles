
vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

local modes = "nv"
for c in modes:gmatch"." do
	vim.keymap.set(c, "<S-Up>", "<C-d>")
	vim.keymap.set(c, "<S-Down>", "<C-u>")
	vim.keymap.set(c, "<S-Right>", "$")
	vim.keymap.set(c, "<S-Left>", "0")
end

vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "E", ":Neotree<CR>")
vim.keymap.set("n", "<C-f>", ":%s/")
