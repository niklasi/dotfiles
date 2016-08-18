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

set number                        " Show line numbers.
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

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

autocmd FileType coffee setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set laststatus=2                  " Show the status line all the time

colorscheme monokai
set background=dark
hi Normal ctermbg=NONE

set smartindent
set autoindent
set foldenable "Enable code folding
set mousehide "Hide mouse when typing

autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let mapleader = "\<Space>"

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jj <ESC>

nmap <Leader><Leader> :
nmap ö ;
nmap Ö ,
nmap ^ <space>}
nmap Å {
" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <C-y><C-y> "+yy

nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e .<CR>
nnoremap <silent> <C-p> :FZF<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['standard']
autocmd bufwritepost *.js silent !standard-format -w %
set autoread
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" End Syntastic

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au FileType javascript nmap <leader>t :!npm test<cr>
au FileType javascript nmap <leader>r :!npm start<cr>

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd bufwritepost .vimrc source $MYVIMRC

" let g:ctrlp_use_caching = 0
" if executable('ag')
"   set grepprg=ag\ --nogroup\ --nocolor

"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" else
"   let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"   let g:ctrlp_prompt_mappings = {
"         \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"         \ }
" endif

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

