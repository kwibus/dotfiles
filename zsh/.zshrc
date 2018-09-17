source_count=$((${source_count-0} + 1 ))
ZDOTDIR=${ZDOTDIR-$HOME/.config/zsh}

autoload -U colors && colors
eval $(dircolors)

HISTFILE=${HISTFILE:=~/.histfile}
[ -f "$HISTFILE" ] || mkdir -p $(dirname "$HISTFILE")
[ -d "$ZDOTDIR" ] || mkdir -p "$ZDOTDIR"
[ -d "$ZDOTDIR/completion" ] || mkdir "$ZDOTDIR/completion"

# Lines configured by zsh-newuser-install
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY AUTOCD BEEP NOTIFY #SHARE_HISTORY
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' format $'\e[00;31m%d \e[0m'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'correction %e'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %l%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename "$ZDOTDIR/.zshrc"


# End of lines adcomplete

Watch=all
stty -ixon # disable Ctrl-S  freeze

# delete key
# bindkey -r  "^[h"

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

bindkey '\e[3~' delete-char

bindkey '^Xr' history-search-backward

bindkey '\ef' emacs-forward-word
bindkey '\eb' emacs-backward-word

# bindkey "^[[A" history-search-backward
# bindkey "^[[B" history-search-forward

# setop EXTENDEDGLOB
setopt PROMPT_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt NO_LIST_BEEP
setopt CORRECT
# setopt auto_menu
#setopt CORRECTALL
setopt GLOBDOTS
setopt AUTOPUSHD               # automatically append dirs to the push/pop list
setopt PUSHDIGNOREdUPS         # and dont duplicate them
setopt COMPLETE_ALIASES

setopt PRINT_EXIT_VALUE
# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT


# bindkey "^I" menu-expand-or-complete

zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}"/zsh/cache


export ANDROID_HOME=/opt/android-sdk
export SUDO_ASKPASS=/usr/lib/git-core/git-gui--askpass

export EDITOR="vim"
export VAGRANT_DEFAULT_PROVIDER=libvirt
# export LESS="-ra"

export _JAVA_AWT_WM_NONREPARENTING=1
# export PYTHONPATH=/usr/lib/python3.3/site-packages
# export CCACHE_DIR=/home/rens/.cache/ccache    # Tell ccache to use this path to store its cache

KEYTIMEOUT=1
alias -r pandoc='pandoc --lua-filter=task-list.lua'
alias -g wlan=wlp5s0

alias -r x='startx "$XINITRC"'
alias -r rm='rm -i'
alias -r mv='mv -i'
alias -r cp='cp -i'

alias -r tp='trash-put'
alias -r grep='grep --color=auto'
alias -r ls='ls --color=auto -ht'
alias  dirs='dirs -v'
alias -r less='less -r'
alias -r myLimit='ulimit  -Sc unlimited -Sv $((1024*1024))'
alias octave="octave -q"
alias o="xdg-open"
alias gdb="gdb -q"
alias -r glog='git log --oneline --graph --decorate=short'

alias -r cabal-static-install='cabal install --with-compiler=/usr/share/ghc-pristine/bin/ghc'
# if which HsColour > /dev/null
# then
#     alias ghci='ghci 2>&1 | HsColour -tty'
# fi



man() {
        env \
                LESS_TERMCAP_mb=$(printf "\e[1;31m") \
                LESS_TERMCAP_md=$(printf "\e[1;31m") \
                LESS_TERMCAP_me=$(printf "\e[0m") \
                LESS_TERMCAP_se=$(printf "\e[0m") \
                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
                LESS_TERMCAP_ue=$(printf "\e[0m") \
                LESS_TERMCAP_us=$(printf "\e[1;32m") \
                        man "$@"
}
include () {
    if [ -f "$1" ]
    then
        source "$1"
        eval "$2"
    fi
}

include /usr/share/autojump/autojump.zsh
include /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/doc/pkgfile/command-not-found.zsh

include "$ZDOTDIR"/cabalpromt.zsh 'cabal_pr="sandbox_prompt"'
include "$ZDOTDIR"/gitpromt.zsh 'git_pr="__git_prompt"'

setopt promptsubst

leftHeader=\
"%{$fg[red]%}%n%{$reset_color%}\
@\
%{$fg[blue]%}%m%{$reset_color%}\
:\
%{$fg_no_bold[yellow]%}%1~ %{$reset_color%}"

local zero='%([BSUbfksu]|([FK]|){*})'
local timePrompt=" [%t] "

local leftLength=${#${(S%%)leftHeader//$~zero/}}
local timeLength=${#${(S%%)timePrompt//$~zero/}}

# badSmile="%(?,halo ,%{$fg[red]%}:( %{$reset_color%} "

local line='$leftHeader''%{$fg[grey]%}%U${(r:$((COLUMNS- ${#${(S%%)leftHeader//$~zero/}} -$timeLength )):: :)}%u%{$reset_color%}''$timePrompt'

prompt="$line""%(1j.%j.)%#> "

export RPS1='$project $($cabal_pr) $($git_pr)'
fuction precmd_reset()
{
    stty sane
    tput cnorm   # set currsor visable normal
}
autoload -U add-zsh-hook
add-zsh-hook precmd precmd_reset
help()
{
    man zshbuiltins | sed -ne "/^       $1 /,/^\$/{s/       //; p}"
}
# # Load zsh-autosuggestions.
# include "$ZDOTDIR"/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"


# bindkey '^ ' autosuggest-accept
#
# ttyctl -f
#
# zstyle ':completion:*:manuals'    separate-sections true
# zstyle ':completion:*:manuals.*'  insert-sections   true
# zstyle ':completion:*:man:*'      menu yes select
#
GENCOMPL_FPATH="$ZDOTDIR"/gencomplete
# GENCOMPL_PY=python2
include "$ZDOTDIR"/zsh-completion-generator/zsh-completion-generator.plugin.zsh


autoload -Uz compinit bashcompinit
# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack restricts
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
# else
#     compinit -C;
# fi;

bashcompinit
include /usr/share/bash-completion/completions/cabal

( cd "$ZDOTDIR"/completion/
    { which stack    && test ! $(find _stack    -mtime -20) } &> /dev/null && stack --bash-completion-script stack > _stack
    { which kubectl  && test ! $(find _kubectl  -mtime -20) } &> /dev/null && kubectl completion zsh > _kubectl
    { which minikube && test ! $(find _minikube -mtime -20) } &> /dev/null && minikube completion zsh > _minikube
)
include $ZDOTDIR/git-extras-completion.zsh

include /usr/share/undistract-me/long-running.bash notify_when_long_running_commands_finish_install

GOPATHSTART="$GOPATH"

function chpwd {

    local projectroot=$(findProjectRoot.sh)

    if ! [ -z $projectroot ]
    then
        _project="$(basename projectroot)"
        GOPATH="$projectroot:$GOPATHSTART"
    else
        _project=""
    fi
}
chpwd

# cdUndoKey() { #   popd #   zle       reset-prompt #   echo
#   ls
#   zle       reset-prompt
# }
#
# cdParentKey() {
#   pushd ..
#   zle      reset-prompt
#   echo
#   ls
#   zle       reset-prompt
# }
#
# zle -N                 cdParentKey
# zle -N                 cdUndoKey
# bindkey '^[[1;3A'      cdParentKey
# bindkey '^[[1;3D'      cdUndoKey
