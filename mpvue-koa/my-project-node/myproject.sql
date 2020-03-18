/*
 Navicat Premium Data Transfer

 Source Server         : myproject
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : myproject

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 16/03/2020 16:41:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `foodType` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `oldPrice` decimal(10,0) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sellCount` int DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1` (`foodType`),
  CONSTRAINT `fk1` FOREIGN KEY (`foodType`) REFERENCES `list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food
-- ----------------------------
BEGIN;
INSERT INTO `food` VALUES (1, 1, '香菇青菜', 18, 26, '味道鲜美，香味浓郁，老少皆宜。', 101, 'https://i3.meishichina.com/attachment/recipe/2018/04/27/20180427152481101712310169539.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/27/20180427152481101712310169539.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (2, 1, '麻婆豆腐', 20, 30, '麻、辣、烫、嫩、酥、香、鲜。', 127, 'https://i3.meishichina.com/attachment/recipe/2015/06/01/c640_201506011433146195575.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/06/01/c640_201506011433146195575.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (3, 1, '红烧肉', 36, 42, '色泽金黄、肥而不腻，入口酥软即化。', 171, 'https://i3.meishichina.com/attachment/recipe/2014/10/27/c640_20141027211913820385989.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2014/10/27/c640_20141027211913820385989.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (4, 1, '番茄烧排骨', 34, 36, '酸爽的味道，带着些许甜，还有青椒的香味。', 127, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455961943913.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455961943913.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (5, 1, '辣子鸡', 28, 40, '外酥里嫩，干松香辣，特别下饭。', 103, 'https://i3.meishichina.com/attachment/recipe/2014/12/19/c640_201412191418956489678.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2014/12/19/c640_201412191418956489678.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (6, 1, '家常木须肉', 22, 36, '荤素都有，食材丰富。', 127, 'https://i3.meishichina.com/attachment/good/2013/03/26/20130326203705518087276.jpg', 'https://i3.meishichina.com/attachment/good/2013/03/26/20130326203705518087276.jpg');
INSERT INTO `food` VALUES (7, 1, '红烧茄子', 15, 18, '咸香适口，配米饭吃极其适合。', 139, 'https://i3.meishichina.com/attachment/recipe/2015/01/24/c640_201501241422067691580.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/01/24/c640_201501241422067691580.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (8, 1, '手撕包菜', 16, 28, '非常可口的下饭菜，清脆爽口。', 232, 'https://i3.meishichina.com/attachment/recipe/2020/02/07/2020020715810818867798197577.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/07/2020020715810818867798197577.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (9, 1, '葱香牛肉', 32, 38, '下饭好吃的家常菜。', 122, 'https://i3.meishichina.com/attachment/recipe/2020/02/11/2020021115813873738151958079.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/11/2020021115813873738151958079.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (10, 2, '雪梨瘦肉汤', 12, 18, '雪梨润肺化痰、止咳清润。', 15, 'https://i3.meishichina.com/attachment/recipe/2020/01/08/2020010815784602752209702111.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/01/08/2020010815784602752209702111.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (11, 2, '玉米排骨汤', 14, 22, '猪骨肉香，玉米清甜，去燥润肺之佳品。', 16, 'https://i3.meishichina.com/attachment/recipe/2020/01/05/2020010515782258498139732003.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/01/05/2020010515782258498139732003.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (12, 2, '枸杞银耳汤', 8, 10, '补脾开胃、益气清肠、滋阴润肺，并且美丽没负担。', 125, 'https://i3.meishichina.com/attachment/recipe/2019/12/31/2019123115777963268489702111.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2019/12/31/2019123115777963268489702111.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (13, 2, '虫草花鸡汤', 16, 18, '虫草花对增强和调节人体免疫功能有一定作用。', 17, 'https://i3.meishichina.com/attachment/recipe/2019/12/21/2019122115768969384319702111.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2019/12/21/2019122115768969384319702111.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (14, 3, '东北白米饭', 1, 2, '香软东北大米。', 208, 'https://i8.meishichina.com/attachment/recipe/2012/10/14/20121014210158408898425.jpg?x-oss-process=style/c320', 'https://i8.meishichina.com/attachment/recipe/2012/10/14/20121014210158408898425.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (15, 3, '黑麦馒头', 6, NULL, '味道香浓，营养丰富。', 43, 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812514782678197577.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812514782678197577.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (16, 3, '玉米烙', 16, NULL, '脆嫩香甜。', 29, 'https://i3.meishichina.com/attachment/recipe/2020/02/07/2020020715810817766938197577.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/07/2020020715810817766938197577.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (17, 3, '羊肉焖饭', 18, NULL, '米粒分明，羊肉香而不膻，鲜嫩可口。', 18, 'https://i3.meishichina.com/attachment/recipe/2016/12/07/20161207148110531940913.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2016/12/07/20161207148110531940913.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (18, 3, '鸡丝凉面', 16, NULL, '面条筋道，肉丝鲜香。', 43, 'https://i3.meishichina.com/attachment/recipe/2017/06/13/20170613149731915185913.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2017/06/13/20170613149731915185913.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (19, 3, '红豆汤圆', 12, NULL, '脆红豆具有补血养颜的功效，对身体好处多多。', 29, 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812221192908197577.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812221192908197577.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (20, 3, '牛肉焗饭', 18, NULL, '平淡的表面下隐藏着丰富的食材。', 115, 'https://i3.meishichina.com/attachment/recipe/2020/02/08/2020020815811369328301958079.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/08/2020020815811369328301958079.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (21, 4, '韩式泡菜', 4, NULL, '口感丰富', 84, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455506016013.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455506016013.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (22, 4, '韩式冷面', 19, 24, '酸中带甜、甜中透辣、辣里又带香。', 68, 'https://i3.meishichina.com/attachment/recipe/2014/12/19/c640_20141219134059996428875.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2014/12/19/c640_20141219134059996428875.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (23, 4, '日式炸猪排', 14, NULL, '香脆可口。', 84, 'https://i3.meishichina.com/attachment/recipe/2015/03/04/c640_201503041425470306811.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/03/04/c640_201503041425470306811.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (24, 4, '日式照烧鸡腿饭', 19, 24, '一个人的营养午餐。', 58, 'https://i3.meishichina.com/attachment/recipe/2015/03/02/c640_201503021425266456576.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/03/02/c640_201503021425266456576.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (25, 5, '越南春卷', 17, NULL, '健康减肥，好看好吃。', 13, 'https://i3.meishichina.com/attachment/recipe/2015/05/01/c640_201505011430452639829.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/05/01/c640_201505011430452639829.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (26, 5, '泰式菠萝炒饭', 20, 26, '菠萝味甘、微酸、性微寒，有清热解暑、生津止渴的功效。', 122, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455695566613.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455695566613.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (27, 5, '印度飞饼', 13, 20, '口感酥脆，层次分明又不乏鸡蛋夹层的香甜软糯。', 62, 'https://i3.meishichina.com/attachment/recipe/2015/02/04/c640_201502041423057349407.gif?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/02/04/c640_201502041423057349407.gif?x-oss-process=style/c320');
INSERT INTO `food` VALUES (28, 6, '法式可丽饼', 16, NULL, '鸡蛋、奶酪、菠菜、蘑菇和培根的组合非常美味。', 12, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455720373413.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455720373413.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (29, 6, '意大利肉酱面', 15, NULL, '牛肉浓香，柔韧筋道的一面蘸满了鲜美丰厚的酱汁。', 22, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455553765713.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455553765713.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (30, 6, '西班牙海鲜饭', 16, NULL, '多种海鲜，口感丰富。', 12, 'https://i3.meishichina.com/attachment/recipe/2015/02/05/c640_201502051423138436565.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/02/05/c640_201502051423138436565.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (31, 7, '牛肉小酥肉', 26, 30, '回民特色菜，鲜香味美不油腻。', 129, 'https://i3.meishichina.com/attachment/recipe/2020/01/20/2020012015795143435431958079.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/01/20/2020012015795143435431958079.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (32, 7, '新疆大盘鸡', 36, 40, '鸡肉采用先炒后烧的方法制成，土豆软糯、香辣微麻。', 28, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455585915013.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152455585915013.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (33, 7, '孜然羊肉', 26, 30, '干香耐嚼，回味无穷。', 29, 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152456400332913.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/24/20180424152456400332913.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (34, 7, '粉蒸羊肉', 24, 30, '越吃越喜欢。', 32, 'https://i3.meishichina.com/attachment/recipe/2018/04/26/201804261524727547429.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/04/26/201804261524727547429.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (35, 7, '干锅牛头肉', 28, 32, '寒冬食牛肉，有养胃作用，为寒冬补益佳品。', 89, 'https://i3.meishichina.com/attachment/recipe/2018/05/02/2018050215252468258659702108.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2018/05/02/2018050215252468258659702108.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (36, 8, '黑椒牛肉三明治', 16, 18, '爽滑酥嫩，肉汁四溢。', 99, 'https://i8.meishichina.com/attachment/recipe/2016/06/10/p800_20160610rxbco9jodfhm8ob0.jpg?x-oss-process=style/c320', 'https://i8.meishichina.com/attachment/recipe/2016/06/10/p800_20160610rxbco9jodfhm8ob0.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (37, 8, '鸡胸肉水果沙拉', 15, 17, '口感饱满，回味悠长。', 34, 'https://i3.meishichina.com/attachment/recipe/2016/11/24/20161124147996126813313.jpg?x-oss-process=style/c180', 'https://i3.meishichina.com/attachment/recipe/2016/11/24/20161124147996126813313.jpg?x-oss-process=style/c180');
INSERT INTO `food` VALUES (38, 8, '酸奶蔬菜沙拉', 12, NULL, '轻食又饱腹，健身是的不二之选。', 20, 'https://i3.meishichina.com/attachment/recipe/2017/10/16/20171016150812640069113.jpg?x-oss-process=style/c180', 'https://i3.meishichina.com/attachment/recipe/2017/10/16/20171016150812640069113.jpg?x-oss-process=style/c180');
INSERT INTO `food` VALUES (39, 8, '燕麦水果套餐', 12, NULL, '0卡路里，健康减肥无负担。', 36, 'https://i3.meishichina.com/attachment/recipe/2016/08/09/c640_20160809147072329516613.jpg?x-oss-process=style/c180', 'https://i3.meishichina.com/attachment/recipe/2016/08/09/c640_20160809147072329516613.jpg?x-oss-process=style/c180');
INSERT INTO `food` VALUES (40, 8, '鸡胸肉拉面', 16, 20, '低油低盐高蛋白，适合减肥健身人群。', 120, 'https://i3.meishichina.com/attachment/recipe/2018/12/24/2018122415456147678679702111.jpg?x-oss-process=style/c180', 'https://i3.meishichina.com/attachment/recipe/2018/12/24/2018122415456147678679702111.jpg?x-oss-process=style/c180');
INSERT INTO `food` VALUES (41, 9, '蛋黄酥', 8, NULL, '一层层酥皮加上甜糯的豆沙，最后还夹着蛋黄的咸香。', 188, 'https://i3.meishichina.com/attachment/blog/2016/12/21/20161221148228906291213.jpg', 'https://i3.meishichina.com/attachment/blog/2016/12/21/20161221148228906291213.jpg');
INSERT INTO `food` VALUES (42, 9, '芝麻核桃糖', 6, NULL, '又香又甜，忍不住要多吃几块。', 18, 'https://i3.meishichina.com/attachment/blog/2016/12/22/20161222148239773142213.jpg', 'https://i3.meishichina.com/attachment/blog/2016/12/22/20161222148239773142213.jpg');
INSERT INTO `food` VALUES (43, 9, '双色软曲奇', 10, 12, '满满黄油香。', 48, 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812504074918197577.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2020/02/09/2020020915812504074918197577.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (44, 9, '冰糖雪梨', 10, NULL, '雪梨性凉味甘，有润肺化痰，清热解毒等功效。', 58, 'https://i3.meishichina.com/attachment/recipe/2015/05/11/c640_201505111431310070464.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2015/05/11/c640_201505111431310070464.jpg?x-oss-process=style/c320');
INSERT INTO `food` VALUES (45, 9, '酸奶水果杯', 18, NULL, '一层水果一层酸奶，大粒的果肉，绚丽的色彩，更健康营养。', 88, 'https://i3.meishichina.com/attachment/recipe/2016/03/01/c640_20160301145679796873713.jpg?x-oss-process=style/c320', 'https://i3.meishichina.com/attachment/recipe/2016/03/01/c640_20160301145679796873713.jpg?x-oss-process=style/c320');
COMMIT;

-- ----------------------------
-- Table structure for list
-- ----------------------------
DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of list
-- ----------------------------
BEGIN;
INSERT INTO `list` VALUES (1, '中式家常菜');
INSERT INTO `list` VALUES (2, '汤羹');
INSERT INTO `list` VALUES (3, '主食/小吃');
INSERT INTO `list` VALUES (4, '韩餐/日料');
INSERT INTO `list` VALUES (5, '东南亚风情');
INSERT INTO `list` VALUES (6, '欧洲风味');
INSERT INTO `list` VALUES (7, '清真');
INSERT INTO `list` VALUES (8, '健身食谱');
INSERT INTO `list` VALUES (9, '甜品/饮品');
COMMIT;

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `foodId` int NOT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `rateTime` varchar(255) DEFAULT NULL,
  `rateType` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `rateImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk2` (`foodId`),
  CONSTRAINT `fk2` FOREIGN KEY (`foodId`) REFERENCES `food` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of rate
-- ----------------------------
BEGIN;
INSERT INTO `rate` VALUES ('1', 1, '1', '1', '1', '1', '1', '1', '1');
COMMIT;

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk3` FOREIGN KEY (`id`) REFERENCES `food` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of recommend
-- ----------------------------
BEGIN;
INSERT INTO `recommend` VALUES (10, '健身餐', 12, 'http://www.swjswang.com/uploads/allimg/170412/3-1F412151Z2H7.jpg');
INSERT INTO `recommend` VALUES (19, '红豆汤圆', 12, 'http://n.sinaimg.cn/sinacn17/579/w640h739/20181014/71c3-hmhhnqs4138853.jpg');
INSERT INTO `recommend` VALUES (23, '日式炸猪排', 14, 'http://i5.chuimg.com/80a144897ea54567be76bd6c957b6f01_1024w_1280h.jpg@2o_50sh_1pr_1l_600w_90q_1wh');
INSERT INTO `recommend` VALUES (45, '酸奶水果杯', 18, 'https://i3.meishichina.com/attachment/pai/2020/03/16/20200316158431852838133810667631.JPG?x-oss-process=style/c180');
COMMIT;

-- ----------------------------
-- Table structure for swiper_ad
-- ----------------------------
DROP TABLE IF EXISTS `swiper_ad`;
CREATE TABLE `swiper_ad` (
  `id` int NOT NULL,
  `adType` int DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of swiper_ad
-- ----------------------------
BEGIN;
INSERT INTO `swiper_ad` VALUES (1, 1, 'https://i3.meishichina.com/attachment/magic/2020/03/03/2020030315832190035108197577.jpg');
INSERT INTO `swiper_ad` VALUES (2, 1, 'https://i3.meishichina.com/attachment/magic/2020/02/18/2020021815819915697568197577.jpg');
INSERT INTO `swiper_ad` VALUES (3, 1, 'https://i3.meishichina.com/attachment/magic/2020/02/27/2020022715827848206028197577.jpg');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
