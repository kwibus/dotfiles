#! /bin/bash
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$XDG_DATA_DIRS"
export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

export TERMINFO="$XDG_DATA_HOME"/terminfo # Precludes system path searching.

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export STACK_ROOT="$XDG_DATA_HOME"/stack
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
#
# export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CARGO_HOME="$XDG_DATA_HOME"/cargo

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export ICEAUTHORITY="$XDG_RUNTIME_DIR"/iceauthority
export XAUTHORITY="$XDG_RUNTIME_DIR"/xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export WINEPREFIX="$XDG_DATA_HOME"/wine
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvt-$(cat /proc/sys/kernel/hostname)"

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME"/gimp

# export ZDOTDIR="$XDG_CONFIG_HOME"/zsh this is done in /etc/zshenv to prvent strartup new user
export HISTFILE="$XDG_DATA_HOME"/zsh/history

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
