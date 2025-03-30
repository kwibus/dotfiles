" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'

nmap <Leader>v :RunSilent xdg-open /tmp/vim-pandoc-out.pdf&<CR>
nmap <Leader>c :update<Cr> :Pandoc pdf  -o /tmp/vim-pandoc-out.pdf <CR> " toc
" let g:pandoc#compiler#arguments = "--lua-filter=/home/rens/scripts/task-list.lua"
" let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = 'Pandoc pdf -o /tmp/vim-pandoc-out.pdf'

" autocmd BufWritePost *  Dispatch! Pandoc pdf  -o /tmp/vim-pandoc-out.pdf

" syntax region markdownFold start="^\z(#\+\) " end="\(^#\(\z1#*\)\@!#*[^#]\)\@=" transparent fold
" setlocal  foldmethod=syntax
" function! SyncTexForward()
"   let s:syncfile = LatexBox_GetOutputFile()
"   let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
"   exec execstr
" endfunction

" markdown complestion deoplete
"call deoplete#custom#var('omni', 'input_patterns', {
"\ 'pandoc': '@'
"\})

let g:pandoc#syntax#conceal#use=0
let g:livepreview_previewer = 'zathura'

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'terraform']

