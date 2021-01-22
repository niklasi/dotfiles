set nocompatible                  " Must come first because it changes other options.
set encoding=utf-8

filetype plugin indent on         " Turn on file type detection.
syntax enable                     " Turn on syntax highlighting.

silent! packadd minpac            " Try to load minpac.

if exists('g:loaded_minpac')         " minpac is available.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('wincent/terminus')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('bling/vim-airline')

  call minpac#add('junegunn/fzf.vim')
  set rtp+=~/.fzf   " Add fzf to runtime path
  
  call minpac#add('w0rp/ale')
  call minpac#add('editorconfig/editorconfig-vim')

  call minpac#add('moll/vim-node')

  call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})
  call minpac#add('benmills/vimux', {'type': 'opt'})
  call minpac#add('christoomey/vim-tmux-navigator', {'type': 'opt'})
  call minpac#add('Yggdroot/indentLine')

  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/async.vim')
  call minpac#add('arcticicestudio/nord-vim')
  call minpac#add('machakann/vim-highlightedyank')
  call minpac#add('stsewd/fzf-checkout.vim')

  call minpac#add('jparise/vim-graphql')

  " packloadall " Load all plugins right now
  silent! packadd editorconfig-vim " Load editorconfig-vim right now
  augroup plugins
    autocmd!

    autocmd FileType markdown silent! packadd vim-markdown
    autocmd FileType markdown hi mkdCode ctermbg=0
    autocmd FileType markdown map <leader>r :w!<CR>:w!/tmp/vim-markdown.md<CR>:!pandoc -s -f markdown -t html -o /tmp/vim-markdown.html /tmp/vim-markdown.md<CR>:!open /tmp/vim-markdown.html > /dev/null 2> /dev/null&<CR><CR>

    " add yaml stuffs
    au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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

set splitright                    " Open split to the right side

set cmdheight=2

silent! colorscheme nord

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let mapleader = "\<Space>"

if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

if !exists("g:loaded_tmux_navigator") || &diff
  nnoremap <C-j> <C-w>j
  nnoremap <C-h> <C-w>h
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif


inoremap jj <ESC>

" Sudo tee trick
cmap w!! w !sudo tee % >/dev/null

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9 }}
let $FZF_DEFAULT_OPTS='--reverse'

let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'create': {'keymap': 'ctrl-b'},
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

nnoremap <silent> <C-f> :Ag<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>gb :GBranches<CR>
tnoremap <silent> <leader>c <C-\><C-n>

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

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1

nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>ee :NERDTreeFocus<CR>
nnoremap <Leader><Leader>e :NERDTreeFind<CR>

nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

nnoremap <Leader>gd :ALEGoToDefinition<CR>
nnoremap <Leader>gr :ALEFindReferences<CR>
nnoremap <Leader>rr :ALERename<CR>

let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_set_balloons = 1
let g:ale_enabled = 1

augroup vimrc
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  if executable('npm')
    if $TMUX != ""
      autocmd FileType javascript,typescript nmap <leader>t :VimuxRunCommand("npm test")<cr>
      autocmd FileType javascript,typescript nmap <leader>r :VimuxRunCommand("npm start")<cr>
    else
      autocmd FileType javascript,typescript nmap <leader>t :!npm test<cr>
      autocmd FileType javascript,typescript nmap <leader>r :!npm start<cr>
    endif
    let packagejson = niklasi#npm#get_package_json('<afile>')
    if !empty(packagejson)
      if has_key(packagejson, 'devDependencies')
        let linters = {}
        let fixers = []
        let devDep = packagejson['devDependencies']
        if has_key(devDep, 'standard')
          let linters.javascript = ['standard']
          let linters.typescript = ['tsserver', 'standard']
          call add(fixers, 'standard')
        endif
        if has_key(devDep, 'prettier')
          call add(fixers, 'prettier')
          let linters.html = ['prettier']
          let linters.scss = ['prettier']
        endif
        if has_key(devDep, 'eslint')
          call add(fixers, 'eslint')
          let linters.javascript = ['eslint']
          let linters.typescript = ['tsserver', 'eslint']
        endif
        if !empty(fixers)
          let g:ale_fixers = fixers
        endif
        if !empty(linters)
          let g:ale_linters = linters
        endif
      endif
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
