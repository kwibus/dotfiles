" reservie background color" {{{
function! ReverseBackground()
if &background==# 'light'
  set background=dark
  " AirlineTheme powerlineish
else
  set background=light
  " AirlineTheme solarized
endif
  let s:test='colorscheme '.g:colors_name
  execute s:test
endfunction

command! Togglebackground call ReverseBackground()
noremap <F7> :Togglebackground<CR>

"}}}

" jump to tag {{{
let g:rt_cw = ''
function! RT()
  ALEGoToDefinition
  let l:cw = expand('<cword>')
  try
    if l:cw != g:rt_cw
        execute 'tag ' . l:cw
        call search(l:cw,'c',line('.'))
    else
        try
            execute 'tnext'
        catch /.*/
            execute 'trewind'
        endtry
        call search(l:cw,'c',line('.'))
    endif
    let g:rt_cw = l:cw
  catch /.*/
    echo 'no tags on ' . l:cw
  endtry
endfunction
map <C-]> :call RT()<CR>
"}}}

function! <SID>Preserve(command) "{{{
  let l:line = line('.')
  let l:colum = col('.')
  execute a:command
  call cursor(l:line, l:colum)
endfunction
com! StripTrailingWhitespaces call s:Preserve('%s/\s\+$//e')
" }}}

function! <SID>DiffWithSaved() " {{{
  let l:filetype=&filetype
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . l:filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" }}}

function! PlugLoaded(name)
  # TODO warning not loaded
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

function! s:ShowMaps()
  let old_reg = getreg("a")          " save the current content of register a
  let old_reg_type = getregtype("a") " save the type of the register as well
try
  redir @a                           " redirect output to register a
  " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
  silent map | call feedkeys("\<CR>")    
  redir END                          " end output redirection
  vnew                               " new buffer in vertical window
  put a                              " put content of register
  " Sort on 4th character column which is the key(s)
  %!sort -k1.4,1.4
finally                              " Execute even if exception is raised
  call setreg("a", old_reg, old_reg_type) " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function
