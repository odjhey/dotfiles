require("configs.options")
require("configs.autocmds")
require("configs.lsp")
require("configs.lazy")
require("configs.unfiled")

vim.cmd([[colorscheme tokyonight]])

vim.schedule(function()
	require("configs.mappings")
end)

vim.schedule(function()
	require("configs.vertjump").setup()
end)
