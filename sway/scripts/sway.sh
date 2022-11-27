#! /bin/bash

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

set -a
source "${XDG_CONFIG_HOME}/sway/env"
set +a

ssh_pid=$(pgrep -x ssh-agent |head -1)
if [ -z "$ssh_pid" ]
then
    eval "$(ssh-agent -s -a /tmp/ssh-agent)"
    mv "$SSH_AUTH_SOCK" "/tmp/ssh-agent.$SSH_AGENT_PID"
else
    export SSH_AGENT_PID="$ssh_pid"
fi

export SSH_AUTH_SOCK="/tmp/ssh-agent.$SSH_AGENT_PID"
exec systemd-cat --identifier=sway sway


