return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>t", "<cmd>Trouble diagnostics toggle<cr>", mode = "n" }
    },
    config = function()
      require "trouble".setup()
    end
  }
}
