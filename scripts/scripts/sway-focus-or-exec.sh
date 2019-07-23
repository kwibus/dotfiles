#!/bin/bash
program_id=$1
program="$@"
workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) .name' )
n=$(sway '[app_id='$program_id' workspace='"$workspace"']' focus | jq '. | length')
if [ "$n" -eq 0 ]
then
    shift
    # notify-send "$program_id" -- "$*"
    exec "$program_id"   $*
fi
