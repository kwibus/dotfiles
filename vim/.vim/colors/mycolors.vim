hi clear
if exists('syntax_on')
  syntax reset
endif

" runtime colors/solarized8.vim
runtime colors/NeoSolarized.vim
" runtime colors/base16-default.vim
let g:solarized_diffmode='high'
let g:colors_name = 'mycolors'

" highlight SignColumn ctermbg=8
highlight MyTodo ctermfg=red

highlight ToLong ctermfg=red
highlight IndentGuidesEven ctermbg=black
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

" set higlight spelling error underline not a color
highlight clear  SpellBad
highlight SpellBad cterm=underline
highlight SpellBad gui=undercurl

 highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE 
