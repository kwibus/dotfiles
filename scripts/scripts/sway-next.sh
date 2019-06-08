#!/bin/bash
next=${1:-1}
[ x$1 == xprevious ] && next=0
layout=$(swaymsg -t get_workspaces|jq '.[].layout')
case $layout in
    '"stacked"') 
        direction=Down
        [ "$next" -eq 0 ] && direction=UP
    ;;
    *) 
        direction=Left
        [ "$next" -eq 0 ] && direction=Right
    ;;
esac
sway focus $direction
