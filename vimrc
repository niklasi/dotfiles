set nocompatible                  " Must come first because it changes other options.
set encoding=utf-8

call plug#begin('~/dotfiles/vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'suan/vim-instant-markdown'
Plug 'moll/vim-node'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'othree/html5.vim'
Plug 'wincent/terminus'
Plug 'benmills/vimux'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'fatih/vim-go'
call plug#end()

filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show current line number.
set relativenumber                " Show relative numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.

set nowrap                        " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.
set noerrorbells				          " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " And again. 
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time

set smartindent
set autoindent
set nofoldenable                  " Disable code folding
set mousehide                     " Hide mouse when typing

set autoread                      " Auto read file when changed outside of vim

set wildignore+=*.DS_Store        " Mac Support bootstrap
set wildignore+=*/_build**        " Mac Support bootstrap

colorscheme onedark
set background=dark
hi Normal ctermbg=NONE

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let mapleader = "\<Space>"

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jj <ESC>

" Sudo tee trick
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>l :redraw!<CR>

" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <C-y><C-y> "+yy

" Move visual blocks up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader><Leader>e :NERDTreeFind<CR>
nnoremap <silent> <C-p> :Ag<CR>

function! LinterHook(config)
  if has_key(a:config, 'linter')
    let g:ale_fixers = {&filetype: [a:config['linter']]}
    let g:ale_linters = {&filetype: [a:config['linter']]}
  else
    let g:ale_enabled = 0
  endif

  return 0 " Return 0 to show no error happened
endfunction


let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:ale_fix_on_save = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

call editorconfig#AddNewHook(function('LinterHook'))

augroup vimrc
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd FileType coffee setlocal shiftwidth=4 tabstop=4 noexpandtab
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  
  if executable('npm')
    if $TMUX != ""
      autocmd FileType javascript nmap <leader>t :VimuxRunCommand("npm test")<cr>
      autocmd FileType javascript nmap <leader>r :VimuxRunCommand("npm start")<cr>
    else
      autocmd FileType javascript nmap <leader>t :!npm test<cr>
      autocmd FileType javascript nmap <leader>r :!npm start<cr>
    endif
  endif

  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
    if has("gui_win32")
        set guifont=Consolas:h12:cANSI
    elseif has("gui_macvim")
        set guifont=Hack:h13
    elseif has("gui_gtk2")
        set guifont=Inconsolata\ 14
    endif
    
    if !exists("g:vimrcloaded")
        winpos 0 0

        if ! &diff
           winsize 160 50
        else
            winsize 227 50
        endif
        
        let g:vimrcloaded = 1
    endif
endif
:nohls
