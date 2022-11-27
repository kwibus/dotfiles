#!/bin/bash

set -o erronexit
set -o nounset
set -o pipefail

focused=$(swaymsg -t get_outputs  |jq '.[]| select(.focused==true).name'  )
# echo focus: $focused
scale=$(swaymsg -t get_outputs  |jq '.[]| select(.focused==true).scale'  )
# echo scale: $scale
sway output "$focused" scale  $(bc <<< "scale =3; $scale $1")

