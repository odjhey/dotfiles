local M = {}

local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- ---------------------------------------------------------------------------
-- Pick a directory, then choose what to do with it
--   <CR>   -> live_grep
--   <C-f>  -> find_files
-- ---------------------------------------------------------------------------
function M.pick_dir_then_search()
	telescope.find_files({
		prompt_title = "Pick directory",
		find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
		attach_mappings = function(_, map)
			local function get_dir_and_close(bufnr)
				local entry = action_state.get_selected_entry()
				actions.close(bufnr)
				local dir = entry.path or entry[1]
				if not dir or dir == "" then
					vim.notify("No directory selected", vim.log.levels.WARN)
					return nil
				end
				return dir
			end

			local function do_grep(bufnr)
				local dir = get_dir_and_close(bufnr)
				if not dir then
					return
				end
				telescope.live_grep({ cwd = dir, prompt_title = "Grep: " .. dir })
			end

			local function do_find(bufnr)
				local dir = get_dir_and_close(bufnr)
				if not dir then
					return
				end
				telescope.find_files({ cwd = dir, prompt_title = "Files: " .. dir, hidden = true })
			end

			map("i", "<CR>", do_grep)
			map("n", "<CR>", do_grep)

			map("i", "<C-f>", do_find)
			map("n", "<C-f>", do_find)

			return true
		end,
	})
end

-- ---------------------------------------------------------------------------
-- live_grep restricted to files in the current window's arglist
-- ---------------------------------------------------------------------------
function M.grep_in_arglist()
	local files = vim.fn.argv()
	if not files or #files == 0 then
		vim.notify("Arglist is empty. Use :args / :argadd first.", vim.log.levels.WARN)
		return
	end

	telescope.live_grep({
		prompt_title = ("Grep arglist (%d files)"):format(#files),
		search_dirs = files,
	})
end

return M
