#!/bin/bash

SERVER="user01@backup.example.com"              # Backup server
    
LOCAL="/home/user01/Documents/"                 # Local directory
REMOTE="/home/user01/backup/Documents/"         # Remote directory

LOCAL_TSFILE="/home/user01/.backup_timestamp"   # Local timestamp file
REMOTE_TSFILE="/home/user01/.backup_timestamp"  # Remote timestamp file

function confirm {
    echo -n "$1"
    read answer
    if [[ $answer != "y" ]]; then
        echo "结束"
        exit 0
    fi
}

function backup {
    rsync -n -av --delete $LOCAL ${SERVER}:${REMOTE}
    confirm "确定要备份本地文件吗? ( y / n)"
    rsync -av --delete $LOCAL ${SERVER}:${REMOTE}
    ts_local=$( date +%Y%m%d%H%M%S )
    echo -n $ts_local > $LOCAL_TSFILE
    ssh $SERVER "echo -n $ts_local > $REMOTE_TSFILE"
}

function download {
    rsync -n -av --delete ${SERVER}:${REMOTE} $LOACL
    confirm "确定要下载远程文件吗? ( y / n)"
    rsync -av --delete ${SERVER}:${REMOTE} $LOCAL
    ts_local=$( date +%Y%m%d%H%M%S )
    echo -n $ts_local > $LOCAL_TSFILE
}

ts_remote=$( ssh $SERVER "cat $REMOTE_TSFILE" )
ts_local=$( cat $LOCAL_TSFILE)

$ts_remote echo "远程文件的时间: $ts_remoute"
$ts_local  echo "本地文件的时间: $ts_local"
echo "------------"

if [[ $1 == "backup" ]]; then
    echo "强制备份"
    backup
    exit 0
fi

if [[ $1 == "download" ]]; then
    echo "强制下载"
    download
    exit 0
fi

if [[ $ts_load -ge $ts_remote ]]; then
    echo "本地文件已经更新"
    download
    exit 0
fi
if [[ $ts_load -lt $ts_remote ]]; then
    echo "远程文件已经更新"
    download
    exit 0
fi
