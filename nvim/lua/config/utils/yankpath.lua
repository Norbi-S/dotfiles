local function copy_to_clipboard(str)
  vim.fn.setreg("+", str)
  print("Copied to clipboard: " .. str)
end

local yank_absolute_path = function()
  local path = vim.fn.expand("%:p")
  copy_to_clipboard(path)
end

local yank_relative_path = function()
  local path = vim.fn.expand("%:.")
  copy_to_clipboard(path)
end

local yank_file = function()
  local path = vim.fn.expand("%:t")
  copy_to_clipboard(path)
end

-- Keybindings
vim.keymap.set("n", "<leader>cp", yank_relative_path)
vim.keymap.set("n", "<leader>ca", yank_absolute_path)
vim.keymap.set("n", "<leader>cf", yank_file)
