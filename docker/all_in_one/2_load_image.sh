#!/bin/bash

# 服务器执行
# 加载tar包

echo "加载tar包"
image_name="ishou_all_20200412_191754.tar"

# TODO 将镜像上传到服务器上

docker load -i $image_name