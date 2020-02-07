USE shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 -- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
 -- и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу
 -- DATETIME, сохранив введеные ранее значения.
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255) COMMENT 'создано в',
  updated_at VARCHAR(255) COMMENT 'обновлено в'
) COMMENT = 'Покупатели';

DESC users 

ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at  updated_at DATETIME;
DESC users 

SELECT * FROM users LIMIT 6;

-- Задание 1 
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем

INSERT INTO users VALUES 
	(NULL, 'Геннадий', '1990-10-05', NOW(), NOW()),
 	(NULL, 'Наталья', '1984-11-12', NOW(), NOW()),
 	(NULL, 'Александр', '1985-05-20', NOW(), NOW()),
 	(NULL, 'Сергей', '1988-02-14', NOW(), NOW()),
 	(NULL, 'Иван', '1998-01-12', NOW(), NOW()),
 	(NULL, 'Мария', '1992-08-29', NOW(), NOW());

 -- Комментарий: посчитал, что UPDATE будет лишним, операцию NOW можно сразу вставить через INSERT
 
SELECT * FROM users LIMIT 6;


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DESC products
 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- Задание №2
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи 
-- таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны 
-- выводиться в конце, после всех записей.

INSERT INTO storehouses_products 
	(value)
VALUES
	(0), (2500), (0), (30), (500), (1); 

SELECT value FROM storehouses_products; 

SELECT id, value FROM storehouses_products ORDER BY value = 0, value;  

-- агрегация данных

-- 1) Подсчитайте средний возраст пользователей в таблице users
-- Воспользуемся предыдущими записями 

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255) COMMENT 'создано в',
  updated_at VARCHAR(255) COMMENT 'обновлено в'
) COMMENT = 'Покупатели';

INSERT INTO users VALUES 
	(NULL, 'Геннадий', '1990-10-05', NOW(), NOW()),
 	(NULL, 'Наталья', '1984-11-12', NOW(), NOW()),
 	(NULL, 'Александр', '1985-05-20', NOW(), NOW()),
 	(NULL, 'Сергей', '1988-02-14', NOW(), NOW()),
 	(NULL, 'Иван', '1998-01-12', NOW(), NOW()),
 	(NULL, 'Мария', '1992-08-29', NOW(), NOW());
 
сначала найдем текущий возраст пользователей

SELECT name, TIMESTAMPDIFF (YEAR, birthday_at, NOW()) AS age FROM users;  

Потом посчитаем их среднее значение

SELECT AVG(TIMESTAMPDIFF (YEAR, birthday_at, NOW())) FROM users; 

-- 3) 
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
-- Функции "произведение" нет в MySQL, зато его можно выразить через свойство натуральных логарифмов.
-- Коммент: решил взять id товаров на складе, произведение вышло чуть больше, чем 120. 

SELECT EXP(SUM(LOG(id))) FROM storehouses_products; 

-- 2) Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- Для решения удобно воспользоваться функцией DATE_FORMAT и NOW() и выбрать формат %W (дни по английски)
-- при подсчете записей используем count(*), далее как в методичке, группируем по дням, сортируем в обратном порядке 


SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day, 
	COUNT(*) AS full_amount
FROM 
	users 
GROUP BY 
	day 
ORDER BY 
	full_amount
	
USE shop; 

	-- Урок 10. Практическое задание по триггерам. 
	 
	-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
	--  Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают
	--  неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей
	--  или оба поля были зdаполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
	
	SELECT * FROM products;

-- По условию ДЗ нужно вызвать ошибку, если оба поля name, description IS NULL (сразу код для вставки) 

DELIMITER //

CREATE TRIGGER check_desription_and_name_before_ins BEFORE INSERT IN products; 
FOR EACH ROW 
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE TEXT = 'CHECK is not passed. Name and description is not determined'
	END IF; 
END//

-- блок вставки
-- оба значения неопределены

INSERT INTO products 
	(name, desription, price, catalog_id)
VALUES
	(NULL, NULL, 5000.00, 2); //

-- определено одно из двух

INSERT INTO products 
	(name, desription, price, catalog_id)
VALUES
	(NULL, 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1; //

	-- Триггер на проверку перед обновлением таблицы products

CREATE TRIGGER check_desription_and_name_before_upd BEFORE UPDATE IN products; 
FOR EACH ROW 
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE TEXT = 'CHECK is not passed. Name and description is not determined'
	END IF; 
END//

-- Задание №11
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и 
-- содержимое поля name.

CREATE TABLE logs ( 
  name_of_table VARCHAR(255) NOT NULL, 
  id_pr_key INT UNSIGNED NOT NULL,
  name_row VARCHAR(255) NOT NULL, 
  created_at DATETIME DEFAULT NOW()) 
  ENGINE=Archive; 	

 -- для users: 
 
 -- после вставки
 
CREATE TRIGGER log_trig_user_insert AFTER INSERT ON users; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'users', NEW.id, NEW.name FROM users u2);  
  END//

-- после обновления

CREATE TRIGGER log_trig_user_update AFTER UPDATE ON users; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'users', NEW.id, NEW.name FROM users u2);  
  END//
  
-- для catalogs: 

CREATE TRIGGER log_trig_catalogs_insert AFTER INSERT ON catalogs; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'catalogs', NEW.id, catalogs.name FROM catalogs c2);  
  END//

-- после обновления

CREATE TRIGGER log_trig_catalogs_update AFTER UPDATE ON catalogs; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'catalogs', NEW.id, NEW.name FROM catalogs c2);  
  END//
  
  -- для products: 
  
  CREATE TRIGGER log_trig_products_insert AFTER INSERT ON products; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'products', NEW.id, NEW.name FROM products p2);  
  END//

-- после обновления

CREATE TRIGGER log_trig_products_update AFTER UPDATE ON products; 
FOR EACH ROW 
  BEGIN 
	INSERT INTO logs VALUES FROM (SELECT 'products', products.id, products.name FROM products p2);  
  END//
  
  
  
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
-- поиск электронного адреса пользователя по его имени.
-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

  -- Подбор коллекции IP адресов: 
  
  -- Берем Хэш, с помощью команды INCRBY делаем приращение на единицу. 
  
 HINCRBY ip_addr '172.20.10.1' 1 
 HGETALL ip_addr 
 
 HGET ip_addr
 
 
 -- Поиск имени по электронному адресу пользователя и наоборот
 
 
 
 HSET email 'anatoly' 'lyutov89@yandex.ru'
 HSET email 'natan' 'lyutov1989@gmail.com'
 HSET email 'maria' 'anurova1993@mail.ru'
 
 HGET email 'natan'
 
 HSET users 'lyutov89@yandex.ru' 'anatoly'
 HSET users 'lyutov1989@gmail.com' 'natan'
 HSET users 'anurova1993@mail.ru' 'maria'
 
 HGET users 'lyutov89@yandex.ru'
 
 -- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
 
 -- Через пакетный менеджер устанавливаем mongo db 
 -- brew update
 -- brew install mongo db 
 
 -- либо для ubuntu используем команду открытого ключа GPG Mongo DB (из coderlessons.com) 
 
 -- https://coderlessons.com/tutorials/bazy-dannykh/uchitsia-mongodb/mongodb-kratkoe-rukovodstvo
 -- https://coderlessons.com/tutorials/bazy-dannykh/uchitsia-mongodb/mongodb-kratkoe-rukovodstvo
 -- https://metanit.com/nosql/mongodb/2.1.php
 
 
show dbs

use shop
 
 db.createCollection('catalogs')
 db.createCollection('products')
 
-- Заполняем коллекцию catalogs, аналогично в MySQL

  db.catalogs.insert({name: 'Процессоры'})
  db.catalogs.insert({name: 'Материнские платы'})
  db.catalogs.insert({name: 'Видеокарты'})
  db.catalogs.insert({name: 'Жесткие диски'})
  db.catalogs.insert({name: 'Оперативная память'})
  
  -- Заполняем products
  
  db.products.insert(
  {
    name: 'Intel Core i3-8100',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 7890.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'Intel Core i5-7400',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 12700.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'ASUS ROG MAXIMUS X HERO',
    description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
    price: 19310.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56c")
  }
);

db.products.insert(
  {
    name: 'GeForce GTX',
    description: 'Видеокарта NVIDIA GeForce GTX 1660 SUPER, 6144 МБ видеопамяти, GDDR6 частота ядра/памяти: 1830/14000 МГц разъемы HDMI, DisplayPort x3 поддержка DirectX 12, OpenGL 4.6, Vulkan',     
    price: 15644.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56d")
  }
);

db.products.insert(
  {
    name: 'Seagate ST1000LM048X',
    description: 'жесткий диск для ноутбука и настольного компьютера объем 1000 ГБ форм-фактор 2.5"'     
    price: 2745.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56e")
  }
);

db.products.insert(
  {
    name: 'sumsung ddr4 (M378A1K43CB2-CTD)',
    description: '1 модуль памяти DDR4 объем модуля 8 ГБ форм-фактор DIMM, 288-контактный частота 2666 МГц CAS Latency (CL): 19'     
    price: 2210.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56f")
  }
);


  
  

 
  
  