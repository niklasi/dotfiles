local lspconfig = require 'lspconfig'

local M = {}
M.setup = function(on_attach)
  lspconfig.tailwindcss.setup {
    cmd = { 'npx', '@tailwindcss/language-server', '--stdio' },
    on_attach = on_attach,
  }
end

return M
