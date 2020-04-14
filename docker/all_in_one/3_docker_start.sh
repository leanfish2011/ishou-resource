#!/bin/bash

# 服务器执行
# 部署镜像

# 所有镜像
image_portainer="portainer:20200329_212642"
image_ishou_mariadb_infra="mariadb:20200329_204923"
image_ishou_redis_infra="redis:20200329_204223"
image_ishou_nginx_infra="ishou_nginx_infra:v1.0_dev_20200414_223526_eb9dab9"
image_ishou_mariadb_init="ishou_mariadb_init:v1.0_dev_20200411_154744_981cbab"
image_ishou_eureka_service="eureka-server:v1.0_dev_20200406_183306_19da952"
image_ishou_auth_service="auth:v1.0_dev_20200412_172850_ac7eb73"
image_ishou_site_service="ishou-service-site:v1.0_dev_20200411_173205_a4183bd"
image_ishou_web="ishou-web:v1.0_dev_20200412_174519_5838952"


read -p "确定重新部署服务 (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "重新部署服务，请确认旧的服务已经关闭！";
else
  exit 1;
fi

global_password=$(date +%s%N|md5sum|head -c 10)
echo $global_password

data_path="/home/data/ishou/data"
echo "数据挂载目录："$data_path
echo "清除挂载目录数据……"
dataFile=$data_path"/*"
sudo rm -rf $dataFile

echo "0、portainer docker管理镜像启动，端口：9000"
sudo docker run -d --net=host \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name portainer \
  $image_portainer

echo "1、mariadb 基础服务镜像启动，端口：3306"
sudo docker run -d --net=host \
  --restart always \
  -v $data_path"/mariadb":/var/lib/mysql \
  --name ishou_mariadb_infra \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  $image_ishou_mariadb_infra

echo "2、redis 基础服务镜像启动，端口：6379"
sudo docker run -d --net=host \
  --restart=always \
  -v $data_path"/redis":/data \
  --name ishou_redis_infra \
  $image_ishou_redis_infra \
  redis-server --appendonly yes --requirepass $global_password

echo "3、nginx 基础服务镜像启动，端口：80"
sudo docker run -d --net=host \
  --restart=always \
  -v $data_path"/nginx/web":/usr/share/nginx/html \
  -v $data_path"/nginx/log":/var/log/nginx \
  --name ishou_nginx_infra \
  $image_ishou_nginx_infra

echo "部署中……"
sleep 1m

echo "4、mariadb 初始化镜像启动"
sudo docker run -d --net=host \
  -v $data_path"/init/mariadb/backup":/home/mysql/backup \
  --name ishou_mariadb_init \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  $image_ishou_mariadb_init

echo "5、eureka 服务启动，端口：9999"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_eureka_service \
  $image_ishou_eureka_service

echo "部署中……"
sleep 1m

echo "6、auth 服务启动，端口：9091"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_auth_service \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  -e REDIS_PASSWORD=$global_password \
  $image_ishou_auth_service

echo "7、site 服务启动，端口：9092"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_site_service \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  $image_ishou_site_service

echo "8、前端镜像启动"
sudo docker run -d --net=host \
  --name ishou_web \
  -v $data_path"/nginx/web":/opt/project/web \
  $image_ishou_web

echo "部署中……"
sleep 1m

echo "镜像启动完成！"