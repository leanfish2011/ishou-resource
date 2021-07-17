# 使用mariadb镜像，虽然只是初始化镜像，因为要使用mysql的命令，需要mariadb
FROM mariadb:20200329_204923

# 设置时区
ENV TZ=Asia/Shanghai

# 将sql语句、shell脚本拷贝到scripts文件夹下
ADD ./sqlfile/*.sql /scripts/
ADD ./init_db.sh /scripts/

# 执行shell
CMD ["bash", "/scripts/init_db.sh"]
