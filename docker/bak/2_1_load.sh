#!/bin/bash

# 本地执行
# 加载镜像

# 读取镜像包
filelist=`ls ./*.tar`
for image_name in $filelist
do
    echo "load "$image_name
    docker load -i $image_name
done