  [[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="$HOME/.config"
autoload -U colors && colors
eval $(dircolors)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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
zstyle ':completion:*' menu select=0
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'correction %e'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %l%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/rens/.zshrc'

autoload -Uz compinit bashcompinit
compinit
# End of lines added by compinstall

export PATH=$HOME/scripts:$HOME/.local/bin:$PATH

Watch=all

zstyle ':completion:*:functions' ignored-patterns '_*'
stty -ixon # disable Ctrl-S  freeze

# delete key
bindkey '\e[3~' delete-char
bindkey '^Xr' history-search-backward
bindkey '\ef' emacs-forward-word
bindkey '\eb' emacs-backward-word

# bindkey "^[[A" history-search-backward
# bindkey "^[[B" history-search-forward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# setop EXTENDEDGLOB
setopt PROMPT_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt NO_LIST_BEEP
setopt NO_HIST_BEEP
setopt CORRECT
#setopt CORRECTALL
setopt GLOBDOTS
setopt AUTOPUSHD               # automatically append dirs to the push/pop list
setopt PUSHDIGNOREdUPS         # and don't duplicate them

setopt PRINT_EXIT_VALUE
# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script "$(which stack)")"


zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#
#export _JAVA_AWT_WM_NONREPARENTING=1 # werk niet`
#export PYTHONPATH=/usr/lib/python3.3/site-packages
# export CCACHE_DIR=/home/rens/.cache/ccache    # Tell ccache to use this path to store its cache

export EDITOR="vim"
KEYTIMEOUT=1

alias -r startx='startx ~/.xinitrc'
alias -r rm='rm -i'
alias -r mv='mv -i'
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

include /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/doc/pkgfile/command-not-found.zsh

include ~/.zsh/cabalpromt.zsh
include ~/.zsh/gitpromt.zsh

prompt="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%(1j.%j.)%#"

export RPS1='$(sandbox_prompt) $(__git_prompt)'

