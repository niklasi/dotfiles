local options = {
  showcmd = true,                         -- Display incomplete commands
  showmode = true,                        -- Display the mode you're in.
  backspace = "indent,eol,start",         -- Intuitive backspacing.
  hidden = true,                          -- Handle multiple buffers better.
  wildmenu = true,                        -- Enhanced command line completion.
  wildmode = "list:longest",              -- Complete files like a shell.
  ignorecase = true,                      -- Case-insensitive searching.
  smartcase = true,                       -- But case-sensitive if expression contains a capital letter.
  number = true,                          -- Show current line number.
  relativenumber = true,                  -- Show relative numbers.
  ruler = true,                           -- Show cursor position.
  incsearch = true,                       -- Highlight matches as you type.
  wrap = false,                           -- Turn on line wrapping.
  scrolloff = 3,                          -- Show 3 lines of context around the cursor.
  title = true,                           -- Set the terminal's title
  visualbell = false,                     -- No beeping.
  errorbells = false,				              -- No beeping.
  backup = false,                         -- Don't make a backup before overwriting a file.
  writebackup = false,                    -- And again.
  swapfile = false,                       -- And again.
  tabstop = 2,                            -- Global tab width.
  shiftwidth = 2,                         -- And again, related.
  expandtab = true,                       -- Use spaces instead of tabs
  laststatus = 2,                         -- Show the status line all the time
  smartindent = true,
  autoindent = true,
  foldenable = false,                     -- Disable code folding
  splitright = true,                      -- Open split to the right side
  cmdheight = 2
}

vim.cmd "set wildignore+=*.DS_Store"          -- Mac Support bootstrap
vim.cmd "set wildignore+=*/_build**"                  -- Mac Support bootstrap

for k, v in pairs(options) do
  vim.opt[k] = v
end
