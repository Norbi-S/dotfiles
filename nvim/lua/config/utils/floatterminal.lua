local executors = require("config.utils.executors")

-- Terminal window management

local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.9)
  local height = opts.height or math.floor(vim.o.lines * 0.9)

  -- Calculate the position to center of the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local job_id = 0
local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    job_id = vim.bo.channel
    vim.keymap.set("n", "<esc>", function()
      vim.api.nvim_win_hide(state.floating.win)
    end, { buffer = state.floating.buf })
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Executing commands

local function run_cmd(cmd)
  -- Show terminal if it's hidden
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    toggle_terminal()
  end

  vim.fn.chansend(job_id, { cmd })
end

local function select_and_run_cmd(cmds)
  vim.ui.select(cmds, {
    prompt = 'Select command to execute:',
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      run_cmd(choice)
    else
      print('Selection cancelled')
    end
  end)
end

-- Register mappings and commands

vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})

vim.keymap.set("n", "<C-space>", "<cmd>FloatTerminal<CR>")
vim.keymap.set("n", "<leader>gx", function()
  local cmds = executors.get_cmds_to_run()

  if table.getn(cmds) == 0 then
    toggle_terminal()
  end

  run_cmd(cmds[1])
end)
vim.keymap.set("n", "<leader>gX", function()
  local cmds = executors.get_cmds_to_run()

  if table.getn(cmds) == 0 then
    print("No commands to run")
    return
  end

  select_and_run_cmd(cmds)
end)

-- Return as a module

local M = {}

M.toggle_terminal = toggle_terminal
M.run_cmd = run_cmd

return M
