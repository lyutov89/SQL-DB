
- �������� �� ��� ���������� ���� ���������
https://vk.com/geekbrainsru

-- ������� ��
CREATE DATABASE vk;

-- ������ �� �������
USE vk;

-- ������� ������� �������������
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DESCRIBE users;

-- ������� ��������
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100),
  photo_id INT UNSIGNED NOT NULL
);

-- ������� ���������
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);

-- ������� ������
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);

-- ������� �������� ��������� ���������
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


-- ������� �����
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- ������� �����������
CREATE TABLE meetings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  scheduled_at DATETIME 
);

-- ������� ����� ������������� � �����
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);

-- ������� �����������
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ������� ����� ����������� 
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- ������� ������
DROP TABLE posts;
CREATE TABLE posts (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    header VARCHAR (255),
    body TEXT NOT NULL,
    media_types INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DESC posts;

-- ������� ������

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');
 
 INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

 SELECT * FROM target_types tt; 
-- Проверим
SELECT * FROM likes LIMIT 100;


CREATE TABLE meetings_users (
  meeting_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`meeting_id`)
); 

-- Заполняем
INSERT INTO meetings_users 
  SELECT 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    CURRENT_TIMESTAMP 
  FROM posts;
 
 
   
   -- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем 

-- Сначала ищем тех, кто писал выбранному другу сообщения
-- Для начала добавим нашему пользователю побольше друзей. Поменяем с помощью UPDATE нашу БД. 100 пользователей - очень мало, 
-- чтобы найти пересечения в рандомном заполнении. 
-- Зададим пользователея с user_id = 92. Ему было написано аж 4 сообщения. Изменим адресатов на друзей, 
-- как критерий - само сообщение (скопировал в update) и от кого было отправлено. Тоже самое и по дружбе. 

UPDATE messages
SET from_user_id = 74
WHERE to_user_id = 92
AND body = 'Aperiam aut reprehenderit error enim pariatur blanditiis. Distinctio voluptatem consequuntur aperiam ea unde accusamus voluptas et. Id deleniti pariatur et labore quas beatae ut.'; 

UPDATE messages
SET from_user_id = 11
WHERE to_user_id = 92
AND body = 'Doloremque dignissimos quis quia saepe quia sint qui alias. Est architecto voluptas tempore placeat culpa. Laboriosam et pariatur minus tempore alias eum.'

UPDATE friendship
SET friend_id = 11
WHERE user_id = 92; 

UPDATE friendship
SET friend_id = 11
WHERE user_id = 92; 

-- мы добились того, что пользователь 11 отправлял пользователю 92 целых 2 сообщения. 

(SELECT friend_id FROM friendship WHERE user_id = 92)
UNION
(SELECT user_id FROM friendship WHERE friend_id = 92);

-- выбираем сообщения от пользователя к пользователю
SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE from_user_id = 92
      OR to_user_id = 92
    ORDER BY created_at DESC;
   
 -- меняем OR на AND и ставим критерий взаимной дружбы! 

SELECT from_user_id, to_user_id, body, is_delivered, created_at 
  FROM messages
    WHERE to_user_id = 92
      AND from_user_id IN (
      (SELECT friend_id FROM friendship WHERE user_id = 92)
       UNION
      (SELECT user_id FROM friendship WHERE friend_id = 92)
       )
    ORDER BY created_at DESC;
   
 -- Добавляем подзапрос с именем и фамилией друга 11 и 74, ставим счетчик count, уходим от created_at, ставим all_messages в сортировку
 -- Группируем по друзьям! 
 
   SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend, 
   	COUNT(*) AS all_messages
   	FROM messages
    WHERE to_user_id = 92
      AND from_user_id IN (
      (SELECT friend_id FROM friendship WHERE user_id = 92)
       UNION
      (SELECT user_id FROM friendship WHERE friend_id = 92)
       )
    GROUP BY friend
    ORDER BY all_messages DESC
    LIMIT 1;
   
-- 3. 10 пользователей, которые получили больше всех лайков 
   
    -- Больше всех лайков: 
  
  SELECT target_id, COUNT(*) AS likes_id FROM likes l2
  WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users') 
  GROUP BY target_id
  ORDER BY likes_id DESC
  LIMIT 10; 
 
-- 10 самых молодых пользователей: 

   SELECT user_id, birthday, 
   TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age FROM profiles p2
   ORDER BY age ASC LIMIT 10; 
  
-- Поле age убираем, преобразуем к более простому виду:

   SELECT user_id, birthday FROM profiles p2
   ORDER BY birthday DESC LIMIT 10; 
  
  -- Как найти всех самых молодых, у которых больше всего лайков? Как объединить 10 самый молодых и 10 самых лайкнутых?
  -- Долго не получалось, получал ошибку. В итоге сдался и посмотрел в видео тот "чит-код", который приводит к решению 
  -- путем замены target id на выбранный псевдоним Alias (AS) 
  
  -- Получаем итоговый запрос: 
  
  SELECT target_id, COUNT(*) AS likes_id FROM likes l2
  WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users') 
  AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) 
         AS person_sort_by_birthday_young)
  GROUP BY target_id; 
  
 -- Мы видим, что пересечение дало только один результат, спасибо Вам за подаренный чит-код. Он был вымучен, долго
 -- над ним думал, теперь надолго запомню! 
 
 -- Можно, конечно, дальше посчитать сумму лайков от всех пользователей формально. Но он у нас вышел один. Пришлось убрать 
 -- target_id и сортировку по user_id, которая была до этого.  

 SELECT SUM(likes_on_user) AS likes_sum FROM (
  SELECT COUNT(*) AS likes_on_user FROM likes l2
  WHERE target_type_id = (SELECT id FROM target_types WHERE name = 'users') 
  AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) 
         AS person_sort_by_birthday_young)
  GROUP BY target_id)
  AS counted_likes; 
 

-- 4. Кто больше поставил лайков F or M? Здесь ок!

SELECT CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex, 
    COUNT(*) FROM (SELECT user_id as user, 
         (SELECT sex FROM profiles WHERE user_id = user) as sex FROM likes l2 ) dummy_table
GROUP BY sex 
ORDER BY COUNT(*) DESC LIMIT 1; 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.


-- будем делать выборку по друзьям и статусу дружбы, сообщениям и кол-ву лайков. 
-- для начала посмотрим структуру: 

DESC users; 
DESC friendship; 
DESC messages; 
DESC likes; 
SELECT * FROM friendship_statuses fs; 

-- корневая таблица здесь - users. Из нее делаем выборку. 

SELECT id, CONCAT (first_name, ' ', last_name) AS user, 
     (SELECT COUNT(*) FROM messages m2 WHERE m2.from_user_id = u2.id) + 
     (SELECT COUNT(*) FROM likes l2 WHERE l2.user_id = u2.id) + 
     (SELECT COUNT(*) FROM friendship f2 WHERE f2.status_id = 'confirmed' AND f2.friend_id = u2.id) 
     AS activity
     FROM users u2 
     ORDER BY activity
     

    
  -- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. 
-- Агрегация данных”

-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные 
-- корректировки и/или улучшения (JOIN пока не применять).

-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей. 

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.

   -- Теперь используем JOIN! ДЗ в процессе доработки, пока лучше не проверять, есть ошибки в текущих запросах. Сдам позже 
   
     
   -- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался 
-- с нашим пользователем.

     DESC friendship; 
    
     DESC messages; 
     
-- Как и в прошлый раз выбираем user = 92 и его переписку с пользователями

    SELECT from_user_id, to_user_id
    FROM messages m2
    WHERE to_user_id = 92 OR from_user_id = 92; 

   SELECT * FROM friendship f; 

-- Добавляем счетчик COUNT

    SELECT from_user_id, to_user_id, COUNT(*) AS counted_messages
      FROM messages m2
        LEFT JOIN friendship
          ON friendship.friend_id = m2.to_user_id 
             OR friendship.user_id = m2.to_user_id
      WHERE to_user_id = 92 
    GROUP BY from_user_id, to_user_id
    ORDER BY counted_messages DESC LIMIT 1;
   
   -- из всех друзей! 
   
    SELECT * FROM messages m2 WHERE (from_user_id = 92 OR to_user_id = 92); 
   
    SELECT * FROM friendship WHERE (user_id = 92 or friend_id = 92); 
   
    SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = from_user_id) AS friend, 
   	COUNT(*) AS all_messages
   	FROM messages
    WHERE to_user_id = 92
      AND from_user_id IN (
      (SELECT friend_id FROM friendship WHERE user_id = 92)
       UNION
      (SELECT user_id FROM friendship WHERE friend_id = 92)
       )
    GROUP BY friend
    ORDER BY all_messages DESC
    LIMIT 1;
     
     
     
  -- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.    
     
  SELECT target_id, COUNT(DISTINCT(likes.id)) AS likes_number
  	FROM likes
      LEFT JOIN profiles
  	    ON likes.target_id = profiles.user_id
  	  JOIN target_types
        ON likes.target_type_id = target_types.id
    WHERE target_types.id = 2
   GROUP BY likes.target_id
   ORDER BY birthday DESC
   LIMIT 10; 
 
 -- считаем сумму лайков 
 
  SELECT SUM(likes_on_user) AS likes_sum FROM (
    SELECT COUNT(DISTINCT(likes.id)) AS likes_on_user
  	FROM likes
  	  LEFT JOIN profiles
  	    ON likes.target_id = profiles.user_id
      JOIN target_types
        ON likes.target_type_id = target_types.id
      WHERE target_types.id = 2
   GROUP BY likes.target_id
   ORDER BY birthday DESC
   LIMIT 10) AS counted_likes;

  
  -- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
  
  SELECT CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex, 
    COUNT(*) FROM (SELECT user_id as user, 
         (SELECT sex FROM profiles WHERE user_id = user) as sex FROM likes l2 ) dummy_table
GROUP BY sex 
ORDER BY COUNT(*) DESC LIMIT 1; 
  
SELECT * FROM likes l2; 

SELECT * FROM profiles p2;

    SELECT CASE (sex)
      WHEN 'm' THEN 'man'
      WHEN 'f' THEN 'women'
    END AS sex,
	user_id as user, COUNT(*) AS counted_like FROM profiles 
      LEFT JOIN likes
        ON profiles.user = likes.user_id
    GROUP BY sex
    ORDER BY COUNT(*) DESC; 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании 
-- социальной сети.

   SELECT id, CONCAT (first_name, ' ', last_name) AS user, 
     (SELECT COUNT(*) FROM messages m2 WHERE m2.from_user_id = u2.id) + 
     (SELECT COUNT(*) FROM likes l2 WHERE l2.user_id = u2.id) + 
     (SELECT COUNT(*) FROM friendship f2 WHERE f2.status_id = 'confirmed' AND f2.friend_id = u2.id) 
     AS activity
     FROM users u2 
     ORDER BY activity
    
     SELECT id, CONCAT (first_name, ' ', last_name) AS user FROM users u2
       INNER JOIN messages
          ON messages.from_user_id = users.id
       INNER JOIN likes 
          ON likes.user_id = users.id
       INNER JOIN friendship 
          ON friendship.friend_id = users.id
     ORDER BY id; 
     
     
       
     	
     
 
  
-- Таблица связей

  ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;

-- Для таблицы сообщений

ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   
-- Для статусов дружбы

ALTER TABLE friendship_statuses
  ADD CONSTRAINT friendship_statuses_id_fk 
    FOREIGN KEY (id) REFERENCES friendship(status_id); 
-- добавить primary key и foreign key к сущностям. 
   

-- ������������� ����� ��������� ���� SQL
-- https://www.sqlstyle.guide/ru/

-- ��������� ������� � ������ ���������
-- на http://filldb.info

-- ������������ 
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm