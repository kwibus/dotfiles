" TODO matbe add Cscope
" TODO maybe fold quickfix
" TODO forward and backward search markdown tex

set encoding=utf-8
scriptencoding utf-8

function! Install()
    if empty(glob('~/.vim/autoload/plug.vim'))
      " silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        " \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
    endif
    call mkdir($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/backup')

endfunction
command! Install call Install()

call plug#begin()

" Plug 'takac/vim-hardtime'
" Plug 'rickhowe/diffchar.vim' " this plugin uses deault mapping
" Plug 'vim-scripts/vim-auto-save'
" Plug 'gelguy/Cmd2.vim'
" Plug 'jalvesaq/vimcmdline'
" Plug 'jpalardy/vim-slime'
" Plug 'Shougo/vimshell.vim'
" Plug 'ujihisa/repl.vim'
" Plug 'cazador481/fakeclip.neovim'

Plug 'AssailantLF/vim-active-numbers' " only number in active window, is this useful?

Plug 'kopischke/vim-stay'
Plug 'kopischke/vim-fetch'
Plug 'Konfekt/FastFold'

Plug 'jceb/vim-editqf' " eddit quickfix is not realy stable consider remove

if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif

Plug 'zirrostig/vim-schlepp' " drag with visual cursor

Plug 'tpope/vim-eunuch' " unix helpers sudowrite,..

Plug 'vim-scripts/matchit.zip'
" Plug 'arnar/vim-matchopen'

Plug 'jamessan/vim-gnupg'

Plug 'vim-scripts/argtextobj.vim'

Plug 'michaeljsmith/vim-indent-object'
Plug 'chrisdone/hindent' , {'for': 'haskell'}
"
Plug 'terryma/vim-smooth-scroll'

if has('nvim')
   Plug 'benekastah/neomake'
else
    Plug 'scrooloose/syntastic'
endif

if exists('$TMUX')
    Plug 'benmills/vimux'
    Plug 'keith/tmux.vim' " syntax  highlight tmuxconfig file
    Plug 'wellle/tmux-complete.vim' " complete text from tmux buffers
endif
Plug 'christoomey/vim-tmux-navigator' " source even when not in tmux becauces it provides windo navigatio in vim


Plug 'Matt-Deacalion/vim-systemd-syntax'     , {'for': 'systemd'}
Plug 'clever-f.vim' " repeat last f with f
Plug 'haya14busa/incsearch.vim' " incremental search

Plug 'gilligan/vim-textobj-haskell'       , {'for': 'haskell'} | Plug 'kana/vim-textobj-user' " defined textobject haskell fucntion ih. maybe remove almost same as ip
" Plug 'kana/vim-filetype-haskell'          , {'for': 'haskell'}

" :let $PATH .= '~/.vim/plugged/lushtags/'
" Plug 'mkasa/lushtags'                     , {'for': 'haskell', 'do': 'cabal sandbox init && cabal install'}
" Plug 'dag/vim2hs'                         , {'for': 'haskell'}
Plug 'itchyny/vim-haskell-indent'         , {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim'                , {'for': 'haskell'} |  Plug 'Shougo/vimproc.vim' , {'do':'make'}
Plug 'Twinside/vim-haskellFold'           , {'for': 'haskell'}
Plug 'Twinside/vim-syntax-haskell-cabal'  , {'for': 'haskell'}

Plug 'vim-scripts/a.vim'      , {'for': ['c', 'cpp']}
Plug 'Rip-Rip/clang_complete' , {'for': ['c', 'cpp']}
Plug 'peterhoeg/vim-qml' , {'for': 'qml'}

Plug 'LaTeX-Box-Team/LaTeX-Box'  , {'for': 'tex'}

Plug 'vim-pandoc/vim-pandoc', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'markdown'}

" Plug 'nelstrom/vim-markdown-folding' , {'for': 'markdown'}
"     let g:markdown_fold_style = 'nested'

Plug 'xolox/vim-easytags', {'do': 'mkdir ~/.vim/easytags' } | Plug 'xolox/vim-misc'
"

if &term =~ '^linux'
else
    " Plug 'nathanaelkane/vim-indent-guides' " show bars to hint indetation level
    Plug 'Yggdroot/indentLine'
endif

Plug 'bkad/CamelCaseMotion' " make camel case motion , and <  not ,w ,b ,e ?

if executable('fzf')
    Plug 'junegunn/fzf',  " double install
    Plug 'junegunn/fzf.vim'
endif

Plug 'kien/ctrlp.vim'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'

Plug 'Firef0x/PKGBUILD.vim'              , {'for': 'PKGBUILD'}

Plug 'eagletmt/neco-ghc'                  , {'for': 'haskell'}
if has('nvim')
   Plug 'Shougo/deoplete.nvim'

else
    " Plug 'Shougo/neocomplcache.vim'
    " Plug 'JazzCore/neocomplcache-ultisnips'

    Plug 'Shougo/neocomplete.vim'|  Plug 'Shougo/vimproc.vim' , {'do':'make'}
endif

Plug 'kien/rainbow_parentheses.vim'
Plug 'chrisbra/Recover.vim' "does not work well with neovim
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature' " displayes marks

" Plug 'sjl/badwolf'
" Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'

Plug 'honza/vim-snippets'  "ultisnips
Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular' " TODO use one of them
Plug 'junegunn/vim-easy-align'

Plug 'majutsushi/tagbar' , {'on' : 'Tagbar'} 
Plug 'tomtom/tcomment_vim' "add comments gc
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree',     {'on' : 'UndotreeToggle'}
" Plug 'terryma/vim-multiple-cursors' " not stable, does not work currust rest exit, can be have unexpected 
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim' |  Plug 'tpope/vim-dispatch'
" Plug 'tommcdo/vim-exchange' "cx exchange commoad, did not use
" Plug 'vim-scripts/restore_view.vim' -- replace vim stay
Plug 'tpope/vim-abolish'

Plug 'nelstrom/vim-qargs'
" Plug 'thinca/vim-quickrun' " does run part of file in repl, hard to use use
Plug 'wellle/targets.vim' " add extra text opjects an( i' ia
" Plug 'takac/vim-hardtime'
" Plug 'rstacruz/vim-closer' " does not work whell with indentation and editing existed code
" Plug 'chrisbra/Colorizer'
call plug#end()

" edditqf
     au BufReadPost quickfix nnoremap <buffer>  dd idd:w<CR>:copen<CR> " delete quickfix item

" HardTime
    aug END
    " let g:hardtime_showmsg = 1
    " au VimEnter * HardTimeOn

" EasyAlign
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

if has('nvim')
" cursor |
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  "
" neomake
  autocmd! BufWritePost * Neomake
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1
else
"synntastic plugin syntax cheker

    let g:syntastic_sh_checkers=['sh', 'checkbashisms', 'shellcheck']

    let g:syntastic_sh_shellcheck_args = '-x'
    let g:syntastic_sh_checkbashisms_args = '-x'
    "
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
    " "Enable this option to tell syntastic to always stick any detected errors into the loclist:
    " if (&ft=='c' || &ft=='cpp') "TODO niet gekeken of het werkt
    "     let g:syntastic_always_populate_loc_list=0
    " else
    "     let g:syntastic_always_populate_loc_list=1
    " endif

    "close error list (loclal list window) als de rest ook gesloten is  aug QFClose

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

    let g:neocomplete#use_vimproc = 1
if &term =~ '^xterm\|rxvt'
  " solid underscore
  let &t_SI .= "\<Esc>[6 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif
    " if exists('$TMUX')
    "     " does it work
    "
    "     let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "     let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        " let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        " let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    " else
    "     let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    "     let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    " endif
endif
syntax enable

" hindent
let g:hindent_style = 'chris-done'

"vim visual drag
    vmap <unique> <up>    <Plug>SchleppUp
    vmap <unique> <down>  <Plug>SchleppDown
    vmap <unique> <left>  <Plug>SchleppLeft
    vmap <unique> <right> <Plug>SchleppRight

    map <X1Mouse> <C-o>
    map <X2Mouse> <C-i>
    nnoremap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>
" vim-smooth-scroll
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

    set ignorecase
    " set smartcase
"
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

  set tags=./tags;
  let g:easytags_dynamic_files = 1
  let g:easytags_async = 1
  let g:easytags_by_filetype = "~/.vim/easytags"

"solarized colors scheme
  let g:solarized_termtrans = 1
  set background=dark
  colorscheme mycolors
  " let g:solarized_termcolors=16
  " let g:solarized_termcolors=256
  " set t_Co=256

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

    let g:ack_use_dispatch=1
" ctrlp
    if executable('git')
        let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    elseif executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    endif
"persistent undo 1


    set undofile                " Save undo's after file closes
    set undodir=$HOME/.vim/undo// " where to save undo histories
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo

    "swap file
    set directory=.,$XDG_RUNTIME_DIR

" fold
    " set foldmethod=syntax
    set foldlevelstart=99 "default all folds open


    " set ttymouse=xterm2

    syntax on

" backup
    set  backupdir=$HOME/.vim/backup//
    let myvar = strftime("(%y%m%d)%Hh%M")
    let myvar = "set backupext=_". myvar
    execute myvar
    set backup

    set showcmd
    set number
    set mouse=a
    set title
    set cursorline   " hi CursorLine term=none cterm=none ctermbg=3
    set clipboard=unnamed
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

    set viewoptions=cursor,folds,slash,unix

    au CursorHoldI * stopinsert " leave insert after interactive

    au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1]) " dont move curror on exit

    set virtualedit=block
    set lazyredraw
    set splitright
    set splitbelow
    set wildmenu
    set wildmode=list,full
    set gdefault " maybe no a good idee
    set scrolloff=7
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

    " nnoremap '' <nop>

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

    cmap w!! SudoWrite
    " cmap w!! w !sudo tee > /dev/null %
    " cmap w!! execute ':silent w !sudo tee %  > /dev/null'

    noremap <silent> [l :ll <CR> :lprevious<CR>
    noremap <silent> ]l :ll <CR> :lnext<CR>

    nnoremap <C-i>   <Esc>:tabnext<CR> " <C-i> == tab
    noremap <C-t>    <Esc>:tabnew<CR>


    noremap <C-a>     <Esc>^
    inoremap <C-a>     <Esc>I
    noremap <C-e>     <Esc>g_
    inoremap <C-e>     <Esc>g_a

    inoremap          <F2>  <NOP>
    inoremap <silent> <F3>  :Tagbar<CR><NOP>
    inoremap          <F4> <NOP>
    inoremap          <F4> <NOP>
    inoremap          <F4> <NOP>
    inoremap          <F4> <NOP>
    inoremap          <F7> <NOP>
    inoremap <silent> <F8> :set spell!<Cr>
    inoremap          <F9> <NOP>
    inoremap          <F10> <NOP>
    inoremap          <F11> <NOP>
    inoremap          <F12> <NOP>

    noremap <silent><F2>  :UndotreeToggle<CR>
    noremap <silent><F3>  :Tagbar<CR>
    set pastetoggle=<F4>
    noremap <silent> <F5> :YRShow<CR>
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

    " noremap <UP> <nop>
    " noremap <DOWN> <nop>
    " noremap <LEFT> <nop>
    " noremap <RIGHt> <nop>

    set hidden
    autocmd WinLeave * setlocal nohidden
    " autocmd WinLeave *(on-disk version) setlocal nohidden
    set confirm  " ask if you want to save

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
let test = 1

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

" noremap [c [d
" noremap ]c ]d

    highlight SignColumn ctermbg=8
    highlight Comment ctermfg=2

" inentGuide
"
" "let g:indent_guides_auto_colors = 0

  let g:indent_guides_guide_size=1
  let g:indent_guides_start_level=1
  let g:indent_guides_enable_on_vim_startup = 1

" nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
" nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
" function! NextClosedFold(dir)
"     let cmd = 'norm!z' . a:dir
"     let view = winsaveview()
"     let [l0, l, open] = [0, view.lnum, 1]
"     while l != l0 && open
"         exe cmd
"         let [l0, l] = [l, line('.')]
"         let open = foldclosed(l) < 0
"     endwhile
"     if open
"         call winrestview(view)
"     endif
" endfunction


" au BufRead,BufNewFile * let b:save_time = localtime()
"
" au CursorHold * call UpdateBackup ()
"
" let g:autosave_time = 10
" " save if needed / update the save_time after the save
" function! UpdateBackup ()
"   if((localtime() - b:save_time) >= g:autosave_time)
"       let l:fname = expand('%:p') . '_' . strftime('%Y_%m_%d_%H.%M.%S')
"       echomsg l:fname
"       let l:fname = "set backupext=_".l:fname
"       execute l:fname
"       echo l:fname
"       " silent execute 'write' l:fname
"       let b:save_time = localtime()
"   else
"       "
"       " just debugging info
"       echo "[+] ". (localtime() - b:save_time) ." seconds have elapsed so far."
"   endif
" endfunction

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

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
highlight MyTodo ctermfg=red
" save if needed / update the save_time after the save

"  color colum for where the line is to long
highlight ColorColumn ctermbg=10
call matchadd('ColorColumn', '\%82v', 100) "longer then 80 is to long, so 81 should be colord, but i have end of line char that get collerd when the line is 80 long, so 82


" TODO test if this works
" Cyclic tag navigation {{{
let g:rt_cw = ''
function! RT()
    let cw = expand('<cword>')
    try
        if cw != g:rt_cw
            execute 'tag ' . cw
            call search(cw,'c',line('.'))
        else
            try
                execute 'tnext'
            catch /.*/
                execute 'trewind'
            endtry
            call search(cw,'c',line('.'))
        endif
        let g:rt_cw = cw
    catch /.*/
        echo "no tags on " . cw
    endtry
endfunction
map <C-]> :call RT()<CR>
" }}}
