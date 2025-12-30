local lspconfig = require 'lspconfig'

local M = {}
M.setup = function(on_attach, capabilities)
  -- local ts_utils = require("nvim-lsp-ts-utils")

  lspconfig.ts_ls.setup {
    cmd = { 'typescript-language-server', '--stdio' },
    -- init_options = ts_utils.init_options,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

return M
