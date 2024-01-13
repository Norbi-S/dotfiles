return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { "nvim-lua/plenary.nvim", "folke/flash.nvim" },
    keys = {
        { '<leader>pf', '<cmd>Telescope find_files<cr>', mode = 'n' },
        { '<C-p>',      '<cmd>Telescope git_files<cr>',  mode = 'n' },
        { '<leader>ps', '<cmd>Telescope live_grep<cr>',  mode = 'n' },
        { '<leader>ph', '<cmd>Telescope help_tags<cr>',  mode = 'n' }
    },
    opts = function(_, opts)
        local function flash(prompt_bufnr)
            require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                    mode = "search",
                    exclude = {
                        function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                        end,
                    },
                },
                action = function(match)
                    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                    picker:set_selection(match.pos[1] - 1)
                end,
            })
        end
        opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
            mappings = {
                n = { s = flash },
                i = { ["<c-s>"] = flash },
            },
        })
    end
}
