#!/bin/bash

TMPFILE=/tmp/snapshot.log.$$
# $$ 进程ID

# 以 rw 再次挂载 /snapshot
# 执行 rsync
# 以 ro再次挂载 /snapshot

iconv -f utf8 -t iso-2022-jp $TMPFILE | mail -s "$SUBJECT" admin@example.com
rm $TMPFILE

# date 2>&1 | tee logfile.txt | logger -t "header"
# 记录日志
