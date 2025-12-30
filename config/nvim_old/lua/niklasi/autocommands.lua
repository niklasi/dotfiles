vim.cmd [[
  augroup dirvish_config
    autocmd!
    autocmd FileType dirvish silent! unmap <buffer> <C-p>
  augroup END

  augroup vimrc
    autocmd!

    " automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =

    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    
    autocmd FileType http nmap <buffer> <leader>r <Plug>RestNvim;
    autocmd FileType http nmap <buffer> <leader>t <Plug>RestNvimPreview;

    autocmd FileType lua silent! nmap <buffer> <leader>r :so %<cr>

    if executable('npm')
      if $TMUX != ""
        autocmd FileType javascript,typescript nmap <buffer> <leader>t :VimuxRunCommand("npm test")<cr>
        autocmd FileType javascript,typescript nmap <buffer> <leader>r :VimuxRunCommand("npm start")<cr>
      else
        autocmd FileType javascript,typescript nmap <buffer> <leader>t :!npm test<cr>
        autocmd FileType javascript,typescript nmap <buffer> <leader>r :!npm start<cr>
      endif
    endif

  augroup END
]]
