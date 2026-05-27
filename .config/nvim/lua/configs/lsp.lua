local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},

	ts_ls = {}, -- default config
	biome = {}, -- uses per-project biome, no global install needed
	eslint = {},
	pyright = {},
	hls = {},
	purescriptls = {},
	kotlin_lsp = {},
	zk = {
		default_config = {
			cmd = { "zk", "lsp" },
			filetypes = { "markdown" },
			root_dir = function()
				return vim.loop.cwd()
			end,
			settings = {},
		},
	},
}

for name, opts in pairs(servers) do
	vim.lsp.config(name, opts)
	vim.lsp.enable(name)
end
