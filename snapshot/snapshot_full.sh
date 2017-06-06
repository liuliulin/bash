#!/bin/bash

TMPFILE=/tmp/snapshot.log.$$

{
    echo "== Rsync from /data/ to /snapshot/: $(date)"
    mount -o rw,remount /dev/sdc
    rsync -av /data/ /snapshot/
    rc=$?
    mount -o ro,remount /dev/sdc

    if [[ $rc -qe 0 ]]; then
        echo "=== Snapshot succeeded: $(date)"
        SUBJECT="Snapshot report (Succeeded)"
    else
        echo "=== Snapshot failed with rc=$rc: $(date)"
        SUBJECT="Snapshot report (Failed)"
    fi
} 2>&1 | tee $TMPFILE | logger -t "snapshot"

iconv -f utf8 -t iso-2022-jp $TMPFILE | mail "$SUBJECT" admin@example.com
rm $TMPFILE
