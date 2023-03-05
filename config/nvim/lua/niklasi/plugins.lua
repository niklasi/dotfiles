local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local function inTmux()
  return vim.env.TMUX ~= nil
end

require('lazy').setup({
  -- use '/Users/niklas/dev/niklasi/dotnet-cli.nvim'
  'sheerun/vim-polyglot',
  'tpope/vim-fugitive',
  'tpope/vim-surround',

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  'wincent/terminus',

  {
    'hoob3rt/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-dap.nvim',
    },
  },

  'MDeiml/tree-sitter-markdown',
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  {
    'benmills/vimux',
    cond = inTmux,
  },

  {
    'christoomey/vim-tmux-navigator',
    cond = inTmux,
  },

  'Yggdroot/indentLine',
  {
    'shaunsingh/nord.nvim',
    config = function()
      vim.cmd 'colorscheme nord'
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
    end,
  },
  'jparise/vim-graphql',
  'mbbill/undotree',
  'psliwka/vim-smoothie',
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'jayp0521/mason-null-ls.nvim',
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      -- Helpers to install LSPs and maintain them
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
  'hrsh7th/cmp-nvim-lua', --Neovim lua api
  'hrsh7th/cmp-path', --Neovim lua api
  {
    -- 'L3MON4D3/LuaSnip',
    -- install jsregexp (optional!).
    -- build = 'make install_jsregexp',
  },
  'nvim-lua/plenary.nvim',
  'szw/vim-maximizer',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      -- show treesitter nodes
      'nvim-treesitter/playground',
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },

  {
    'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort ,^.*[\\/],'
    end,
  },
  'roginfarrer/vim-dirvish-dovish',

  'omnisharp/omnisharp-vim',
  'mfussenegger/nvim-dap',
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  'theHamsta/nvim-dap-virtual-text',

  {
    'rest-nvim/rest.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
  },
}, {
  install = { missing = true, colorscheme = { 'nord' } },
})
