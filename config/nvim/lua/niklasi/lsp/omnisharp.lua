local lspconfig = require 'lspconfig'

local pid = vim.fn.getpid()
local omnisharp_bin = '/Users/niklas/.omnisharp/OmniSharp'

local M = {}
M.setup = function(on_attach, capabilities)
  lspconfig.omnisharp.setup {
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
