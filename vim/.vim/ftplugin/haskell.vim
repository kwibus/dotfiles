let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

if executable('hscope' )
    set cscopeprg=hscope
endif

inoreab <buffer> int Int
inoreab <buffer> integer Integer
inoreab <buffer> string String
" inoreab <buffer> double Double
inoreab <buffer> float Float

" hindent {{{
let g:hindent_style = 'chris-done' "}}}
" https://github.com/eagletmt/neco-ghc
let g:haskellmode_completion_ghc = 0
setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
let g:necoghc_debug=1
" let b:closer = 1 |
" let b:closer_flags = '([{'

let g:ale_linters = {
\   'haskell': ['stack-build','hlint'],
\}
let g:ale_haskell_hdevtools_options  = '-S -g -Wall -g -dynamic'
let g:syntastic_haskell_hdevtools_args = '-S -g -Wall -g -dynamic'

let g:syntastic_haskell_scan_args= '-jfalse -l110 -cf'

set makeprg=cabal\ build
" let g:neomake_autolint_enabled=0 "try ale
let g:neomake_haskell_enabled_makers =['hdevtools','hlint']
let g:syntastic_haskell_checkers=['ghcmod','hlint','scan']  "ghcmod, new versio of ghcmod do not work

" if has('nvim')
" else
"     autocmd BufWritePost * GhcModCheckAndLintAsync
" endif
" tagbar hasktags {{{
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
"}}}
"easyTags hasktags {{{
let  g:easytags_languages = {
\   'haskell': {
\       'cmd': 'hasktags',
\       'args': [],
\       'fileoutput_opt': '-o ',
\       'stdout_opt': '-o-',
\       'recurse_flag': ''
\   }
\}
"}}}
" nnoremap <silent> <leader>] :GhcModTypeClear<CR>
" nnoremap <silent> <leader>\\  :GhcModType<CR>
nmap <leader>w :GhcModTypeInsert<CR>
nmap <leader>s :GhcModSplitFunCase<CR>
nmap <silent><leader>t :GhcModType<CR>
nmap <leader>q :GhcModTypeClear<CR>

" does not work yet
let g:projectionist_heuristics = {
      \   'tests/': {
      \   'src/*.hs': {'alternate': 'tests/Test{}.hs'},
      \   'tests/Test*.hs': {'alternate' : 'src/{}.hs'}
      \   }
      \ }

" this will give problems if i ever enable autosove
autocmd BufWritePre * StripTrailingWhitespaces

" "{{{
" function! s:CabalCargs(args)
"    let l:output = system('cabal-cargs ' . a:args)
"    if v:shell_error != 0
"       let l:lines = split(l:output, '\n')
"       echohl ErrorMsg
"       echomsg 'args: ' . a:args
"       for l:line in l:lines
"          echomsg l:line
"       endfor
"       echohl None
"       return ''
"    endif
"    return l:output
" endfunction
"
" function! s:HdevtoolsOptions()
"     return s:CabalCargs('--format=hdevtools --sourcefile=' . shellescape(expand('%')))
" endfunction
"
"
" function! s:InitHaskellVars()
"    if filereadable(expand('%'))
"
"     let g:syntastic_haskell_hdevtools_args=  s:HdevtoolsOptions() " '-g -Wall'
"       let g:hdevtools_options = s:HdevtoolsOptions()
"    endif
" endfunction
"
" call s:InitHaskellVars()
" "}}}
