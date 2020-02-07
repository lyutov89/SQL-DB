
CREATE DATABASE open_lk; 

USE open_lk; 

-- Таблица users. TIN - это как наш ИНН. 

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TIN INT NOT NULL, 
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица профилей

CREATE TABLE profile (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100)
); 

-- Таблица кошелек пользователя

CREATE TABLE wallet (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TIN INT NOT NULL,
  rubles INT NOT NULL, 
  euro INT NOT NULL, 
  dollar INT NOT NULL
); 

-- Таблица типов ценных бумаг 

CREATE TABLE assets_types (
   id INT UNSIGNED NOT NULL,
   type_of_asset VARCHAR(100)
); 

-- Таблица акций

-- price - DECIMAL или FLOAT? Нужно, чтобы обрабатывалось например 233.84

CREATE TABLE shares_list (
   id INT UNSIGNED NOT NULL,
   ticker CHAR(10), 
   price DECIMAL UNSIGNED,
   exchange_type VARCHAR(100), 
   last_news VARCHAR(255), 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
); 

DROP TABLE shares_list; 



-- Таблица профиля акции

CREATE TABLE share_profile (
   share_id INT UNSIGNED NOT NULL,
   ticker CHAR (10), 
   volume_of_deals_for_day INT NOT NULL, 
   open_price INT NOT NULL, 
   close_price INT NOT NULL,
   expecting_dividend INT UNSIGNED, 
   share_amount INT UNSIGNED, 
   next_report DATE NOT NULL
   ); 

-- Таблица рынков

CREATE TABLE type_of_exchanges ( 
   id INT UNSIGNED NOT NULL, 
   exchange CHAR(10) 
   ); 

-- Таблица сделок пользователя 
DROP TABLE user_deals; 
  
CREATE TABLE user_deals (
   id INT UNSIGNED NOT NULL, 
   user_id INT NOT NULL, 
   TIN INT NOT NULL, 
   asset_type CHAR(10),
   type_of_deal CHAR(10), 
   price_for_equity INT NOT NULL
   ); 

-- Таблица облигаций (бондов) nkd_value - накопленный купонный доход 

DROP TABLE list_bond; 

CREATE TABLE list_bond (
   id INT UNSIGNED NOT NULL,
   price_nominal INT NOT NULL, 
   current_price INT NOT NULL, 
   period_payment INT NOT NULL, 
   nkd_value INT NOT NULL, 
   nearest_payment DATE NOT NULL, 
   bond_coupon INT NOT NULL, 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() 
   ); 
  
-- Таблица валют 
  
CREATE TABLE currencies (
   id INT UNSIGNED NOT NULL,
   ticker VARCHAR(10), 
   current_value INT UNSIGNED NOT NULL, 
   trade_volume INT UNSIGNED NOT NULL, 
   open_price INT UNSIGNED NOT NULL, 
   close_price INT UNSIGNED NOT NULL
   ); 
  
-- Таблица товаров
  
CREATE TABLE goods (
   id INT UNSIGNED NOT NULL, 
   good_group VARCHAR(10), 
   ticker VARCHAR(10), 
   current_value INT UNSIGNED NOT NULL, 
   trade_volume INT UNSIGNED NOT NULL, 
   open_price INT UNSIGNED NOT NULL, 
   close_price INT UNSIGNED NOT NULL
   ); 

-- Таблица групп товаров
  
CREATE TABLE goods_group (
   id INT UNSIGNED NOT NULL, 
   name_good_group VARCHAR(10)
   ); 

-- Таблица торговых идей

CREATE TABLE analytical_ideas (
   id INT UNSIGNED NOT NULL, 
   name VARCHAR(255),
   ticker CHAR(10), 
   type_deal CHAR(10),
   time_horizont VARCHAR (255), 
   earning_forecast INT UNSIGNED NOT NULL, 
   created_at DATETIME DEFAULT NOW(),
   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() 
  ); 

SHOW TABLES 




