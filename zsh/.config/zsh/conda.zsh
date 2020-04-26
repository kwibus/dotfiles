__conda_setup="$('/home/rens/.local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"

function conda_setup {
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/rens/.local/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/rens/.local/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/rens/.local/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

