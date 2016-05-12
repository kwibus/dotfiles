if executable('hscope' )
    set cscopeprg=hscope
endif
setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

" let b:closer = 1 |
" let b:closer_flags = '([{'

let g:syntastic_haskell_hdevtools_args= '-g -Wall'
let g:syntastic_haskell_scan_args= "-jfalse -l110 -cf"
set makeprg=cabal\ build
" let g:syntastic_haskell_checkers=['hdevtools''hlint','scan']  "ghcmod, new versio of ghcmod do not work

" if has('nvim')
" else
"     autocmd BufWritePost * GhcModCheckAndLintAsync
" endif
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
let g:easytags_languages = {
\   'haskell': {
\       'cmd': 'hasktags',
\       'args': [],
\       'fileoutput_opt': '-o ',
\       'stdout_opt': '-o-',
\       'recurse_flag': ''
\   }
\}
"
" nnoremap <silent> <leader>] :GhcModTypeClear<CR>
" nnoremap <silent> <leader>\\  :GhcModType<CR> 
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
