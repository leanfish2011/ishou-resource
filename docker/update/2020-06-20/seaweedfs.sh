#!/bin/bash

echo "1、seaweedfs_master 基础服务镜像启动，端口：9333"
sudo docker run -d --net=host \
  --restart=always \
  --name ishou_seaweedfs_master_infra \
  seaweedfs:20200620_182621 \
  master

echo "2、seaweedfs_volume 基础服务镜像启动，端口：8080"
sudo docker run -d --net=host \
  --restart=always \
  --name ishou_seaweedfs_volume_infra \
  seaweedfs:20200620_182621 \
  volume