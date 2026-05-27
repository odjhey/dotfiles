local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			file_ignore_patterns = {
				"%.gd%.uid$",
			},
		},
		pickers = {
			find_files = {
				file_ignore_patterns = {
					"%.tscn$",
					"%.gd%.uid$",
				},
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
}

return M
