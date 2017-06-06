#!/bin/bash

while read server; do
    ssh -n $server "$@"
done

# use
sh busan2.sh hostnaem < server.txt
