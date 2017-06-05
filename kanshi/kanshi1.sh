#!/bin/bash

while [[ true ]]; do
    pgrep -x mysqld >/dev/null 2>&1
    rc=$?
    if [[ $rc -ne 0 ]]; then
        logger -t "kanshi" "mysqld is down."
    fi
    sleep 10
done
