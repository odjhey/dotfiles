local M = {}

function M.on_attach(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Preview
	--
	-- gitsigns.preview_hunk() opens a floating scratch buffer (buftype=nofile)
	-- without a filename. No filename => no filetype detection => no diff colors.
	--
	-- We wrap it to explicitly set `filetype=diff` (and `syntax=diff`) on the
	-- preview buffer so Neovim applies proper diff highlighting.
	map("n", "<leader>hp", function()
		gitsigns.preview_hunk()

		vim.schedule(function()
			local wins = vim.api.nvim_list_wins()
			for i = #wins, 1, -1 do
				local win = wins[i]
				local cfg = vim.api.nvim_win_get_config(win)
				if cfg.relative ~= "" then
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].buftype == "nofile" then
						vim.bo[buf].filetype = "diff"
						vim.bo[buf].syntax = "diff"
						return
					end
				end
			end
		end)
	end, { desc = "Gitsigns preview hunk (float)" })

	-- Navigation
	map("n", "]h", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]h", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Gitsigns next hunk" })

	map("n", "[h", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[h", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Gitsigns prev hunk" })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Gitsigns stage hunk" })
	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Gitsigns stage buffer" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Gitsigns reset hunk" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Gitsigns reset buffer" })

	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Gitsigns stage selection" })

	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Gitsigns reset selection" })

	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Gitsigns blame line (full)" })

	map("n", "<leader>hd", gitsigns.diffthis, { desc = "Gitsigns diff this" })
end

return M
