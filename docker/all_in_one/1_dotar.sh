#!/bin/bash

# 本地执行
# 镜像打成tar包，用于交付
images=(
    "portainer:20200329_212642" 
    "mariadb:20200329_204923" 
    "redis:20200329_204223" 
    "ishou_nginx_infra:v1.0_dev_20200416_213339_c02895e" 
    "ishou_mariadb_init:v1.0_dev_20200415_223128_eea82b1" 
    "eureka-server:v1.0_dev_20200416_212951_19da952" 
    "auth:v1.0_dev_20200412_172850_ac7eb73" 
    "ishou-service-site:v1.0_dev_20200416_213129_8dc91fa" 
    "ishou-web:v1.0_dev_20200416_213517_5838952"
    );

for var in ${images[@]}
do
    echo $var;
    tar_name=$var".tar"
    sudo docker save > $tar_name $var
    echo "tar包完成："$tar_name
done

# 将所有tar包打成一个
time=$(date "+%Y%m%d_%H%M%S")
name="ishou_all_"$time".tar"
tar -cvf $name *.tar
echo $name

echo "删除其他小包……"
rm *:*.tar

echo "打包完成！"