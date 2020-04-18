#!/bin/bash

# 读取镜像列表

images_file="images.txt"

image_portainer=""
cat $images_file | while read line
do
    echo $line
    imageArray=(${line//=/ })
    echo ${images[0]}
    #$($line)
done

echo $image_portainer