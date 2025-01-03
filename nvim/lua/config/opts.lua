local set = vim.opt

-- Enable line numbers
set.number = true
set.relativenumber = true

set.wrap = false

-- Default tab width (0 uses `tabstop` value)
set.tabstop = 4
set.softtabstop = 0
set.shiftwidth = 0

set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.scrolloff = 8

set.colorcolumn = "80"

set.signcolumn = "yes:1"
