#! /bin/sh

command=$1

tmpfile=/tmp/player.sh_lastPlayer # dont know a cleaner solution for this, but its unlikely this will clash with other programs

# will pick player which is playing
# otherwise player were last command is send to
get_active_Player (){
    if mpc status | grep -q playing
    then
        echo mpd
        return
    fi
     
    ctl_players="$(playerctl -l)"
    for p in $ctl_players
    do
        if [ "$(playerctl --player="$p" status)" = Playing ]
        then
            echo "$p"
            return
        fi
    done

    # check if previous player is active
    if [ -f "$tmpfile" ]
    then
        last_player=$(cat "$tmpfile")
        if [ "$last_player" = mpd ] || echo  "$ctl_players" | grep -q "$last_player" 
        then 
            echo "$last_player"
            return
        fi
    fi
    # possix way of get first of list might be better options
    set -- $ctl_players mpd
    echo "$1"
}

perform_comand (){

    player="$1"
    command="$2"

    if [ "$player" = mpd ]
    then
        mpc "$command"
    else
        case $command in
            prev) playerctl --player="$player" previous ;;
            toggle) playerctl  --player="$player" play-pause;;
            next) playerctl --player="$player" next;;
            *) echo Command \""$command"\" not supporte.

        esac
    fi

}

set -o errexit
set -o nounset
set -o pipefail


player=$(get_active_Player)

echo "$player" "$command"
perform_comand "$player" "$command"

echo "$player" > "$tmpfile"


