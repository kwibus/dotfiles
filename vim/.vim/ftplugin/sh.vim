" bash workournd fold{{{
    let g:sh_fold_enabled=5
    let g:is_bash=1
    set foldmethod=syntax
" }}}
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }

let g:neomake_sh_enabled_makers =['sh', 'checkbashisms', 'shellcheck']
" syntastic
let g:syntastic_sh_checkers=['sh', 'checkbashisms', 'shellcheck']

let g:syntastic_sh_shellcheck_args = '-x'
let g:syntastic_sh_checkbashisms_args = '-x'

set completefunc=zsh_completion#Complete


