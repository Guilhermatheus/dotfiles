
vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<S-Up>", "<C-u>")
vim.keymap.set({"n", "v"}, "<S-Down>", "<C-d>")
vim.keymap.set({"n", "v"}, "<S-Right>", "$")
vim.keymap.set({"n", "v"}, "<S-Left>", "0")

vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "E", ":Oil<CR>")
vim.keymap.set("n", "<C-f>", ":%s///g")
vim.keymap.set("n", "<C-r>", ":%s/^\t\+/    /g<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
