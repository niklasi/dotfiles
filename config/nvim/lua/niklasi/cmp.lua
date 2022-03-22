local cmp = require 'cmp'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

local sourceNames = {
  nvim_lsp = '[LSP]',
  buffer = '[Buffer]',
  luasnip = '[LuaSnip]',
  nvim_lua = '[NvimLua]',
  path = '[Path]',
}
-- nvim-cmp setup
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp', priority = 100 },
    { name = 'buffer', priority = 2, keyword_length = 5, max_item_count = 5 },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = sourceNames[entry.source.name]
      return vim_item
    end,
  },
}
