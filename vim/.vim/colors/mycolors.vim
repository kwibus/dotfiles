hi clear
if exists('syntax_on')
  syntax reset
endif

runtime colors/solarized.vim
" runtime colors/base16-default.vim
let g:solarized_diffmode='high'
let g:colors_name = 'mycolors'

" highlight SignColumn ctermbg=8
highlight MyTodo ctermfg=red
let g:indent_guides_auto_colors = 0
if &background==#'dark'

    highlight Comment ctermfg=grey  "default is to dark fro my tast
    highlight IndentGuidesEven ctermbg=black
else

    highlight Comment ctermfg=darkgrey  "default is to dark fro my tast
    highlight normal ctermbg=white
    " highlight IndentGuidesEven ctermbg=white
endif

 highlight IncSearchCursor ctermfg=0 ctermbg=6
