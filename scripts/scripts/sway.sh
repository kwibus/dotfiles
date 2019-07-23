#! /bin/bash

# GTK+ (3.0+)
#export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland

#QT
#export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORM=wayland
export QT_STYLE_OVERRIDE=kvantum
#SDL
export SDL_VIDEODRIVER=wayland

#Java
export _JAVA_AWT_WM_NONREPARENTING=1

export XDG_SESSION_TYPE=wayland

export MOZ_ENABLE_WAYLAND=1


pkill ssh-agent
eval `ssh-agent -s`
WLR_DRM_NO_ATOMIC=0
exec sway -V

