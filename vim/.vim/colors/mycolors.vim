hi clear
if exists("syntax_on")
  syntax reset
endif

runtime colors/solarized.vim

let g:colors_name = "mycolors"

highlight SignColumn ctermbg=8
highlight Comment ctermfg=2

let g:indent_guides_auto_colors = 0

if &background=="dark"
    hi IndentGuidesEven ctermbg=black
else
    highlight normal ctermbg=white
    highlight  IndentGuidesEven ctermbg=white
endif

