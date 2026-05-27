-- Mappings
local map = vim.keymap.set
local lsp = vim.lsp

-- Which-key group labels
local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>fx", group = "Find extended" },
	{ "<leader>d", group = "Dialogs" },
	{ "<leader>a", group = "Actions" },
	{ "<leader>h", group = "Hunk (git)" },
})

local user = {
	n = {
		["<leader><CR>"] = { "<C-^>", "" },
		["<left>"] = { "<cmd> cprev <cr>", "Quickfix prev" },
		["<right>"] = { "<cmd> cnext <cr>", "Quickfix next" },
		["<up>"] = { "<cmd> lprev <cr>", "Loclist prev" },
		["<down>"] = { "<cmd> lnext <cr>", "Loclist next" },
	},
}

for key, value in pairs(user.n) do
	map("n", key, value[1], { desc = value[2] })
end

-- Find
local telescope_builtin = require("telescope.builtin")
local telescope_fns = require("configs.telescope_fns")

map("n", "<leader>ff", "<cmd>Telescope find_files theme=ivy<cr>", { desc = "Telescope find files" })
map("n", "<leader>fd", "<cmd>Telescope git_status theme=dropdown<cr>", { desc = "Telescope find dirty files" })
map("n", "<leader>fw", telescope_builtin.grep_string, { desc = "Telescope grep string under cursor" })
map("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Telescope grep" })
map("n", "<leader>f0", telescope_builtin.resume, { desc = "Telescope resume last" })
map("n", "<leader>fxd", telescope_fns.pick_dir_then_search, { desc = "Telescope find from selected dir" })
map("n", "<leader>fxa", telescope_fns.grep_in_arglist, { desc = "Telescope find from argslist" })
map("n", "<leader>fz", "<cmd>ZkNotes {notebook_path = '$ZK_NOTEBOOK_DIR'}<cr>", { desc = "zk find notes" })

-- Dialogs
local mini_files = require("mini.files")
map("n", "<leader>df", function()
	mini_files.open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Action open mini.files" })
map("n", "<leader>dt", telescope_builtin.builtin, { desc = "Telescope open" })
map("n", "<leader>d0", "<cmd>Neotree position=float reveal=true<cr>", { desc = "Neotree open float" })

map("n", "<leader>dzb", "<Cmd>ZkBacklinks<CR>", { desc = "zk show backlinks" })
map("n", "<leader>dzt", "<Cmd>ZkTags<CR>", { desc = "zk show tags" })

-- Actions
map("n", "<leader>af", function()
	require("conform").format()
end, { desc = "Conform format" })
map("n", "<leader>ar", lsp.buf.rename, { desc = "LSP Rename" })
map("n", "<leader>avm", "<Cmd>RenderMarkdown toggle<CR>", { desc = "Markdown toggle render" })
