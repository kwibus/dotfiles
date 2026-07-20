
function __git_prompt {
  # Check if we are in a git repo
  local git_dir=$(git rev-parse --git-dir 2> /dev/null)
  [[ -z "$git_dir" ]] && return

  local DIRTY="%{$fg[yellow]%}"
  local CLEAN="%{$fg[green]%}"
  local UNMERGED="%{$fg[red]%}"
  local RESET="%{$terminfo[sgr0]%}"
  
  local color=$CLEAN
  
  # Check for unmerged files
  if [[ -n $(git ls-files -u 2> /dev/null) ]]; then
    color=$UNMERGED
  else
    # Check for changes (with timeout)
    # 124 = timeout, 1 = dirty, 0 = clean
    timeout 0.1 git diff --quiet 2> /dev/null
    local res=$?
    if [[ $res -eq 1 || $res -eq 124 ]]; then
      color=$DIRTY
    else
      timeout 0.1 git diff --cached --quiet 2> /dev/null
      [[ $? -ne 0 ]] && color=$DIRTY
    fi
  fi

  # More robust branch/version detection
  local ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ "$ref" == "HEAD" || -z "$ref" ]]; then
    # If detached HEAD, show short hash (the "version")
    ref=$(git rev-parse --short HEAD 2> /dev/null)
  fi

  # Fallback if ref is still empty
  [[ -z "$ref" ]] && ref="unknown"

  echo -n "${RESET}[${color}${ref}${RESET}]"
}
