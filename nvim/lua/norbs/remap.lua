vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allow moving blocks of text with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at same spot when merging lines
vim.keymap.set("n", "J", "mzJ`z")

-- Center viewport when doing scrolling/jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Disable "Ex" mode
vim.keymap.set("n", "Q", "<nop>")

-- Format buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Utilities for copying paths and filenames

function YankPath()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    print("Copied to clipboard: " .. path)
end

function YankFile()
    local file = vim.fn.expand("%:t")
    vim.fn.setreg("+", file)
    print("Copied to clipboard: " .. file)
end

vim.keymap.set("n", "<leader>cp", YankPath)
vim.keymap.set("n", "<leader>cf", YankFile)
