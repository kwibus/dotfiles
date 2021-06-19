selectors=$(swaymsg -t get_tree | awk '$1 ~ /"app_id"|"class"/ && $2 !~ /null/{print $1,$2}' |  tr ":" "=" |tr -d ' ,')
if app=$(cut -d = -f2 <<< $selectors |tr '[:upper:]' '[:lower:]' |tr -d '"'  |dmenu)
then 
    selector="$(grep -i "$app" <<< $selectors )"
    key=$(echo $selector | cut -d = -f1  |tr -d '"')
    val=$(echo $selector | cut -d = -f2  )
    sway "[${key}=${val}]" focus
fi
