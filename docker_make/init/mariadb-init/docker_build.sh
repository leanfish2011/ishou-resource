#!/bin/bash

# 整个项目父路径
project_path_prefix="/home/tim/git/ishou"

# 项目版本
version="v1.0"

# 有sql语句的项目sql路径，空格分割
project_sql_path=(auth/mariadb ishou-service-site/mariadb ishou-service-system/mariadb)

function build_image()
{
    mariadb_docker_path=$project_path_prefix"/ishou-resource/docker_make/init/mariadb-init"
    #如果文件夹不存在，创建文件夹
    if [ ! -d $mariadb_docker_path ]; then
        echo $mariadb_docker_path"不存在"
        exit
    fi

    sqlfile_path=$mariadb_docker_path"/sqlfile/"
    echo "进入mariadb制作镜像sql目录："$sqlfile_path
    cd $sqlfile_path
    ls
    echo "删除旧的sql"
    rm *.sql
    
    for i in ${!project_sql_path[@]}
    do
        sql_full_path=$project_path_prefix"/"${project_sql_path[$i]}
        cd $sql_full_path
        echo $i".拷贝sql的项目："$sql_full_path
        cp *.sql $sqlfile_path
    done

    echo "进入mariadb制作镜像目录："$mariadb_docker_path
    cd $mariadb_docker_path
    
    latest_commit_id=$(git rev-parse --short HEAD)
    branch=$(git symbolic-ref --short -q HEAD)
    time=$(date "+%Y%m%d_%H%M%S")
    tag=$version"_"$branch"_"$time"_"$latest_commit_id
    docker_name="ishou_mariadb_init:"$tag
    sudo docker build -t $docker_name .
}

function test()
{
    for var in ${project_sql_path[@]};
    do
        echo $var
    done
}

# 入口
build_image
