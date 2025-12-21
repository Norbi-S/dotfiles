local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values
local Path = require("plenary.path")

local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
      results = { "red", "green", "blue" }
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

-- colors()

local template_paths = {
  "/Users/norbs/.config/nvim/templates/templates.json"
}

local function load_templates()
  local result = {}
  for _, path in ipairs(template_paths) do
    local loaded = vim.json.decode(Path:new(path):read())
    vim.list_extend(result, loaded)
  end
  return result
end

local templates = load_templates()
print(vim.inspect(templates))
