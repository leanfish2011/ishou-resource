-- 爱收藏网站管理库
-- 1、创建库
drop database if exists ishou_site; -- 直接删除数据库，不提醒
create database ishou_site; -- 创建数据库
use ishou_site; -- 选择数据库


DROP TABLE IF EXISTS `site_home`;
CREATE TABLE `site_home` (
  `id` varchar(60) NOT NULL COMMENT '主键',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `creator_id` varchar(60) NOT NULL COMMENT '创建人id',
  `modified_time` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT '修改时间',
  `modifier_id` varchar(60) DEFAULT NULL COMMENT '修改人id',
  `name` varchar(50) DEFAULT NULL COMMENT '网站名称',
  `url` varchar(100) DEFAULT NULL COMMENT '网站地址',
  `remark` varchar(100) DEFAULT NULL COMMENT '简介',
  `tag` varchar(100) DEFAULT NULL COMMENT '标签',
  `sort_num` int(11) DEFAULT NULL COMMENT '顺序',
  `visit_count` int(11) DEFAULT 0 COMMENT '访问次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页网站收藏';


DROP TABLE IF EXISTS `site_personal`;
CREATE TABLE `site_personal` (
  `id` varchar(60) NOT NULL COMMENT '主键',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `creator_id` varchar(60) NOT NULL COMMENT '创建人id',
  `modified_time` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT '修改时间',
  `modifier_id` varchar(60) DEFAULT NULL COMMENT '修改人id',
  `name` varchar(50) DEFAULT NULL COMMENT '网站名称',
  `url` varchar(100) DEFAULT NULL COMMENT '网站地址',
  `remark` varchar(100) DEFAULT NULL COMMENT '简介',
  `tag` varchar(100) DEFAULT NULL COMMENT '标签',
  `sort_num` int(11) DEFAULT NULL COMMENT '顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人网站收藏';


-- 插入默认网站
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('3d3eb99f-f2a5-4fec-98d7-12143bd7eec7','0-admin','开源中国','https://www.oschina.net/','收录各种开源软件','开源');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('82e5e1bb-ff83-4e44-a0cf-fd1796d3a574','0-admin','博客园','https://www.cnblogs.com/','IT界长期维护和更新的博客','博客');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('979628bb-7a4b-4721-bd2f-3ff268e6b653','0-admin','常用工具','https://tool.lu/','常用工具','工具');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('9b255362-b4b8-45e9-93db-91341f5dfa7c','0-admin','webos','http://www.25os.com/default.html','在线OS','OS');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('a0725992-6181-46c5-ae80-bbf0bfb1eb7c','0-admin','在线工具','https://tool.oschina.net/','各种工具集合','工具');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('a5797ec3-77b6-4138-a703-21f14d55910c','0-admin','在线绘图','https://www.processon.com/','绘制各种图形','绘图');
INSERT INTO site_home(`id`,`creator_id`,`name`,`url`,`remark`,`tag`) VALUES ('c7d94517-021d-4248-b07e-52e6eec8b6fa','0-admin','在线编程','https://www.shiyanlou.com/','在线做实验，高效学习编程','编程');