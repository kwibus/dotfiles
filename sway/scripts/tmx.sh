#!/bin/bash

base_session="${1:-base}"
exec tmux new-session -At "${base_session}" -s $$
