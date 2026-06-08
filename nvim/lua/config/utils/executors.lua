-- Functions which defined default executions

---@class CommandOpts
---@param absolute_path string
---@param absolute_path_without_extension string
---@param relative_path string
---@param file_name string
---@param file_name_without_extension string

---@class FileMatchRule
---@field file_pattern string
---@field cmd fun(opts: CommandOpts): string?

---@class GroupMatchRule
---@field group_pattern string
---@field cmds (GroupMatchRule|FileMatchRule)[]

local cmd_mapping = {
  {
    group_pattern = ".*",
    cmds = {
      {
        file_pattern = "%.sh$",
        cmd = function(opts)
          return "bash " .. opts.absolute_path .. "\r\n"
        end
      }
    }
  },
}

---@return string[]
local function get_cmds_to_run()
  ---@type CommandOpts
  local opts = {
    absolute_path = vim.fn.expand("%:p"),
    absolute_path_without_extension = vim.fn.expand("%:p:r"),
    relative_path = vim.fn.expand("%:."),
    file_name = vim.fn.expand("%:t"),
    file_name_without_extension = vim.fn.expand("%:t:r"),
  }

  local cmds = {}

  ---@param rules (GroupMatchRule|FileMatchRule)[]
  local function __get_cmds_to_run(rules)
    for _, rule in ipairs(rules) do
      if rule["group_pattern"] ~= nil then
        if string.match(opts.absolute_path, rule.group_pattern) then
          __get_cmds_to_run(rule.cmds)
        end
      else
        if string.match(opts.absolute_path, rule.file_pattern) then
          local cmd = rule.cmd(opts)
          if cmd ~= nil then
            table.insert(cmds, cmd)
          end
        end
      end
    end
  end

  __get_cmds_to_run(cmd_mapping)
  return cmds
end

local M = {}
M.get_cmds_to_run = get_cmds_to_run
return M
