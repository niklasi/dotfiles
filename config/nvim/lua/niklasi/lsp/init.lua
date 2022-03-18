local u = require("niklasi.utils")

local lsp = vim.lsp

-- lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     signs = true,
--     virtual_text = true,
-- })

local border_opts = { border = "single", focusable = false, scope = "line" }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
  },
  float = {
    header = "",
    source = "always",
    border = "single",
},
})
-- global.lsp = {
--     border_opts = border_opts,
-- }

local on_attach = function(client, bufnr)

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- commands
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({ float = global.lsp.border_opts })")
    u.lua_command("LspDiagNext", "vim.lsp.diagnostic.goto_next({ float = global.lsp.border_opts })")
    u.lua_command("LspDiagLine", "vim.diagnostic.open_float(nil, {virtual_text = false, source = 'always'})")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

    -- bindings
    u.buf_map("n", "<leader>rr", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "<leader>D", ":LspTypeDef<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[d", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]d", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("n", "<Leader>d", ":LspDiagLine<CR>", nil, bufnr)
    u.buf_map("i", "<C-k>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    -- telescope
    u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    u.buf_map("n", "<Leader>gd", ":LspDef<CR>", nil, bufnr)

    if client.resolved_capabilities.code_action then
        u.buf_map("n", "<Leader>ca", ":LspAct<CR>", nil, bufnr)
        u.buf_map("v", "<Leader>ca", "<Esc><cmd> LspRangeAct<CR>", nil, bufnr)
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("niklasi.lsp.tsserver").setup(on_attach, capabilities)
require("niklasi.lsp.sumneko-lua").setup(on_attach)
require("niklasi.lsp.null-ls").setup(on_attach)
-- require("lsp.jsonls").setup(on_attach, capabilities)
