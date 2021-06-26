#! /bin/sh

dircolors -p |awk '{if ($2 ~ /[0-9]{2};[0-9]{2}/ ) {print "\033["$2"m"  $0  "\033[0m"}else {print $0} }'
