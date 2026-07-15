return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
    },
    config = function()
      -- vim.diagnostic.config({ virtual_lines = true })
      vim.diagnostic.config({ virtual_text = true })

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- Lua LSP
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_init = function(client)
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
                vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
              },
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end
      })
      vim.lsp.enable("lua_ls")
      -- Language servers to setup
      local servers = {
        "lua_ls",
        "zls", -- Zig LSP
        -- "gopls", -- Go LSP
        -- PHP LSPs
        -- "phpactor",
        -- "intelephense",
        -- Ruby LSPs
        -- "ruby_lsp",
        -- "rubocop",
        "pylsp", -- Python LSP
        -- "ocamllsp", -- Ocaml LSP
        -- C++ LSPs
        -- "cmake",
        -- "clangd",
        -- "ts_ls", -- Javascript LSPs
        -- "sourcekit", -- Swift LSP
        "rust_analyzer", -- Rust LSP
        "ols",           -- Odin LSP
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Set up formatting on save
          if client.supports_method('textDocument/formatting') then
            -- Fotmat the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end

          -- Keybindings
          local opts = { buffer = args.buf, remap = false }

          -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set('n', '<leader>vh', '<cmd>ClangdSwitchSourceHeader<CR>')
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end
      })
    end,
  }
}
