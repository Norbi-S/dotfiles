return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    opts = {},
    keys = {
        { '<leader>pt', '<cmd>TodoTrouble<cr>', mode = 'n' },
    },
}
