set nocompatible                  " Must come first because it changes other options.
set encoding=utf-8

filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

silent! packadd minpac            " Try to load minpac.

if exists('*minpac#init')         " minpac is available.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('wincent/terminus')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('bling/vim-airline')
  call minpac#add('joshdick/onedark.vim')

  call minpac#add('junegunn/fzf.vim')
  set rtp+=~/.fzf      " Add fzf to runtime path
  
  call minpac#add('w0rp/ale')
  call minpac#add('editorconfig/editorconfig-vim')

  call minpac#add('moll/vim-node')
  call minpac#add('pangloss/vim-javascript')

  call minpac#add('suan/vim-instant-markdown', {'type': 'opt'})
  call minpac#add('fatih/vim-go', {'type': 'opt'})
  call minpac#add('othree/html5.vim', {'type': 'opt'})
  call minpac#add('benmills/vimux', {'type': 'opt'})
  call minpac#add('christoomey/vim-tmux-navigator', {'type': 'opt'})

  " packloadall " Load all plugins right now
  silent! packadd editorconfig-vim " Load editorconfig-vim right now
  silent! packadd onedark.vim " Load onedark right now
  
  augroup plugins
    autocmd!

    autocmd FileType markdown silent! packadd vim-instant-markdown
    autocmd FileType html silent! packadd html5.vim
    autocmd FileType go silent! packadd vim-go

    if $TMUX != ""
      silent! packadd vimux
      silent! packadd vim-tmux-navigator
    endif

  augroup END

  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
endif

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

silent! colorscheme onedark
silent! set background=dark
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

nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:ale_fix_on_save = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_enabled = 0

augroup vimrc
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
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

  if exists("g:loaded_EditorConfig")
      function! LinterHook(config)
        if has_key(a:config, 'linter')
          let g:ale_fixers = {&filetype: [a:config['linter']]}
          let g:ale_linters = {&filetype: [a:config['linter']]}
          let g:ale_enabled = 1
        endif

      return 0 " Return 0 to show no error happened
    endfunction
    call editorconfig#AddNewHook(function('LinterHook'))
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
