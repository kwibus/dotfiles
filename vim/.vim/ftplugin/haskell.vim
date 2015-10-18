setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

let g:syntastic_haskell_hdevtools_args= '-g -Wall'
let g:syntastic_haskell_scan_args= "-jfalse -l110 -cf"

let g:syntastic_haskell_checkers=['ghcmod','hlint','scan']

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
\       'args': ['-x'],
\       'fileoutput_opt': '-f ',
\       'stdout_opt': '-o-',
\       'recurse_flag': '-R'
\   }
\}
nnoremap <silent> <leader>] :GhcModTypeClear<CR>
nnoremap <silent> <leader>\\  :GhcModType<CR> 
