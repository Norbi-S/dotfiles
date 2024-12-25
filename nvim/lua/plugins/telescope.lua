return {
    'nvim-telescope/telescope.nvim',
    dependencies = { "nvim-lua/plenary.nvim", },
    keys = {
        { '<leader>pf', '<cmd>Telescope find_files<cr>', mode = 'n' },
        { '<C-p>',      '<cmd>Telescope git_files<cr>',  mode = 'n' },
        { '<leader>ps', '<cmd>Telescope live_grep<cr>',  mode = 'n' },
        { '<leader>ph', '<cmd>Telescope help_tags<cr>',  mode = 'n' }
    },
}
