# zmodload zsh/zprof # for profiling
XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/"$UID"}
ZDOTDIR=${ZDOTDIR:-$HOME/.zsh}

fpath=("$ZDOTDIR"/completion  "$ZDOTDIR"/gencomplete "$ZDOTDIR/updatedComplete"  $fpath)
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
export HISTFILESIZE=1000000
export HISTSIZE=1000000

setopt APPEND_HISTORY AUTOCD BEEP NOTIFY INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
# setopt HIST_IGNORE_ALL_DUPS  # Disabled: causes old history to vanish, confusing in tmux
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE       # Do not record an event starting with a space.
setopt HIST_VERIFY
setopt HIST_FCNTL_LOCK         # Prevent history corruption when multiple tmux panes write

setopt PUSHDIGNOREDUPS         # and don't duplicate them

bindkey -e
# map shift enter to enter
bindkey '\e[13;2u' accept-line

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' format '%F{red}%d%f'
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
#
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

# setopt EXTENDED_GLOB
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

# autoload -U predict-on
# zle -N predict-on
# bindkey '^X^P' predict-on  # Ctrl+X, Ctrl+P to toggle

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Generate completions if they are missing or older than 20 days
# Move this before compinit so it can pick them up
( cd "$ZDOTDIR"/updatedComplete/ 2>/dev/null || mkdir -p "$ZDOTDIR"/updatedComplete && cd "$ZDOTDIR"/updatedComplete
    { which rclone   && [[ ! -f _rclone   || -n $(find _rclone   -mtime +20) ]] } &>/dev/null && rclone genautocomplete zsh _rclone
    { which stack    && [[ ! -f _stack    || -n $(find _stack    -mtime +20) ]] } &>/dev/null && stack --bash-completion-script stack > _stack
    { which kubectl  && [[ ! -f _kubectl  || -n $(find _kubectl  -mtime +20) ]] } &>/dev/null && kubectl completion zsh > _kubectl
    { which minikube && [[ ! -f _minikube || -n $(find _minikube -mtime +20) ]] } &>/dev/null && minikube completion zsh > _minikube
    { which rustup   && [[ ! -f _cargo    || -n $(find _cargo    -mtime +20) ]] } &>/dev/null && rustup completions zsh cargo > _cargo
)

autoload -Uz compinit bashcompinit
compinit -d $XDG_CACHE_HOME/zsh/dump
bashcompinit

complete -o nospace -C terraform terraform
# Register az FIRST, then gcloud
# az break bashcomponit skip this by calling register-python-argcomplete directly
# include /opt/azure-cli/bin/az.completion.sh

# Load az completion before gcloud to avoid state corruption.
# Both use python-argcomplete, but az's 'compdef' call resets completion
# variables (_tags_level, _last_nmatches) that gcloud's bashcompinit needs.
# Loading az first ensures gcloud inherits correct state.
eval "$(register-python-argcomplete az)"

source /opt/google-cloud-cli/path.zsh.inc
source /opt/google-cloud-cli/completion.zsh.inc

if sway_pid=$(pgrep -x sway); then
    export SWAYSOCK=/run/user/${UID}/sway-ipc.${UID}."$sway_pid".sock
    unset sway_pid
else
    unset SWAYSOCK
fi
# export SWAYSOCK=(/run/user/${UID}/sway-ipc.${UID}.*.sock)
if niri_pid=$(pgrep -x niri); then
    export NIRI_SOCKET="/run/user/${UID}/niri.${WAYLAND_DISPLAY}."$niri_pid".sock"
    unset niri_pid
else
    unset NIRI_SOCKET
fi
# export NIRI_SOCKET=("/run/user/${UID}/niri.${WAYLAND_DISPLAY}.*.sock")
export HYPRLAND_INSTANCE_SIGNATURE="$(ls -1t /tmp/hypr 2>/dev/null |head -1   )"

# Force podman container instead of docker
# export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

export DISABLE_TELEMETRY=1 # disable telmeter claude
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

export _ZO_ECHO=1 # echo dir before z
eval "$(zoxide init zsh)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

# include "$ZDOTDIR"/cabalpromt.zsh 'cabal_pr="sandbox_prompt"'
# include "$ZDOTDIR"/gitpromt.zsh 'git_pr="__git_prompt"'
# include "$ZDOTDIR"/conda.zsh
# include /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
setopt promptsubst

# vcs_info configuration for git status
autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats ' [%b]'
zstyle ':vcs_info:git:*' actionformats ' [%b|%a]'
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:git:*' stagedstr '+'

# Hook to color the branch name based on status
zstyle ':vcs_info:git*+set-message:*' hooks git-st-color
+vi-git-st-color() {
    local color="blue"
    if [[ -n ${hook_com[staged]} ]]; then
        color="green"
    elif [[ -n ${hook_com[unstaged]} ]]; then
        color="yellow"
    fi
    hook_com[branch]="%F{$color}${hook_com[branch]}%f"
}

# Define the left side of the header
leftHeader="%F{red}%n%f@%F{blue}%m%f:%F{yellow}%1~ %f"

precmd_vcs_info() {
    vcs_info
    local zero='%([BSUbfksu]|([FK]|){*})'

    # Store clean lengths for dynamic expansion
    _left_len=${#${(S%%)leftHeader//$~zero/}}
    _git_time_str="${vcs_info_msg_0_} [%T] "
    _right_len=${#${(S%%)_git_time_str//$~zero/}}

    # PROMPT_SUBST will now recalculate the math in the single quotes on every redraw/resize
    PROMPT='${leftHeader}%F{grey}%U${(r:$((COLUMNS - _left_len - _right_len - 1)):: :)}%u%f${_git_time_str}'$'\n'"%(1j.%j.)%#> "
}
add-zsh-hook precmd precmd_vcs_info

function precmd_reset()
{
    stty sane
    tput cnorm   # set cursor visible normal
}
add-zsh-hook precmd precmd_reset

help()
{
    man zshbuiltins | sed -ne "/^       $1 /,/^\$/{s/       //; p}"
}

GENCOMPL_FPATH="$ZDOTDIR"/gencomplete
include "$ZDOTDIR"/zsh-completion-generator/zsh-completion-generator.plugin.zsh


include /usr/bin/aws_zsh_completer.sh  # Temporarily disabled to test
# eval "$(_MOLECULE_COMPLETE=source molecule)"

include $ZDOTDIR/git-extras-completion.zsh

include /usr/share/undistract-me/long-running.bash notify_when_long_running_commands_finish_install

export PYTHONPYCACHEPREFIX="$HOME/.cache/cpython/"
mkdir -p "${PYTHONPYCACHEPREFIX}"

# include '/usr/share/nvm/init-nvm.sh'

# zprof # for profiling
