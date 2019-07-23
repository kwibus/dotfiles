#! /bin/sh

tests="Cmake Git CabalSanbox Cabal"

globexists (){
  test -e "$1" -o -L "$1"
}
findroot(){
while [ "$PWD" != "/" ] #[ -z $root ]
do  
    if any "$tests"
    then 
        echo "$PWD"
        exit 0
    else 
        cd ..
    fi
done  
exit 1
}

CabalSanbox(){
[ -f cabal.sandbox.config ]
}

Cabal(){
  globexists *.cabal
}
Git(){
[ -d .git ]
}
Cmake(){
     grep -q -s -e "^[\s]*project(" CMakeLists.txt
}
any(){
    tests=$1

    for test in $tests
    do
        if $test 
        then 
            return 0
        fi
    done 
    return 1
}
# gitRoot="$(git rev-parse --show-toplevel)"
findroot 
echo
