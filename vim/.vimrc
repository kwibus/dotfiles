" general TODO's {{{
" TODO switch to test shortcut
" TODO remove unused
" TODO maybe add Cscope
" TODO maybe fold quickfix / remove quickfix entrys
" TODO write fold expr based on indent except when indent 0
      "then fold  until first nonempty line with indent 0
" TODO forward and backward search markdown tex
" TODO find a way to spelcheck camelcase snake case ..
" TODO tags
" TODO sorting completion  , complet biggest commue / remove duplecats
" TODO fix no TODO color when switching background
" TODO add histories to completion
" TODO delay vimdiff{put/get}  fold so you can see result
" TODO haddock comments highlight in vim
" TODO zsh completion in vim bash
" TODO think about remapping leader
"""}}}
filetype plugin on
filetype indent on
syntax enable

set encoding=utf-8
scriptencoding utf-8

"instal " {{{
function! Install()
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

      :source$MYVIMRC<CR> " TODO maybe bad idea
      autocmd! VimEnter * PlugInstall
    endif
    call mkdir($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/backup')
endfunction

command! Install call Install()
"}}}
" Plugins {{{
call plug#begin()
Plug 'terryma/vim-expand-region'
" Plug 'machakann'/vim-columnmove -- TODO have to try??
" Plug 'takac/vim-hardtime'
" Plug 'rickhowe/diffdchar.vim' " this plugin uses deault mapping
" Plug 'vim-scripts/vim-auto-save'
" Plug 'gelguy/Cmd2.vim'
" Plug 'jalvesaq/vimcmdline'
" Plug 'jpalardy/vim-slime'
" Plug 'Shougo/vimshell.vim'
" Plug 'ujihisa/repl.vim'
" Plug 'cazador481/fakeclip.neovim'
" Plug 'vim-scripts/SearchComplete'
" Plug 'jszakmeister/vim-togglecursor'
" Plug 'Valodim/vim-zsh-completion'
Plug 'LucHermitte/VimFold4C'
Plug 'kana/vim-niceblock'
Plug 'machakann/vim-highlightedyank'
Plug 'troydm/zoomwintab.vim/'
Plug 'tommcdo/vim-lion'
Plug 'metakirby5/codi.vim'
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
"
Plug 'terryma/vim-smooth-scroll'

if has('nvim')
   Plug 'benekastah/neomake'
else
    Plug 'scrooloose/syntastic'
endif

Plug 'keith/tmux.vim' " syntax  highlight tmuxconfig file
if exists('$TMUX')
    Plug 'benmills/vimux'
    Plug 'wellle/tmux-complete.vim' " complete text from tmux buffers
endif
Plug 'christoomey/vim-tmux-navigator' " source even when not in tmux becauces it provides windo navigatio in vim


Plug 'Matt-Deacalion/vim-systemd-syntax'     , {'for': 'systemd'}
Plug 'clever-f.vim' " repeat last f with f
Plug 'justinmk/vim-sneak' " f with to char s
Plug 'haya14busa/incsearch.vim' " incremental search

" Plug 'gilligan/vim-textobj-haskell'       , {'for': 'haskell'} | Plug 'kana/vim-textobj-user' " defined textobject haskell fucntion ih. maybe remove almost same as ip -now gitgutter hunk
" Plug 'kana/vim-filetype-haskell'          , {'for': 'haskell'}

" :let $PATH .= '~/.vim/plugged/lushtags/'
" Plug 'mkasa/lushtags'                     , {'for': 'haskell', 'do': 'cabal sandbox init && cabal install'}
" Plug 'dag/vim2hs'                         , {'for': 'haskell'}
Plug 'itchyny/vim-haskell-indent'         , {'for': 'haskell'}
" Plug 'chrisdone/hindent' ,                  {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim'                , {'for': 'haskell'} |  Plug 'Shougo/vimproc.vim' , {'do':'make'}
Plug 'Twinside/vim-haskellFold'           , {'for': 'haskell'}
Plug 'Twinside/vim-syntax-haskell-cabal'  , {'for': 'haskell'}

Plug 'vim-scripts/a.vim'      , {'for': ['c', 'cpp']}
Plug 'Rip-Rip/clang_complete' , {'for': ['c', 'cpp']} "need some special attion whith new ncurs hat to patch
Plug 'peterhoeg/vim-qml' , {'for': 'qml'}

Plug 'LaTeX-Box-Team/LaTeX-Box'  , {'for': 'tex'}

Plug 'vim-pandoc/vim-pandoc' " , {'for': ['markdown','tex']}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown','tex']}


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

" Plug 'vim-bufferline'
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
Plug 'luochen1990/rainbow'
" Plug 'kien/rainbow_parentheses.vim'
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
Plug 'terryma/vim-multiple-cursors' " not stable, does not work currust rest exit, can be have unexpected
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim' |  Plug 'tpope/vim-dispatch'
Plug 'tommcdo/vim-exchange' "cx exchange commoad, did not use
" Plug 'vim-scripts/restore_view.vim' -- replace vim stay
Plug 'tpope/vim-abolish'

Plug 'nelstrom/vim-qargs'
" Plug 'thinca/vim-quickrun' " does run part of file in repl, hard to use use
Plug 'wellle/targets.vim' " add extra text opjects an( i' ia
" Plug 'takac/vim-hardtime'
" Plug 'rstacruz/vim-closer' " does not work whell with indentation and editing existed code
" Plug 'chrisbra/Colorizer'
call plug#end() " }}}
" general settings {{{

autocmd! FileType * setlocal  formatoptions-=o

autocmd! WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&buftype') == "quickfix"|q|endif

if ! has('nvim')
    set viminfo+=n~/.vim/viminfo
endif
"undo {{{
" undotree {{{
    let g:undotree_WindowLayout=2
    "}}}
    " persistent  undo {{{
    set undofile                " Save undo's after file closes
    set undodir=$HOME/.vim/undo// " where to save undo histories
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo TODO check
    "}}}}
"}}}
    "swap file TODO
    " set directory=.,$XDG_CACH_HOME/vim/

" fold {{{
    " set foldmethod=syntax
    set foldlevelstart=0 "default all folds closed
    "
    " nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
    " nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
    " function! NextClosedFold(dir) "{{{
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
    " endfunction "}}}
" }}}

" backup {{{
    "TODO need fix
    set  backupdir=$HOME/.vim/backup//
    let myvar = strftime('(%y%m%d)%Hh%M')
    let myvar = 'set backupext=_'. myvar
    execute myvar
    set backup

    " au BufRead,BufNewFile * let b:save_time = localtime()
    "
    " au CursorHold * call UpdateBackup ()
    "
    " let g:autosave_time = 10
    " " save if needed / update the save_time after the save
    " function! UpdateBackup () {{{
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
    " endfunction "}}}
" }}}
    set showcmd
    set number
    " mouse support {{{
    if has('mouse')
      set mouse=a
    endif

    if has('mouse_sgr')
      set ttymouse=sgr
    endif

    " set ttymouse=xterm2 TODO why did i disable this
    "}}}
    set title
    set cursorline
    set clipboard=unnamed
    set list
    set listchars=tab:▸\ ,eol:¬,trail:_,extends:#,nbsp:.

    set conceallevel=2

    set timeoutlen=4000 ttimeoutlen=0 " solves delay escp

    " tab en indent {{{
    set smarttab
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    "}}}

    set viewoptions=cursor,slash,unix ",fold

    "autocmd! CursorHoldI * stopinsert " leave insert after interactive
    "autocmd! InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1]) " dont move curror on exit

    set virtualedit=block
    " set lazyredraw --TODO test if this helps
    set splitright
    set splitbelow
    set wildmenu
    set wildmode=list,full

    set gdefault " maybe no a good idee
    if has('nvim')
        set inccommand=nosplit
    endif

    set scrolloff=7
    set errorbells

    set hidden
    " TODO test
    autocmd! WinLeave * setlocal nohidden

    " autocmd WinLeave *(on-disk version) setlocal nohidden
    set confirm  " ask if you want to save

    set backspace=indent,eol,start "indent  allow backspacing over autoindent eol allow backspacing over line breaks (join lines)
    "start   allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert
    " set whichwrap=<,>,[,] " allow cursor key to move past end of aline to the next line TODO
" wrap  {{{
    set wrap
    set linebreak
    set showbreak=~~~
    set showmatch
"}}}
"{{{ spellcheck
    set spellcapcheck = ""
    set spelllang=en,nl

" Languagetool install global {{{
    let g:languagetool_jar="/usr/share/java/languagetool/languagetool-commandline.jar" "}}}
"}}}
"}}}
" {{{ highlighting
" solarized colors scheme {{{
  let g:solarized_termtrans = 1
  if empty($background)
      set background=dark
  else
      execute 'set background='.$background
  endif

  colorscheme mycolors
  " let g:solarized_termcolors=16
  " let g:solarized_termcolors=256
  " set t_Co=256
" }}}
"
    highlight SignColumn ctermbg=8
    highlight Comment ctermfg=2

    "  color colum for where the line is to long
    highlight ColorColumn ctermbg=10

    augroup vimrc_todo " TODO Cleanup
        au!
        au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
              \ containedin=.*Comment,vimCommentTitle
    augroup END
    call matchadd('ColorColumn', '\%82v', 100) "longer then 80 is to long, so 81 should be colord, but i have end of line char that get collerd when the line is 80 long, so 82
" rainbow {{{
" luochen1990/rainbow {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['brown', 'magenta', 'darkred', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'haskell': {
    \           'parentheses': [['(',')'], ['\[','\]']],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}
" }}}
" 'kien/rainbow_parentheses.vim'{{{
    " command RainbowParenthesesToggle
    " command RainbowParenthesesLoadRound
    " command RainbowParenthesesLoadSquare
    "
    " let g:rbpt_colorpairs = [
    "     \ ['brown',       'RoyalBlue3'],
    "     \ ['Darkblue',    'SeaGreen3'],
    "     \ ['darkgray',    'DarkOrchid3'],
    "     \ ['darkgreen',   'firebrick3'],
    "     \ ['darkcyan',    'RoyalBlue3'],
    "     \ ['darkred',     'SeaGreen3'],
    "     \ ['DARKMAGENTA', 'DARKORCHID3'],
    "     \ ['BROWN',       'FIREBRICK3'],
    "     \ ['GRAY',        'ROYALBLUE3'],
    "     \ ['DARKMAGENTA', 'DARKORCHID3'],
    "     \ ['DARKBLUE',    'FIREBRICK3'],
    "     \ ['DARKRED',     'DARKORCHID3'],
    "     \ ['DARKGREEN',   'ROYALBLUE3'],
    "     \ ['DARKCYAN',    'SEAGREEN3'],
    "     \ ['RED',         'FIREBRICK3'],
    "     \ ]
" }}}
" }}}

" highlightyank {{{
        " if ! has('nvim')
        "     map y <Plug>(highlightedyank)
        " endi
    " }}}
"}}}
" mappings {{{
    inoremap jj <Esc> " TODO does this work for me ?
    " inoremap l; <Esc>
    " inoremap ;l <Esc>
    "
" EasyAlign {{{
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
" }}}
" CamelCaseMotion {{{
    call camelcasemotion#CreateMotionMappings(',') "}}}
" disable mappings {{{

    nnoremap Z <nop>
    nnoremap K <nop>
    nnoremap Q <nop>
   " nnoremap '' <nop>
   "
   " noremap <UP> <nop>
   " noremap <DOWN> <nop>
   " noremap <LEFT> <nop>
   " noremap <RIGHt> <nop>
" HardTime  {{{
    " let g:hardtime_showmsg = 1
    " au VimEnter * HardTimeOn
"}}}
" }}}
"vim visual drag "{{{
    vmap <up>    <Plug>SchleppUp
    vmap <down>  <Plug>SchleppDown
    vmap <left>  <Plug>SchleppLeft
    vmap <right> <Plug>SchleppRight

    map <X1Mouse> <C-o>
    map <X2Mouse> <C-i>
    nnoremap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>
"}}}

    noremap <leader>r :source$MYVIMRC<CR>

    nnoremap <C-S> :<C-u>update<CR>
    inoremap <c-s> <Esc>:update<CR>

    " reverse of <S-J> join for <S-K>
    nnoremap <S-k> i<CR><Esc>== " TODO  can better

    " highlight last inserted text
    " doesn`t work
    nnoremap gV `[v`]

" Yank {{{
    nnoremap Y y$
    " YankRing {{{
    let g:yankring_history_dir='/tmp'
    let g:yankring_history_file = 'vimYankRing'.$USER
    function! YRRunAfterMaps()
        nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
    endfunction
"   }}}
" }}}
" close vim mappings {{{
    command! Q  q
    command! WQ wq
    command! Wq wq
    command! W w

    cmap w!! SudoWrite
    " cmap w!! w !sudo tee > /dev/null %
    " cmap w!! execute ':silent w !sudo tee %  > /dev/null'
"}}}
    " next {{{
    noremap <silent> [l :ll <CR> :lprevious<CR>
    noremap <silent> ]l :ll <CR> :lnext<CR>

    " noremap [c [d
    " noremap ]c ]d
    " }}}
    nnoremap <C-i>   <Esc>:tabnext<CR> " <C-i> == tab
    noremap <C-t>    <Esc>:tabnew<CR>

" emac compatable mappings {{{
    noremap <C-a>     <Esc>^
    inoremap <C-a>     <Esc>I
    noremap <C-e>     <Esc>g_
    inoremap <C-e>     <Esc>g_a
" }}}
" Toggles {{{
    inoremap          <F2>  <NOP>
    inoremap <silent> <F3>  :Tagbar<CR><NOP>
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

" multicusor " {{{
    let g:ctrlp_map = '<F12>'

    let g:multi_cursor_start_key='<F6>'
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

        " Called once right before you start selecting multiple cursors
        function! Multiple_cursors_before()
          if exists(':NeoCompleteLock')==2
            exe 'NeoCompleteLock'
          endif
        endfunction

        " Called once only when the multiple selection is canceled (default <Esc>)
        function! Multiple_cursors_after()
          if exists(':NeoCompleteUnlock')==2
            exe 'NeoCompleteUnlock'
          endif
        endfunction
"}}}
"}}}

"Better window navigation
    " replaced with tmux plugin
    " nnoremap <C-j> <C-w>j
    " nnoremap <C-k> <C-w>k
    " nnoremap <C-h> <C-w>h
    " nnoremap <C-l> <C-w>l

    " nnoremap <C-S-h>

    map j gj
    map k gk

"}}}
" edditqf {{{
     " au BufReadPost quickfix nnoremap <buffer>  dd idd:w<CR>:copen<CR> " delete quickfix item
" }}}
" change cursor shape in insertmode {{{
if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
    " TODO this can cleaner
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
  elseif &term =~ '^screen\|tmux'
      " this only works in tmux/screen on xterm rxvt
      let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"

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
endif
"}}}
" {{{ syntax checker
if has('nvim')
    "neomake
        autocmd! BufWritePost * Neomake
else
    "syntastic plugin syntax cheker {{{

    "If enabled, syntastic will do syntax checks when buffers are first loaded as well as on saving

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0

    let g:syntastic_enable_signs=1
    let g:syntastic_error_symbol = 'E>'
    let g:syntastic_style_error_symbol = 'e>'
    let g:syntastic_warning_symbol = 'W>'
    let g:syntastic_style_warnig_symbol = 'w>'
    "
    " "Enable this option to tell syntastic to always stick any detected errors into the loclist:
    " if (&ft=='c' || &ft=='cpp') "TODO niet gekeken of het werkt
    "     let g:syntastic_always_populate_loc_list=0
    " else
    "     let g:syntastic_always_populate_loc_list=1
    " endif

    " }}}
endif
" }}}
" completion {{{
" set completeopt=longest,menuone
if has('nvim')
    " Use deoplete. {{{
      let g:deoplete#enable_at_startup = 1
      " }}}
else
    " neocomplete {{{
      let g:neocomplete#enable_at_startup = 1
      " Use smartcase.
      let g:neocomplete#enable_smart_case = 0
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

      let g:neocomplete#enable_fuzzy_completion=0
      let g:neocomplcache_force_overwrite_completefunc = 1

      call neocomplete#custom#source('_', 'sorters', ['sorter_length'])
      let g:neocomplete#use_vimproc = 1
  " }}}
endif
    " ultisnips {{{
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'
    " }}}
" }}}
" vim-smooth-scroll {{{
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" }}}
" {{{ search
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch

   "This unsets the "last search pattern" register by hitting return
    nnoremap <silent><CR> :noh<CR><CR>
"
" incsearch TODO why? {{{
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)
" }}}
" }}}
" airline {{{
  set laststatus=2
  let g:airline_theme='powerlineish'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#bufferline#enabled = 0
  let g:airline#extensions#tabline#buffer_min_count =2
"}}}
" easytags{{{
  " let g:easytags_events = ['BufWritePost']

  set tags=./tags;
  let g:easytags_dynamic_files = 1
  let g:easytags_async = 1
  let g:easytags_by_filetype = '~/.vim/easytags'
"}}}
" git {{{
autocmd! BufNewFile,BufRead *.git/COMMIT_EDITMSG set ft=gitcommit
" " git gutter {{{
    " let g:gitgutter_escape_grep = 1 " TODO i think this no longer needed
    nmap ]h <Plug>GitGutterNextHunk
    nmap [h <Plug>GitGutterPrevHunk

    omap ih <Plug>GitGutterTextObjectInnerPending
    omap ah <Plug>GitGutterTextObjectOuterPending
    xmap ih <Plug>GitGutterTextObjectInnerVisual
    xmap ah <Plug>GitGutterTextObjectOuterVisual
"}}}
"fugative {{{
    " !command Gl Glog --oneline --graph --decorate=short
    " !command Gll Gllog --oneline --graph --decorate=short
"}}}
" }}}
" ack.vim {{{
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

    let g:ack_use_dispatch=1
"}}}
" ctrlp {{{
    if executable('git')
        let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    elseif executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    endif
"}}}
" inentGuide {{{
"
" "let g:indent_guides_auto_colors = 0

  let g:indent_guides_guide_size=1
  let g:indent_guides_start_level=1
  let g:indent_guides_enable_on_vim_startup = 1
"}}}
" reservie background color" {{{
function! ReverseBackground()
 if &bg=='light'
    set bg=dark
    AirlineTheme powerlineish
 else
    set bg=light
    AirlineTheme solarized
 endif
    let s:test='colorscheme '.g:colors_name
    execute s:test
endfunction

command! Togglebackground call ReverseBackground()
noremap <F7> :Togglebackground<CR>
"}}}
" search todos {{{
" TODO maybe remove
function! SearchTODO ()
    Ack "TODO"
    copen
endfunction
command! TODO call SearchTODO()
"}}}
" Cyclic tag navigation {{{
" TODO test if this works
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
        echo 'no tags on ' . cw
    endtry
endfunction
map <C-]> :call RT()<CR>
"}}}
function! <SID>StripTrailingWhitespaces() "{{{
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfunction
com! StripTrailingWhitespaces call s:StripTrailingWhitespaces()
" }}}
function! s:DiffWithSaved() " {{{
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
"}}}
