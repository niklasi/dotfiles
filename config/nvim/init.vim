let mapleader = "\<Space>"
let g:nord_disable_background = v:true
let g:nord_italic = v:true
lua require('nord').set()
silent! colorscheme nord

if has("persistent_undo")
    set undodir=$HOME/.undodir
    set undofile
endif

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

" Sudo tee trick
cmap w!! w !sudo tee % >/dev/null

nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <C-f> <cmd>Telescope live_grep<cr>
nnoremap <silent> <C-b> <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <silent> <leader>gb <cmd>Telescope git_branches<cr>
" nnoremap <silent> <C-f> :Ag<CR>
" nnoremap <silent> <C-p> :GFiles<CR>
" nnoremap <silent> <C-b> :Buffers<CR>
" nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gs :G<CR>
" nnoremap <silent> <leader>gb :GBranches<CR>
tnoremap <silent> <leader>c <C-\><C-n>
nnoremap <silent> <leader>z :UndotreeToggle<CR>

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

nnoremap <Leader>e :Dirvish<CR>
nnoremap <Leader><Leader>e :Dirvish %<CR>
let g:dirvish_mode = ':sort ,^.*[\/],'
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
augroup END

nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

" zoom a vim pane, <C-w>= to re-balance
" nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
" nnoremap <leader>= :wincmd =<cr>

" nnoremap <Leader>gd :ALEGoToDefinition<CR>
" nnoremap <Leader>gr :ALEFindReferences<CR>
" nnoremap <Leader>rr :ALERename<CR>
" nnoremap <Leader>ca :ALECodeAction<CR>
" vnoremap <Leader>ca :ALECodeAction<CR>

" let g:airline_powerline_fonts = 1
lua require('lualine').setup({options = {theme = 'nord'}})

noremap <C-w>m :MaximizerToggle<CR>

augroup vimrc
  autocmd!

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
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
  endif

augroup END

lua require('niklasi.plugins')
lua require('niklasi.lsp')

:nohls
