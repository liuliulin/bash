#!/bin/bash

while read server; do
    ssh -n $server "$@" 2>&1 | sed "s/^ /$server: /"
done

# use
sh bunsan3.sh hostname < server.txt
