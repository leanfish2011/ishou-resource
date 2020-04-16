FROM nginx:20200329_204023

ENV TZ=Asia/Shanghai

# 将当前目录下的nginx.conf拷贝进去，替换nginx中的配置文件
ADD ./nginx.conf /etc/nginx/

# 将启动脚本拷贝进去
COPY startup.sh /usr/local/bin/startup.sh

# 赋予可执行权限
RUN chmod +x /usr/local/bin/startup.sh

#CMD ["nginx", "-g", "daemon off;"]
# 启动脚本
CMD /usr/local/bin/startup.sh
