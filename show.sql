/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.24-0ubuntu0.16.04.1 : Database - show
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`show` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `show`;

/*Table structure for table `mp_admin` */

DROP TABLE IF EXISTS `mp_admin`;

CREATE TABLE `mp_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realname` varchar(30) DEFAULT NULL COMMENT '管理员姓名',
  `username` varchar(30) DEFAULT NULL COMMENT '账号',
  `gender` tinyint(4) DEFAULT NULL COMMENT '1男2女',
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL COMMENT '手机号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '添加时间',
  `last_login_ip` varchar(20) DEFAULT '0.0.0.0',
  `last_login_time` int(10) unsigned DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态0冻结1正常',
  `login_times` int(11) DEFAULT '0' COMMENT '登陆次数',
  `level` tinyint(4) DEFAULT '1' COMMENT '管理员等级',
  `desc` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_admin` */

insert  into `mp_admin`(`id`,`realname`,`username`,`gender`,`email`,`tel`,`password`,`create_time`,`last_login_ip`,`last_login_time`,`status`,`login_times`,`level`,`desc`) values (1,'猛男','show',1,'1873645345@qq.com','13102163019','d1fa1a0c55a342587ff1c43fbae9c014',1540099895,'218.68.102.170',1557628383,1,60,1,'好人啊\n'),(5,'测试','test',1,'a@qq.com','13102163019','182190c915daadda6d909f9691819e45',1553784231,'60.25.11.29',1555239718,1,4,1,''),(6,'0003','0003',1,'003@002.com','13800000000','fb6e881c6db9a0c4defd2fed72645f70',1554198512,'223.192.253.12',1554390107,1,5,1,''),(7,'张涛','zhang',1,'boss@jianghairui.com','13102163019','182190c915daadda6d909f9691819e45',1555239513,'60.25.11.29',1555239546,1,1,1,'');

/*Table structure for table `mp_auth_group` */

DROP TABLE IF EXISTS `mp_auth_group`;

CREATE TABLE `mp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `desc` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `mp_auth_group` */

insert  into `mp_auth_group`(`id`,`title`,`desc`,`status`,`rules`) values (1,'后台操作员','上货啥的',1,'6,30,7,31,32,33,34,35,36,37,38,8,39,40,9,41,42,76,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,68,69,70,71,72,73,74,75'),(2,'普通代理','',1,'9,41,42,43,44,45,52,54,60'),(3,'下单用户','此用户只能下单',1,'8,39,40,9,41,42,76,62,63,64,65,66,67');

/*Table structure for table `mp_auth_group_access` */

DROP TABLE IF EXISTS `mp_auth_group_access`;

CREATE TABLE `mp_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `mp_auth_group_access` */

insert  into `mp_auth_group_access`(`uid`,`group_id`) values (5,1),(6,2),(7,3);

/*Table structure for table `mp_auth_rule` */

DROP TABLE IF EXISTS `mp_auth_rule`;

CREATE TABLE `mp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(30) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

/*Data for the table `mp_auth_rule` */

insert  into `mp_auth_rule`(`id`,`name`,`title`,`type`,`status`,`condition`,`pid`) values (5,'Admin','管理员管理',1,1,'',0),(6,'System','系统管理',1,1,'',0),(7,'Banner','轮播图设置',1,1,'',0),(8,'Index','首页设置',1,1,'',0),(9,'Login','个人中心',1,1,'',0),(10,'Admin/adminlist','管理员列表',1,1,'',5),(11,'Admin/adminadd','添加管理员',1,1,'',5),(12,'Admin/adminadd_post','添加管理员POST',1,1,'',5),(13,'Admin/adminmod','修改管理员',1,1,'',5),(14,'Admin/adminmod_post','修改管理员POST',1,1,'',5),(15,'Admin/adminDel','删除管理员',1,1,'',5),(16,'Admin/admin_multidel','批量删除管理员',1,1,'',5),(17,'Admin/adminStop','拉黑管理员',1,1,'',5),(18,'Admin/adminStart','恢复管理员',1,1,'',5),(19,'Admin/rulelist','权限列表',1,1,'',5),(20,'Admin/ruleadd','添加权限',1,1,'',5),(21,'Admin/ruleadd_post','添加权限POST',1,1,'',5),(22,'Admin/ruledel','删除权限',1,1,'',5),(23,'Admin/grouplist','角色列表',1,1,'',5),(24,'Admin/groupadd','添加角色',1,1,'',5),(25,'Admin/groupadd_post','添加角色POST',1,1,'',5),(26,'Admin/groupmod','修改角色',1,1,'',5),(27,'Admin/groupmod_post','修改角色POST',1,1,'',5),(28,'Admin/groupdel','删除角色',1,1,'',5),(29,'Admin/group_multidel','批量删除角色',1,1,'',5),(30,'System/syslog','系统日志',1,1,'',6),(31,'Banner/slideshow','轮播图列表',1,1,'',7),(32,'Banner/slideadd','添加轮播图',1,1,'',7),(33,'Banner/slidemod','修改轮播图',1,1,'',7),(34,'Banner/slidemod_post','修改轮播图POST',1,1,'',7),(35,'Banner/slide_del','删除轮播图',1,1,'',7),(36,'Banner/sortSlide','轮播图排序',1,1,'',7),(37,'Banner/slide_stop','禁用轮播图',1,1,'',7),(38,'Banner/slide_start','启用轮播图',1,1,'',7),(39,'Index/index','首页',1,1,'',8),(40,'Index/uploadImage','通用上传图片(必选)',1,1,'',8),(41,'Login/modifyInfo','修改个人资料',1,1,'',9),(42,'Login/logout','退出',1,1,'',9),(43,'Shop','商城管理',1,1,'',0),(44,'Shop/goodsList','商品列表',1,1,'',43),(45,'Shop/getCateList','获取二级分类',1,1,'',43),(46,'Shop/goodsAdd','添加商品',1,1,'',43),(47,'Shop/goodsAddPost','添加商品POST',1,1,'',43),(48,'Shop/goodsDetail','修改商品',1,1,'',43),(49,'Shop/goodsModPost','修改商品POST',1,1,'',43),(50,'Shop/recommend','推荐商品',1,1,'',43),(51,'Shop/goodsHide','隐藏商品',1,1,'',43),(52,'Shop/goodsShow','显示商品',1,1,'',43),(53,'Shop/goodsDel','删除商品',1,1,'',43),(54,'Shop/cateList','分类列表',1,1,'',43),(55,'Shop/cateAdd','添加分类',1,1,'',43),(56,'Shop/cateAddPost','添加分类POST',1,1,'',43),(57,'Shop/cateDetail','修改分类',1,1,'',43),(58,'Shop/cateModPost','修改分类POST',1,1,'',43),(59,'Shop/cateHide','隐藏分类',1,1,'',43),(60,'Shop/cateShow','显示分类',1,1,'',43),(61,'Shop/cateDel','删除分类',1,1,'',43),(62,'Order','用户下单',1,1,'',0),(63,'Order/goodsList','商品列表',1,1,'',62),(64,'Order/orderList','订单列表',1,1,'',62),(65,'Order/goodsDetail','商品详情',1,1,'',62),(66,'Order/order','下单',1,1,'',62),(67,'Order/getCateList','获取二级分类',1,1,'',62),(68,'Shop/orderList','订单列表',1,1,'',43),(69,'Shop/orderPass','确认订单',1,1,'',43),(70,'Shop/orderReject','拒绝订单',1,1,'',43),(71,'Shop/multi_recommend','批量推荐',1,1,'',43),(72,'Shop/multi_new','批量新品',1,1,'',43),(73,'Shop/multi_del','批量删除商品',1,1,'',43),(74,'Shop/multi_up','批量上架',1,1,'',43),(75,'Shop/multi_down','批量下架',1,1,'',43),(76,'Login/personal','修改个人资料页面',1,1,'',9);

/*Table structure for table `mp_goods` */

DROP TABLE IF EXISTS `mp_goods`;

CREATE TABLE `mp_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT '0001',
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `name` varchar(50) DEFAULT NULL COMMENT '商品名',
  `price` decimal(10,2) DEFAULT '0.00',
  `stock` int(11) DEFAULT '0',
  `detail` text COMMENT '商品详情',
  `pics` varchar(2000) DEFAULT NULL COMMENT '缩略图',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `is_new` tinyint(4) DEFAULT '0' COMMENT '0不是1是',
  `hot` tinyint(4) DEFAULT '0' COMMENT '1精品',
  `status` tinyint(4) DEFAULT '0' COMMENT '0下架1上架',
  `up_time` timestamp NULL DEFAULT NULL COMMENT '上架时间',
  `create_time` int(10) unsigned DEFAULT NULL,
  `del` tinyint(4) DEFAULT '0' COMMENT '0删除1正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_goods` */

insert  into `mp_goods`(`id`,`number`,`cate_id`,`name`,`price`,`stock`,`detail`,`pics`,`sort`,`is_new`,`hot`,`status`,`up_time`,`create_time`,`del`) values (1,'0001',20,'GUCCI','150.00',85,'<p style=\"text-align: center;\">骚气的小裙子,为什么富文本不正常啊,现在好像正常了呀</p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190324/1553441028934033.jpg\" title=\"1553441028934033.jpg\" alt=\"1553441028934033.jpg\" width=\"360\" height=\"516\" border=\"0\" vspace=\"0\" style=\"width: 360px; height: 516px;\"/></p><p><br/></p>','a:3:{i:0;s:57:\"static/uploads/goods/2019-04-14/155343850541046000944.jpg\";i:1;s:57:\"static/uploads/goods/2019-04-14/155343850732806800315.jpg\";i:2;s:57:\"static/uploads/goods/2019-04-14/155343850920659200994.jpg\";}',0,1,0,1,'2019-03-26 00:00:00',1553442507,0),(2,'0002',20,'PARADA','50.00',999,'','a:1:{i:0;s:57:\"static/uploads/goods/2019-03-28/155343854520740800301.jpg\";}',0,1,0,1,'2019-03-26 00:00:00',1553438549,0),(3,'0003',20,'伊莎贝拉.阿佳妮','435.00',40,'<p style=\"text-align: center;\">哇!真好看呀!随便说几句废话,下面上图</p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190325/1553522299306631.jpg\" title=\"1553522299306631.jpg\" alt=\"1553522299306631.jpg\" width=\"500\" height=\"543\" border=\"0\" vspace=\"0\" style=\"width: 500px; height: 543px;\"/></p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190325/1553522305362787.jpg\" title=\"1553522305362787.jpg\" alt=\"1553522305362787.jpg\" width=\"400\" height=\"470\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 470px;\"/></p>','a:3:{i:0;s:57:\"static/uploads/goods/2019-03-28/155343666528606500932.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155343666747579600313.jpg\";i:2;s:57:\"static/uploads/goods/2019-03-28/155343666968219200421.jpg\";}',0,1,1,1,'2019-03-26 00:00:00',1553522339,0),(4,'0004',22,'仙女裙啊','230.00',100,'<p style=\"text-align: center; text-indent: 2em;\">娜妮长袖印花雪纺衫套装裙2019春季新款网纱连衣裙两件套大摆裙</p><p style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; text-align: center;\" microsoft=\"\" line-height:=\"\" white-space:=\"\" background-color:=\"\" text-indent:=\"\" text-align:=\"\"><img src=\"/ueditor/php/upload/image/20190325/1553527072103258.jpg\" title=\"1553527072103258.jpg\" alt=\"1553527072103258.jpg\" width=\"400\" height=\"400\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 400px;\"/></p><p style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; text-align: center;\" microsoft=\"\" line-height:=\"\" white-space:=\"\" background-color:=\"\" text-indent:=\"\" text-align:=\"\"><img src=\"/ueditor/php/upload/image/20190325/1553527109458651.jpg\" title=\"1553527109458651.jpg\" alt=\"1553527109458651.jpg\" width=\"400\" height=\"400\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 400px;\"/></p><p style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; text-align: center;\" microsoft=\"\" line-height:=\"\" white-space:=\"\" background-color:=\"\" text-indent:=\"\" text-align:=\"\"><img src=\"/ueditor/php/upload/image/20190325/1553527133684793.jpg\" title=\"1553527133684793.jpg\" alt=\"1553527133684793.jpg\" width=\"400\" height=\"400\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 400px;\"/></p><p style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px;\" microsoft=\"\" line-height:=\"\" white-space:=\"\" background-color:=\"\" text-indent:=\"\"><br/></p>','a:5:{i:0;s:57:\"static/uploads/goods/2019-03-28/155343672512259100525.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155343673082414100317.jpg\";i:2;s:57:\"static/uploads/goods/2019-03-28/155343673403203500247.jpg\";i:3;s:57:\"static/uploads/goods/2019-03-28/155343673665481200896.jpg\";i:4;s:57:\"static/uploads/goods/2019-03-28/155343674562670000579.jpg\";}',0,1,0,1,'2019-03-20 00:00:00',1553527615,0),(5,'0005',24,'男神毛衣','98.00',999,'','a:2:{i:0;s:57:\"static/uploads/goods/2019-03-28/155343689337271500503.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155343689600350300544.jpg\";}',0,1,1,1,'2019-03-01 00:00:00',1553436910,0),(6,'0006',26,'猛男西服','1980.00',14,'<p style=\"text-align: center;\"><span style=\"color: rgb(112, 48, 160); font-size: 20px;\">就是</span><span style=\"color: rgb(255, 0, 0);\">这样</span></p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190325/1553527398173186.jpg\" title=\"1553527398173186.jpg\" alt=\"1553527398173186.jpg\" width=\"400\" height=\"622\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 622px;\"/></p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190325/1553527429373763.jpg\" title=\"1553527429373763.jpg\" alt=\"1553527429373763.jpg\" width=\"400\" height=\"659\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 659px;\"/></p><p><br/></p><p><br/></p>','a:5:{i:0;s:57:\"static/uploads/goods/2019-03-28/155343778149518100806.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155343840232877300734.jpg\";i:2;s:57:\"static/uploads/goods/2019-03-28/155343840485175900886.jpg\";i:3;s:57:\"static/uploads/goods/2019-03-28/155343841093935800701.jpg\";i:4;s:57:\"static/uploads/goods/2019-03-28/155343841568749400792.jpg\";}',0,1,0,1,'2018-03-03 00:00:00',1553527827,0),(8,'00007',21,'长袖印花雪纺衫','600.00',100,'<p style=\"text-align: center;\">是真好看呀</p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190325/1553528728141384.jpg\" title=\"1553528728141384.jpg\" alt=\"1553528728141384.jpg\" width=\"400\" height=\"569\" border=\"0\" vspace=\"0\" style=\"width: 400px; height: 569px;\"/></p>','a:4:{i:0;s:57:\"static/uploads/goods/2019-03-28/155352867260130400355.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155352867563827700619.jpg\";i:2;s:57:\"static/uploads/goods/2019-03-28/155352868049712000624.jpg\";i:3;s:57:\"static/uploads/goods/2019-03-28/155352868278030600180.jpg\";}',0,1,1,1,'2017-03-15 00:00:00',1553528741,0),(11,'00008',22,'春装2019新款夏流行裙子女','975.00',20,'<p style=\"text-align: center;\">尺寸：开衫肩宽37 胸围84 袖长45 衣长43</p><p style=\"text-align: center;\"><img src=\"/ueditor/php/upload/image/20190326/1553605979991873.jpg\" title=\"1553605979991873.jpg\" alt=\"O1CN01fw0iZz1Mjl79j0GyA_!!0-item_pic.jpg_430x430q90.jpg\"/></p>','a:4:{i:0;s:57:\"static/uploads/goods/2019-03-28/155360593011455100653.jpg\";i:1;s:57:\"static/uploads/goods/2019-03-28/155360593303700400421.jpg\";i:2;s:57:\"static/uploads/goods/2019-03-28/155360593487270200572.jpg\";i:3;s:57:\"static/uploads/goods/2019-03-28/155360594023889600980.jpg\";}',0,1,1,1,'2019-04-01 00:00:00',1553605985,0),(13,'dd',33,'2019凉鞋新款上图','12.00',12,'<p>2019凉鞋新款上图，牛漆皮，内里全皮，垫脚羊皮，鞋跟粗跟，高7厘米，黑白两个颜色可选，货号mdx801</p><p><br/></p><p><img src=\"/ueditor/php/upload/image/20190404/1554389682427430.jpg\" style=\"\" title=\"1554389682427430.jpg\"/></p><p><img src=\"/ueditor/php/upload/image/20190404/1554389682579916.jpg\" style=\"\" title=\"1554389682579916.jpg\"/></p><p><img src=\"/ueditor/php/upload/image/20190404/1554389682213368.jpg\" style=\"\" title=\"1554389682213368.jpg\"/></p><p><br/></p>','a:1:{i:0;s:57:\"static/uploads/goods/2019-04-04/155438961887620200700.jpg\";}',0,1,1,1,'2019-04-04 00:00:00',1554389687,0);

/*Table structure for table `mp_goods_cate` */

DROP TABLE IF EXISTS `mp_goods_cate`;

CREATE TABLE `mp_goods_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) DEFAULT NULL,
  `cate_name` varchar(25) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `status` tinyint(4) DEFAULT '1' COMMENT '0隐藏1显示',
  `del` tinyint(4) DEFAULT '0' COMMENT '0未删除1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_goods_cate` */

insert  into `mp_goods_cate`(`id`,`icon`,`cate_name`,`pid`,`status`,`del`) values (17,'static/upload/2019-03-24/155343019801567600414.jpg','女装',0,1,0),(18,'static/upload/2019-03-24/155343020968206100926.jpg','男装',0,1,0),(19,'static/upload/2019-03-24/155343025099819600933.jpg','生活用品',0,1,0),(20,'static/upload/2019-03-24/155343032389861900524.jpg','短裙',17,1,0),(21,'static/upload/2019-03-24/155343034924302400604.jpg','连衣裙',17,1,0),(22,'static/upload/2019-03-24/155343034340780000404.jpg','仙女裙',17,1,0),(23,'static/upload/2019-03-27/155369383897051300578.jpg','大佬',17,1,0),(24,'static/upload/2019-03-24/155343066237677700400.jpg','毛衣',18,1,0),(25,'static/upload/2019-03-24/155343069110213100849.jpg','夹克',18,1,0),(26,'static/upload/2019-03-24/155343071044366700801.jpg','猛男西服',18,1,0),(27,'static/upload/2019-03-24/155343075203996700306.jpg','渣男墨镜',18,1,0),(28,'static/upload/2019-03-25/155352357345255800779.jpg','易世顿',18,1,0),(29,'static/upload/2019-03-24/155343861198746300743.jpg','茶杯',19,1,0),(30,'static/upload/2019-03-24/155343864476821000582.jpg','书皮',19,1,0),(31,'static/upload/2019-03-24/155343870026467800782.jpg','牙刷',19,1,0),(32,'static/upload/2019-04-04/155438852105320500367.jpg','鞋',0,1,0),(33,'static/upload/2019-04-04/155438893796305300914.jpg','女装',32,1,0);

/*Table structure for table `mp_order` */

DROP TABLE IF EXISTS `mp_order`;

CREATE TABLE `mp_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '下单人',
  `order_sn` varchar(25) DEFAULT NULL COMMENT '单号',
  `goods_id` int(11) DEFAULT NULL COMMENT '商品ID',
  `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '总价',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  `unit_price` decimal(10,2) DEFAULT '0.00' COMMENT '单价',
  `status` tinyint(4) DEFAULT '1' COMMENT '1审核中2已确认3未通过',
  `create_time` int(11) DEFAULT NULL COMMENT '下单时间',
  `confirm_time` int(11) DEFAULT NULL COMMENT '确认时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '确认人',
  `del` tinyint(4) DEFAULT '0' COMMENT '1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_order` */

insert  into `mp_order`(`id`,`uid`,`order_sn`,`goods_id`,`total_price`,`num`,`unit_price`,`status`,`create_time`,`confirm_time`,`admin_id`,`del`) values (1,1,'155523061678580200508',1,'1800.00',12,'150.00',3,1555230616,1555234238,NULL,0),(2,1,'155523069749922800238',1,'150.00',1,'150.00',3,1555230697,1555234236,NULL,0),(3,1,'155523071398417600929',1,'1050.00',7,'150.00',3,1555230713,1555234234,NULL,0),(4,1,'155523164745262800367',1,'12000.00',80,'150.00',3,1555231647,1555234229,NULL,0),(5,1,'155523185863855600768',3,'4350.00',10,'435.00',3,1555231858,1555239688,NULL,0),(6,1,'155523195839648300197',6,'1980.00',1,'1980.00',2,1555231958,1555239686,NULL,0),(7,7,'155523956664838800419',1,'2250.00',15,'150.00',2,1555239566,1555239682,NULL,0),(8,7,'155523958750023600820',3,'4350.00',10,'435.00',2,1555239587,1555239678,NULL,0);

/*Table structure for table `mp_slideshow` */

DROP TABLE IF EXISTS `mp_slideshow`;

CREATE TABLE `mp_slideshow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `sort` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_slideshow` */

insert  into `mp_slideshow`(`id`,`title`,`pic`,`url`,`status`,`sort`) values (14,'白蛇缘起','static/upload/2019-03-24/155342942820920600663.jpg','http://show.jianghairui.com/api/shop/detail/id/1.html',1,0),(15,'石原里美','static/upload/2019-03-24/155342944822390900115.jpg','http://show.jianghairui.com/api/shop/detail/id/3.html',1,0),(16,'绫濑遥','static/upload/2019-03-24/155342949275005200170.jpg','http://show.jianghairui.com/api/shop/detail/id/4.html',1,0),(18,'fff','static/upload/2019-04-04/155438977546395400888.jpg','https://www.baidu.com',1,0);

/*Table structure for table `mp_syslog` */

DROP TABLE IF EXISTS `mp_syslog`;

CREATE TABLE `mp_syslog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '0登录1增2删3改',
  PRIMARY KEY (`id`),
  KEY `sys_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;

/*Data for the table `mp_syslog` */

insert  into `mp_syslog`(`id`,`admin_id`,`detail`,`create_time`,`ip`,`type`) values (21,1,'登录账号',1553476046,'218.68.108.150',0),(22,1,'登录账号',1553522149,'60.25.12.177',0),(23,1,'登录账号',1553528518,'60.25.12.177',0),(24,1,'登录账号',1553604023,'60.25.12.177',0),(25,1,'登录账号',1553611255,'59.41.94.34',0),(26,1,'登录账号',1553613752,'223.192.253.37',0),(27,1,'登录账号',1553649712,'218.68.108.150',0),(28,1,'登录账号',1553693811,'60.25.12.177',0),(29,1,'登录账号',1553696289,'59.42.128.61',0),(30,1,'登录账号',1553743901,'117.136.41.74',0),(31,1,'登录账号',1553783559,'60.25.12.177',0),(32,5,'登录账号',1553785344,'60.25.12.177',0),(33,1,'登录账号',1553785928,'60.25.12.177',0),(34,1,'登录账号',1554198173,'59.42.128.217',0),(35,1,'登录账号',1554198548,'59.42.128.217',0),(36,6,'登录账号',1554198594,'59.42.128.217',0),(37,1,'登录账号',1554198615,'59.42.128.217',0),(38,1,'登录账号',1554198722,'59.42.128.217',0),(39,6,'登录账号',1554198754,'59.42.128.217',0),(40,1,'登录账号',1554198891,'59.42.128.217',0),(41,6,'登录账号',1554199891,'59.42.128.217',0),(42,6,'登录账号',1554207962,'59.42.128.217',0),(43,1,'登录账号',1554207979,'59.42.128.217',0),(44,1,'登录账号',1554216314,'60.25.12.177',0),(45,1,'登录账号',1554385058,'59.41.94.94',0),(46,1,'登录账号',1554388240,'223.192.253.12',0),(47,1,'登录账号',1554388744,'223.192.253.12',0),(48,1,'登录账号',1554389111,'120.230.119.149',0),(49,1,'登录账号',1554389536,'60.25.63.79',0),(50,1,'登录账号',1554389592,'223.192.253.12',0),(51,6,'登录账号',1554390107,'223.192.253.12',0),(52,1,'登录账号',1554641189,'60.25.63.79',0),(53,1,'登录账号',1555164508,'60.25.11.29',0),(54,1,'登录账号',1555218546,'60.25.11.29',0),(55,1,'登录账号',1555218860,'60.25.11.29',0),(56,1,'登录账号',1555228111,'60.25.11.29',0),(57,1,'登录账号',1555236736,'60.25.11.29',0),(58,7,'登录账号',1555239546,'60.25.11.29',0),(59,1,'登录账号',1555239612,'60.25.11.29',0),(60,5,'登录账号',1555239662,'60.25.11.29',0),(61,5,'登录账号',1555239710,'60.25.11.29',0),(62,5,'登录账号',1555239718,'60.25.11.29',0),(63,1,'登录账号',1555239755,'60.25.11.29',0),(64,1,'登录账号',1555423206,'60.25.11.29',0),(65,1,'登录账号',1555465689,'221.197.56.192',0),(66,1,'登录账号',1555500827,'60.25.10.181',0),(67,1,'登录账号',1556099260,'221.197.66.63',0),(68,1,'登录账号',1557114878,'218.68.108.156',0),(69,1,'登录账号',1557628383,'218.68.102.170',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
