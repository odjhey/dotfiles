local M = {}

local defaults = {
	mappings = {
		find_down = "<leader>j",
		find_up = "<leader>k",
	},
	mapping_modes = { "n", "x", "o" },
	ignore_whitespace = true,
	no_wrap = true,
	silent = true,
	set_last_search = false,
	jump_to_first_word = true,
}

M.config = vim.deepcopy(defaults)

local function escape_for_search(char)
	return vim.fn.escape(char, [[\^$.*~[]])
end

local function build_pattern(char)
	local escaped = escape_for_search(char)

	if M.config.ignore_whitespace then
		return [[^\s*]] .. escaped
	end

	return [[^]] .. escaped
end

local function set_last_search_state(pattern, direction)
	vim.fn.setreg("/", pattern)
	vim.fn.histadd("search", pattern)
	vim.v.searchforward = direction == "down" and 1 or 0
end

local function first_nonblank_col(line)
	local idx = line:find("%S")
	if idx then
		return idx - 1
	end
	return nil
end

local function move_to_first_word()
	local line = vim.api.nvim_get_current_line()
	local col = first_nonblank_col(line)

	if col ~= nil then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_win_set_cursor(0, { row, col })
	end
end

local function prepare_backward_search()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if row <= 1 then
		return false
	end

	local prev_line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1] or ""
	vim.api.nvim_win_set_cursor(0, { row - 1, #prev_line })
	return true
end

local function search_once(pattern, direction)
	local flags = ""

	if direction == "up" then
		flags = flags .. "b"
	end

	if M.config.no_wrap then
		flags = flags .. "W"
	end

	if direction == "up" then
		local ok = prepare_backward_search()
		if not ok then
			return 0
		end
	end

	return vim.fn.search(pattern, flags)
end

local function do_search(direction)
	local char = vim.fn.getcharstr()
	if not char or char == "" then
		return
	end

	local pattern = build_pattern(char)
	local count = vim.v.count1
	local found = 0

	if M.config.set_last_search then
		set_last_search_state(pattern, direction)
	end

	for _ = 1, count do
		found = search_once(pattern, direction)
		if found == 0 then
			break
		end
	end

	if found == 0 then
		if not M.config.silent then
			vim.notify(("No vertical match for %q (%s x%d)"):format(char, direction, count), vim.log.levels.INFO)
		end
		return
	end

	if M.config.jump_to_first_word then
		move_to_first_word()
	end
end

function M.find_down()
	do_search("down")
end

function M.find_up()
	do_search("up")
end

local function set_mapping(lhs, rhs, desc)
	if not lhs or lhs == false then
		return
	end

	vim.keymap.set(M.config.mapping_modes, lhs, rhs, {
		desc = desc,
		silent = true,
	})
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})

	local mappings = M.config.mappings or {}

	set_mapping(mappings.find_down, M.find_down, "Vertical find down")
	set_mapping(mappings.find_up, M.find_up, "Vertical find up")
end

return M
