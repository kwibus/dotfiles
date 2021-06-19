"" REMEBER bear for  c/c++
" general TODO's {{{
" TODO ALE does not support checkbashisme
" TODO improve or eplace repmo
" TODO switch to test shortcut
" TODO remove unused
" TODO maybe add Cscope
" TODO maybe fold quickfix / remove quickfix entrys
" TODO find a way to spelcheck camelcase snake case ..
" TODO tags
" TODO sorting completion  , complet biggest commue / remove duplecats
" TODO add histories to completion
" TODO delay vimdiff{put/get}  fold so you can see result
" TODO haddock comments highlight in vim
" TODO haskell syntax checker pedantic
" TODO StripTrailingWhitespaces on serten file types
"}}}
set secure
filetype plugin on
filetype indent on
syntax enable

set encoding=utf-8
scriptencoding utf-8
let g:python3_host_prog = "/usr/bin/python3"
"instal " {{{
function! Install()
    if empty(glob('~/.vim/autoload/plug.vim'))
      !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    call mkdir($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/backup')
    call mkdir($HOME.'/.vim/swap')
    " call mkdir($HOME.'/.vim/view')

     source  ~/.vim/autoload/plug.vim

    endif

    if empty(glob('~/.vim/plugged/'))
        autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
     endif
endfunction
" call Install()
command! Install call Install()
"}}}

" Plugins {{{
call plug#begin()
Plug 'vim-scripts/LargeFile'
Plug 'hari-rangarajan/CCTree'
" Plug 'gu-fan/InstantRst'
Plug 'vim-utils/vim-man'
Plug 'hashivim/vim-terraform'
" Plug 'andymass/vim-matchup'  " try out
Plug 'posva/vim-vue'                                   "vue.js support
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] } " for repl
Plug 'PProvost/vim-ps1'                                " powershel
Plug 'gnattishness/cscope_maps'                        " cscope key  bindings
Plug 'artur-shaik/vim-javacomplete2'                   " jave competion
Plug 'sedm0784/vim-you-autocorrect'                    " autocimic autocorrect spell
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }    " go plugin
Plug 'tobyS/pdv'   | Plug 'tobyS/vmustache'            " mustash plugin
Plug '907th/vim-auto-save'                             " auto save not enabled by deval

" Plug 'rhysd/vim-grammarous'    " advanced spell checking TODO choose one of the to
" Plug 'dpelle/vim-LanguageTool' " advanced spellll checking

" Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
" Plug 'Townk/vim-autoclose'
" Plug 'cohama/lexima.vim'

" Plug 'vim-scripts/Highlight-UnMatched-Brackets'
Plug 'roxma/vim-paste-easy'  "set paste on when pasting
Plug 'junegunn/vim-peekaboo' " show content registers
Plug 'itchyny/vim-cursorword' " underline word under cursor
" Plug 'airblade/vim-matchquote' -- conflict with matchit TODO alternative
Plug 'kovetskiy/sxhkd-vim'
" Plug 'jiangmiao/auto-pairs'  "TODO Try configure
Plug 'huesersohn/curry.vim' " TODO only cury files >
"Plug 'Houl/vim-repmo'       "TODO
Plug 'ternjs/tern_for_vim', {'do':'npm install'}
" Plug 'mhinz/vim-startify'
Plug 'w0rp/ale'
" Plug 'dojoteef/neomake-autolint' | Plug 'benekastah/neomake'
Plug 'rust-lang/rust.vim' ,{'for': 'rust'}
Plug 'tpope/vim-sleuth'                     " detect tab seting in file
Plug 'tpope/vim-projectionist' " TODO implement
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'terryma/vim-expand-region' "expand visual selection with +
" vnoremap _ <Plug>(expand_region_expand)
" vnoremap + <Plug>(expand_region_shrink)
" Plug 'mustache/vim-mustache-handlebars' " did never use
" Plug 'machakann'/vim-columnmove " TODO have to try??
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
Plug 'Valodim/vim-zsh-completion'
Plug 'xolox/vim-reload' | Plug 'xolox/vim-misc'
" Plug 'LucHermitte/VimFold4C' " had erros
Plug 'kana/vim-niceblock' " enable IA.. in other visual mode then blcok
Plug 'machakann/vim-highlightedyank'
Plug 'troydm/zoomwintab.vim/'
Plug 'tommcdo/vim-lion' "map  gl<region><pattern> to alliment

" Plug 'metakirby5/codi.vim' # interactive output but never used it :Codi python
" Plug 'AssailantLF/vim-active-numbers' " only number in active window, is this useful?

Plug 'kopischke/vim-stay' " store setting view zo is preserved TODO replace with vim-workspace?
Plug 'kopischke/vim-fetch' " you can open file specific line :e file:line:colom
Plug 'Konfekt/FastFold'

"Plug 'jceb/vim-editqf' " eddit quickfix is not realy stable consider remove

if executable('editorconfig')
    Plug 'editorconfig/editorconfig-vim'
endif
Plug 'timakro/vim-copytoggle' " remove everythin that would make copy pase by select hard (F5)
Plug 'zirrostig/vim-schlepp' " drag with visual cursor
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-eunuch' " unix helpers sudowrite,..

" Plug 'arnar/vim-matchopen'

Plug 'jamessan/vim-egnupg'

Plug 'kana/vim-textobj-fold' | Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment' | Plug 'kana/vim-textobj-user'
" Plug 'vim-scripts/argtextobj.vim' " targest does the same
Plug 'kana/vim-textobj-entire' " is ie ae
Plug 'michaeljsmith/vim-indent-object'
"
Plug 'terryma/vim-smooth-scroll'

" if has('nvim')
   " Plug 'benekastahir/neomake'
" else
"     Plug 'scrooloose/syntastic' " always use neomake
" endif

Plug 'keith/tmux.vim' " syntax  highlight tmuxconfig file
if exists('$TMUX')
    Plug 'benmills/vimux'
    Plug 'roxma/vim-tmux-clipboard' | Plug 'tmux-plugins/vim-tmux-focus-events' " TODO how goed does this work
    Plug 'wellle/tmux-complete.vim' " complete text from tmux buffers
endif
Plug 'christoomey/vim-tmux-navigator' " source even when not in tmux becauces it provides windo navigatio in vim


Plug 'Matt-Deacalion/vim-systemd-syntax'     , {'for': 'systemd'} " maybe need always loud for detection
" Plug 'rhysd/clever-f.vim'                                         " repeat last f with f TODO Test
" let g:clever_f_show_prompt=1
Plug 'juftinmk/vim-sneak'                                       " f with to char s does not work well with repmo
let g:sneak#label = 1

Plug 'haya14busa/incsearch.vim'                                   " incremental search  TODO room inprovement TODO should no longer be nesecary in new vim version
Plug 'idris-hackers/idris-vim'            , {'for': 'idris'}
" Plug 'neovimhaskell/haskell-vim'        , {'for': 'haskell'}
" Plug 'gilligan/vim-textobj-haskell      , {'for': 'haskell'} | Plug 'kana/vim-textobj-user' " defined textobject haskell fucntion ih. maybe remove almost same as ip -now gitgutter hunk
" Plug 'kana/vim-filetype-haskell'        , {'for': 'haskell'}
" Plug 'mkasa/lushtags'                   , {'for': 'haskell', 'do': 'cabal sandbox init && cabal install'}
" Plug 'dag/vim2hs'                       , {'for': 'haskell'}
" Plug 'itchyny/vim-haskell-indent'       , {'for': 'haskell'}
" Plug 'chrisdone/hindent' ,                {'for': 'haskell'}

Plug 'ludovicchabant/vim-gutentags'
Plug 'rob-b/gutenhasktags'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'master',
"     \ 'do': './install.sh'
"     \ }
"Plug 'eagletmt/ghcmod-vim'              , {'for': 'haskell'} |  Plug 'Shougo/vimproc.vim' , {'do':'make'}
Plug 'Twinside/vim-haskellFold'         , {'for': 'haskell'}
Plug 'Twinside/vim-syntax-haskell-cabal', {'for': 'haskell'}
" Plug 'dan-t/vim-hsimport'               , {'for': 'haskell'}
Plug 'Twinside/vim-syntax-haskell-cabal', {'for': 'haskell'} " Plug 'vim-scripts/a.vim'      , {'for': ['c', 'cpp']}

" Plug 'Rip-Rip/clang_complete' , {'for': ['c', 'cpp']} "need some special attion whith new ncurs hat to patch
" Plug 'xavierd/clang_complete' , {'for': ['c', 'cpp']} "need some special attion whith new ncurs hat to patch

Plug 'peterhoeg/vim-qml' , {'for': 'qml'}

Plug 'LaTeX-Box-Team/LaTeX-Box'  , {'for': 'tex'}

Plug 'vim-pandoc/vim-pandoc'          ", {'for': ['markdown','tex']}
let g:pandoc#modules#disabled=['chdir']
Plug 'vim-pandoc/vim-pandoc-syntax'   ", {'for': ['markdown','tex']}
" Plug 'pyarmak/vim-pandoc-live-preview' ", {'for': ['markdown','tex']} -- does this work?

" Plug 'nelstrom/vim-markdown-folding' , {'for': 'markdown'}
"     let g:markdown_fold_style = 'nested'

" Plug 'xolox/vim-easytags', {'do': 'mkdir ~/.vim/easytags' } | Plug 'xolox/vim-misc'

if &term =~# '^linux'
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

Plug 'junegunn/gv.vim'
Plug 'tpope/vim-ragtag'  "<C-X>/ Last HTML tag closed TODO are better plugins
" Plug 'gregsexton/gitv'
" Plug 'airblade/vim-gitgutter' " git gutter was slow on large files
if has('nvim') || has('patch-8.0.902') " replace gitgutter
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'Firef0x/PKGBUILD.vim'              , {'for': 'PKGBUILD'}
"
Plug 'eagletmt/neco-ghc'                  , {'for': 'haskell'}
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-zsh'
if has('nvim')

  "Plug 'neovim/nvim-lsp' " dont use this yet

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " completion via ale"TODO lookinto  zchee/deoplete-clang  and jave suport
else
    " Plug 'Shougo/neocomplcache.vim'
    " Plug 'JazzCore/neocomplcache-ultisnips'
  Plug 'Shougo/deoplete.nvim',
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
    " Plug 'Shougo/neocomplete.vim'|  Plug 'Shougo/vimproc.vim' , {'do':'make'}
endif

Plug 'chrisbra/Recover.vim' "does not work well with neovim
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature' " displayes marks do not use fair much

Plug 'luochen1990/rainbow'
" Plug 'kien/rainbow_parentheses.vim'

" Plug 'sjl/badwolf'
" Plug 'chriskempson/base16-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'
" Plug 'mhinz/vim-janah'

Plug 'honza/vim-snippets'  "ultisnips
" Plug 'tpope/vim-surround' " sandwich better?
" Plug 'machakann/vim-sandwich' " alternative timpope surround

Plug 'godlygeek/tabular' " TODO use one of them
Plug 'junegunn/vim-easy-align'

Plug 'majutsushi/tagbar' , {'on' : 'Tagbar'}

Plug 'tomtom/tcomment_vim' "add comments gc TODO some conflicet with textObjectcomment
  let g:tcomment_textobject_inlinecommen=''

Plug 'SirVer/ultisnips'
" Plug 'simnalamburt/vim-mundo'
" Plug 'sjl/gundo.vim'
Plug 'mbbill/undotree'",     {'on' : 'UndotreeToggle'}
Plug 'terryma/vim-multiple-cursors' " not stable, does not work currust rest exit, can be have unexpected

" Plug 'Shougo/denite.nvim'
Plug 'maxbrunsfeld/vim-yankstack'
" Plug 'vim-scripts/YankRing.vim'
Plug 'Shougo/neoyank.vim' | Plug 'Shougo/unite.vim' " dont configer correctly
" Plug 'svermeulen/vim-easyclip'

Plug 'mileszs/ack.vim' |  Plug 'tpope/vim-dispatch'
" Plug 'tommcdo/vim-exchange' "cx exchange commoad, did not use can be replace
" with substiut from easyclip
Plug 'tpope/vim-abolish'

" Plug 'nelstrom/vim-qargs' " no longer needed with :cdo
" Plug 'thinca/vim-quickrun' " does run part of file in repl, hard to use use
Plug 'wellle/targets.vim' " add extra text opjects an( i' ia
" Plug 'takac/vim-hardtime'
" Plug 'rstacruz/vim-closer' " does not work whell with indentation and editing existed code
" Plug 'pseewald/vim-anyfold' " TODO not used but devince folding based on indentation
" Plug 'norcalli/nvim-colorizer.lua' lua require 'colorizer'.setup()
" Plug 'chrisbra/Colorizer' " highlighting colorcodes
call plug#end() " }}}

" {{{ true colors " not fully enabled
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " set termguicolors " does not work well
endif
" }}
" {{{ highlighting

   augroup synHiglight
     autocmd!
     autocmd BufWinEnter,Syntax * syntax sync fromstart " this can be slow on large files, fromstart can be replaced for a speedup

"    autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
   augroup END

  set synmaxcol=190

" solarized colors scheme {{{
  let g:solarized_termtrans = 1
  " let g:solarized_termcolors=256
  " let g:solarized_termcolors=16
  if empty($background)
      set background=dark
  else
      execute 'set background='.$background
  endif

  colorscheme mycolors
" }}}
"
    " highlight SyntasticError ctermbg=0
    "  color colum for where the line is to long
    " highlight ColorColumn ctermbg=10

    augroup vimrc_todo " TODO Cleanup
        au!
        au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
              \ containedin=.*Comment,vimCommentTitle
    augroup END
    call matchadd('ToLong', '\%82v', 100) "longer then 80 is to long, so 81 should be colord, but i have end of line char that get collerd when the line is 80 long, so 82
" rainbow {{{
" luochen1990/rainbow {{{
let g:rainbow_active = 1

let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['brown', 'magenta', 'darkred', 'blue'],
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
"   }}}
" }}}

" highlightyank {{{
        " if ! has('nvim')
        "     map y <Plug>(highlightedyank)
        " end
  " }}}
"}}}
" general settings {{{
  set nojoinspaces " TODO explain

" if has('gui_running')
if ! has('nvim')
    set ballooneval
    set mousemodel=popup
    set balloonevalterm
endif

set path+=**
set viewdir=$HOME/.vim/view
set directory=.,~/.vim/swap

autocmd FileType * setlocal  formatoptions-=o " dont insert comment when you oO from within comment
autocmd BufEnter * if &filetype == "" | setlocal filetype=text | endif " when no filetype detect make it text
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&buftype') == "quickfix"|quit|endif " quit if only quickfix open
autocmd BufNewFile,BufRead,BufEnter /home/rens/.ssh/config.d/*.conf setlocal syntax=sshconfig


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

  " set foldopen=all
  " set foldclose=all
  set foldopen=block,hor,insert,jump,mark,quickfix,search,tag,undo
  " command! ClearLocationList lexpr []
  " command! ClearQuickfixList cexpr []
" }}}
" backup {{{
    "TODO need fix
    set  backupdir=$HOME/.vim/backup//
    let g:myvar = strftime('(%y%m%d)%Hh%M')
    let g:myvar = 'set backupext=_'. g:myvar
    execute g:myvar
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
    set list
    set listchars=tab:▸\ ,eol:¬,trail:_,extends:#,nbsp:.

    set conceallevel=0

    set timeoutlen=4000 ttimeoutlen=0 " solves delay escp

    " tab en indent {{{
    set smarttab
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    "}}}

    set viewoptions=cursor,slash,unix,folds
    set commentstring=#\ %s
    "autocmd! CursorHoldI * stopinsert " leave insert after interactive
    "autocmd! InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1]) " dont move curror on exit

    set virtualedit=block,onemore
    set lazyredraw "TODO test if this helps
    set ttyfast
    set splitright " TODO dont konw if i still like this
    set splitbelow
    set wildmenu
    set wildmode=list,full

    set gdefault " maybe no a good idee
    if has('nvim')
        set inccommand=nosplit
    endif

    set scrolloff=7
    set errorbells

    set nohidden
    " TODO test
    " autocmd WinLeave * setlocal nohidden

    " autocmd WinLeave *(on-disk version) setlocal nohidden
    set confirm  " ask if you want to save

    set backspace=indent,eol,start "indent  allow backspacing over autoindent eol allow backspacing over line breaks (join lines)
    "start   allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert
    " set whichwrap=<,>,[,] " allow cursor key to move past end of aline to the next line TODO

    set showmatch
" wrap  {{{
    set wrap
    set linebreak
    set showbreak=~~~
"}}}
"{{{ spellcheck
    set spellcapcheck = ""
    set spelllang=en,nl

"{{{ vim-you-autocorrect
highlight AutocorrectGood ctermfg=Red guifg=Red gui=undercurl
augroup ILoveCorrections
  autocmd!
  "autocmd FileType text EnableAutocorrect
  "autocmd FileType text imap <c-U> <C-O><Plug>VimyouautocorrectUndo
augroup END
" Languagetool install global {{{
if &runtimepath =~ 'vim-Languagetool'
    " let g:grammarous#languagetool_cmd = '/usr/share/java/languagetool/languagetool-commandline.jar'
    let g:languagetool_jar='/usr/share/java/languagetool/languagetool-commandline.jar' "}}}
endif
"}}}
"}}}
" mappings {{{
    let g:mapleader = ' '
    let g:mapleader="\<SPACE>"
    inoremap <C-w> <C-\><C-o>dB

    inoremap <C-h> <C-\><C-o>db
    inoremap <C-BS> <C-\><C-o>db
    " inoremap jj <Esc> " TODO does this work for me ?
    " inoremap l; <Esc>
    " inoremap ;l <Esc>
  " nnoremap _ <C-x>
  " nnoremap + <C-a>
" zoomwintab {{{
  let g:zoomwintab_remap=0
  map <C-W>z :ZoomWinTabToggle<CR>
"}}}
" EasyAlign {{{
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
" }}}
" CamelCaseMotion {{{
    call camelcasemotion#CreateMotionMappings(',') "}}}
" disable mappings {{{

    " nnoremap Z <nop>
    nnoremap K <nop>
    nnoremap Q <nop>
   " nnoremap '' <nop>

   noremap <UP> <nop>
   noremap <DOWN> <nop>
   noremap <LEFT> <nop>
   noremap <RIGHt> <nop>
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

    " noremap <leader>r :source$MYVIMRC<CR>

"reloud vim plugin{{{
    let g:reload_on_write = 0
    noremap <leader>r :source$MYVIMRC<CR>:ReloadScript<CR>
"}}}

    nnoremap <C-S> :update<CR>
    inoremap <c-s> <Esc>:update<CR>a

    " reverse of <S-J> join for <S-K>
    nnoremap <S-k> i<CR><Esc>== " TODO  can better

    " highlight last inserted text
    " doesn`t work
    " nnoremap gV `[v`]

" Yank {{{

    "{{yankstack

    let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
    call yankstack#setup()
    nmap <M-n> <Plug>yankstack_substitute_newer_paste
    nmap <A-p> <Plug>yankstack_substitute_older_paste
    nmap <A-n> <Plug>yankstack_substitute_newer_paste
    "has to be before remaps yank and past
    " }}}
    nnoremap Y y$
    " set clipboard=unnamedplus

    " easy-clip {{{
    " let g:EasyClipShareYanks=1
    " let g:EasyClipShareYanksDirectory='/tmp'
    " let g:EasyClipShareYanksFile='vim-easyclip'
    "
    " let g:EasyClipUseSubstituteDefaults=1
    " let g:EasyClipUseCutDefaults = 0

    " nmap yd <Plug>MoveMotionPlug
    " xmap yd <Plug>MoveMotionXPlug
    " nmap ydd <Plug>MoveMotionLinePlug
    " }}}

    " " YankRing {{{
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

    cmap W!! SudoWrite
    cmap w!! SudoWrite
    " cmap w!! w !sudo tee > /dev/null %
    " cmap w!! execute ':silent w !sudo tee %  > /dev/null'
"}}}
    " next object {{{

    " map <expr> [l repmo#Key1(':ll<CR> :lprevious<CR>', ':ll<CR> :lnext<CR>')
    " map <expr> ]l repmo#Key1(':ll<CR> :lnext<CR>', ':ll<CR> :lprevious<CR>')
    noremap <silent> [l :ll <CR> :lprevious<CR>
    noremap <silent> ]l :ll <cr> :lnext<cr>

    " noremap [c [d
    " noremap ]c ]d
    " }}}
    " nnoremap <C-i>   <Esc>:tabnext<CR> " <C-i> == tab
    " noremap <C-t>    <Esc>:tabnew<CR>

" emac compatable mappings {{{
    noremap <C-a>     <Esc>^
    inoremap <C-a>     <Esc>I
    noremap <C-e>     <Esc>g_
    inoremap <C-e>     <Esc>g_a
" }}}
" Toggles {{{
    imap              <F1>  <NOP>
    inoremap          <F2>  <NOP>
    inoremap <silent> <F3>  <C-o>:Tagbar<CR>

    inoremap          <F4>  <NOP>
    inoremap          <F7>  <NOP>
    inoremap <silent> <F8>  <C-o>:set spell!<Cr>
    inoremap          <F9>  <NOP>
    inoremap          <F10> <NOP>
    inoremap          <F11> <NOP>
    inoremap          <F12> <NOP>

    nmap            <F1>  <NOP>
    noremap <silent><F2>  :UndotreeToggle<CR>
    noremap <silent><F3>  :Tagbar<CR>
    set pastetoggle=<F4>

    nmap <F5> <Plug>copytoggle
    " noremap <silent> <F5> :YRShow<CR> -- was part of yankring
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

    " nnoremap <C-S-j> :5winc + <Cr>
    " nnoremap <C-S-k> :5winc - <Cr>
    " nnoremap <C-S-h> :5winc < <Cr>
    " nnoremap <C-S-l> :5winc > <Cr>

    map j gj
    map k gk

"}}}
" edditqf {{{
     " au BufReadPost quickfix nnoremap <buffer>  dd idd:w<CR>:copen<CR> " delete quickfix item
" }}}
" change cursor shape in insertmode {{{

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
if has('nvim')
    "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 "replace by guicursor
else
    " TODO this can cleaner
  if &term =~? '^xterm\|rxvt'
    " solid underscore
    let &t_SI .= "\<Esc>[6 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
  elseif &term =~? '^screen\|tmux'
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
  " ale{{{

map  <C-i> :ALEHover<CR>
  " }}}
" completion {{{
set completeopt=longest,menuone
" if has('nvim')

  " Use deoplete. {{{
    " call deoplete#enable_logging('DEBUG', 'deoplete.log')

    let g:deoplete#enable_at_startup = 1
    " if !exists('g:deoplete#omni#input_patterns')
    "   let g:deoplete#omni#input_patterns = {}
    " endif

    " inoremap <silent><expr> <TAB>
        "       \ pumvisible() ? "\<C-n>" :
        "       \ <SID>check_back_space() ? "\<TAB>" :
        "       \ deoplete#manual_complete()
        "       function! s:check_back_space() abort "{{{
        "         let col = col('.') - 1
        "         return !col || getline('.')[col - 1]  =~ '\s'
        "   endfunction "}}}

    " add completion ALE completion
    " call deoplete#custom#option('sources', {
    " \ '_': ['ale','tmuxcomplete#complete','file'],
    " \ 'sh': ['ale','tmuxcomplete#complete','file','omni','zsh_completion#Complete'],
    " \})

" endif
  " ultisnips {{{
  let g:UltiSnipsExpandTrigger='<C-l>'
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
  " nnoremap <silent><CR> :noh<CR><CR>
"
" auto stop search highlighting and move to next serach result with tab {{{
  let g:incsearch#auto_nohlsearch = 1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(inceearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " map f <Plug>Sneak_f
  " map F <Plug>Sneak_F
  " map t <Plug>Sneak_t
  " map T <Plug>Sneak_T

  augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
  augroup END
  function! s:incsearch_keymap()
    IncSearchNoreMap <Right> <Over>(incsearch-next)
    IncSearchNoreMap <Left>  <Over>(incsearch-prev)
    IncSearchNoreMap <Down>  <Over>(incsearch-scroll-f)
    IncSearchNoreMap <Up>    <Over>(incsearch-scroll-b)
  endfunction
" }}}
" }}}
" airline {{{
  set laststatus=2
  " let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 0
  let g:airline_symbols_ascii = 1
" powerline symbols

  if !exists('g:airline_symbols') " TODO why is this here
    let g:airline_symbols = {}
  endif

  let g:airline_left_sep = '»'
  let g:airline_left_sep = ''
  " let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = ''
  " let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '¶'
  " let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.maxlinenr = ''

  " let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
" }}}
" nerdtree {{{
"close vim if only nerdtre open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" user nurdtree on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" }}}
" tags {{{
" gutenhasktags {{{
  let g:gutentags_project_info = [ {'type': 'python', 'file': 'setup.py'},
                                 \ {'type': 'ruby', 'file': 'Gemfile'},
                                 \ {'type': 'haskell', 'file': 'Setup.hs'} ]
  let g:gutentags_ctags_executable_haskell = 'gutenhasktags'
" }}}
" easytags {{{
  let g:easytags_events = ['BufWritePost']

  " set tags+=./tags
  let g:easytags_dynamic_files = 1
  let g:easytags_async = 1
  let g:easytags_by_filetype = '~/.vim/easytags'
"}}}
"}}}
" git {{{
  autocmd! BufNewFile,BufRead *.git/COMMIT_EDITMSG set ft=gitcommit
" git gutter {{{
  " let g:gitgutter_escape_grep = 1 " TODO i think this no longer needed
  " nmap ]h <Plug>(GitGutterNextHunk)
  " nmap [h <Plug>(GitGutterPrevHunk)
  "
  " omap ih <Plug>(GitGutterTextObjectInnerPending)
  " omap ah <Plug>(GitGutterTextObjectOuterPending)
  " xmap ih <Plug>(GitGutterTextObjectInnerVisual)
  " xmap ah <Plug>(GitGutterTextObjectOuterVisual)
"}}}
" vim-signify  (git hunk signs){{{
      autocmd User SignifyHunk call s:show_current_hunk()

    function! s:show_current_hunk() abort
      let h = sy#util#get_hunk_stats()
      if !empty(h)
        echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
      endif
    endfunction
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
if &background==# 'light'
  set background=dark
  AirlineTheme powerlineish
else
  set background=light
  AirlineTheme solarized
endif
  let s:test='colorscheme '.g:colors_name
  execute s:test
endfunction

command! Togglebackground call ReverseBackground()
noremap <F7> :Togglebackground<CR>

"}}}

let g:rt_cw = ''
function! RT()
  ALEGoToDefinition
  let l:cw = expand('<cword>')
  try
    if l:cw != g:rt_cw
        execute 'tag ' . l:cw
        call search(l:cw,'c',line('.'))
    else
        try
            execute 'tnext'
        catch /.*/
            execute 'trewind'
        endtry
        call search(l:cw,'c',line('.'))
    endif
    let g:rt_cw = l:cw
  catch /.*/
    echo 'no tags on ' . l:cw
  endtry
endfunction
map <C-]> :call RT()<CR>
"}}

function! <SID>Preserve(command) "{{{
  let l:line = line('.')
  let l:colum = col('.')
  execute a:command
  call cursor(l:line, l:colum)
endfunction
com! StripTrailingWhitespaces call s:Preserve('%s/\s\+$//e')
" }}

function! <SID>DiffWithSaved() " {{{
  let l:filetype=&filetype
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe 'setlocal bt=nofile bh=wipe nobl noswf ro ft=' . l:filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" }}}

