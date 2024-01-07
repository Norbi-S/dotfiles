-- Toggle trouble
vim.keymap.set("n", "<leader>tt", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").close() end)
