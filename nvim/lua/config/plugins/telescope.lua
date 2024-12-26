return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { "ThePrimeagen/harpoon" },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('harpoon')

      vim.keymap.set("n", "<leader>ph", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<leader>pf", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>pc", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end)
      vim.keymap.set("n", "<space>pp", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      require("config.telescope.multigrep").setup()

      vim.keymap.set("n", "<leader>pe", "<cmd>Telescope harpoon marks<CR>")
    end
  }
}
