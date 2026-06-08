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
local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    job_id = vim.bo.channel
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

local function run_cmd(cmd)
  -- Show terminal if it's hidden
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    toggle_terminal()
  end

  vim.fn.chansend(job_id, { cmd })
end

-- Functions which define default execution

---@class CommandOpts
---@field absolute_path string
---@field relative_path string
---@field file_name string

---@class FileMatchRule
---@field file_pattern string
---@field cmd fun(opts: CommandOpts): string?

---@class GroupMatchRule
---@field group_pattern string
---@field cmds (GroupMatchRule|FileMatchRule)[]

---@type GroupMatchRule[]
local cmd_mapping = {
  {
    group_pattern = ".*",
    cmds = {
      {
        file_pattern = "%.sh$",
        cmd = function(opts)
          return "source " .. opts.absolute_path .. "\r\n"
        end
      },
      {
        file_pattern = "%.py$",
        cmd = function(opts)
          return "python3 " .. opts.file_name .. "\r\n"
        end
      }
    }
  }
}

---@return string?
local function get_cmd_to_run()
  ---@type CommandOpts
  local opts = {
    absolute_path = vim.fn.expand("%:p"),
    relative_path = vim.fn.expand("%:."),
    file_name = vim.fn.expand("%:t"),
  }

  ---@param rules (GroupMatchRule|FileMatchRule)[]
  ---@return string?
  local function __get_cmds_to_run(rules)
    for _, rule in ipairs(rules) do
      if rule["group_pattern"] ~= nil then
        if string.match(opts.absolute_path, rule.group_pattern) then
          res = __get_cmds_to_run(rule.cmds)
          if res ~= nil then
            return res
          end
        end
      else
        if string.match(opts.absolute_path, rule.file_pattern) then
          return rule.cmd(opts)
        end
      end
    end
  end

  return __get_cmds_to_run(cmd_mapping)
end

-- Registering commands, keyboard shortcuts

vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})

vim.keymap.set("n", "<C-space>", "<cmd>FloatTerminal<CR>")
vim.keymap.set("n", "<leader>gx", function()
  local cmd = get_cmd_to_run()
  if cmd ~= nil then
    run_cmd(cmd)
  else
    toggle_terminal()
  end
end)

-- Return as module

local M = {}

M.toggle_terminal = toggle_terminal
M.run_cmd = run_cmd

return M
