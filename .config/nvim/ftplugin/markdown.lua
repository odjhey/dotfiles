-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
	local function map(...)
		vim.api.nvim_buf_set_keymap(0, ...)
	end
	local opts = { noremap = true, silent = false }

	-- sadge can't do partial fns?
	-- local fmerge = vim.tbl_extend("force")
	local function fmerge(opts_, extra)
		return vim.tbl_extend("force", opts_, extra)
	end

	-- Open the link under the caret.
	map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", fmerge(opts, { desc = "zk open link" }))

	-- Create a new note in the same directory as the current buffer, using the current selection for title.
	map(
		"v",
		"<leader>aznt",
		":'<,'>ZkNewFromTitleSelection { dir = 'unfiled' }<CR>",
		fmerge(opts, { desc = "zk new note from selection as title" })
	)
	-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
	map(
		"v",
		"<leader>aznc",
		":'<,'>ZkNewFromContentSelection { dir = 'unfiled', title = vim.fn.input('Title: ') }<CR>",
		fmerge(opts, { desc = "zk new note from selection as content" })
	)
end
