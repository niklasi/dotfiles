set nocompatible                  " Must come first because it changes other options.
set encoding=utf-8
call plug#begin('~/dotfiles/vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'sickill/vim-monokai'
Plug 'scrooloose/syntastic'
Plug 'christoomey/vim-tmux-navigator'
Plug 'suan/vim-instant-markdown'
Plug 'moll/vim-node'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'othree/html5.vim'
Plug 'wincent/terminus'
Plug 'benmills/vimux'
Plug 'editorconfig/editorconfig-vim'
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

colorscheme monokai
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

nmap <Leader><Leader> :NERDTreeToggle<CR>
nmap <Leader><Leader><Leader> :NERDTreeFind<CR>
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
nnoremap <Leader>e :e .<CR>
nnoremap <silent> <C-p> :Ag<CR>

function! StandardFix()
  if exists('b:linter') && b:linter == 'standard'
    if executable('standard')
      execute('!standard --fix %')
    endif
  endif
endfunction

augroup standard
  autocmd!
  autocmd bufwritepost *.js silent call StandardFix()
augroup END

" Syntastic
function! LinterHook(config)
  if has_key(a:config, 'linter')
    let b:linter = a:config['linter']
    if a:config['linter'] == 'standard'
      let g:syntastic_javascript_checkers = ['standard']
    endif
  endif

  return 0 " Return 0 to show no error happened
endfunction

call editorconfig#AddNewHook(function('LinterHook'))

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" End Syntastic

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

augroup vimrc
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd FileType coffee setlocal shiftwidth=4 tabstop=4 noexpandtab
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FocusGained * :redraw!

  if executable('npm')
    autocmd FileType javascript nmap <leader>t :VimuxRunCommand("npm test")<cr>
    autocmd FileType javascript nmap <leader>r :VimuxRunCommand("npm start")<cr>
  endif

  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>c <Plug>(go-coverage)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)

  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
    if has("gui_win32")
        set guifont=Consolas:h12:cANSI
    elseif has("gui_macvim")
        set guifont=Inconsolata:h16
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

