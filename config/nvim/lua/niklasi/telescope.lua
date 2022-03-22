local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
  return
end
local u = require 'niklasi.utils'

telescope.setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        mirror = false,
        prompt_position = 'top',
      },
      vertical = {
        mirror = false,
      },
    },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
}
telescope.load_extension 'fzf'

-- lsp
u.command('LspRef', 'Telescope lsp_references')
u.command('LspDef', 'Telescope lsp_definitions')
u.command('LspSym', 'Telescope lsp_workspace_symbols')
u.command('LspAct', 'Telescope lsp_code_actions')
u.command('LspRangeAct', 'Telescope lsp_range_code_actions')
