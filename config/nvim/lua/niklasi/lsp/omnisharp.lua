local lspconfig = require 'lspconfig'

local pid = vim.fn.getpid()
local omnisharp_bin = 'Omnisharp'

local M = {}
M.setup = function(on_attach, capabilities)
  lspconfig.omnisharp.setup {
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

return M
