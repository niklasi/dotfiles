require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'ts_ls', 'lua_ls', 'tailwindcss' },
  automatic_installation = true,
  ui = { check_outdated_servers_on_open = true },
}
