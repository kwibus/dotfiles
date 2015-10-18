
" clang outo complet plugin(c,c++)
"     noremap <leader>u :call g:ClangUpdateQuickFix()<CR>
    let g:clang_auto_select = 1
    " If equal to 0, nothing is selected
    " If equal to 1, automatically select the first entry in the popup menu, but
    " without inserting it into the code
    " If equal to 2, automatically select the first entry in the popup menu, and
    " insert it into the code

    let g:clang_complete_copen = 0
    let g:clang_periodic_quickfix =1
    let g:clang_close_preview= 1
    let g:clang_snippets_engine = 'ultisnips'
    let g:clang_snippets = 1
    let g:clang_user_options = '-std=c++11'

    let g:neocomplcache_force_omni_patterns.c =
                \ '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp =
                \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.objc =
                \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.objcpp =
                \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" Syntastic
    " let g:syntastic_c_remove_include_errors = 1
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_cpp_checkers = ['clang_check','gcc']
    let g:syntastic_c_auto_refresh_includes = 1

    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_c_compiler = 'clang'
    let g:syntastic_c_check_header = 1

    let g:syntastic_clang_check_config_file='.clang_complete'
    let g:syntastic_cpp_config_file='.clang_complete'
    let g:syntastic_c_cflags_file = '.clang_complete'

" vimux  Todo vind genral alternative
    noremap <leader>t :wa <CR> :call VimuxRunCommand("cd ~/Documenten/projects/fluidsimulator/build/debug/;make")<CR>
    noremap <leader>y :wa <CR> :call VimuxRunCommand("cd ~/Documenten/projects/fluidsimulator/build/debug/; src/FluidSimulation")<CR>


set foldmethod=syntax
    set foldtext=CustomFoldText() 
    function! CustomFoldText()
        "get first non-blank line
        let fs = v:foldstart
        while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
        endwhile
        if fs > v:foldend
            let line = getline(v:foldstart)
        else
            let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
        endif

        let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
        let foldSize = 1 + v:foldend - v:foldstart
        let foldSizeStr = " " . foldSize . " lines "
        let foldLevelStr = repeat("+--", v:foldlevel)
        let lineCount = line("$")
        let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
        let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
        return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
    endfunction 
