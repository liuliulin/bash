#!/bin/bash

servers=(
    "10.138.0.3"
    "10.138.0.4"
    "10.130.170.10"
    "QUIT"
    )

PS3="连接服务器?"

select server in "${servers[@]}"; do
    if [[ -z $server ]]; then
        echo "请选择菜单内的数字"
        continue
    fi
    if [[ $server == "QUIT" ]]; then
        echo "退出"
        exit 0
    fi
    echo "连接$server"
    ssh "$server"
done
