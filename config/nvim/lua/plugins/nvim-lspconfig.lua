return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
    vim.lsp.config('*', {
      root_markers = { '.git' },
    })
    -- vim.lsp.config('roslyn', {})
    vim.lsp.enable 'roslyn'
    vim.lsp.enable 'ts_ls'
    vim.lsp.enable 'lua_ls'
    vim.lsp.enable 'gopls'
  end,
}
