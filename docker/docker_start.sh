#!/bin/bash

echo "0、portainer docker管理镜像启动，端口：9000"
sudo docker run -d --net=host \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name portainer \
  portainer:20200329_212642

echo "1、mariadb 基础服务镜像启动，端口：3306"
sudo docker run -d --net=host \
  --restart always \
  -v /home/tim/data/ishou/data/mariadb:/var/lib/mysql \
  --name ishou_mariadb_infra \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mariadb:20200329_204923

echo "2、redis 基础服务镜像启动，端口：6379"
sudo docker run -d --net=host \
  --restart=always \
  -v /home/tim/data/ishou/data/redis:/data \
  --name ishou_redis_infra \
  redis:20200329_204223 \
  redis-server --appendonly yes --requirepass "123456"

echo "3、nginx 基础服务镜像启动，端口：80"
sudo docker run -d --net=host \
  --restart=always \
  -v /home/tim/data/ishou/data/nginx/web:/usr/share/nginx/html \
  -v /home/tim/data/ishou/data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v /home/tim/data/ishou/data/nginx/log:/var/log/nginx \
  --name ishou_nginx_infra \
  nginx:20200329_204023

echo "4、mariadb 初始化镜像启动"
sudo docker run -d --net=host \
  -v /home/tim/data/ishou/data/init/mariadb/backup:/home/mysql/backup \
  --name ishou_mariadb_init \
  -e MYSQL_ROOT_PASSWORD=123456 \
  ishou_mariadb_init:v1.0_dev_20200406_134258_9fe38fb

echo "5、eureka 服务启动，端口：9999"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_eureka_service \
  eureka-server:v1.0_dev_20200406_183306_19da952

echo "6、auth 服务启动，端口：9091"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_auth_service \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e REDIS_PASSWORD=123456 \
  auth:v1.0_dev_20200406_183523_739d37a

echo "7、site 服务启动，端口：9092"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_site_service \
  -e MYSQL_ROOT_PASSWORD=123456 \
  ishou-service-site:v1.0_dev_20200406_182831_7cd20da

echo "8、前端镜像启动"
sudo docker run -d --net=host \
  --name ishou_web \
  -v /home/tim/data/ishou/data/nginx/web:/opt/project/web \
  ishou-web:v1.0_dev_20200406_103732_c1f52a6

echo "镜像启动完成！"