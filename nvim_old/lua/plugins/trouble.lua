return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<leader>t", "<cmd>Trouble diagnostics toggle<cr>" },
    },
}
