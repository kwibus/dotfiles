#!/bin/bash
program_id=$1
program="$@"
workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) .name' )
n=$(sway '[app_id='$program_id' workspace='"$workspace"']' focus | jq '.[].success')
if [ "$n" == "false" ]
then
    shift
    exec "$program_id"   $*
fi
