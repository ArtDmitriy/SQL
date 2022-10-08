-- Generation time: Wed, 16 Sep 2020 02:01:47 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_25
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
                        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                        `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `is_free` enum('free','paid') COLLATE utf8_unicode_ci DEFAULT NULL,
                        `admin_user_id` bigint(20) unsigned NOT NULL,
                        UNIQUE KEY `id` (`id`),
                        KEY `apps_name_idx` (`name`),
                        KEY `admin_user_id` (`admin_user_id`),
                        CONSTRAINT `apps_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `apps` VALUES ('1','numquam','free','1'),
                          ('2','beatae','free','2'),
                          ('3','accusantium','paid','3'),
                          ('4','est','free','4'),
                          ('5','ad','free','5'),
                          ('6','vel','paid','6'),
                          ('7','aliquam','paid','7'),
                          ('8','sit','free','8'),
                          ('9','velit','paid','9'),
                          ('10','vel','paid','10'),
                          ('11','et','paid','11'),
                          ('12','dolores','free','12'),
                          ('13','quia','free','13'),
                          ('14','id','free','14'),
                          ('15','quibusdam','paid','15'),
                          ('16','officia','free','16'),
                          ('17','temporibus','paid','17'),
                          ('18','autem','paid','18'),
                          ('19','rem','paid','19'),
                          ('20','nihil','free','20'),
                          ('21','est','free','21'),
                          ('22','non','paid','22'),
                          ('23','qui','free','23'),
                          ('24','ut','free','24'),
                          ('25','ut','paid','25'),
                          ('26','quia','paid','26'),
                          ('27','autem','free','27'),
                          ('28','accusamus','free','28'),
                          ('29','ut','free','29'),
                          ('30','blanditiis','paid','30');


DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
                               `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                               `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
                               `admin_user_id` bigint(20) unsigned NOT NULL,
                               UNIQUE KEY `id` (`id`),
                               KEY `communities_name_idx` (`name`),
                               KEY `admin_user_id` (`admin_user_id`),
                               CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `communities` VALUES ('1','consequuntur','1'),
                                 ('2','est','2'),
                                 ('3','consequatur','3'),
                                 ('4','ab','4'),
                                 ('5','neque','5'),
                                 ('6','et','6'),
                                 ('7','fugit','7'),
                                 ('8','sint','8'),
                                 ('9','neque','9'),
                                 ('10','est','10'),
                                 ('11','sapiente','11'),
                                 ('12','aspernatur','12'),
                                 ('13','tempore','13'),
                                 ('14','enim','14'),
                                 ('15','et','15'),
                                 ('16','consequatur','16'),
                                 ('17','maiores','17'),
                                 ('18','nihil','18'),
                                 ('19','modi','19'),
                                 ('20','aliquam','20'),
                                 ('21','pariatur','21'),
                                 ('22','placeat','22'),
                                 ('23','nisi','23'),
                                 ('24','aut','24'),
                                 ('25','est','25'),
                                 ('26','tenetur','26'),
                                 ('27','rem','27'),
                                 ('28','mollitia','28'),
                                 ('29','error','29'),
                                 ('30','neque','30');


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
                                   `initiator_user_id` bigint(20) unsigned NOT NULL,
                                   `target_user_id` bigint(20) unsigned NOT NULL,
                                   `status` enum('requested','approved','unfriended','declined') COLLATE utf8_unicode_ci DEFAULT NULL,
                                   `requested_at` datetime DEFAULT current_timestamp(),
                                   `confirmed_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
                                   PRIMARY KEY (`initiator_user_id`,`target_user_id`),
                                   KEY `target_user_id` (`target_user_id`),
                                   CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
                                   CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `friend_requests` VALUES ('1','1','approved','2008-02-22 05:48:20','2009-01-29 22:09:47'),
                                     ('2','2','declined','1992-06-18 23:27:04','2007-01-19 23:45:25'),
                                     ('3','3','declined','1998-05-12 11:54:26','1992-08-08 00:49:11'),
                                     ('4','4','unfriended','1979-10-24 13:25:07','2009-02-24 19:09:34'),
                                     ('5','5','approved','1992-09-27 08:33:58','2011-02-10 02:16:27'),
                                     ('6','6','unfriended','1995-09-09 10:36:00','2003-05-16 02:16:24'),
                                     ('7','7','declined','1972-05-14 07:04:51','1980-10-30 14:45:36'),
                                     ('8','8','unfriended','1998-12-29 23:38:23','2014-02-03 03:27:54'),
                                     ('9','9','unfriended','1979-05-04 11:35:13','1971-04-16 09:17:34'),
                                     ('10','10','approved','1972-09-10 12:38:13','2009-10-21 01:58:34'),
                                     ('11','11','declined','1984-02-20 02:41:00','2017-04-25 16:12:10'),
                                     ('12','12','declined','1980-09-02 21:29:02','1981-07-23 17:41:32'),
                                     ('13','13','requested','2014-05-20 20:46:32','2019-02-17 08:12:57'),
                                     ('14','14','approved','2007-11-24 02:46:11','2018-09-15 09:11:50'),
                                     ('15','15','requested','2003-05-06 22:13:55','2003-07-06 05:12:46'),
                                     ('16','16','unfriended','2016-02-19 20:58:56','1972-06-28 19:07:18'),
                                     ('17','17','approved','2002-08-10 06:35:32','1976-11-16 11:46:18'),
                                     ('18','18','declined','1970-04-28 01:17:54','1983-11-03 17:46:26'),
                                     ('19','19','unfriended','1975-09-12 01:54:02','2005-04-21 04:00:10'),
                                     ('20','20','requested','1988-01-29 21:02:21','1982-06-18 00:19:41'),
                                     ('21','21','requested','1991-01-10 15:18:39','1975-02-22 11:56:57'),
                                     ('22','22','declined','2006-09-18 18:01:05','2009-04-05 11:08:35'),
                                     ('23','23','unfriended','1982-11-26 23:23:52','1980-06-07 06:05:17'),
                                     ('24','24','unfriended','1986-08-17 02:20:02','2019-07-19 17:27:02'),
                                     ('25','25','unfriended','1974-10-25 17:23:09','1971-12-06 23:27:38'),
                                     ('26','26','declined','2007-02-09 06:45:41','2010-08-07 14:39:18'),
                                     ('27','27','requested','1973-02-28 02:28:14','2015-03-05 08:53:07'),
                                     ('28','28','declined','1995-12-08 00:46:10','1994-06-28 14:42:27'),
                                     ('29','29','unfriended','2013-11-14 06:08:57','2001-05-29 00:09:34'),
                                     ('30','30','approved','2009-01-19 15:42:08','2014-01-17 17:02:41');


DROP TABLE IF EXISTS `goods_categories`;
CREATE TABLE `goods_categories` (
                                    `category_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                    `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                                    `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                    PRIMARY KEY (`category_id`),
                                    UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица категорий товаров';

INSERT INTO `goods_categories` VALUES ('1','enim','1994-06-18 13:55:19'),
                                      ('2','fugiat','1990-01-29 12:30:57'),
                                      ('3','blanditiis','2016-12-09 15:31:48'),
                                      ('4','asperiores','1992-12-16 18:30:51'),
                                      ('5','animi','1989-07-31 08:19:08'),
                                      ('6','fuga','1996-09-02 09:13:57'),
                                      ('7','quasi','1982-03-21 20:18:54'),
                                      ('8','non','1994-01-16 12:50:31'),
                                      ('9','consectetur','2013-03-14 15:28:40'),
                                      ('10','itaque','2014-08-25 22:09:26'),
                                      ('11','et','2004-12-27 17:21:40'),
                                      ('12','aperiam','1979-07-27 04:29:12'),
                                      ('13','libero','1993-09-17 21:22:28'),
                                      ('14','odit','1984-04-07 16:44:42'),
                                      ('15','quae','1973-04-11 15:59:36'),
                                      ('16','ut','2017-12-30 13:12:59'),
                                      ('17','nihil','1981-10-10 06:29:42'),
                                      ('18','mollitia','1998-11-13 16:18:44'),
                                      ('19','repellat','1977-12-28 16:15:36'),
                                      ('20','temporibus','1998-07-20 17:23:11'),
                                      ('21','possimus','1993-07-21 02:31:44'),
                                      ('22','officia','2013-03-28 06:44:43'),
                                      ('23','sed','2013-05-17 23:07:10'),
                                      ('24','amet','1977-12-22 08:56:15'),
                                      ('25','nostrum','1980-12-30 14:35:11'),
                                      ('26','eaque','1999-07-17 08:44:04'),
                                      ('27','optio','2006-04-30 20:54:56'),
                                      ('28','veritatis','1972-06-26 17:39:50'),
                                      ('29','maxime','1995-12-09 20:19:13'),
                                      ('30','quia','1980-09-19 18:07:13');


DROP TABLE IF EXISTS `goods_description`;
CREATE TABLE `goods_description` (
                                     `goods_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                     `goods_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                                     `goods_photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                                     `goods_description` text COLLATE utf8_unicode_ci DEFAULT NULL,
                                     `goods_price` decimal(10,2) DEFAULT NULL,
                                     `goods_category` bigint(20) unsigned NOT NULL,
                                     `user_posted_id` bigint(20) unsigned NOT NULL,
                                     PRIMARY KEY (`goods_id`),
                                     KEY `goods_category_idx` (`goods_category`),
                                     KEY `user_posted_id` (`user_posted_id`),
                                     CONSTRAINT `fk_goods_category` FOREIGN KEY (`goods_category`) REFERENCES `goods_categories` (`category_id`),
                                     CONSTRAINT `goods_description_ibfk_1` FOREIGN KEY (`user_posted_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с описанием товара';



DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
                         `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                         `user_id` bigint(20) unsigned NOT NULL,
                         `media_id` bigint(20) unsigned NOT NULL,
                         `created_at` datetime DEFAULT current_timestamp(),
                         UNIQUE KEY `id` (`id`),
                         KEY `user_id` (`user_id`),
                         KEY `media_id` (`media_id`),
                         CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
                         CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `likes` VALUES ('1','1','1','2002-04-18 23:27:36'),
                           ('2','2','2','1991-12-25 05:06:33'),
                           ('3','3','3','1976-10-27 14:04:21'),
                           ('4','4','4','1987-05-22 03:17:25'),
                           ('5','5','5','2003-12-09 20:58:08'),
                           ('6','6','6','2018-01-22 19:17:16'),
                           ('7','7','7','1976-08-04 02:50:14'),
                           ('8','8','8','1988-02-20 19:05:28'),
                           ('9','9','9','1977-03-07 04:44:35'),
                           ('10','10','10','1998-08-28 22:36:19'),
                           ('11','11','11','1988-07-24 02:06:33'),
                           ('12','12','12','2010-03-16 14:53:41'),
                           ('13','13','13','1980-05-25 16:07:34'),
                           ('14','14','14','1983-08-07 08:21:33'),
                           ('15','15','15','2006-03-16 19:31:24'),
                           ('16','16','16','1995-10-04 14:39:39'),
                           ('17','17','17','2018-01-29 15:09:15'),
                           ('18','18','18','1989-11-22 00:13:38'),
                           ('19','19','19','1972-05-07 12:06:42'),
                           ('20','20','20','1989-04-01 00:00:06'),
                           ('21','21','21','1979-07-30 05:09:35'),
                           ('22','22','22','1972-11-19 00:04:30'),
                           ('23','23','23','1996-06-21 22:15:03'),
                           ('24','24','24','2007-02-28 19:35:45'),
                           ('25','25','25','1998-06-09 21:05:16'),
                           ('26','26','26','1973-11-18 00:29:23'),
                           ('27','27','27','2014-03-06 10:47:06'),
                           ('28','28','28','1997-07-12 21:05:00'),
                           ('29','29','29','1989-02-20 23:39:57'),
                           ('30','30','30','2009-09-09 08:32:52');


DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
                         `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                         `media_type_id` bigint(20) unsigned NOT NULL,
                         `user_id` bigint(20) unsigned NOT NULL,
                         `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
                         `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                         `size` int(11) DEFAULT NULL,
                         `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
                         `created_at` datetime DEFAULT current_timestamp(),
                         `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
                         UNIQUE KEY `id` (`id`),
                         KEY `user_id` (`user_id`),
                         KEY `media_type_id` (`media_type_id`),
                         CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
                         CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media` VALUES ('1','1','1','Omnis sint et et itaque. Veniam quis unde sint velit omnis impedit. Unde ad officiis eum debitis et. Eum occaecati debitis ut iste ea assumenda repellat. Suscipit non blanditiis saepe maiores.','illum','329360939',NULL,'1983-02-05 14:55:45','2004-09-10 19:01:59'),
                           ('2','2','2','Ea quia harum ab nesciunt qui. Nobis nihil rerum iure voluptates magni autem. Et omnis fugiat ut iste tempore. Error ipsum ducimus quam quidem.','tenetur','83',NULL,'1984-09-03 08:55:22','1995-06-24 16:50:53'),
                           ('3','3','3','Magnam aut ut quae ea tempore rerum nesciunt. Suscipit ut quia optio aut. Consequatur quaerat molestiae at suscipit temporibus tempore assumenda in. Temporibus voluptatem cumque ut odio et et.','perspiciatis','0',NULL,'2016-10-02 11:03:18','2012-12-29 05:33:43'),
                           ('4','4','4','Dolor ipsam minus omnis fuga magni sint. Tempore aspernatur neque tempore nobis qui est. Itaque consequatur voluptatem et accusantium dignissimos tenetur sit. Quibusdam cum culpa expedita neque.','veniam','8765',NULL,'2006-05-18 20:15:43','2004-07-12 18:28:01'),
                           ('5','1','5','Repellendus totam voluptates est eos beatae. Exercitationem praesentium dolorum est dolorem sit. Nihil omnis dolor sed natus beatae aut.','est','18855377',NULL,'2010-12-15 18:02:26','2014-01-20 19:37:38'),
                           ('6','2','6','Natus sint placeat odio ducimus quod. Velit sit rem ad eligendi dolorem odio laboriosam. Quisquam maiores doloribus aspernatur excepturi quaerat. Ut autem dolor odit quod eligendi et.','autem','8393591',NULL,'2012-11-29 05:38:56','1982-12-24 16:26:34'),
                           ('7','3','7','Corrupti maiores est eligendi quo. Et quisquam nulla quia qui. Quia labore facilis quos aliquid.','consequuntur','665563963',NULL,'1989-05-17 23:34:20','2015-07-02 20:35:59'),
                           ('8','4','8','Sunt dolores autem praesentium ut aliquam voluptatibus. Soluta consequatur sunt saepe reprehenderit. Quaerat cum tempore sapiente aut perferendis. Ipsum tempore consequatur quis est excepturi.','ut','596795',NULL,'1976-02-06 22:29:51','1987-04-11 23:34:49'),
                           ('9','1','9','Eum non in sed et. Reprehenderit ea ab sequi voluptates consequuntur. Alias quidem ipsa temporibus doloremque repudiandae quo. Veritatis quia sint vel aperiam voluptas magni. Voluptatem dolor debitis aut dolorem.','voluptas','684376',NULL,'2015-10-05 18:14:56','2012-12-06 23:27:31'),
                           ('10','2','10','Dolorem omnis minima et laborum explicabo aut harum. Et molestiae ea rem aut. Aperiam consequuntur quam fugiat quasi distinctio. Non commodi adipisci reprehenderit et exercitationem.','voluptatibus','923333',NULL,'1980-09-29 11:02:47','2017-11-25 14:07:47'),
                           ('11','3','11','Et impedit nihil dolorum et qui. Vitae consequatur doloremque consectetur non repellendus quia harum. Molestiae fugit ut eligendi accusantium aut.','quisquam','2',NULL,'1976-02-13 11:00:08','1987-02-09 02:47:01'),
                           ('12','4','12','Quia molestias possimus consequuntur et nesciunt. Rem neque molestiae quaerat iusto. Placeat quibusdam optio sunt.','autem','9',NULL,'1974-07-17 22:06:44','1987-08-15 04:27:43'),
                           ('13','1','13','Non omnis nobis tempore occaecati aut doloribus similique. Molestias illum error atque modi recusandae consequatur. Assumenda eos dolores est perferendis asperiores ad qui.','libero','560',NULL,'2018-12-17 19:46:41','1980-09-01 00:51:37'),
                           ('14','2','14','Reprehenderit quas consequatur culpa ducimus et sit. Aperiam qui aut accusamus eos necessitatibus illo molestiae. Dolorum mollitia ut aut reprehenderit veritatis quaerat. Qui voluptas voluptas hic tempora consequuntur.','cupiditate','2677090',NULL,'2002-03-12 05:10:12','1970-10-11 00:47:57'),
                           ('15','3','15','Quia officia debitis omnis quia ut. Et perspiciatis rem fugit et ea inventore. Adipisci laborum dolore ut.','aperiam','657',NULL,'1990-09-03 15:10:46','2014-05-16 12:18:42'),
                           ('16','4','16','Quo temporibus quia molestias. Facere minima quo est dolorem et ea.','accusamus','3',NULL,'2008-01-24 13:31:23','1999-02-19 23:58:12'),
                           ('17','1','17','Et voluptatem voluptas et ipsa. Eveniet qui voluptatem commodi. Qui dolorem maxime dolorem quia cupiditate.','id','907561',NULL,'1981-09-16 14:47:25','1997-07-27 21:33:42'),
                           ('18','2','18','Natus eum rerum aliquam laboriosam iusto. Sunt hic libero eos molestiae. Optio ab aliquid nisi ipsa odio.','nobis','232',NULL,'2012-10-20 14:24:39','2012-10-06 05:43:51'),
                           ('19','3','19','A qui commodi vitae illo ut qui. Aut et expedita non facere tempora veniam necessitatibus esse. Provident possimus nostrum assumenda.','quia','43503',NULL,'1986-10-29 06:57:35','1985-12-30 08:57:56'),
                           ('20','4','20','Et quaerat non vero beatae. Blanditiis reprehenderit earum ut fugit est. Veritatis dolorem alias eum ipsam. Repellat voluptatum asperiores totam.','aliquid','7109',NULL,'1983-06-05 21:11:12','1971-11-08 21:59:52'),
                           ('21','1','21','Et nostrum quasi maiores quaerat. Dolore unde est cumque voluptatem. Voluptas pariatur est animi voluptatem. Enim ea eum in in est qui.','incidunt','285451707',NULL,'2009-09-04 13:02:09','1984-04-23 09:45:21'),
                           ('22','2','22','Excepturi tenetur ipsa deserunt natus perferendis ut. Dolorum distinctio voluptate ut repellendus. Ad incidunt maxime est necessitatibus est consequatur. Consectetur sed cumque veniam voluptate rerum ad quia.','et','303741162',NULL,'1975-12-05 08:43:45','1970-03-03 06:56:09'),
                           ('23','3','23','Molestiae tenetur nostrum corporis asperiores eaque nisi. Impedit et ipsum nihil ipsa quidem sit. Laborum non consequatur dolore ullam natus animi.','voluptatem','6450955',NULL,'2009-10-19 04:56:55','1977-01-15 09:20:37'),
                           ('24','4','24','Voluptatem vitae iste necessitatibus vel odio. Vel aperiam quia suscipit fuga ea voluptatibus. Et quisquam aut dolorem.','qui','272717771',NULL,'1999-04-20 18:57:43','1979-10-30 09:42:24'),
                           ('25','1','25','Est velit aut quam dolores deserunt et. Et nemo temporibus in hic voluptatem impedit. Consectetur ut nobis cumque dolores temporibus. Provident maxime et ab quam.','debitis','48',NULL,'2016-12-15 19:30:30','2011-07-25 18:31:28'),
                           ('26','2','26','Assumenda et blanditiis odio est. Vitae repellendus alias ea perferendis eum. Nisi impedit quidem suscipit. Eveniet totam atque cumque velit nostrum.','qui','905045',NULL,'1998-04-04 16:45:21','1972-02-02 08:46:36'),
                           ('27','3','27','Sunt culpa praesentium architecto facere rerum eum similique. Esse voluptatem beatae est eos provident nam voluptatem.','ratione','23',NULL,'2003-08-01 03:17:53','1998-10-12 12:30:32'),
                           ('28','4','28','Molestias qui nemo recusandae et provident. Pariatur id dolorem minus.','et','297',NULL,'2004-11-24 19:28:47','1974-04-02 16:00:14'),
                           ('29','1','29','Enim quis et laborum itaque ut omnis perferendis id. Occaecati et ullam perferendis ratione. Maiores est est incidunt.','voluptates','84',NULL,'2008-07-02 15:33:36','2020-02-18 17:08:52'),
                           ('30','2','30','Sed possimus aut non. Veritatis atque iure reprehenderit magni sit. Odio laudantium sunt autem voluptas deserunt. Aut aut sed qui.','ut','326',NULL,'1999-11-21 12:10:44','2012-05-11 23:37:49');


DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
                               `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                               `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                               `created_at` datetime DEFAULT current_timestamp(),
                               `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
                               UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `media_types` VALUES ('1','sint','2011-08-10 01:09:17','1973-08-15 00:55:47'),
                                 ('2','illum','2019-02-03 01:10:01','2015-07-02 02:00:28'),
                                 ('3','ratione','1989-09-01 04:03:45','1995-06-08 22:43:28'),
                                 ('4','numquam','1989-12-03 01:48:58','1993-02-15 00:24:59');


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
                            `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                            `from_user_id` bigint(20) unsigned NOT NULL,
                            `to_user_id` bigint(20) unsigned NOT NULL,
                            `body` text COLLATE utf8_unicode_ci DEFAULT NULL,
                            `created_at` datetime DEFAULT current_timestamp(),
                            UNIQUE KEY `id` (`id`),
                            KEY `from_user_id` (`from_user_id`),
                            KEY `to_user_id` (`to_user_id`),
                            CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
                            CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `messages` VALUES ('1','1','1','Impedit totam pariatur beatae quos magni ducimus repellendus sunt. Quidem qui nam optio repudiandae omnis. Modi explicabo illum dolores voluptate. Aut accusamus molestias ea quia praesentium pariatur rem. Atque vero provident corrupti dolores fugiat quos.','1987-06-21 12:07:54'),
                              ('2','2','2','Voluptatibus dignissimos iusto ut excepturi quibusdam libero inventore. Iusto dolore et nisi dicta nam qui. Voluptas facere in eaque.','2010-08-10 17:12:05'),
                              ('3','3','3','Libero expedita beatae maiores consequuntur. Quia fugit non sit distinctio ullam placeat. Eum voluptatem nobis nisi commodi. Qui nihil odio ipsa necessitatibus consequuntur ea.','1976-10-20 07:02:39'),
                              ('4','4','4','Libero architecto distinctio quibusdam occaecati et modi. Similique cumque eveniet sunt fuga. Eos sed consequuntur est sit sit aut qui. Aut sunt laborum qui pariatur similique. Incidunt voluptatem rem et voluptas sapiente voluptas sit.','1983-01-13 07:01:44'),
                              ('5','5','5','Quos tempore quia suscipit occaecati. Doloremque deleniti perspiciatis ipsam voluptatum officia odio debitis laborum. Fuga voluptatem qui soluta exercitationem. Voluptates id quasi ut.','2000-06-18 19:33:37'),
                              ('6','6','6','Culpa totam vel temporibus officiis non sapiente. Excepturi qui illo qui alias consequatur accusamus. Modi dolores et hic quia ipsam quaerat. Voluptate explicabo ut et minus doloremque.','1978-02-18 22:34:39'),
                              ('7','7','7','Error velit nostrum laborum suscipit. A odio ratione tempora tenetur aliquam magni. Omnis eligendi placeat nobis similique ab. Ipsum vel voluptate blanditiis dolor qui.','2013-02-22 21:46:05'),
                              ('8','8','8','Perferendis debitis id ducimus. Adipisci excepturi voluptas sint sequi tenetur dolorum. Voluptas voluptates ipsum ullam rerum quae laudantium.','1988-10-01 06:32:53'),
                              ('9','9','9','Soluta eum tenetur voluptatem quaerat incidunt qui quibusdam placeat. Voluptatum delectus asperiores cumque deserunt voluptas. Rem repellat alias eligendi itaque ab eius. Quia eveniet debitis repudiandae ut dolores autem molestias.','1976-11-04 18:33:00'),
                              ('10','10','10','Ipsam dolorum rerum qui amet necessitatibus. Neque et illum quia magnam. Doloremque expedita maxime deleniti. Aliquam necessitatibus eius minus ut.','2020-04-13 10:45:59'),
                              ('11','11','11','Dolorem quod et et dolore. Amet accusamus eius sint et ad et. Eos expedita sit illum qui et.','1992-02-22 08:21:54'),
                              ('12','12','12','Voluptatem earum rerum asperiores aut voluptatem est. Ut optio velit magni veniam provident aut. Quidem voluptate eaque nesciunt.','2008-09-01 13:01:52'),
                              ('13','13','13','Quisquam dolorem et debitis harum facilis. Soluta molestias ut minima. Qui voluptatem rerum ab ad. Qui numquam magni cumque placeat ut. Commodi maiores ut similique enim natus.','2003-05-17 02:58:01'),
                              ('14','14','14','Aut vero ipsa ducimus ut. Velit hic et quia distinctio odio laborum dolorem. Repellendus aliquam magni eum voluptatem molestiae qui.','2012-11-20 15:12:28'),
                              ('15','15','15','Voluptas pariatur nisi ipsum voluptas voluptatem. Odio quis animi odit. Architecto facilis quod est numquam laborum debitis.','2018-01-21 00:10:16'),
                              ('16','16','16','Voluptas assumenda eos exercitationem autem. Autem vel vitae sapiente voluptatem. Sit ut rerum a maxime dolorum vitae.','2009-05-09 05:47:22'),
                              ('17','17','17','Earum aliquid totam impedit occaecati. Debitis aspernatur repellendus sapiente corrupti non et at. Consequuntur autem esse ullam dolorem maiores quis.','1992-02-20 23:25:22'),
                              ('18','18','18','Et sit temporibus commodi beatae aut enim est. Hic maiores accusantium dolores mollitia quia quasi. Et eos placeat omnis et atque alias tenetur eum. Dolorem voluptatum aliquid esse maxime a alias earum.','1971-06-24 23:04:41'),
                              ('19','19','19','Ea accusantium pariatur beatae sequi illo distinctio. Optio quia architecto dolore eum consequuntur eius qui. Excepturi atque voluptates ut quia.','1971-12-02 02:42:14'),
                              ('20','20','20','Possimus voluptate fugiat neque quas ut sunt libero. Harum iusto tempore dolore eaque autem qui. Aut non quis voluptatem aut. Perferendis ratione sit nesciunt dolores quos.','2014-12-23 20:20:08'),
                              ('21','21','21','Laudantium sequi dolorum ratione illo. Nobis hic deleniti laudantium sunt consequatur sequi nam. Quis dolor voluptas eligendi vel eos consectetur. Nesciunt amet sequi nihil ut et.','1994-03-25 02:10:34'),
                              ('22','22','22','Quos in dolor ipsam explicabo alias. Minima sed quisquam rerum et id. Laborum non quaerat enim delectus ab.','1997-10-25 09:30:54'),
                              ('23','23','23','Tenetur ut est explicabo impedit commodi consequatur dolor repellendus. Reprehenderit et sint vero non. Amet in odit autem maxime.','1988-04-13 23:23:59'),
                              ('24','24','24','Sunt doloribus consequatur suscipit deserunt aperiam voluptatem et. Qui dignissimos at sed mollitia veniam animi occaecati. Dolorem adipisci sequi consequatur vel pariatur est nesciunt qui.','1972-06-24 12:25:26'),
                              ('25','25','25','Reiciendis voluptatem autem commodi occaecati numquam. Natus cumque accusamus repellat itaque dolores cumque ex. Expedita ea ipsum accusantium qui. Nisi et fuga ut adipisci quam eos dicta minus. Debitis libero perspiciatis id vitae necessitatibus.','1993-02-21 17:51:07'),
                              ('26','26','26','Omnis veritatis aliquid perferendis eius fuga. Vel eum labore et aut aut quia. Molestiae natus debitis esse dolore harum blanditiis tenetur. Ut in unde possimus dolore odit tempore. Architecto consectetur repellendus id dolor error qui.','2015-04-02 12:28:09'),
                              ('27','27','27','Laboriosam enim recusandae voluptatum. Reprehenderit consequuntur illum ad sunt minima saepe et quisquam. Laborum libero iusto temporibus qui est veniam omnis voluptates.','1994-01-16 15:16:49'),
                              ('28','28','28','Libero ipsum odit est dignissimos. Dolorem atque libero laborum reprehenderit reiciendis nemo aut repudiandae. Aut et dolores qui nesciunt non iure sed. Aut vel eveniet nostrum omnis.','1971-12-23 06:51:48'),
                              ('29','29','29','Qui nobis architecto a omnis laborum eaque doloremque dolores. Autem nesciunt architecto molestias. Alias et ullam rerum.','2010-10-13 14:17:57'),
                              ('30','30','30','Autem quo iure sit illum dolores quibusdam. Adipisci nobis ut repellendus quidem qui eius. Eveniet deserunt repellat cum officia enim nesciunt totam. Voluptatem voluptatem non ducimus amet.','1980-03-08 01:56:13');


DROP TABLE IF EXISTS `online_status`;
CREATE TABLE `online_status` (
                                 `active_user_id` bigint(20) unsigned NOT NULL,
                                 `status_online_user` enum('Online','MobileOnline','Ofline') COLLATE utf8_unicode_ci DEFAULT NULL,
                                 `update_time` datetime DEFAULT NULL ON UPDATE current_timestamp(),
                                 KEY `active_user_id` (`active_user_id`),
                                 KEY `status_online_user` (`status_online_user`),
                                 KEY `update_time` (`update_time`),
                                 CONSTRAINT `online_status_ibfk_1` FOREIGN KEY (`active_user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='таблица активности пользователя';

INSERT INTO `online_status` VALUES ('1','Online','1983-03-13 03:51:49'),
                                   ('2','MobileOnline','1984-12-16 16:45:03'),
                                   ('3','Ofline','1978-08-21 16:08:09'),
                                   ('4','Online','2000-10-07 04:14:16'),
                                   ('5','MobileOnline','2006-11-26 17:28:35'),
                                   ('6','Ofline','1987-08-07 09:45:01'),
                                   ('7','Ofline','1990-12-08 21:17:01'),
                                   ('8','Ofline','1970-07-22 15:14:17'),
                                   ('9','MobileOnline','1974-06-12 10:53:34'),
                                   ('10','MobileOnline','2016-10-13 12:57:12'),
                                   ('11','Ofline','1983-03-19 21:18:50'),
                                   ('12','Ofline','1985-03-28 08:35:18'),
                                   ('13','MobileOnline','1993-09-04 18:24:21'),
                                   ('14','Online','2010-03-14 01:36:46'),
                                   ('15','Online','1972-05-16 20:30:11'),
                                   ('16','Ofline','2018-01-31 13:19:32'),
                                   ('17','Online','1996-08-14 18:18:53'),
                                   ('18','Online','1992-05-16 07:22:20'),
                                   ('19','Ofline','2018-04-26 00:06:19'),
                                   ('20','MobileOnline','1987-06-23 15:55:06'),
                                   ('21','Online','1985-03-24 10:59:21'),
                                   ('22','MobileOnline','1984-06-24 12:57:31'),
                                   ('23','Online','2012-08-24 11:26:44'),
                                   ('24','Online','1997-10-21 09:06:52'),
                                   ('25','Ofline','1992-06-07 23:16:03'),
                                   ('26','Online','2012-12-31 15:33:56'),
                                   ('27','Ofline','2005-04-06 09:06:15'),
                                   ('28','MobileOnline','1976-08-24 10:11:12'),
                                   ('29','Ofline','1970-03-31 11:03:56'),
                                   ('30','Online','1982-03-27 20:53:58');


DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
                           `user_id` bigint(20) unsigned NOT NULL,
                           `gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                           `hometown` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
                           `created_at` datetime DEFAULT current_timestamp(),
                           `birthday` DATE,
                           PRIMARY KEY (`user_id`),
                           CONSTRAINT `fk_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `profile` (user_id, gender, hometown, birthday) VALUES ('1','m','Pariatur amet sunt excepturi tempore.','1976-04-23'),
                                                                   ('2','f','Voluptatem quaerat placeat nemo nostrum.','1996-03-14'),
                                                                   ('3','f','Ut cupiditate ab in eius quo.','1982-08-10'),
                                                                   ('4','f','Quis molestiae et et laudantium ipsum vel corrupti.','1983-06-05'),
                                                                   ('5','f','Quos dolor quod voluptas voluptas voluptatem pariatur eos.','1994-08-15'),
                                                                   ('6','m','In fuga corporis aperiam tempore.','2017-12-05'),
                                                                   ('7','f','Non totam harum illum nisi necessitatibus incidunt.','1976-03-16'),
                                                                   ('8','m','Ipsa porro est consequatur consequatur saepe.','2006-11-13'),
                                                                   ('9','m','Quidem quam dignissimos amet suscipit et.','1971-06-09'),
                                                                   ('10','m','Voluptatem omnis nostrum nihil itaque modi.','2020-03-28'),
                                                                   ('11','m','Maxime voluptatum enim qui tempora.','1977-07-04'),
                                                                   ('12','m','Nobis ut assumenda esse autem.','1993-04-16'),
                                                                   ('13','m','Consectetur necessitatibus qui nihil distinctio nesciunt doloremque minima.','1991-04-07'),
                                                                   ('14','f','Nemo expedita consequuntur provident.','1998-10-16'),
                                                                   ('15','m','Doloribus doloremque voluptas hic ut quia impedit.','1996-06-27'),
                                                                   ('16','f','Aperiam quas vel neque.','1981-09-27'),
                                                                   ('17','m','Quo omnis quod omnis consequatur.','1996-03-28'),
                                                                   ('18','f','Voluptates placeat odit aperiam.','1995-11-11'),
                                                                   ('19','f','Consequatur fuga quia hic.','1999-03-05');


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
                         `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                         `firstname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
                         `lastname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
                         `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
                         `phone` bigint(20) unsigned DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `email` (`email`),
                         UNIQUE KEY `phone` (`phone`),
                         KEY `idx_user_name` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='юзеры';

INSERT INTO `users` VALUES ('1','Elenora','Altenwerth','kirlin.dayton@example.net','82236250345'),
                           ('2','Hallie','Fisher','chelsie91@example.org','83779249410'),
                           ('3','Loyce','Huel','mconnelly@example.net','84898176463'),
                           ('4','Floy','Heaney','giovanna.hettinger@example.com','82641857550'),
                           ('5','Joseph','Wisozk','bednar.nya@example.com','83051154455'),
                           ('6','Cassandre','Larkin','jakayla.nienow@example.net','83977361065'),
                           ('7','Magnus','Parisian','jbashirian@example.net','88207509149'),
                           ('8','Reggie','Haag','nlindgren@example.com','89827258344'),
                           ('9','Mavis','DuBuque','myrna.ryan@example.com','86292616366'),
                           ('10','Reanna','McKenzie','antonina95@example.org','87719167745'),
                           ('11','Brown','Kunde','hbernhard@example.com','81838754820'),
                           ('12','Blake','Flatley','leonor.miller@example.net','80218789619'),
                           ('13','Haylie','Jast','marian.bergstrom@example.com','87567972391'),
                           ('14','Carlie','Walsh','sweissnat@example.org','84551400644'),
                           ('15','Hobart','Wehner','garland.homenick@example.net','80126224453'),
                           ('16','Elfrieda','Goodwin','abernathy.sabryna@example.org','83467185450'),
                           ('17','Maymie','Erdman','remington29@example.org','88263778621'),
                           ('18','Alvah','Hirthe','rtillman@example.com','83199035204'),
                           ('19','Isabelle','Pouros','kiera93@example.net','87318771826'),
                           ('20','Willie','Grady','kwilkinson@example.org','87863757465'),
                           ('21','Evalyn','Emard','qdubuque@example.net','89643893879'),
                           ('22','Rosetta','Jacobson','hobart.wintheiser@example.net','82979337116'),
                           ('23','Quinten','Lubowitz','wbrekke@example.org','86917808065'),
                           ('24','Jany','Ortiz','keebler.donnell@example.net','84283564626'),
                           ('25','Eliza','Haley','hahn.erika@example.org','88295862041'),
                           ('26','Joaquin','Crooks','twiegand@example.com','82407956859'),
                           ('27','Gladyce','Botsford','jweber@example.org','87027711281'),
                           ('28','Marianne','Erdman','charley.collier@example.net','86550224614'),
                           ('29','Adolph','Koch','justice.ziemann@example.org','89032813343'),
                           ('30','Modesta','Swaniawski','bspinka@example.org','84173306338');


DROP TABLE IF EXISTS `users_apps`;
CREATE TABLE `users_apps` (
                              `user_id` bigint(20) unsigned NOT NULL,
                              `apps_id` bigint(20) unsigned NOT NULL,
                              PRIMARY KEY (`user_id`,`apps_id`),
                              KEY `apps_id` (`apps_id`),
                              CONSTRAINT `users_apps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
                              CONSTRAINT `users_apps_ibfk_2` FOREIGN KEY (`apps_id`) REFERENCES `apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_apps` VALUES ('1','1'),
                                ('2','2'),
                                ('3','3'),
                                ('4','4'),
                                ('5','5'),
                                ('6','6'),
                                ('7','7'),
                                ('8','8'),
                                ('9','9'),
                                ('10','10'),
                                ('11','11'),
                                ('12','12'),
                                ('13','13'),
                                ('14','14'),
                                ('15','15'),
                                ('16','16'),
                                ('17','17'),
                                ('18','18'),
                                ('19','19'),
                                ('20','20'),
                                ('21','21'),
                                ('22','22'),
                                ('23','23'),
                                ('24','24'),
                                ('25','25'),
                                ('26','26'),
                                ('27','27'),
                                ('28','28'),
                                ('29','29'),
                                ('30','30');


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
                                     `user_id` bigint(20) unsigned NOT NULL,
                                     `community_id` bigint(20) unsigned NOT NULL,
                                     PRIMARY KEY (`user_id`,`community_id`),
                                     KEY `community_id` (`community_id`),
                                     CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
                                     CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_communities` VALUES ('1','1'),
                                       ('2','2'),
                                       ('3','3'),
                                       ('4','4'),
                                       ('5','5'),
                                       ('6','6'),
                                       ('7','7'),
                                       ('8','8'),
                                       ('9','9'),
                                       ('10','10'),
                                       ('11','11'),
                                       ('12','12'),
                                       ('13','13'),
                                       ('14','14'),
                                       ('15','15'),
                                       ('16','16'),
                                       ('17','17'),
                                       ('18','18'),
                                       ('19','19'),
                                       ('20','20'),
                                       ('21','21'),
                                       ('22','22'),
                                       ('23','23'),
                                       ('24','24'),
                                       ('25','25'),
                                       ('26','26'),
                                       ('27','27'),
                                       ('28','28'),
                                       ('29','29'),
                                       ('30','30');


INSERT INTO `goods_description` (`goods_name`, `goods_photo`, `goods_description`, `goods_price`, `goods_category`, `user_posted_id`)
VALUES
('phone','phone.jpg','Lorem10', 200.99, 1, 11),
('laptop','laptop.jpg','Lorem10', 200.99, 12, 28),
('pc','pc.jpg','Lorem10', 200.99, 13, 22),
('book','book.jpg','Lorem10', 200.99, 21, 19),
('table','table.jpg','Lorem10', 200.99, 11, 15),
('apple','apple.jpg','Lorem10', 200.99, 6, 13),
('watch','watch.jpg','Lorem10', 200.99, 8, 16),
('iphone','iphone.jpg','Lorem10', 200.99, 9, 5),
('ipad','ipad.jpg','Lorem10', 200.99, 19, 9),
('macbook','macbook.jpg','Lorem10', 200.99, 25, 6),
('macbookPro','macbookPro.jpg','Lorem10', 2200.99, 5, 7);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
