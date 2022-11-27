#! /bin/bash

command="$*"
doctest(){
    file="$1"
    if [ -x doctest ]; then
        echo doctest: "$file"
        doctest "$file"
    fi
}

haskellspec(){
    file=$1
    fi="$(basename "$file" .hs )"
    minsrc=$(echo "${file/$root}"| sed 's/\/src//g')
    f="$(dirname "$minsrc" )"
    spec=$root/test/$f$fi"Spec.hs"
    if [ -f "$spec" ]; then
    echo Hspec: "$file"
    runhaskell "$spec"
    fi
}

haskell() {
    file=$1
    haskellspec "$file"
    doctest "$file"
    cabaltest
}
cabaltest(){

    cabal build -j -v0 -fno-max-relevant-binds #&& \
        # cabal test -- --color=always -fno-max-relevant-binds -j 8 --quickcheck-max-size 100 "$arg"
    # cabal new-run test:tests -- -j 4 --quickcheck-max-size 20 --quickcheck-tests 20 -t 3 -q
    # stack test --test-arguments="-j 4 -t 20 --quickcheck-max-size 30 --quickcheck-tests 100  --color=always --hide-successes -fno-max-relevant-binds"
}

declare -A fileMapHash

arg="$@"
echo "$arg"
root="$(findProjectRoot.sh)"
root=${root:=$PWD}
echo project root: "$root"

run_commands () {
    file="$1"

    if [ -n "$command" ]; then
        $command
        continue
    fi
    echo "$file"
    fHaskell=$(echo "$file" |grep -E '(.hs$)|(.lhs$)')
    if [ "$fHaskell"  !=  "" ]
    then
        haskell "$file";
    fi
    if [ -f makefile ]  || [ -f Makefile ]; then
        make|| break
    fi

}

inotifywait  -q --format %w%f --exclude="(.)*/\.(.)*" -mre modify,create "$(pwd)"   | while read file; #--exclude .*
do
    md5="$(md5sum "$file" 2> /dev/null )"
    if [ "${fileMapHash[$file]}" != "$md5" ]; then
        fileMapHash["$file"]="$md5"

        clear
        # echo $file

        window_height=$(tput lines )
        run_commands $file |head -n "${window_height}"
        #(run_commands "$file" 1> /dev/null) 2>&1 | head -n "${window_height}"

        sleep 1
    fi
done

