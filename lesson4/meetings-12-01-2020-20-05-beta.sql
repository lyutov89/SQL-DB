-- Generation time: Sun, 12 Jan 2020 20:05:25 +0000
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
USE vk;
DROP TABLE IF EXISTS `meetings`;
CREATE TABLE `meetings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `meetings` VALUES ('1','quas','2005-09-14 09:41:27'),
('2','vitae','2015-12-21 19:17:42'),
('3','tenetur','2013-03-10 22:22:20'),
('4','qui','1979-08-20 22:23:08'),
('5','sequi','2011-07-20 12:08:52'),
('6','ex','1988-02-14 04:55:23'),
('7','eaque','2018-08-11 04:59:18'),
('8','dolorem','2003-09-24 05:46:30'),
('9','alias','2004-06-02 10:17:25'),
('10','rerum','2002-06-18 10:04:42'),
('11','fugit','1987-10-14 03:21:02'),
('12','nobis','2014-03-30 04:20:52'),
('13','sed','2018-11-24 06:55:56'),
('14','voluptatem','2010-05-12 11:31:52'),
('15','et','2016-11-27 02:35:59'),
('16','perferendis','2000-04-21 06:40:13'),
('17','autem','1970-12-05 03:16:53'),
('18','perspiciatis','1978-01-20 05:54:27'),
('19','est','2004-02-07 00:01:36'),
('20','necessitatibus','1995-08-05 09:13:30'),
('21','omnis','2005-02-13 21:29:31'),
('22','sunt','1988-04-03 03:50:01'),
('23','natus','2008-11-25 23:37:55'),
('24','error','1971-05-28 10:00:31'),
('25','eum','2008-04-26 18:30:38'),
('26','voluptas','2012-09-01 08:00:30'),
('27','in','1985-04-18 23:44:05'),
('28','dolor','1997-12-06 12:29:36'),
('29','consequatur','1979-07-30 22:10:16'),
('30','harum','1974-02-14 17:41:59'),
('31','assumenda','2013-05-16 13:49:34'),
('32','beatae','1998-02-28 03:10:05'),
('33','aspernatur','1992-04-14 16:40:12'),
('34','pariatur','1987-12-19 01:58:15'),
('35','culpa','1997-07-10 01:49:37'),
('36','neque','1973-07-16 18:33:29'),
('37','dolores','1979-05-29 04:26:32'),
('38','nihil','1978-01-06 21:58:13'),
('39','iure','1981-04-03 18:20:19'),
('40','cupiditate','2008-05-15 15:24:04'),
('41','a','1984-10-20 10:41:07'),
('42','ut','1995-11-20 01:39:22'),
('43','quia','2014-12-04 15:53:20'),
('44','praesentium','1987-09-22 13:41:36'),
('45','consequuntur','1987-10-19 18:07:52'),
('46','aut','2019-10-06 14:04:44'),
('47','id','1984-10-23 14:23:33'),
('48','impedit','1981-04-08 23:22:50'),
('49','saepe','1985-01-25 23:10:53'),
('50','dolore','1986-04-27 14:23:17'),
('51','deleniti','2000-03-03 00:07:54'),
('52','porro','2019-06-05 11:03:19'),
('53','blanditiis','1988-05-27 21:22:31'),
('54','reprehenderit','2010-04-28 16:05:09'),
('55','soluta','1979-02-10 10:56:29'),
('56','excepturi','1999-02-13 02:58:44'),
('57','dignissimos','1978-12-31 15:21:36'),
('58','accusamus','1970-08-05 11:56:17'),
('59','molestiae','2001-05-29 09:20:14'),
('60','sit','2018-02-25 20:42:18'),
('61','quo','1978-06-19 13:00:46'),
('62','occaecati','1995-10-23 15:00:03'),
('63','corrupti','1990-09-23 13:57:16'),
('64','sint','1982-11-10 15:49:32'),
('65','voluptates','1977-10-14 05:13:50'),
('66','molestias','2011-04-09 08:36:38'),
('67','eveniet','1974-02-17 13:22:36'),
('68','doloremque','1974-01-24 14:37:11'),
('69','delectus','1988-01-30 04:48:31'),
('70','non','1991-08-12 19:40:51'),
('71','nisi','1986-11-01 09:56:36'),
('72','doloribus','2011-02-15 07:19:45'),
('73','eius','1991-10-16 21:11:25'),
('74','minus','1972-09-24 02:28:59'),
('75','vero','1978-06-26 21:05:08'),
('76','ad','2010-09-20 14:44:41'),
('77','fugiat','1974-04-12 17:19:30'),
('78','temporibus','1986-02-26 15:13:28'),
('79','officia','1971-09-01 11:53:15'),
('80','deserunt','1986-05-22 04:04:45'),
('81','provident','1986-10-02 17:33:19'),
('82','laudantium','1987-11-15 11:22:03'),
('83','reiciendis','1995-11-09 11:43:26'),
('84','ea','2004-08-17 02:04:01'),
('85','mollitia','1970-01-16 18:25:34'),
('86','illo','2012-08-06 17:26:15'),
('87','velit','1983-09-05 00:49:44'),
('88','maiores','1989-07-30 09:02:48'),
('89','quae','1998-11-25 01:33:47'),
('90','possimus','1989-01-10 07:24:23'),
('91','aliquid','1979-02-10 10:04:05'),
('92','exercitationem','2013-06-28 00:54:21'),
('93','vel','1974-06-07 05:48:40'),
('94','ullam','2019-03-10 15:43:43'),
('95','quisquam','1995-05-25 16:39:35'),
('96','dolorum','1989-11-09 00:32:23'),
('97','quasi','1999-04-29 19:23:44'),
('98','nulla','1975-05-29 09:19:50'),
('99','nesciunt','1994-03-16 17:12:14'),
('100','illum','1983-11-22 04:53:17'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

