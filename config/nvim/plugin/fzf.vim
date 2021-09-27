" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9 }}
" let $FZF_DEFAULT_OPTS='--reverse'

" let g:fzf_checkout_git_options = '--sort=-committerdate'
" let g:fzf_branch_actions = {
"       \ 'create': {'keymap': 'ctrl-b'},
"       \ 'diff': {
"       \   'prompt': 'Diff> ',
"       \   'execute': 'Git diff {branch}',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-f',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \}
" " An action can be a reference to a function that processes selected lines
" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   copen
"   cc
" endfunction

" let g:fzf_action = {
"   \ 'ctrl-q': function('s:build_quickfix_list'),
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

