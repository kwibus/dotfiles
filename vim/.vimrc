if empty(glob('~/.vim/autoload/plug.vim'))
  " silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    " \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin()
" Plug 'gelguy/Cmd2.vim'
" Plug 'vim-scripts/vim-auto-save'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'clever-f.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'keith/tmux.vim'
Plug 'kana/vim-filetype-haskell'          , {'for': 'haskell'}
" Plug 'dag/vim2hs'                         , {'for': 'haskell'}
Plug 'eagletmt/neco-ghc'                  , {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim'                , {'for': 'haskell'}
Plug 'Twinside/vim-haskellFold'           , {'for': 'haskell'}
Plug 'Twinside/vim-syntax-haskell-cabal'  , {'for': 'haskell'}

Plug 'vim-scripts/a.vim'      , {'for': ['c', 'cpp']}
Plug 'Rip-Rip/clang_complete' , {'for': ['c', 'cpp']}

Plug 'LaTeX-Box-Team/LaTeX-Box'  , {'for': 'tex'}

Plug 'peterhoeg/vim-qml' , {'for': 'qml'}

Plug 'nelstrom/vim-markdown-folding' , {'for': 'markdown'}

Plug 'xolox/vim-easytags' , {'do' : 'mkdir $HOME/.vim/easytags' } | Plug 'xolox/vim-misc'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bkad/CamelCaseMotion'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'Firef0x/PKGBUILD.vim'
" Plug 'Shougo/neocomplcache.vim'
" Plug 'JazzCore/neocomplcache-ultisnips'
Plug 'Shougo/neocomplete.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'chrisbra/Recover.vim'
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'honza/vim-snippets'  "ultisnips
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/vimproc.vim' , {'do':'make'}
Plug 'benmills/vimux'
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-qargs'
Plug 'tommcdo/vim-exchange'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-abolish'
Plug 'airblade/vim-gitgutter'
" Plug 'chrisbra/Colorizer'
call plug#end()

" allows cursor change in tmux mode
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
elseif exists('$TMUX')
    " does it work
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

syntax enable
" incsearch
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    set hlsearch
    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

" Languagetool install global
    let g:languagetool_jar="/usr/share/java/languagetool/languagetool-commandline.jar"

"
" poweerline/airline
  set laststatus=2
  let g:airline_theme='powerlineish'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#bufferline#enabled = 0
  let g:airline#extensions#tabline#buffer_min_count =2
"
"easytags
  let g:easytags_events = ['BufWritePost']
  let g:easytags_dynamic_files = 1

  " let g:easytags_suppress_report = 1
  let g:easytags_by_filetype = "~/.vim/easytags"

"solarized colors scheme
  let g:solarized_termtrans = 1
  set background=dark
  colorscheme mycolors
  " let g:solarized_termcolors=16
  " let g:solarized_termcolors=256
  " set t_Co=256

"neocomplete
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " inoremap <expr> <C-L>     neocomplete#complete_common_string()

    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " let g:neocomplcache_enable_at_startup = 1
    " let g:neocomplcache_min_syntax_length = 3
    " inoremap <expr><S-Space>  neocomplcache#start_manual_complete()
    " inoremap <expr><C-l>  neocomplcache#close_popup()
    " inoremap <expr><C-@> <C-Space>
    " inoremap <C-j> <C-N>
    " inoremap <C-k> <C-p>

let g:neocomplcache_force_overwrite_completefunc = 1

"synntastic plugin syntax cheker

    let g:syntastic_sh_checkers=['sh', 'checkbashisms', 'shellcheck']
    "If enabled, syntastic will do syntax checks when buffers are first loaded as well as on saving
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_check_on_open=0
    let g:syntastic_check_on_wq=0

    let g:syntastic_enable_signs=1
    let g:syntastic_error_symbol = "E>"
    let g:syntastic_style_error_symbol = "e>"
    let g:syntastic_warning_symbol = "W>"
    let g:syntastic_style_warnig_symbol = "w>"
    "
    "Enable this option to tell syntastic to always stick any detected errors into the loclist:
    if (&ft=='c' || &ft=='cpp')"TODO niet gekeken of het werkt
        let g:syntastic_always_populate_loc_list=0
    else
        let g:syntastic_always_populate_loc_list=1
    endif

    "close error list (loclal list window) als de rest ook gesloten is  aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
    aug END
    " if has('autocmd')
        "    autocmd cursorhold * SyntasticCheck
    " endif

"ultisnips
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" git gutter
    let g:gitgutter_escape_grep = 1

"fugative
    " !command Gl Glog --oneline --graph --decorate=short
    " !command Gll Gllog --oneline --graph --decorate=short

" ack.vim
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

scriptencoding utf-8
set encoding=utf-8

" ctrlp
    if executable('git')
        let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    elseif executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    endif
"persistent undo 1

    set undofile                " Save undo's after file closes
    set undodir=$HOME/.vim/undo " where to save undo histories
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo

" fold
    set foldmethod=syntax
    set foldlevelstart=99 "default all folds open


    " set ttymouse=xterm2
    syntax on

    set hidden
    set showcmd
    set number
    set mouse=a
    set title
    set cursorline   " hi CursorLine term=none cterm=none ctermbg=3
    set clipboard=unnamedplus
    set list
    set listchars=tab:▸\ ,eol:¬,trail:_,extends:#,nbsp:.

    set conceallevel=2
    set timeoutlen=4000 ttimeoutlen=0 " solvesl delay escp

    " tab en indent
    filetype plugin indent on
    set smarttab
    set expandtab
    set shiftwidth=4
    set softtabstop=4

    " search highlighting
    set hlsearch
    set incsearch

    set viewoptions=folds

    set virtualedit=block
    set lazyredraw 
    set splitright
    set splitbelow
    set wildmenu
    set wildmode=list,full
    set gdefault " maybe no a good idee
    set scrolloff=7
    set visualbell
    set errorbells

    " wrap
    set wrap
    set linebreak
    set showbreak=~~~
    set showmatch   
    set spellcapcheck = ""
    set spelllang=en,nl

    inoremap l; <Esc>
    inoremap ;l <Esc>

    nnoremap Z <nop>
    nnoremap K <nop>
    nnoremap Q <nop>

    noremap <leader>r :source$MYVIMRC<CR>

    nnoremap <C-S> :<C-u>update<CR>
    inoremap <c-s> <Esc>:update<CR>

    " reverse of <S-J> join for <S-K>
    nnoremap <S-k> i<CR><Esc>==

    " highlight last inserted text
    " doesn`t work
    nnoremap gV `[v`]
    "
" YankRing
    let g:yankring_history_dir='/tmp'
    let g:yankring_history_file = 'vimYankRing'.$USER
    function! YRRunAfterMaps()
        nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
    endfunction
    nnoremap Y y$

    command! Q  q
    command! WQ wq
    command! Wq wq
    command! W w
    cmap w!! w !sudo tee > /dev/null %

    noremap <silent> [l :ll <CR> :lprevious<CR>
    noremap <silent> ]l :ll <CR> :lnext<CR>

    nnoremap <C-i>   <Esc>:tabnext<CR> " <C-i> == tab
    noremap <C-t>    <Esc>:tabnew<CR>


    noremap <C-a>     <Esc>^
    inoremap <C-a>     <Esc>I
    noremap <C-e>     <Esc>g_
    inoremap <C-e>     <Esc>g_a

    noremap <silent><F2>  :UndotreeToggle<CR>
    noremap <silent><F3>  :Tagbar<CR>
    set pastetoggle=<F4>
    nnoremap <silent> <F5> :YRShow<CR>
    noremap <silent> <F8> :set spell!<Cr>

    let g:ctrlp_map = '<F12>'

    let g:multi_cursor_start_key='<F6>'
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

" set completeopt=longest,menuone
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@>  <C-x><C-o>

"This unsets the "last search pattern" register by hitting return
    nnoremap <silent><CR> :noh<CR><CR>

"Better window navigation
    " replaced with tmux plugin
    " nnoremap <C-j> <C-w>j
    " nnoremap <C-k> <C-w>k
    " nnoremap <C-h> <C-w>h
    " nnoremap <C-l> <C-w>l

    " nnoremap <C-S-h>

    map j gj
    map k gk

    noremap <UP> <nop>
    noremap <DOWN> <nop>
    noremap <LEFT> <nop>
    noremap <RIGHt> <nop>

    set backspace=indent,eol,start "indent  allow backspacing over autoindent eol allow backspacing over line breaks (join lines)
    "start   allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert
    " set whichwrap=<,>,[,] " allow cursor key to move past end of aline to the next line

    " highlight SignColumn ctermbg=

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['DARKMAGENTA', 'DARKORCHID3'],
    \ ['BROWN',       'FIREBRICK3'],
    \ ['GRAY',        'ROYALBLUE3'],
    \ ['DARKMAGENTA', 'DARKORCHID3'],
    \ ['DARKBLUE',    'FIREBRICK3'],
    \ ['DARKRED',     'DARKORCHID3'],
    \ ['DARKGREEN',   'ROYALBLUE3'],
    \ ['DARKCYAN',    'SEAGREEN3'],
    \ ['RED',         'FIREBRICK3'],
    \ ]


autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG set ft=gitcommit
autocmd Filetype gitcommit setlocal spell  textwidth=72

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
com! StripTrailingWhitespaces call s:StripTrailingWhitespaces()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


    highlight SignColumn ctermbg=8
    highlight Comment ctermfg=2

" inentGuide
"
" "let g:indent_guides_auto_colors = 0

"  set tw=2 sw=2 noet
  let g:indent_guides_guide_size=1
  let g:indent_guides_start_level=1
  let g:indent_guides_enable_on_vim_startup = 1

function! ReverseBackground()
 if &bg=="light"
    set bg=dark
    AirlineTheme powerlineish
 else
    set bg=light
    AirlineTheme solarized
 endif
    let s:test="colorscheme ".g:colors_name
    execute s:test
endfunction

command! Togglebackground call ReverseBackground()
noremap <F7> :Togglebackground<CR>

function! SearchTODO ()
    Ack "TODO"
    copen
endfunction
command! TODO call SearchTODO()

  cmap <F5> <Plug>(Cmd2Suggest)
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
highlight MyTodo ctermfg=red

highlight ColorColumn ctermbg=lightgrey
call matchadd('ColorColumn', '\%82v', 100)
