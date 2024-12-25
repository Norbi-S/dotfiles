return {
    "ThePrimeagen/harpoon",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    lazy = false,
    config = function()
        require("harpoon").setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 20,
            }
        })
        require("telescope").load_extension("harpoon")
    end,
}
