#!/bin/bash

# 目前没有定制需求，直接拉取最新镜像，打tag
# 后续有定制，进入到各个目录中，编写Dockerfile和Makefile，重新打镜像

# 构建mariadb基础镜像
sudo docker pull mariadb:latest
sudo docker tag mariadb:latest mariadb:20200329_204923

# 构建nginx基础镜像
sudo docker pull nginx:latest
sudo docker tag nginx:latest nginx:20200329_204023

# 构建redis基础镜像
sudo docker pull redis:latest
sudo docker tag redis:latest redis:20200329_204223

# 构建mongo基础镜像
sudo docker pull mongo:latest
sudo docker tag mongo:latest mongo:20200329_205123

# 构建openjdk基础镜像
sudo docker pull openjdk:8-jdk-alpine
sudo docker tag openjdk:8-jdk-alpine openjdk:20200329_205523

# 构建mariadb初始化基础镜像
# 镜像来源：https://registry.hub.docker.com/r/arey/mysql-client
sudo docker pull arey/mysql-client:latest
sudo docker tag arey/mysql-client:latest mysql-client:20210809_194301
