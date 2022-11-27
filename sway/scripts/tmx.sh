#!/bin/bash

#
# Modified TMUX start script from:
#     http://forums.gentoo.org/viewtopic-t-836006-start-0.html
#



base_session="${1:-base}"
config="$XDG_CONFIG_HOME"/tmux/tmux.conf

tmux_nb=$(tmux ls | grep "^$base_session" | wc -l)
if [ "$tmux_nb" = "0" ]; then
    exec tmux -f "$config" new-session -s "$base_session"
else
    # Make sure we are not already in a tmux session
    if [ -z "$TMUX" ]; then
        # Session is is date and time to prevent conflict
        session_id=$(date +%Y%m%d%H%M%S)
        # Create a new session (without attaching it) and link to base session 
        # to share windows
        tmux -f "$config" new-session -d -t "$base_session" -s "$session_id"
        if [ "$2" = "1" ]; then
            # Create a new window in that session
            tmux new-window
        fi
        # Attach to the new session & kill it once orphaned
        exec tmux attach-session -t "$session_id"
    fi
fi

