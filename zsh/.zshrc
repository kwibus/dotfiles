XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/"$UID"}
ZDOTDIR=${ZDOTDIR:-$HOME/.zsh}
fpath=($ZDOTDIR/completion $fpath)
autoload -U colors && colors
eval $(dircolors)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY AUTOCD BEEP NOTIFY SHARE_HISTORY
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
zstyle :compinstall filename '/home/rens/.zshrc'


# End of lines adcomplete


Watch=all
stty -ixon # disable Ctrl-S  freeze

# delete key
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
setopt PUSHDIGNOREdUPS         # and don't duplicate them

setopt PRINT_EXIT_VALUE
# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT


# bindkey "^I" menu-expand-or-complete

zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

export GOPATH=$HOME/.local/godir
PATH=$HOME/scripts:$HOME/.local/bin:$PATH
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH 

export EDITOR="vim"
export SYSTEMD_EDITOR="vim"
# export LESS="-ra"
# must go aver PATH to find stack

# xdg corrections

# export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvt/urxvt-"$(hostname)"
# export TMUX_TMPDIR="$XDG_RUNTIME_DIR"/tmux

# export _JAVA_AWT_WM_NONREPARENTING=1 # werk niet`
# export PYTHONPATH=/usr/lib/python3.3/site-packages
# export CCACHE_DIR=/home/rens/.cache/ccache    # Tell ccache to use this path to store its cache

KEYTIMEOUT=1

alias -g wlan=wlp5s0
test -n "$TMUX" && alias ssh='TERM=screen ssh'
alias -r x='startx "$XINITRC"'
alias -r rm='rm -i'
alias -r mv='mv -i'
alias -r cp='cp -i'

alias -r tp='trash-put'
alias -r grep='grep --color=auto'
alias -r ls='ls --color=auto -h '
alias  dirs='dirs -v'
alias -r less='less -r'
alias -r myLimit='ulimit  -Sc unlimited -Sv $((1024*1024))'
alias octave="octave -q"
alias o="xdg-open"
alias gdb="gdb -q"
alias -r glog='git log --oneline --graph --decorate=short'

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
    [ -f "$1" ] && source "$1"
}

include /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/doc/pkgfile/command-not-found.zsh

include "$ZDOTDIR"/cabalpromt.zsh
include "$ZDOTDIR"/gitpromt.zsh


prompt="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%(1j.%j.)%#"

export RPS1='$(sandbox_prompt) $(__git_prompt)'
help()
{
    man zshbuiltins | sed -ne "/^       $1 /,/^\$/{s/       //; p}"
}
# # Load zsh-autosuggestions.
# source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh
# AUTOSUGGESTION_HIGHLIGHT_COLOR=1
# # Enable autosuggestions automatically.
# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init
#
# ttyctl -f
#
# zstyle ':completion:*:manuals'    separate-sections true
# zstyle ':completion:*:manuals.*'  insert-sections   true
# zstyle ':completion:*:man:*'      menu yes select

GENCOMPL_FPATH="$ZDOTDIR"/complete
# GENCOMPL_PY=python2
# source "$ZDOTDIR"/zsh-completion-generator/zsh-completion-generator.plugin.zsh

autoload -Uz compinit bashcompinit
compinit -d $XDG_RUNTIME_DIR
bashcompinit

# eval "$(stack --bash-completion-script stack)"

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
