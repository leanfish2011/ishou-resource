#!/bin/bash

# 如果某条结果不是true，则返回
set -e

#################### 1、备份数据库
backup_path="/home/mysql/backup"
# mkdir $backup_path

# 查询所有库
databases=$(mysql -uroot -p$MYSQL_ROOT_PASSWORD -h127.0.0.1 -e "show databases;")
echo "all databases:"$databases

arrayBases=(${databases// / })

include_base="";
exclude_base=("Database" "information_schema" "mysql" "performance_schema");

for var in ${arrayBases[@]}
do
    echo "${exclude_base[@]}" | grep -wq "$var" &&  echo "dump exclude_base:"$var || include_base=$include_base" "$var;
done

if [ -n "$include_base" ]; then 
    echo "STRING is not empty"
    echo "need dump databases:"$include_base;

    # 导出ishou_auth库
    time=$(date "+%Y%m%d_%H%M%S");
    mysqldump -uroot -p$MYSQL_ROOT_PASSWORD -h127.0.0.1 --databases $include_base > $backup_path/all_db_$time.sql;

    echo "数据库备份完成！"
else
    echo "没有需要备份的数据库！"
fi

#################### 2、执行sql
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