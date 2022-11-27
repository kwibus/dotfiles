#!/bin/bash
program_id=$1
workspace="$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) .name' )"
n="$(sway '[app_id='"$program_id"' workspace='"$workspace"']' focus | jq '.[].success')"
if [ "$n" == "false" ]
then
    # try with capital letter
    n="$(sway '[app_id='"${program_id^}"' workspace='"$workspace"']' focus | jq '.[].success')"
fi
if [ "$n" == "false" ]
then
    shift
    exec "$program_id" $@
fi
