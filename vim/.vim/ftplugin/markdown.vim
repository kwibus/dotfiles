" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pp :RunSilent pandoc --toc -o /tmp/vim-pandoc-out.pdf %<CR>:RunSilent xdg-open /tmp/vim-pandoc-out.pdf&<CR>

filetype plugin indent on
