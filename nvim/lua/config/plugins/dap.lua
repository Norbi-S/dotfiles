return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text"
    },
    enabled = false,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      vim.keymap.set('n', '<leader>ds', function()
        dap.toggle_breakpoint()
        dap.continue()
        dapui.open()
      end)
      vim.keymap.set('n', '<leader>dx', function()
        dap.terminate()
        dap.clear_breakpoints()
        dapui.close()
      end)
      vim.keymap.set('n', '<leader>dc', dap.continue)
      vim.keymap.set('n', '<leader>dn', dap.step_over)
      vim.keymap.set('n', '<leader>di', dap.step_into)
      vim.keymap.set('n', '<leader>do', dap.step_out)
      vim.keymap.set('n', '<leader>dbt', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>dbx', dap.clear_breakpoints)
      vim.keymap.set('n', '<leader>dbl', dap.list_breakpoints)

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>d?', function()
        dapui.eval(nil, { enter = true })
      end)

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  }
}
