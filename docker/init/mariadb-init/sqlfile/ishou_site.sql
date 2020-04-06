-- 爱收藏网站管理库
-- 1、创建库
drop database if exists ishou_site; -- 直接删除数据库，不提醒
create database ishou_site; -- 创建数据库
use ishou_site; -- 选择数据库

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
