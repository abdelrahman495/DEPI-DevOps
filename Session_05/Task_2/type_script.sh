#!/bin/bash

for i in ~/*;
do
    if [ -f "$i" ]
    then
        echo "$i is a file"
    elif [ -d "$i" ]
    then
        echo "$i is a directory"
    else
        echo "$i is neither a file nor a directory"
    fi
done

