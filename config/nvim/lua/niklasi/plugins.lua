local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
  'tpope/vim-dadbod',

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
    },
  },
  'MDeiml/tree-sitter-markdown',
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
  'mbbill/undotree',
  'psliwka/vim-smoothie',
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
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

  'hrsh7th/nvim-cmp',     -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer',   -- Buffer source for nvim-cmp
  'hrsh7th/cmp-nvim-lua', --Neovim lua api
  'hrsh7th/cmp-path',     --Neovim lua api
  'nvim-lua/plenary.nvim',
  'szw/vim-maximizer',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      -- show treesitter nodes
      'nvim-treesitter/playground',
    },
  },

  {
    'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort ,^.*[\\/],'
    end,
  },
  'roginfarrer/vim-dirvish-dovish',
}, {
  install = { missing = true, colorscheme = { 'nord' } },
})
