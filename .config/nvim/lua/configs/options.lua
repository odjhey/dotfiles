local g = vim.g
g.mapleader = " "
g.maplocalleader = "\\"

local o = vim.o
o.listchars = "tab:▸ ,trail:·,extends:>,precedes:<,nbsp:␣"

o.shiftwidth = 2
o.tabstop = 2

o.signcolumn = "yes"

o.undofile = true

o.colorcolumn = "120"
o.cursorline = true

-- search
o.ignorecase = true
o.smartcase = true

-- diagnostics
local diagnostic = vim.diagnostic
diagnostic.config({ virtual_text = true })

-- Clipboard: NOT synced with system clipboard
-- Use "+y or "*y to explicitly yank to system clipboard
-- Use "+p or "*p to paste from system clipboard
-- o.clipboard = "unnamedplus"
