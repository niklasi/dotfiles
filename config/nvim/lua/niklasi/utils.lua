local api = vim.api

local get_map_options = function(custom_options)
  local options = { remap = false, silent = true }
  if custom_options then
    options = vim.tbl_extend('force', options, custom_options)
  end
  return options
end

local M = {}

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, get_map_options(opts))
end

for _, mode in ipairs { 'n', 'o', 'i', 'x', 't', 'v' } do
  M[mode .. 'map'] = function(...)
    M.map(mode, ...)
  end
end

M.cmd = function(name, fn_or_cmd)
  vim.api.nvim_create_user_command(name, fn_or_cmd, {})
end

M.buf_cmd = function(name, fn, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr or 0, name, fn, {})
end

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
  vim.api.nvim_feedkeys(M.t(keys), mode or 'i', true)
end

M.warn = function(msg)
  api.nvim_echo({ { msg, 'WarningMsg' } }, true, {})
end

return M
