#!/bin/bash

defice=$(xinput list --short |grep Touchpad |awk '{print $6}'| sed 's/[^1-9]//g')

n=$(xinput --list | grep -c 'pointer' )
if [  "$n" -eq 4 ]
then
    if which synclient &> /dev/null;
    then
        synclient TouchpadOff=1
    fi
    xinput disable "$defice"
else

    if which synclient &> /dev/null;
    then
        synclient TouchpadOff=0 
    fi
    xinput enable "$defice"
fi
