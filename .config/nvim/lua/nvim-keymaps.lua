
vim.keymap.set("n", "U", "<C-r>", {desc = "Undo"})

vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", {desc = "Move line up"})
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", {desc = "Move selection up"})
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", {desc = "Move line down"})
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", {desc = "Move selection down"})

vim.keymap.set("n", "<S-Right>", "$")
vim.keymap.set("v", "<S-Right>", "$")
vim.keymap.set("n", "<S-Left>", "0")
vim.keymap.set("v", "<S-Left>", "0")

vim.keymap.set("v", "<", "<gv", {desc = "Remove indent and reselect"})
vim.keymap.set("v", ">", ">gv", {desc = "Add indent and reselect"})

vim.keymap.set("n", "E", ":Explore<CR>", {desc = "Open file explorer"})
