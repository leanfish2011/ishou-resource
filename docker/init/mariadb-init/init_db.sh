#!/bin/bash

# 如果某条结果不是true，则返回
set -e

# 指明sql脚本所在目录
sql_path="/scripts";
echo "进入脚本目录"$sql_path

# 读取sql
filelist=`ls $sql_path/*.sql`
for file_name in $filelist
do
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -h127.0.0.1 --default-character-set=utf8mb4 -e "source $file_name;"
    echo "执行sql: $file_name 完成";
done

echo "数据库初始化完成！"