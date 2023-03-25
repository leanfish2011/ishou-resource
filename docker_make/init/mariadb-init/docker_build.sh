#!/bin/bash

# 项目版本
version="v2.0"

function build_image()
{
    echo "进入auth mariadb init制作镜像目录："$(pwd)

    latest_commit_id=$(git rev-parse --short HEAD)
    branch=$(git symbolic-ref --short -q HEAD)
    time=$(date "+%Y%m%d_%H%M%S")
    tag=$version"_"$branch"_"$time"_"$latest_commit_id
    docker_name="auth_mariadb_init:"$tag
    sudo docker build -t $docker_name .
}

# 入口
build_image
