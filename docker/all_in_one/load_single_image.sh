#!/bin/bash

# 本地执行
# 实现：
# 1、将本地镜像打成tar
# 2、将tar包上传到服务器
# 3、加载tar包

image="auth:v1.0_dev_20200416_212658_7f0bf70"

# 本地打包镜像
tar_name=$image".tar"
sudo docker save $image > $tar_name 
echo "tar包完成："$tar_name

# 镜像上传
