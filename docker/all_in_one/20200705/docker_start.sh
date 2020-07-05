#!/bin/bash

# 服务器执行，进行镜像全量部署

# ishou整个项目镜像tar包
image_name="ishou_all_20200416_220907.tar"

# ishou各个服务对应镜像
image_portainer="portainer:20200329_212642"
image_ishou_mariadb_infra="mariadb:20200329_204923"
image_ishou_redis_infra="redis:20200329_204223"
image_ishou_nginx_infra="ishou_nginx_infra:v1.0_dev_20200416_213339_c02895e"
image_ishou_seaweedfs_infra="seaweedfs:20200620_182621"
image_ishou_mariadb_init="ishou_mariadb_init:v1.0_dev_20200415_223128_eea82b1"
image_ishou_eureka_service="eureka-server:v1.0_dev_20200416_212951_19da952"
image_ishou_auth_service="auth:v1.0_dev_20200416_212658_7f0bf70"
image_ishou_site_service="ishou-service-site:v1.0_dev_20200416_213129_8dc91fa"
image_ishou_system_service="ishou-service-system:v1.0_dev_20200705_121802_345870c"
image_ishou_web="ishou-web:v1.0_dev_20200416_213517_5838952"


# ishou项目全部容器
containers=(
    "portainer" 
    "ishou_mariadb_infra" 
    "ishou_redis_infra" 
    "ishou_nginx_infra" 
    "ishou_seaweedfs_master_infra" 
    "ishou_seaweedfs_volume_infra" 
    "ishou_mariadb_init"  
    "ishou_eureka_service" 
    "ishou_auth_service" 
    "ishou_site_service" 
    "ishou_system_service" 
    "ishou_web"
  );

# 确定
read -p "重新部署服务，之前的挂载、备份、容器都会清除，确定 (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "重新部署服务！";
else
  exit 1;
fi

# 生成全局密码
global_password=$(date +%s%N|md5sum|head -c 10)
echo $global_password

# 清理挂载目录
data_path="/home/data/ishou/data"
echo "数据挂载目录："$data_path
echo "开始清除挂载目录数据……"
dataFile=$data_path"/*"
sudo rm -rf $dataFile
echo "挂载目录清理完成！"

# 清理容器
echo "开始删除旧的容器……"
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
echo "旧的容器删除完成！"

echo "加载tar包"
sudo docker load -i $image_name

# 部署
echo "开始部署……"
echo "0、portainer docker管理镜像启动，端口：9000"
sudo docker run -d --net=host \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name portainer \
  -e TZ=Asia/Shanghai \
  $image_portainer

echo "1、mariadb 基础服务镜像启动，端口：3306"
sudo docker run -d --net=host \
  --restart always \
  -v $data_path"/mariadb":/var/lib/mysql \
  --name ishou_mariadb_infra \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  -e TZ=Asia/Shanghai \
  $image_ishou_mariadb_infra

echo "2、redis 基础服务镜像启动，端口：6379"
sudo docker run -d --net=host \
  --restart=always \
  -v $data_path"/redis":/data \
  --name ishou_redis_infra \
  -e TZ=Asia/Shanghai \
  $image_ishou_redis_infra \
  redis-server --appendonly yes --requirepass $global_password

echo "3、nginx 基础服务镜像启动，端口：80"
sudo docker run -d --net=host \
  --restart=always \
  -v $data_path"/nginx/web":/usr/share/nginx/html \
  -v $data_path"/nginx/log":/var/log/nginx \
  --name ishou_nginx_infra \
  $image_ishou_nginx_infra

echo "4、seaweedfs_master 基础服务镜像启动，端口：9333"
sudo docker run -d \
  --restart=always \
  --name ishou_seaweedfs_master_infra \
  $image_ishou_seaweedfs_infra \
  master -ip=106.53.116.69

echo "5、seaweedfs_volume 基础服务镜像启动，端口：8080"
sudo docker run -d \
  --restart=always \
  --name ishou_seaweedfs_volume_infra \
  $image_ishou_seaweedfs_infra \
  volume -ip=106.53.116.69

echo "部署中……"
sleep 1m

echo "6、mariadb 初始化镜像启动"
sudo docker run -d --net=host \
  -v $data_path"/init/mariadb/backup":/home/mysql/backup \
  --name ishou_mariadb_init \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  $image_ishou_mariadb_init

echo "7、eureka 服务启动，端口：9999"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_eureka_service \
  $image_ishou_eureka_service

echo "部署中……"
sleep 1m

echo "8、auth 服务启动，端口：9091"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_auth_service \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  -e REDIS_PASSWORD=$global_password \
  $image_ishou_auth_service

echo "9、site 服务启动，端口：9092"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_site_service \
  -e MYSQL_ROOT_PASSWORD=$global_password \
  $image_ishou_site_service

echo "10、system 服务启动，端口：9093"
sudo docker run -d --net=host \
  --restart always \
  --name ishou_system_service \
  -e MAIL_PASSWORD=code \
  $image_ishou_system_service

echo "11、前端镜像启动"
sudo docker run -d --net=host \
  --name ishou_web \
  -v $data_path"/nginx/web":/opt/project/web \
  $image_ishou_web

echo "部署中……"
sleep 1m

echo "镜像部署完成，请在浏览器中输入ip访问！"