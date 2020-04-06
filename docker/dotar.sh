#!/bin/bash

# 镜像打成tar包
images=(
    "portainer:20200329_212642" 
    "mariadb:20200329_204923" 
    "redis:20200329_204223" 
    "nginx:20200329_204023" 
    "ishou_mariadb_init:v1.0_dev_20200406_204556_1ffbacf" 
    "eureka-server:v1.0_dev_20200406_183306_19da952" 
    "auth:v1.0_dev_20200406_183523_739d37a" 
    "ishou-service-site:v1.0_dev_20200406_182831_7cd20da" 
    "ishou-web:v1.0_dev_20200406_103732_c1f52a6"
    );

for var in ${images[@]}
do
    echo $var;
    tar_name=$var".tar"
    sudo docker save > $tar_name $var
    echo "tar包完成："$tar_name
done