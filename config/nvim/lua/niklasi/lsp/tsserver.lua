local lspconfig = require 'lspconfig'

local M = {}
M.setup = function(on_attach, capabilities)
  -- local ts_utils = require("nvim-lsp-ts-utils")

  lspconfig.tsserver.setup {
    cmd = { 'npx', 'typescript-language-server', '--stdio' },
    -- init_options = ts_utils.init_options,
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

return M
