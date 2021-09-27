local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
cmp.setup {
  -- snippet = {
  --   expand = function(args)
  --     require('luasnip').lsp_expand(args.body)
  --   end,
  -- },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C->'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    -- ['<Tab>'] = function(fallback)
    --   if vim.fn.pumvisible() == 1 then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    --   -- elseif luasnip.expand_or_jumpable() then
    --   --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    --   else
    --     fallback()
    --   end
    -- end,
    -- ['<S-Tab>'] = function(fallback)
    --   if vim.fn.pumvisible() == 1 then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
    --   -- elseif luasnip.jumpable(-1) then
    --   --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
    --   else
    --     fallback()
    --   end
    -- end,
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  },
}

require("null-ls").config {}
require("lspconfig")["null-ls"].setup {}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  
  if client.resolved_capabilities.document_formatting then
    -- vim.api.nvim_exec([[
    -- augroup LspAutocommands
    --          autocmd! * <buffer>
    --          autocmd BufWritePost <buffer> LspFormatting
    --     augroup END
    --      ]], true)
  end
end


nvim_lsp.tsserver.setup{
  cmd = { "npx", "typescript-language-server", "--stdio" },
  on_attach = function (client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,

      -- import all
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_opts = {},

      -- formatting
      enable_formatting = true,
      formatter = "prettier_d_slim",
      formatter_opts = {},

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
    vim.cmd("command -buffer Formatting lua vim.lsp.buf.formatting()")
    vim.cmd("command -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")

    -- format on save
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    on_attach(client)
  end
}

--local linter = {
--  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
--  -- lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--  lintIgnoreExitCode = true,
--  lintStdin = true,
--  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
--  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--  formatStdin = true
--}
--local formatter  = {
--  -- formatCommand = "./node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}",
--  formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
--  formatStdin = true
--}

--local languages = {
--  --lua = {luafmt},
--  typescript = {formatter, linter},
--  javascript = {formatter, linter},
--  typescriptreact = {formatter, linter},
--  ['typescript.tsx'] = {formatter, linter},
--  javascriptreact = {formatter, linter},
--  ['javascript.jsx'] = {formatter, linter},
--  vue = {formatter, linter},
--  yaml = {formatter},
--  json = {formatter},
--  html = {formatter},
--  scss = {formatter},
--  css = {formatter},
--  markdown = {formatter},
--}

--nvim_lsp.efm.setup{
--  settings = ...,
--  on_attach = on_attach,
--  cmd = { "efm-langserver" },
--  root_dir = function(fname)
--    local cwd = nvim_lsp.util.root_pattern("tsconfig.json")(fname) or
--    nvim_lsp.util.root_pattern(".eslintrc", ".git")(fname) or
--    nvim_lsp.util.root_pattern("package.json", ".git/")(fname);
--    return cwd
--  end,
--  filetypes = vim.tbl_keys(languages),
--  init_options = {
--    documentFormatting = true
--  },
--  settings = {
--    rootMarkers = { "package.json", ".git" },
--    lintDebounce = 500,
--    languages = languages
--  },
--}

--local filetypes = {
--    typescript = "eslint",
--    typescriptreact = "eslint",
--}

-- local linters = {
--     eslint = {
--         sourceName = "eslint",
--         command = "eslint",
--         rootPatterns = {".eslintrc.js", "package.json"},
--         debounce = 100,
--         args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--         parseJson = {
--             errorsRoot = "[0].messages",
--             line = "line",
--             column = "column",
--             endLine = "endLine",
--             endColumn = "endColumn",
--             message = "${message} [${ruleId}]",
--             security = "severity"
--         },
--         securities = {[2] = "error", [1] = "warning"}
--     }
-- }
-- local formatters = {
--     prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
-- }
-- local formatFiletypes = {
--     typescript = "prettier",
--     typescriptreact = "prettier"
-- }
-- nvim_lsp.diagnosticls.setup {
--     cmd = { "npx", "diagnostic-languageserver", "--stdio" },
--     on_attach = on_attach,
--     filetypes = vim.tbl_keys(filetypes),
--     init_options = {
--         filetypes = filetypes,
--         linters = linters,
--         formatters = formatters,
--         formatFiletypes = formatFiletypes
--     }
-- }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "tsserver" }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   }
-- end
