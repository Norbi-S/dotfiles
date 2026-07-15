return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { {
      "echasnovski/mini.icons",
      opts = {},
      config = function()
        require "mini.icons".setup()
      end
    } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require "oil".setup({
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        confirmation = {
          border = "single",
        },
      })
      vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
    end
  }
}
