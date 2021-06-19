#! /bin/bash

command="$*"

doctest(){
    file=$1
    if [ -x doctest ]
    then
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
    if [ -f "$spec" ]
    then
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
    # echo "$arg"
    # echo cabal  new-test --  --color=always -j 8 --quickcheck-max-size 100 "$arg"
    # cabal new-run test:tests -- -j 4 --quickcheck-max-size 20 --quickcheck-tests 20 -t 3 -q
    stack test --test-arguments="-j 4 -t 20 --quickcheck-max-size 30 --quickcheck-tests 100  --color=always --hide-successes"
}

declare -A fileMapHash

arg="$@"
echo "$arg"
root="$(findProjectRoot.sh)"
root=${root:=$PWD}
echo project root: "$root"

inotifywait  --format %w%f --exclude="(.)*/\.(.)*" -mre modify,create "$(pwd)"   | while read File; #--exclude .*
do
    md5="$(md5sum "$File" 2> /dev/null )"
    if [ "${fileMapHash[$File]}" != "$md5" ];
    then
        clear
        fileMapHash["$File"]="$md5"
        if [ -n $commnnd ]
        then
            $command
            continue
        fi
        echo "$File"
        fHaskell=$(echo "$File" |grep -E '(.hs$)|(.lhs$)')
        if [ "$fHaskell"  !=  "" ]
        then
            haskell "$File";
        fi
        if [ -f makefile ]  || [ -f Makefile ]
        then
            make|| break
        fi

        sleep 1
     fi
done

