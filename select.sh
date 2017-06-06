#!/bin/bash

# 数组
menu=( "Apple" "Grape" "Orange" )
#内置变量
PS3="喜欢哪个?"

select item in ${menu[@]}; do
    echo "喜欢$item"
done
