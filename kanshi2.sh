#!/bin/bash

status=""

while [[ true ]]; do
    pgrep -x mysqld >/dev/null 2>&1
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
