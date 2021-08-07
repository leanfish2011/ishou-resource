1、修改配置文件，不同配置文件对应不同的数据库
	generatorMysql.xml mysql
	generatorOracle.xml oracle
	generatorSqlserver.xml sqlserver

2、清空src文件夹

3、执行命令
java -jar mybatis.jar -configfile generatorMysql.xml -overwrite

4、生成的代码在src文件夹中