" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pp :RunSilent pandoc --toc -o /tmp/vim-pandoc-out.pdf %<CR>:RunSilent xdg-open /tmp/vim-pandoc-out.pdf&<CR>

" syntax region markdownFold start="^\z(#\+\) " end="\(^#\(\z1#*\)\@!#*[^#]\)\@=" transparent fold
" setlocal  foldmethod=syntax
" function! SyncTexForward()
"   let s:syncfile = LatexBox_GetOutputFile()
"   let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
"   exec execstr
" endfunction
let  g:pandoc#syntax#conceal#use=0
nnoremap <Localleader>ls :call SyncTexForward()<CR>
" setlocal foldmethod=expr
" function! MarkdownLevel()
"     let theline = getline(v:lnum)
"     let nextline = getline(v:lnum+1)
"     if theline =~ '^# ' 
"         " begin a fold of level one here
"             return ">1"
"     elseif theline =~ '^## ' 
"         " begin a fold of level two here
"             return ">2"
"     elseif theline =~ '^### ' 
"         " begin a fold of level three here
"             return ">3"
"     elseif nextline =~ '^===*'
"         " elseif the next line starts with at least two ==
"         return ">1"
"     elseif nextline =~ '^---*'
"         " elseif the line ends with at least two --
"         return ">2"
"     elseif foldlevel(v:lnum-1) != "-1" 
"         return foldlevel(v:lnum-1)
"     else
"         return "="
"     endif
" endfunction
" setlocal  foldexpr=MarkdownLevel()
