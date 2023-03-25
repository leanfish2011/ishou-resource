#!/bin/bash

# 项目版本
version="v2.0"

function build_image()
{
    nginx_docker_path=$(pwd)
    echo "进入nginx制作镜像目录："$nginx_docker_path
    cd $nginx_docker_path

    latest_commit_id=$(git rev-parse --short HEAD)
    branch=$(git symbolic-ref --short -q HEAD)
    time=$(date "+%Y%m%d_%H%M%S")
    tag=$version"_"$branch"_"$time"_"$latest_commit_id
    docker_name="ishou_nginx_infra:"$tag

    sudo docker build -t $docker_name .
}

# 入口
build_image
