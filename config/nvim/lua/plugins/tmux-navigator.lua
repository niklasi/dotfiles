local function inTmux()
  return vim.env.TMUX ~= nil
end

return {
  'christoomey/vim-tmux-navigator',
  cond = inTmux,
}
