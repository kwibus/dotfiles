display=${1:-eDP-1}
nActive=$(swaymsg -t get_outputs -r |jq '.[]| select(.active==true).name' |wc -l )
if [ "$nActive" -gt 1 ]
then
   sway output "$display" disable
fi

