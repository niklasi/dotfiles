return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    -- show treesitter nodes
    -- 'nvim-treesitter/playground',
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    -- 'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      ensure_installed = {
        'json',
        'yaml',
        'markdown',
        'markdown_inline',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'query',
        'terraform',
        'just',
        'c_sharp',
        'html',
        'css',
        'razor',
        'javascript',
        'typescript',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}
