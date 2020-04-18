#!/bin/bash

# ishou项目全部容器
containers=(
    "portainer" 
    "ishou_mariadb_infra" 
    "ishou_redis_infra" 
    "ishou_nginx_infra" 
    "ishou_mariadb_init"  
    "ishou_eureka_service" 
    "ishou_auth_service" 
    "ishou_site_service" 
    "ishou_web"
    );

echo "删除旧的容器"
for container in ${containers[@]}
do
    result=$(sudo docker ps -a | grep $container)
    if [[ -n $result ]]
    then
        echo "停止容器："
        sudo docker stop $container

        echo "删除容器："
        sudo docker rm $container
    else
        echo "容器："$container"不存在！"
    fi    
done