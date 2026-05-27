local M = {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	-- for some reason mason removed ensure_installed
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"typescript-language-server",
				"eslint-lsp",
				"purescript-language-server",
				"kotlin-lsp",
				-- keep biome local (per project)
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
	},
	{
		-- "folke/which-key.nvim",
		-- use fork because of broken c_o-zz
		"odjhey/which-key.nvim",
		branch = "fix/broken_i_c_o_mark_others",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.files").setup({})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = require("configs.gitsigns_config"),
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"saghen/blink.cmp",

		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "enter" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						fallbacks = {}, -- always show buffer
					},
				},
			},
			signature = { enabled = true },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
	},

	{
		"zk-org/zk-nvim",
		name = "zk",
		opts = {
			-- See Setup section below
			picker = "telescope",
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			enabled = false,
			restart_highlighter = true,
		},
	},
	{
		"3rd/image.nvim",
		opts = {},
	},

	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
	},
}

return M
