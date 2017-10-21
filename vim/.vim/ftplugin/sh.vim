    let g:neomake_sh_enabled_makers =['sh', 'checkbashisms', 'shellcheck']
" syntastic
    let g:syntastic_sh_checkers=['sh', 'checkbashisms', 'shellcheck']

    let g:syntastic_sh_shellcheck_args = '-x'
    let g:syntastic_sh_checkbashisms_args = '-x'
