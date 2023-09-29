#! /bin/bash

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

set -a
source "${XDG_CONFIG_HOME}/sway/env"
set +a

exec systemd-cat --identifier=sway sway


