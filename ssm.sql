/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : ssm

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-07-06 15:59:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `stu`
-- ----------------------------
DROP TABLE IF EXISTS `stu`;
CREATE TABLE `stu` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `stuname` varchar(100) COLLATE utf8_bin NOT NULL,
  `ssm` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `python` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `java` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of stu
-- ----------------------------
INSERT INTO `stu` VALUES ('3faba888-aaae-46c8-8217-16a81bac7293', '李六', '67', '45', '99', '1');
INSERT INTO `stu` VALUES ('503af27b-d3be-465c-8f9a-35e0997402b4', '王四', '44', '44', '44', '0');
INSERT INTO `stu` VALUES ('7b1b2e88-c4af-483c-afbe-c6d065b4566f', '陈皮', '55', '55', '55', '1');
INSERT INTO `stu` VALUES ('9d1c6b61-be97-4eb7-92c1-0e018d3a40be', '王老六', '98', '67', '87', '1');
INSERT INTO `stu` VALUES ('9fc64c84-9424-4d4d-924d-4378356015f8', '王五', '77', '77', '77', '1');
INSERT INTO `stu` VALUES ('a75d7b88-eb9a-4c9c-a55b-fed580b05c4a', '陈三', '89', '72', '46', '0');
INSERT INTO `stu` VALUES ('a9711aeb-9534-4932-88e4-86726251f4ab', '张三', '99', '99', '99', '1');
INSERT INTO `stu` VALUES ('d36d4588-a72f-4750-8ca6-c1508d8e6171', '李四', '88', '88', '88', '1');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL,
  `username` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0088e0c9-b8e7-46a2-aa0a-1f0c407ff5e7', '333', '333', '1');
INSERT INTO `user` VALUES ('385bb7a8-2606-4009-9609-4fb22e846f0a', '2016074001', '555', '1');
INSERT INTO `user` VALUES ('5c87ad61-57e2-495c-b45a-2b45f9f78069', 'llala', '1234', '1');
INSERT INTO `user` VALUES ('72ab1111-7023-4dbc-9b5c-414fea2671ff', '333', '333', '1');
INSERT INTO `user` VALUES ('9ad02421-537a-4a31-b31a-fa889bf9f8d1', '李四', '222', '0');
INSERT INTO `user` VALUES ('ad974821-c97c-4d33-9ace-0fd34ec77970', '突然', 'ttt', '1');
