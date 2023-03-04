local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
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

  use '/Users/niklas/dev/niklasi/dotnet-cli.nvim'

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
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-dap.nvim' },
    },
  }

  use 'MDeiml/tree-sitter-markdown'
  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
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
  use {
    'nvim-treesitter/playground',
  }
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'

  use 'omnisharp/omnisharp-vim'
  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
  use 'theHamsta/nvim-dap-virtual-text'

  use {
    'rest-nvim/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('rest-nvim').setup {
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      }
    end,
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
