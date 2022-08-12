set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

                                  " Enhanced command line completion.
set wildmode=longest:full         " Popup in command mode
set pumblend=17
set wildoptions=pum

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show current line number.
set relativenumber                " Show relative numbers.
set ruler                         " Show cursor position.
" set colorcolumn=80
set incsearch                     " Highlight matches as you type.

set breakindent
set linebreak
set showbreak =   

" opt.breakindent = true
" opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
" opt.linebreak = true

" set clipboard+=unnamedplus
set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set novisualbell                  " No beeping.
set noerrorbells				          " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " And again. 

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time

set smartindent
set autoindent
set nofoldenable                  " Disable code folding

set wildignore+=*.DS_Store        " Mac Support bootstrap
set wildignore+=*/_build**        " Mac Support bootstrap

set splitright                    " Open split to the right side

set cmdheight=2

