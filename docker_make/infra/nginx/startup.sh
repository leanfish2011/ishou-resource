#!/usr/bin/env sh

# 容器停止后，"daemon off;"还在nginx.conf文件中，下次再重启会报重复
# 判断是否存在，不存在再增加。也直接加到nginx.conf文件中
if grep -q "daemon off;" /etc/nginx/nginx.conf
then
    echo "yes, had daemon off;"
else
    echo "no, add daemon off;"
    echo "daemon off;" >> /etc/nginx/nginx.conf
fi

/usr/sbin/nginx