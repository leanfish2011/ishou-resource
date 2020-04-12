#!/bin/bash

# 整个项目父路径
project_path_prefix="/home/tim/git/ishou"

# 项目版本
version="v1.0"

function build_image()
{
    nginx_docker_path=$project_path_prefix"/ishou-resource/docker/infra/nginx"
    echo "进入mariadb制作镜像目录："$nginx_docker_path
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
