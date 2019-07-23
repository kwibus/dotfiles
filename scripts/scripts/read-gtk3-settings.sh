#!/bin/bash

conf="${XDG_CONFIG_HOME:-$HOME/.config}"/gtk-3.0/settings.ini 
# set -o nounset
getgtk () {
    awk -F= '$1 == "'"$1"'" {print $2}'  "$conf"
}

setgtk(){
    key=$1 
    value=$2
    echo gsettings set org.gnome.desktop.interface "$key" $value
}

setgtk gtk-theme $(getgtk gtk-theme-name)
setgtk icon-theme $(getgtk gtk-icon-theme-name)
setgtk cursor-theme "$(getgtk gtk-cursor-theme-name)"
