require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'tsserver', 'lua_ls', 'tailwindcss', 'omnisharp' },
  automatic_installation = true,
  ui = { check_outdated_servers_on_open = true },
}
