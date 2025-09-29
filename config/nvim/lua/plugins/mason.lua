return {
  'williamboman/mason.nvim',
  dependencies = {
    -- 'williamboman/mason-lspconfig.nvim',
    'nvimtools/none-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    }

    -- require('mason-lspconfig').setup {
    --   ensure_installed = {
    --     'ts_ls',
    --     'lua_ls',
    --     -- 'tailwindcss',
    --     -- 'roslyn',
    --     -- 'rzls',
    --     -- 'json-lsp',
    --     -- 'css-lsp',
    --     -- 'html-lsp'
    --   },
    --   automatic_installation = true,
    --   ui = { check_outdated_servers_on_open = true },
    --   automatic_enable = false,
    -- }
  end,
}
