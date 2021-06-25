#!/bin/bash
exit 1
focused=$(swaymsg -t get_outputs  |jq '.[]| select(.focused==true).name'  )
scale=$(swaymsg -t get_outputs  |jq '.[]| select(.focused==true).scale'  )
sway output "$focused" scale  $(bc <<< "scale =3; $scale $1")

