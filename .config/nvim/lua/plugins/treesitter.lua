local parsers = {
	"lua",
	"typescript",
	"yaml",
	"json",
	"purescript",
	"gdscript",
	"haskell",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,

	build = function()
		vim.cmd("TSInstall " .. table.concat(parsers, " "))
	end,

	config = function()
		vim.opt.termguicolors = true
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
