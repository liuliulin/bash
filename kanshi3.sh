#!/bin/bash

function monitor {
    pgrep -x $1 >/dev/null 2>&1
    return $?
}

if monitor "mysqld"; then
    status="up"
else
    status="down"
fi

while [[ true ]]; do
    monitor "mysqld"
    rc=$?

    if [[ $rc -eq 0 && $status != "up" ]]; then
        status="up"
        logger -t "kanshi" "mysqld is up"
    fi
    
    if [[ $rc -ne 0 && $status != "down" ]]; then
        status="down"
        logger -t "kanshi" "mysqld is down"
    fi
    
    sleep 10
done
