local augroup = vim.api.nvim_create_augroup("UserConfig", {})


-- Highlight yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})


-- Create dirs if they don't exist
vim.api.nvim_create_autocmd("BufWrite", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand('<afile>:p:h')
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, 'p')
		end
	end,
})


-- Open file at the last position if it was edited earlier
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup,
	pattern = '*',
	command = 'silent! normal! g`"zv'
})


-- Start with Netrw if no input file
vim.api.nvim_create_autocmd({"VimEnter"}, {
	group = augroup,
	pattern = {"*"},
	callback = function()
		local current_file = vim.fn.expand("%")
		if current_file ~= "" then vim.cmd(":silent! edit " .. current_file)
		else vim.cmd(":silent! Explore") end
	end
})

