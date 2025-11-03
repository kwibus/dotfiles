XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/"$UID"}
ZDOTDIR=${ZDOTDIR:-$HOME/.zsh}

fpath=("$ZDOTDIR"/completion  "$ZDOTDIR"/gencomplete/ "$ZDOTDIR/updatedComplete"  $fpath)
autoload -U colors && colors
eval $(dircolors --sh)

HISTFILE=${HISTFILE:=~/.histfile}
[ -f "$HISTFILE" ] || mkdir -p $(dirname "$HISTFILE")
[ -d "$ZDOTDIR" ] || mkdir -p "$ZDOTDIR"
[ -d "$ZDOTDIR/completion" ] || mkdir "$ZDOTDIR/completion"
[ -d "$ZDOTDIR/gencomplete" ] || mkdir "$ZDOTDIR/gencomplete"
[ -d "$ZDOTDIR/updatedComplete" ] || mkdir "$ZDOTDIR/updatedComplete"

# Lines configured by zsh-newuser-install
# HISTSIZE=10000
export SAVEHIST=1000000
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt APPEND_HISTORY AUTOCD BEEP NOTIFY INCAPPENDHISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt inc_append_history

# setopt PUSHDIGNOREdUPS         # and don't duplicate them

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
zstyle ':completion:*' file-sort modification # TODO test


# zstyle :compinstall filename '/home/rens/.zshrc'


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

bindkey ${terminfo[kLFT]:-'\e[1;2D'} backward-word #shift-left
bindkey ${terminfo[kRIT]:-'\e[1;2C'} forward-word #shift-right
#bindkey $terminfo[kri] shift-up
#bindkey $terminfo[kind] shift-down

# setop EXTENDEDGLOB
setopt PROMPT_SUBST
setopt NO_LIST_BEEP
setopt CORRECT
# setopt auto_menu
#setopt CORRECTALL
setopt GLOBDOTS
setopt AUTOPUSHD               # automatically append dirs to the push/pop list

setopt PRINT_EXIT_VALUE
# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

#export VDPAU_DRIVER=va_gl
export VDPAU_DRIVER=radeonsi

# bindkey "^I" menu-expand-or-complete

zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh

autoload -Uz compinit bashcompinit
compinit -d $XDG_CACHE_HOME/zsh/dump
bashcompinit

export GOPATH=$HOME/.local/godir
PATH=$HOME/scripts:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$PATH
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
if sway_pid=$(pgrep -x sway); then

    export SWAYSOCK=/run/user/${UID}/sway-ipc.${UID}."$sway_pid".sock
    unset sway_pid
else
    unset SWAYSOCK
fi
if niri_pid=$(pgrep -x niri); then
    export NIRI_SOCKET="/run/user/${UID}/niri.${WAYLAND_DISPLAY}."$niri_pid".sock"
    unset niri_pid
else
    unset NIRI_SOCKET
fi
HYPRLAND_INSTANCE_SIGNATURE="$(ls -1t /tmp/hypr |tail -1)"  2>/dev/null
# Force podman container instead of docker
# export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
# export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh  # TODO test
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass
export EDITOR="nvim"
export SYSTEMD_EDITOR="nvim"
# export LESS="-ra"

# export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvt/urxvt-"$(hostname)"
# export TMUX_TMPDIR="$XDG_RUNTIME_DIR"/tmux

# export PYTHONPATH=/usr/lib/python3.3/site-packages
# export CCACHE_DIR=/home/rens/.cache/ccache    # Tell ccache to use this path to store its cache

KEYTIMEOUT=1
# alias -r pandoc='pandoc --lua-filter=/home/rens/scripts/task-list.lua'

# alias -g wlan=$(basename -a /sys/class/net/w* |head  -n1)
# alias -g eth=$(basename -a /sys/class/net/e* |head -n1 )
#test -n "$TMUX" && alias ssh='TERM=screen ssh'
# alias -r x='startx "$XINITRC"'
alias -r info='info --vi-keys'
alias -r rm='rm -i'
alias -r mv='mv -i'
alias -r cp='cp -i --sparse=always --reflink=auto'

alias -r diff='diff --color=auto'
alias -r tp='trash-put'
alias -r ip='ip -color=auto'
alias -r grep='grep --color=auto'
alias -r ls='ls --color=auto -h'
alias  dirs='dirs -v'
alias -r less='less -r'
# alias -r myLimit='ulimit  -Sc unlimited -Sv $((1024*1024))'
# alias octave="octave -q"
alias o="xdg-open"
alias yay="yay --sudoloop"
alias gdb="gdb -q"
alias -r glog='git log --oneline --graph --decorate=short'
alias -r gcloud="LOGNAME=r_sikma CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud"
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

#include /usr/share/autojump/autojump.zsh
export _ZO_ECHO=1 # echo dir before z 
eval "$(zoxide init zsh)"
include /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
include /usr/share/doc/pkgfile/command-not-found.zsh

include "$ZDOTDIR"/cabalpromt.zsh 'cabal_pr="sandbox_prompt"'
include "$ZDOTDIR"/gitpromt.zsh 'git_pr="__git_prompt"'
include "$ZDOTDIR"/conda.zsh
# include /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
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

local line='$leftHeader''%{$fg[grey]%}%U${(r:$((COLUMNS- ${#${(S%%)leftHeader//$~zero/}} -$timeLength -10 )):: :)}%u%{$reset_color%}''$timePrompt'

prompt="$line"$'\n'"%(1j.%j.)%#> "

export RPS1='$_project $($cabal_pr) $($git_pr)'
fuction precmd_reset()
{
    stty sane
    tput cnorm   # set cursor visible normal
}
autoload -U add-zsh-hook
add-zsh-hook precmd precmd_reset
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

GENCOMPL_FPATH="$ZDOTDIR"/gencomplete
# GENCOMPL_PY=python3
include "$ZDOTDIR"/zsh-completion-generator/zsh-completion-generator.plugin.zsh


#include ~/Downloads/google-cloud-sdk/completion.zsh.inc
include /opt/google-cloud-cli/completion.zsh.inc
include /usr/bin/aws_zsh_completer.sh
# eval "$(_MOLECULE_COMPLETE=source molecule)"

( cd "$ZDOTDIR"/updatedComplete/
    { which rclone   && test ! $(find _rclone   -mtime -20) } &> /dev/null && rclone genautocomplete zsh _rclone
    { which stack    && test ! $(find _stack    -mtime -20) } &> /dev/null && stack --bash-completion-script stack > _stack
    { which kubectl  && test ! $(find _kubectl  -mtime -20) } &> /dev/null && kubectl completion zsh > _kubectl
    { which minikube && test ! $(find _minikube -mtime -20) } &> /dev/null && minikube completion zsh > _minikube
    # { which gitdoc && test ! $(find _gitdoc -mtime -20) } &> /dev/null && register-python-argcomplete  gitdoc > _gitdoc
)
include $ZDOTDIR/git-extras-completion.zsh
include /opt/azure-cli/az.completion

include /usr/share/undistract-me/long-running.bash notify_when_long_running_commands_finish_install
# eval "$(register-python-argcomplete gitdoc)"

export PYTHONPYCACHEPREFIX="$HOME/.cache/cpython/"
mkdir -p "${PYTHONPYCACHEPREFIX}"

# include '/usr/share/nvm/init-nvm.sh'

#auto_pip_venv (){
#
#  if [[ -f venv/bin/activate ]] ; then
#    source venv/bin/activate
#  fi
#
#}
chpwd_functions+=(auto_pip_venv)

# GOPATHSTART="$GOPATH"
#
# function chpwd {
#
#     local projectroot=$(findProjectRoot.sh)
#
#     if ! [ -z $projectroot ]
#     then
#         _project="$(basename $projectroot)"
#         GOPATH="$projectroot:$GOPATHSTART"
#     else
#         _project=""
#     fi
# }
# chpwd
