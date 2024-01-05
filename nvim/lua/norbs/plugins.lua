local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
    },

    {
        'rose-pine/neovim',
        name = 'rose-pine'
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    { "nvim-treesitter/nvim-treesitter-context" },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    { 'mbbill/undotree' },

    { 'tpope/vim-fugitive' },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- LSP Support
            'neovim/nvim-lspconfig',
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
        },
        lazy = true,
    },

    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    {
        "github/copilot.vim",
    },

    {
        "terrortylor/nvim-comment"
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
})
