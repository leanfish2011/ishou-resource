-- 爱收藏用户管理库
-- 1、创建库
drop database if exists ishou_auth; -- 直接删除数据库，不提醒
create database ishou_auth; -- 创建数据库
use ishou_auth; -- 选择数据库

--
-- table structure for table `sys_menu`
--
drop table if exists `sys_menu`;
create table `sys_menu` (
  `id` varchar(60) not null comment '主键',
  `create_time` datetime default current_timestamp comment '创建时间',
  `creator_id` varchar(60) not null comment '创建人id',
  `modified_time` datetime default null on update current_timestamp comment '修改时间',
  `modifier_id` varchar(60) default null comment '修改人id',
  `name` varchar(50) default null comment '菜单名称',
  `url` varchar(100) default null comment '菜单地址',
  `request_path` varchar(100) default null comment '菜单请求地址',
  `parent_id` varchar(60) default null comment '父级菜单id',
  `sort_num` int(11) default null comment '菜单顺序',
  `is_show` tinyint(1) default 1 comment '是否作为后端管理界面菜单显示 1：是,0：否，只是作为分配权限使用',
  primary key (`id`)
) engine=innodb default charset=utf8 comment='系统菜单';


--
-- table structure for table `sys_role`
--
drop table if exists `sys_role`;
create table `sys_role` (
  `id` varchar(60) not null comment '主键',
  `create_time` datetime default current_timestamp comment '创建时间',
  `creator_id` varchar(60) not null comment '创建人id',
  `modified_time` datetime default null on update current_timestamp comment '修改时间',
  `modifier_id` varchar(60) default null comment '修改人id',
  `name` varchar(50) default null comment '角色名称',
  `remark` varchar(200) default null comment '备注',
  primary key (`id`)
) engine=innodb default charset=utf8 comment='角色';


--
-- table structure for table `sys_rolemenu`
--
drop table if exists `sys_rolemenu`;
create table `sys_rolemenu` (
  `id` varchar(60) not null comment '主键',
  `create_time` datetime default current_timestamp comment '创建时间',
  `creator_id` varchar(60) not null comment '创建人id',
  `modified_time` datetime default null on update current_timestamp comment '修改时间',
  `modifier_id` varchar(60) default null comment '修改人id',
  `roleid` varchar(60) default null comment '角色id',
  `menuid` varchar(60) default null comment '菜单id',
  primary key (`id`)
) engine=innodb default charset=utf8 comment='角色菜单';


--
-- table structure for table `sys_roleuser`
--
drop table if exists `sys_roleuser`;
create table `sys_roleuser` (
  `id` varchar(60) not null comment '主键',
  `create_time` datetime default current_timestamp comment '创建时间',
  `creator_id` varchar(60) not null comment '创建人id',
  `modified_time` datetime default null on update current_timestamp comment '修改时间',
  `modifier_id` varchar(60) default null comment '修改人id',
  `roleid` varchar(60) default null comment '角色id',
  `userid` varchar(60) default null comment '用户id',
  primary key (`id`)
) engine=innodb default charset=utf8 comment='角色用户';


--
-- table structure for table `sys_user`
--
drop table if exists `sys_user`;
create table `sys_user` (
  `id` varchar(60) not null comment '主键',
  `create_time` datetime default current_timestamp comment '创建时间',
  `creator_id` varchar(60) not null comment '创建人id',
  `modified_time` datetime default null on update current_timestamp comment '修改时间',
  `modifier_id` varchar(60) default null comment '修改人id',
  `usercode` varchar(50) default null comment '登录名',
  `password` varchar(50) default null comment '登录密码',
  `name` varchar(50) default null comment '用户名称',
  `email` varchar(50) default null comment '用户邮箱',
  `photourl` varchar(200) default null comment '用户图片存放路径。',
  `photo_fingerprint` varchar(45) default null comment '用户头像指纹码',
  primary key (`id`)
) engine=innodb default charset=utf8 comment='系统用户表';




-- 4、初始化数据
-- 用户
insert into sys_user (`id`,`creator_id`,`usercode`,`password`,`name`,`email`) values ('0-admin','0-admin','admin','123456','系统管理员','timjob@163.com');
insert into sys_user (`id`,`creator_id`,`usercode`,`password`,`name`,`email`) values ('1-user','0-admin','user','123456','使用人','yangtze_tim@163.com');

-- 角色
insert into sys_role (`id`,`creator_id`,`name`,`remark`) values ('0-role-admin','0-admin','系统管理员组','系统预置角色');
insert into sys_role (`id`,`creator_id`,`name`,`remark`) values ('1-role-user','0-admin','使用人组','系统预置角色');

-- 角色用户
insert into sys_roleuser (`id`,`creator_id`,`userid`,`roleid`) values ('0','0-admin','0-admin','0-role-admin');
insert into sys_roleuser (`id`,`creator_id`,`userid`,`roleid`) values ('1','0-admin','1-user','1-role-user');


-- 菜单
insert into sys_menu (`id`,`creator_id`,`name`,`sort_num`,`is_show`) values('0','0-admin','菜单',0,1);


  -- 一级菜单
insert into sys_menu (`id`,`creator_id`,`name`,`parent_id`,`sort_num`,`is_show`) values('1','0-admin','网页管理','0',1,1);
insert into sys_menu (`id`,`creator_id`,`name`,`parent_id`,`sort_num`,`is_show`) values('2','0-admin','权限管理','0',2,1);

      -- 二级菜单-收藏管理
insert into sys_menu (`id`,`creator_id`,`name`,`url`,`request_path`,`parent_id`,`sort_num`,`is_show`) values('3','0-admin','网页收藏','/site','/api/v1/site/personal','1',3,1);

    -- 二级菜单-权限管理
insert into  sys_menu (`id`,`creator_id`,`name`,`url`,`request_path`,`parent_id`,`sort_num`,`is_show`) values('4','0-admin','用户管理','/user','/api/v1/auth/user','2',4,1);
insert into  sys_menu (`id`,`creator_id`,`name`,`url`,`request_path`,`parent_id`,`sort_num`,`is_show`) values('5','0-admin','角色管理','/role','/api/v1/auth/role','2',5,1);
insert into  sys_menu (`id`,`creator_id`,`name`,`url`,`request_path`,`parent_id`,`sort_num`,`is_show`) values('6','0-admin','用户角色管理','','/api/v1/auth/role/user','2',6,0);
insert into  sys_menu (`id`,`creator_id`,`name`,`url`,`request_path`,`parent_id`,`sort_num`,`is_show`) values('7','0-admin','角色权限管理','','/api/v1/auth/role/menu','2',7,0);


-- 角色权限
  -- 系统管理员权限
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('0','0-admin','0-role-admin','0');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('1','0-admin','0-role-admin','1');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('2','0-admin','0-role-admin','2');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('3','0-admin','0-role-admin','3');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('4','0-admin','0-role-admin','4');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('5','0-admin','0-role-admin','5');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('6','0-admin','0-role-admin','6');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('7','0-admin','0-role-admin','7');

  -- 普通使用者
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('10','0-admin','1-role-user','0');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('11','0-admin','1-role-user','1');
insert into  sys_rolemenu (`id`,`creator_id`,`roleid`,`menuid`) values ('12','0-admin','1-role-user','3');
