local lspconfig = require("lspconfig")

local u = require("niklasi.utils")

local ts_utils_settings = {
    -- debug = true,
    import_all_scan_buffers = 100,
    eslint_bin = "eslint_d",
    eslint_enable_diagnostics = true,

    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,

    eslint_opts = {
        condition = function(utils)
            return utils.root_has_file(".eslintrc.json")
        end,
        diagnostics_format = "#{m} [#{c}]",
    },
    enable_formatting = false,
    formatter = "prettier_d_slim",
    update_imports_on_move = true,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach, capabilities)
    local ts_utils = require("nvim-lsp-ts-utils")

    lspconfig.tsserver.setup({
        cmd = { "npx", "typescript-language-server", "--stdio" },
        init_options = ts_utils.init_options,
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)

            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
            u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
            u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
            u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
        end,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
end

return M
