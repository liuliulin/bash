#!/bin/bash

file=$1
shift

while read server; do
    ssh -n $server "$@" 2>&1 | sed "s/^ /$server: /" &
done <"$file"
wait

# use
sh bunsan5.sh server.txt free -m
