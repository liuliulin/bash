#!/bin/bash

servers=(
    "10.138.0.3"
    "10.138.0.4"
    "10.130.170.10"
    )

#PS3="连接服务器?"

for server in "${servers[@]}"; do
   # echo "连接$server"
    ssh "$server" "$@"
done
