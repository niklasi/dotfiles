return {
  'hoob3rt/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup { options = { theme = 'nord' } }
  end,
}
