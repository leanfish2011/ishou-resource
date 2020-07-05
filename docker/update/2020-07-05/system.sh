#!/bin/bash

echo "1、system 基础服务镜像启动，端口：9093"
  sudo docker run -d --net=host \
  --restart always \
  --name ishou_system_service \
  -e MAIL_PASSWORD=code \
  ishou-service-system:v1.0_dev_20200705_121802_345870c