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
nnoremap <silent> <leader>gs :G<CR>
tnoremap <silent> <leader>c <C-\><C-n>
nnoremap <silent> <leader>z :UndotreeToggle<CR>

xnoremap p "_dP
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

nnoremap <silent> <Leader>e <cmd>Dirvish<CR>
nnoremap <silent> <Leader><Leader>e <cmd>Dirvish %<CR>
let g:dirvish_mode = ':sort ,^.*[\/],'

nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

noremap <C-w>m :MaximizerToggle<CR>

lua require('niklasi.options')
lua require('niklasi.autocommands')
lua require('niklasi.lualine') 
lua require('niklasi.cmp') 
lua require('niklasi.telescope') 
lua require('niklasi.treesitter') 
lua require('niklasi.plugins')
lua require('niklasi.lsp')
lua require('niklasi.dap')

:nohls
