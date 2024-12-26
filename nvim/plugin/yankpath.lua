local yank_path = function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end

local yank_file = function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end

-- Register commands
vim.api.nvim_create_user_command("YankPath", yank_path, {})
vim.api.nvim_create_user_command("YankFile", yank_file, {})

-- Keybindings
vim.keymap.set("n", "<leader>cp", "<cmd>YankPath<CR>")
vim.keymap.set("n", "<leader>cf", "<cmd>YankFile<CR>")
