local M = {}

function M.json_path()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1] - 1, pos[2]

	local parser = vim.treesitter.get_parser(0)
	if not parser then
		return nil
	end

	local trees = parser:parse()
	if not trees or not trees[1] then
		return nil
	end
	local tree = trees[1]

	local root = tree:root()
	if not root then
		return nil
	end

	local node = root:named_descendant_for_range(row, col, row, col)
	if not node then
		return nil
	end

	local parts = {}

	while node do
		local parent = node:parent()

		if parent and parent:type() == "array" then
			for i = 0, parent:named_child_count() - 1 do
				if parent:named_child(i) == node then
					table.insert(parts, 1, "[" .. i .. "]")
					break
				end
			end
		end

		if parent and parent:type() == "pair" then
			local key = parent:named_child(0)
			if key then
				local k = vim.treesitter.get_node_text(key, 0)
				k = k:gsub('^"(.*)"$', "%1")
				table.insert(parts, 1, k)
			end
		end

		node = parent
	end

	local path = ""
	for _, p in ipairs(parts) do
		if p:sub(1, 1) == "[" then
			path = path .. p
		elseif path == "" then
			path = p
		else
			path = path .. "." .. p
		end
	end

	return path
end

_G.odz = M
