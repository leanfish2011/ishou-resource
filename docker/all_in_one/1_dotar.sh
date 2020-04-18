#!/bin/bash

# 本地执行
# 全部镜像打成一个tar包，用于交付
images=(
    "portainer:20200329_212642" 
    "mariadb:20200329_204923" 
    "redis:20200329_204223" 
    "ishou_nginx_infra:v1.0_dev_20200416_213339_c02895e" 
    "ishou_mariadb_init:v1.0_dev_20200415_223128_eea82b1" 
    "eureka-server:v1.0_dev_20200416_212951_19da952" 
    "auth:v1.0_dev_20200416_212658_7f0bf70" 
    "ishou-service-site:v1.0_dev_20200416_213129_8dc91fa" 
    "ishou-web:v1.0_dev_20200416_213517_5838952"
    );

all_images=" "
for var in ${images[@]}
do
    all_images=$all_images" "$var
done

echo $all_images
time=$(date "+%Y%m%d_%H%M%S")
tar_name="ishou_all_"$time".tar"

sudo docker save $all_images > $tar_name
echo "tar包完成："$tar_name