local null_ls = require 'null-ls'
local b = null_ls.builtins

local sources = {
  b.formatting.prettier_d_slim.with {
    filetypes = {
      'typescript',
      'typescriptreact',
      'javascriptreact',
      'javascript',
      'html',
      'json',
      'yaml',
      'markdown',
      'toml',
    },
  },
  b.formatting.stylua.with {
    condition = function(utils)
      return utils.root_has_file 'stylua.toml'
    end,
  },
  b.formatting.trim_whitespace.with { filetypes = { 'tmux', 'teal', 'zsh' } },
  b.formatting.shfmt,
  -- b.formatting.eslint_d,

  -- b.diagnostics.eslint.with {
  --   condition = function(utils)
  --     return utils.root_has_file { '.eslintrc', '.eslintrc.js', '.eslintrc.json' }
  --   end,
  -- },
  b.diagnostics.eslint_d.with {
    condition = function(utils)
      return utils.root_has_file { '.eslintrc', '.eslintrc.js', '.eslintrc.json' }
    end,
  },
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  b.diagnostics.teal,
  b.diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },

  b.code_actions.eslint_d,

  b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  null_ls.setup {
    debug = true,
    sources = sources,
    on_attach = on_attach,
  }
end

return M
