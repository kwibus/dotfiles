#
#
# This simple script displays whether you are in a cabal sandbox
# the the result of checking for a sandbox is cached, but now that I
# actually think about it, it was probably an unnecessary step.
# Don't forget to customize the PROMPT variable at the bottom 
#
# Looks like this with my prompt: https://files.app.net/rjphjAG9.png
#

function update_cabal_sandbox_info () {
    if [[ -a cabal.sandbox.config ]]
    then
        export __CABAL_SANDBOX="sandbox $(basename $(dirname $CABAL_SANDBOX_CONFIG 2> /dev/null ) 2> /dev/null)"
    else
        export __CABAL_SANDBOX=
    fi
    export __CABAL_SANDBOX_VARS_INVALID=
}

function get_cabal_sandbox_info () {
    test -n "$__CABAL_SANDBOX_VARS_INVALID" && update_cabal_sandbox_info
    echo $__CABAL_SANDBOX
}

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
setopt prompt_subst

export __CABAL_SANDBOX=
export __CABAL_SANDBOX_VARS_INVALID=1

chpwd_functions+='update_cabal_sandbox_chpwd'
update_cabal_sandbox_chpwd () {
    export __CABAL_SANDBOX_VARS_INVALID=1
}

preexec_functions+='update_cabal_sandbox_preexec'
update_cabal_sandbox_preexec () {
    case "$(history $HISTCMD)" in 
        *cabal*) export __CABAL_SANDBOX_VARS_INVALID=1 ;;
    esac
}

SLR_DARKSEA=%{$fg_bold[green]%}

sandbox_prompt () {
     test -n $__CABAL_SANDBOX
     echo "$SLR_DARKSEA$(get_cabal_sandbox_info)%{$reset_color%}"
}

PROMPT="$(sandbox_prompt) , %~ \n"
 

