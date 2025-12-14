#!/bin/bash

session_group="${1:-base}"
exec tmux new-session -At "${session_group}" -s $$
