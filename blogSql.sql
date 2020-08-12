/*
Navicat MySQL Data Transfer

Source Server         : 106.14.140.164_3306
Source Server Version : 50562
Source Host           : 106.14.140.164:3306
Source Database       : vueblog2

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2020-08-12 14:30:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `mdContent` text COMMENT 'md文件源码',
  `htmlContent` text COMMENT 'html源码',
  `summary` text,
  `cid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `publishDate` datetime DEFAULT NULL,
  `editTime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0表示草稿箱，1表示已发表，2表示已删除',
  `pageView` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `uid` (`uid`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('126', 'springboot', 'springboot学习！MySQL也要学！', '<p>springboot学习！MySQL也要学！</p>\n', 'springboot学习！MySQL也要学！\n', '68', '33', '2020-08-05 16:06:32', '2020-08-05 16:06:32', '1', '148');
INSERT INTO `article` VALUES ('127', 'Java编程', 'Java编程思想', '<p>Java编程思想</p>\n', 'Java编程思想\n', '69', '34', '2020-08-11 16:03:50', '2020-08-11 16:03:50', '1', '9');

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `article_tags_ibfk_1` (`aid`),
  CONSTRAINT `article_tags_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  CONSTRAINT `article_tags_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_tags
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `cateName` varchar(64) NOT NULL DEFAULT '',
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`,`cateName`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('66', '16', '123', '2020-08-04');
INSERT INTO `category` VALUES ('67', '7', '1', '2020-08-04');
INSERT INTO `category` VALUES ('68', '33', 'Java学习', '2020-08-05');
INSERT INTO `category` VALUES ('69', '34', 'Java学习', '2020-08-11');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `content` text,
  `publishDate` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL COMMENT '-1表示正常回复，其他值表示是评论的回复',
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  KEY `uid` (`uid`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `article` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`),
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parentId`) REFERENCES `comments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('18', '126', '这个要看情况的你什么都要学，会很累', '2020-08-11', null, '34');
INSERT INTO `comments` VALUES ('20', '127', '什么意思？', '2020-08-11', null, '34');

-- ----------------------------
-- Table structure for pv
-- ----------------------------
DROP TABLE IF EXISTS `pv`;
CREATE TABLE `pv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countDate` date DEFAULT NULL,
  `pv` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pv_ibfk_1` (`uid`),
  CONSTRAINT `pv_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pv
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', '超级管理员');
INSERT INTO `roles` VALUES ('2', '普通用户');
INSERT INTO `roles` VALUES ('3', '测试角色1');
INSERT INTO `roles` VALUES ('4', '测试角色2');
INSERT INTO `roles` VALUES ('5', '测试角色3');

-- ----------------------------
-- Table structure for roles_user
-- ----------------------------
DROP TABLE IF EXISTS `roles_user`;
CREATE TABLE `roles_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT '2',
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `roles_user_ibfk_2` (`uid`),
  CONSTRAINT `roles_user_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `roles` (`id`),
  CONSTRAINT `roles_user_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles_user
-- ----------------------------
INSERT INTO `roles_user` VALUES ('146', '2', '33');
INSERT INTO `roles_user` VALUES ('147', '2', '34');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagName` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tagName` (`tagName`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES ('66', '666');
INSERT INTO `tags` VALUES ('35', 'Ajax');
INSERT INTO `tags` VALUES ('36', 'Dubbo');
INSERT INTO `tags` VALUES ('40', 'git');
INSERT INTO `tags` VALUES ('33', 'Linux');
INSERT INTO `tags` VALUES ('45', 'mongodb');
INSERT INTO `tags` VALUES ('42', 'spring');
INSERT INTO `tags` VALUES ('44', 'SpringSecurity');
INSERT INTO `tags` VALUES ('67', 'test');
INSERT INTO `tags` VALUES ('37', 'websocket');
INSERT INTO `tags` VALUES ('34', 'Zookeeper');
INSERT INTO `tags` VALUES ('50', '图片上传');
INSERT INTO `tags` VALUES ('51', '图片预览');
INSERT INTO `tags` VALUES ('41', '学习资料');
INSERT INTO `tags` VALUES ('65', '杂谈');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `nickname` varchar(64) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `email` varchar(64) DEFAULT NULL,
  `userface` varchar(255) DEFAULT NULL,
  `regTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('33', 'user1', 'user1', '202cb962ac59075b964b07152d234b70', '1', 'user1@qq.com', null, '2020-08-05 16:05:40');
INSERT INTO `user` VALUES ('34', 'user2', 'user2', '202cb962ac59075b964b07152d234b70', '1', 'user2@qq.com', null, '2020-08-06 14:28:05');

-- ----------------------------
-- View structure for pvview
-- ----------------------------
DROP VIEW IF EXISTS `pvview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pvview` AS select sum(`pv`.`pv`) AS `pv`,`pv`.`uid` AS `uid` from `pv` group by `pv`.`uid` ;

-- ----------------------------
-- View structure for totalpvview
-- ----------------------------
DROP VIEW IF EXISTS `totalpvview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `totalpvview` AS select sum(`a`.`pageView`) AS `totalPv`,`a`.`uid` AS `uid` from `article` `a` group by `a`.`uid` ;
