vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set({"n", "v"}, "D", '"_d')

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<S-Up>", "{")
vim.keymap.set({"n", "v"}, "<S-Down>", "}")
vim.keymap.set("i", "<S-Up>", "<C-o>{")
vim.keymap.set("i", "<S-Down>", "<C-o>}")

vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "E", ":Explore<CR>")
vim.keymap.set("n", "<C-f>", "/<C-r><C-w>")
vim.keymap.set("n", "<C-r>", ":%s/<C-r><C-w>//g")
vim.keymap.set("n", "<C-i>", "gg<CR>=G<CR>''<CR>")
vim.keymap.set("n", "<C-o>", ":%s/	/    /g<CR>")

vim.keymap.set({"n", "v"}, ";", ":")
