# 使用mysql-client镜像
FROM mysql-client:20210809_194301

# 设置时区
ENV TZ=Asia/Shanghai

# 将sql语句、shell脚本拷贝到scripts文件夹下
ADD auth.sql /scripts/
ADD init_db.sh /scripts/

# 执行shell，覆盖父类ENTRYPOINT
ENTRYPOINT ["./scripts/init_db.sh"]
