#! /bin/bash

source "$XDG_CONFIG_HOME/sway/env"
export $( grep -o "^[^#]*" "$XDG_CONFIG_HOME/sway/env"| cut -d= -f1 )

# pkill ssh-agent

ssh_pid=$(pgrep -x ssh-agent |head -1)
if [ -z "$ssh_pid" ]
then
    eval `ssh-agent -s -a /tmp/ssh-agent`
    mv $SSH_AUTH_SOCK /tmp/ssh-agent.$SSH_AGENT_PID
else
    export SSH_AGENT_PID="$ssh_pid"
fi

export SSH_AUTH_SOCK="/tmp/ssh-agent.$SSH_AGENT_PID"
exec sway -V

