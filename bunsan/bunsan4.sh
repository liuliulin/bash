#!/bin/bash

while read server; do
    ssh -n $server "$@" 2>&1 | sed "s/^ /$server: /" &
done
wait

# use
sh bunsan4.sh "vmstat 1 5" < server.txt
