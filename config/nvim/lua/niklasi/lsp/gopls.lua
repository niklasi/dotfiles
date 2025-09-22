local M = {}

M.setup = function(on_attach)
  require('lspconfig').gopls.setup {
    cmd = { 'gopls' },
    -- for postfix snippets and analyzers
    on_attach = on_attach,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
  }
end

return M
