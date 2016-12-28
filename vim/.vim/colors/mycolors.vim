hi clear
if exists('syntax_on')
  syntax reset
endif

runtime colors/solarized.vim
" runtime colors/base16-default.vim
let g:solarized_diffmode='high'
let g:colors_name = 'mycolors'

highlight SignColumn ctermbg=8
highlight Comment ctermfg=2
highlight MyTodo ctermfg=red

let g:indent_guides_auto_colors = 0

if &background=='dark'
    hi IndentGuidesEven ctermbg=black
else
    highlight normal ctermbg=white
    " highlight IndentGuidesEven ctermbg=white
endif

