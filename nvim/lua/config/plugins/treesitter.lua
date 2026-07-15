return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local parsers = {
        'bash',
        'c',
        'cpp',
        'comment',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'gitignore',
        'go',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'nginx',
        'odin',
        'php',
        'python',
        'query',
        'regex',
        'ron',
        'rust',
        'scss',
        'svelte',
        'sql',
        'templ',
        'toml',
        'tsv',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
        'zig',
      }
      require("nvim-treesitter.install").install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- check if parses exists and load it
          if not vim.treesitter.language.add(language) then
            return
          end

          -- disable for large files
          local max_filesize = 1024 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return
          end

          -- enable syntax highlighting and other features
          vim.treesitter.start(buf, language)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      })

      -- Custom setup for swift parser
      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_config["swift"] = {
      --   install_info = {
      --     url = "~/.local/share/nvim/tree-sitter-swift/",
      --     files = { "src/parser.c", "src/scanner.c" },
      --   }
      -- }
    end
  }
}
