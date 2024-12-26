return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }

      local comment = require "mini.comment"
      comment.setup {}
    end
  }
}
