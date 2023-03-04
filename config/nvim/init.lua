vim.g.mapleader = ' '

vim.g.nord_disable_background = true
vim.g.nord_italic = true

require('nord').set()

vim.g.dirvish_mode = ':sort ,^.*[\\/],'

require 'niklasi.options'
require 'niklasi.autocommands'
require 'niklasi.lualine'
require 'niklasi.cmp'
require 'niklasi.telescope'
require 'niklasi.treesitter'
require 'niklasi.plugins'
require 'niklasi.lsp'
require 'niklasi.dap'
require 'niklasi.keymaps'
