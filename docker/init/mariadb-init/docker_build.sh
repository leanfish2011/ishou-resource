#!/bin/bash

# 整个项目父路径
project_path_prefix="/home/tim/git/ishou"

# 项目版本
project_version="v1.0"

# 项目分支
project_branch="dev"

# 有sql语句的项目sql路径，空格分割
project_sql_path=(auth/mariadb ishou-service-site/mariadb)

function build_image()
{
    mariadb_docker_path=$project_path_prefix"/ishou-resource/docker/init/mariadb-init"
    sqlfile_path=$mariadb_docker_path"/sqlfile/"
    echo "进入mariadb制作镜像sql目录："$sqlfile_path
    cd $sqlfile_path
    echo "删除旧的sql"
    rm *
    
    for i in ${!project_sql_path[@]}
    do
        sql_full_path=$project_path_prefix"/"${project_sql_path[$i]}
        cd $sql_full_path
        echo $i".拷贝sql的项目："$sql_full_path
        cp *.sql $sqlfile_path
    done

    echo "进入mariadb制作镜像目录："$mariadb_docker_path
    cd $mariadb_docker_path
    time=$(date "+%Y%m%d_%H%M%S")
    tag=$project_version"_"$project_branch"_"$time
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
