镜像制作说明：
1、初始化镜像，即是sql初始化镜像，进入文件夹中，执行docker_build.sh文件。以auth为样例，初始化镜像在各个工程中自己维护
2、基础镜像，大部分使用原始镜像。nginx镜像执行docker_build.sh文件
3、其他实例镜像在各个项目中执行docker_build.sh文件
