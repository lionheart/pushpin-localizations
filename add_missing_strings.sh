#!/usr/bin/env bash

unique_strings () {
    if [ "$1" ]
    then
        FILES="$1"
    else
        FILES="*.lproj/Localizable.strings"
    fi

    cat $FILES | \
    awk -F= '{ print $1 }' | \
    grep -Ev '^[^"].*[^"]$' | \
    sort | \
    uniq
}

unique_strings > all_strings

for i in `ls *.lproj/Localizable.strings`; do
    unique_strings $i > current;
    comm -23 all_strings current >> $i
done;
