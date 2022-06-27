local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  execute 'packadd packer.nvim'
end

vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

local packer = require 'packer'

local function inTmux()
  return vim.env.TMUX ~= nil
end

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'sheerun/vim-polyglot'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  use 'wincent/terminus'
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } },
  }

  use {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
    config = function()
      vim.cmd [[autocmd FileType markdown hi mkdCode ctermbg=0 set wrap]]
      vim.cmd [[autocmd FileType markdown map <leader>mr :w!<CR>:w!/tmp/vim-markdown.md<CR>:!pandoc -s -f markdown -t html -o /tmp/vim-markdown.html /tmp/vim-markdown.md<CR>:!open /tmp/vim-markdown.html > /dev/null 2> /dev/null&<CR><CR>]]
    end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'mkdp#util#install()',
  }

  use {
    'benmills/vimux',
    cond = inTmux,
  }

  use {
    'christoomey/vim-tmux-navigator',
    cond = inTmux,
  }
  use 'Yggdroot/indentLine'

  use 'shaunsingh/nord.nvim'

  use 'jparise/vim-graphql'

  use 'mbbill/undotree'

  use 'psliwka/vim-smoothie'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua' --Neovim lua api
  use 'hrsh7th/cmp-path' --Neovim lua api

  use 'L3MON4D3/LuaSnip'

  use 'nvim-lua/plenary.nvim'

  use 'jose-elias-alvarez/null-ls.nvim'

  use 'szw/vim-maximizer'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
end)
