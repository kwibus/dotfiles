#! /bin/bash

# set -o errexit
# set -o nounset
# set -o pipefail

error() {
    echo ""
    color "$BOLD$RED" "$1">&2
    echo ""
}
isAmend () {
    parentPid="$$"
    while test $parentPid -ne 1  && ps -o command --no-heading $parentPid  2>/dev/null |grep -v "^git\s" > /dev/null
    do
        parentPid=$(ps -o ppid --no-heading $parentPid) > /dev/null 2>&1
    done
    test "$parentPid" -gt 1 && ps -o command --no-heading $parentPid | grep -- "--amend" > /dev/null
}

detectProgramingLangue (){
    { git ls-files |grep ".*\.cabal$" && programlangues=cabal:$programlangues ; } || true
}

useLangues () {
    echo "$programlangues" | grep "$1"  &> /dev/null
}
prependOnOutput () {
    read -r firstLine
    if  [ -n "$firstLine" ];
    then
        error "$1"
        echo "$firstLine"
    fi
    while read -r line;
    do
        echo "$line"
    done
}
checkUnstaged () {
    local hasError
    local untracked=$(git clean --dry-run | awk '{print $3}')
    if [ -n "$untracked" ]
    then
       color "$RED"there are untracked files:
       echo "$untracked"
       hasError=1
    fi
    local unstaged="$(git ls-files --modified)"
    if [ -n "$unstaged" ]
    then
       color "$RED"there are unstaged files:
       echo "$unstaged"
       return 1
       hasError=1
    fi
    if [ "$hasError" = 1 ]
    then
        return 1
    else
        return 0
    fi
}

checkBranch (){
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$BRANCH" == "master" || "$BRANCH" == "develop" ]]; then
        echo "You are on branch $BRANCH. Are you sure you want to commit to this branch?"
        return 1
    fi
}

checkDirtyHead() {
    output="$(git log -1 --format=%B | grep -i "dirty" --color=always)"
    if [ $? -eq 0 ]
    then
        echo  last commit contains dirty:
        echo "$output"
        return 1
    fi
}

checkConfig() {
   source testSrcFile.sh
   if useLangues cabal
   then
         # cabalCheckUnuesd

         echo cabaltest
         export  -f cabaltest
         echo $cabaltest

         git-sandbox cabaltest  3> /dev/null
         #cabal new-exec -- git-sandbox cabaltest  3> /dev/null
   fi
}

cabalCheckUnuesd (){
   cabal clean
   cabal configure -O0 --disable-library-profiling --enable-test --enable-benchmark
   cabal build --ghc-option=-ddump-minimal-imports
   packunused
}

checkWithSpace () {
    # TODO check if this works
    git diff --cached --check --color=always| prependOnOutput "commit has withespace errors"
}

checkChanges () {
    previous="HEAD"
    isAmend && previous="HEAD^"
    export GREP_COLOR='1;37;41'
    git diff --cached --name-only "$previous" |  while read -r FILE;
    do
         git diff --cached --unified=0 "$previous" -- "$FILE" \
            | gitdiffShowLine.awk 2>/dev/null \
            | grep -E '^[0-9]'| grep --color=always "FIXME\|Debug\|\s+$" \
            | awk -v f="$(color "$BLUE" "$FILE")" '{print f ":" $0 }'

    done | prependOnOutput  "Found banned words:"
}

exitComfirm (){
    # TODO fix
    # pkill -P $$
    if [ -t 1 ] ## only ask confirmation if in termainal
    then
    validation="invalid"
    for i in $(seq 1 3)
        do
            if [ "$validation" = invalid ]
            then
                exec <> "$currentTty"
                read -p "do you stil want to commit(y/n)?" -s -n 1 -r choice < "$currentTty"
                case "$choice" in
                    y|Y ) echo "yes"
                        validation="valid"
                        exit 0
                        ;;
                    n|N ) echo "no"
                        exit 1 ;;
                    * ) echo "invalid"
                        ;;
                esac
            fi
        done
        exit 1
    else
        error pre-hook reported errors
        exit 1
    fi
}

trap "error 'abort checks';exitComfirm;" INT

source colors.sh
git status  &> /dev/null || { error "You are not in a git repository"; exit 1; }
echo "pre-commit hook ..."

programlangues=""
programlangues=$(detectProgramingLangue)

currentTty=/dev/"$(ps -otty --no-heading $$ )"

hasError="Failse"

{ isAmend || checkDirtyHead; } || { echo "" ; hasError="True" ;}
checkUnstaged || { echo "" ; hasError="True" ;}


if git show-ref > /dev/null # are there  previous commits
then
    checkBranch  || { echo "" ; hasError="True" ;}
    checkChanges || { echo "" ; hasError="True"; }
fi

checkWithSpace || { echo "" ; hasError="True" ;}
checkConfig || { echo ""; hasError="True" ;}

if [ "$hasError" = "True" ]
then
    exitComfirm
fi
