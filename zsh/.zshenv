export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export VAGRANT_DEFAULT_PROVIDER=libvirt
export MYPY_CACHE_DIR=$XDG_CACHE_HOME/mypy
export GOPATH=$HOME/.local/gobin/
path=(
    $path
    $HOME/scripts
    $HOME/.local/bin
    /usr/share/bcc/tools
    $GOPATH/bin
    $HOME/.local/share/coursier/bin
    $HOME/.local/share/cargo/bin
    $HOME/.config/composer/vendor/bin:$PATH
)
export -U PATH
