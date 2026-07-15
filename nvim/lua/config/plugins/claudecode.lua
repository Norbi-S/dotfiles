return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function(_, opts)
      require("claudecode").setup(opts)
      vim.api.nvim_create_autocmd('TermOpen', {
        group = vim.api.nvim_create_augroup('custom-claude-term-open', { clear = true }),
        pattern = '*claude',
        callback = function()
          vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { buffer = opts.buffer })
        end
      })
    end,
    keys = {
      { "<leader>i",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ic", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>if", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ir", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>iC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>im", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>is", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>is",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.45,
      }
    }
  }
}
