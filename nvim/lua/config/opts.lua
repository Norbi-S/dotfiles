-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false

-- Default tab width (0 uses `tabstop` value)
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 0

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"
