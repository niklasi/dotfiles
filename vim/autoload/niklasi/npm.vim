function! niklasi#npm#get_package_json(file) abort
  let l:path=fnamemodify(a:file, ':p')
  while 1
    let l:path=fnamemodify(l:path, ':h')
    let l:candidate=l:path . '/package.json'
    if filereadable(l:candidate)
      " return l:candidate
      let l:json = readfile(l:candidate)
      let l:dict = json_decode(join(l:json))
      return l:dict
    endif
    if l:path == '' || l:path == '/'
      return []
    endif
  endwhile
endfunction
