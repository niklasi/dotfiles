local telescope_status_ok, telescope = pcall(require, 'telescope.builtin')
local u = require 'niklasi.utils'

local lsp = vim.lsp

-- lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     signs = true,
--     virtual_text = true,
-- })

local border_opts = { border = 'single', focusable = false, scope = 'line' }

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, border_opts)
vim.diagnostic.config {
  virtual_text = {
    source = 'if_many',
  },
  float = {
    header = '',
    source = 'always',
    border = 'single',
  },
}
-- global.lsp = {
--     border_opts = border_opts,
-- }

local formatting_group = vim.api.nvim_create_augroup('formatting', { clear = true })
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- commands
  u.buf_cmd('LspFormatting', function()
    vim.lsp.buf.formatting()
  end, bufnr)
  u.buf_cmd('LspHover', function()
    vim.lsp.buf.hover()
  end, bufnr)
  u.buf_cmd('LspRename', function()
    vim.lsp.buf.rename()
  end, bufnr)
  u.buf_cmd('LspDiagPrev', function()
    vim.lsp.diagnostic.goto_prev { float = client.lsp.border_opts }
  end, bufnr)
  u.buf_cmd('LspDiagNext', function()
    vim.lsp.diagnostic.goto_next { float = client.lsp.border_opts }
  end, bufnr)
  u.buf_cmd('LspDiagLine', function()
    vim.diagnostic.open_float(nil, { virtual_text = false, source = 'always' })
  end, bufnr)
  u.buf_cmd('LspSignatureHelp', function()
    vim.lsp.buf.signature_help()
  end, bufnr)
  u.buf_cmd('LspTypeDef', function()
    vim.lsp.buf.type_definition()
  end, bufnr)
  u.buf_cmd('LspAct', function()
    vim.lsp.buf.code_action()
  end, bufnr)
  u.buf_cmd('LspRangeAct', function()
    vim.lsp.buf.range_code_action()
  end, bufnr)
  u.buf_cmd('LspRef', function()
    if telescope_status_ok then
      telescope.lsp_references()
    else
      vim.lsp.buf.references()
    end
  end, bufnr)
  u.buf_cmd('LspDef', function()
    if telescope_status_ok then
      telescope.lsp_definitions()
    else
      vim.lsp.buf.definition()
    end
  end, bufnr)
  u.buf_cmd('LspSym', function()
    if telescope_status_ok then
      telescope.lsp_workspace_symbols()
    else
      vim.lsp.buf.workspace_symbol()
    end
  end, bufnr)

  -- bindings
  u.nmap('<leader>rr', ':LspRename<CR>', { buffer = bufnr })
  u.nmap('<leader>D', ':LspTypeDef<CR>', { buffer = bufnr })
  u.nmap('K', ':LspHover<CR>', { buffer = bufnr })
  u.nmap('[d', ':LspDiagPrev<CR>', { buffer = bufnr })
  u.nmap(']d', ':LspDiagNext<CR>', { buffer = bufnr })
  u.nmap('<leader>d', ':LspDiagLine<CR>', { buffer = bufnr })
  u.imap('<C-k>', ':LspSignatureHelp<CR>', { buffer = bufnr })

  u.nmap('<leader>gr', ':LspRef<CR>', { buffer = bufnr })
  u.nmap('<leader>gd', ':LspDef<CR>', { buffer = bufnr })

  if client.server_capabilities.codeActionProvider then
    u.nmap('<Leader>ca', ':LspAct<CR>', { buffer = bufnr })
    u.vmap('<Leader>ca', '<Esc><cmd> LspRangeAct<CR>', { buffer = bufnr })
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = formatting_group }
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
      group = formatting_group,
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('niklasi.lsp.tsserver').setup(on_attach, capabilities)
require('niklasi.lsp.lua-ls').setup(on_attach)
require('niklasi.lsp.null-ls').setup(on_attach)
require('niklasi.lsp.tailwindcss').setup(on_attach)
require('niklasi.lsp.omnisharp').setup(on_attach, capabilities)
-- require("lsp.jsonls").setup(on_attach, capabilities)
