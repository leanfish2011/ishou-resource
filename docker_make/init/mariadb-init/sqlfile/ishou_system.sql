drop database if exists ishou_system; -- 直接删除数据库，不提醒
create database ishou_system; -- 创建数据库
use ishou_system; -- 选择数据库

DROP TABLE IF EXISTS `site_sub`;
CREATE TABLE `site_sub` (
  `id` varchar(60) NOT NULL COMMENT '主键',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页网站订阅表';


DROP TABLE IF EXISTS `mes_board`;
CREATE TABLE `mes_board` (
  `id` varchar(60) NOT NULL COMMENT '主键',
  `user_id` varchar(60) NOT NULL COMMENT '用户id',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `user_photo` varchar(200) NOT NULL COMMENT '用户头像',
  `content` varchar(600) NOT NULL COMMENT '评论内容',
  `parent_id` varchar(60) DEFAULT NULL COMMENT '父级id',
  `create_time` datetime default current_timestamp comment '创建时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='留言板';
