#!/bin/sh

if which synclient 2> /dev/null
then

    synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')
else

    defice=$(xinput list --short |egrep "Touchpad|Synaptic" |sed -r 's#.*id=([0-9]+).*#\1#')
    enable=$(xinput list-props "$defice" | grep "Device Enabled" | cut -d":" -f2)
    if echo "$enable" | grep 1
    then
        xinput disable "$defice"
    else
        xinput enable "$defice"
    fi
fi

