


                                                 Урок 10.
Вебинар. Транзакции, переменные, представления. Администрирование. Хранимые процедуры и функции, триггеры.


Прислать предварительную версию курсового проекта:

DDL-команды;
Дамп БД (наполнение таблиц данными), не больше 10 строк в каждой таблице.


1. Описание проекта
За основу взял интернет-магазин OZON.

Сущности.
Основные две сущности
       1-товары (products)
       2-пользователи(users)
Далее: 3-заказы (oreders),
       4-профиль пользователя (profiles),
       5-корзина(busket),
       6-каталог(catalog),
       7-разделы каталога или подразделы (catalog_sections),
       8-отзывы посетителей, не только покупателей (review_users),
       9-Бренды (brands),
       10-способ доставки (method_of_delivery),
       11-статус доставки(stsus_delivery).

База хранит в себе данные по имеющимися товарам в интернет магазине, краткое описание товара.
Также хранит данные пользователя, зарегистрировавшемся под login_user.
Основная информация о пользователе храниться в таблице profiles.
Связь товара и пользователя состоит через корзину.
Пользователь сперва добавляет товар в корзину, после чего может его оформить (процедуру покупки опустил, уж много времени бы заняло,
можно было бы и транкзации добавить, но не распологая стольким временем к сожалению)
Таблицы  brands и catalog_sections созданы для удобства поиска товара для пользователя и для запросов администраторов интернет-магазина.
Данные таблиц orders, status_delivery, method_of_delivery созданы для администрирования интернет-магазина.
Также предусмотрел таблицу review_users (отзывы) для пользователей и администраторов интернет-магазина, для ведения статистики.
Структура БД сейчас грубая, довести до ума не успел.

2. Минимальное количество таблиц - 10;
3. Скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);

-- TABLE catalog
DROP TABLE IF EXISTS catalog;
CREATE TABLE catalog (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(100) NOT NULL COMMENT "Наименование разделов"
  ) COMMENT "Каталог";

-- Заполнение таблицы
INSERT INTO catalog
  (name)
VALUES
  ('electronics'),
  ('clothes&shoes'),
  ('household_аppliances');

-- Пришлось переименовать колонку в таблице catalog для запросов. Потом понял, что не обязательно.
-- Нашел способ внести запросы колонок с двумя одинаковыми названиями.
ALTER TABLE catalog RENAME COLUMN name TO name_catalog;

SELECT * from catalog;

-- TABLE catalog_sections
DROP TABLE IF EXISTS catalog_sections;
CREATE TABLE catalog_sections (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  categories VARCHAR(100) NOT NULL COMMENT "РАзделы каталога",
  catalog_id BIGINT UNSIGNED
  ) COMMENT "Разделы каталога";

SELECT * from catalog_sections cs ;

-- Связь таблицы catalogs - catalog_sections
ALTER TABLE catalog_sections
  ADD CONSTRAINT catalog_id_catalog_sections_fk
FOREIGN KEY (catalog_id) REFERENCES catalog(id);

-- Исправил ошибку
ALTER TABLE catalog_sections modify catalog_id INT UNSIGNED;

-- Заполнение таблицы
INSERT INTO catalog_sections
  (categories, catalog_id)
VALUES
  ('smartphones', 1),
  ('tablets', 1),
  ('notebooks', 1),
  ("TV's", 1),
  ('clothes_for_womens', 2),
  ('clothes_for_mens', 2),
  ('clothes_for_gerls', 2),
  ('clothes_for_boys', 2),
  ('shoes_for_womens', 2),
  ('shoes_for_mens', 2),
  ('shoes_for_gerls', 2),
  ('shoes_for_boys', 2),
  ('accessories', 2),
  ('refrigerators', 3),
  ('washing_machines', 3),
  ('vacuum_cleaners', 3),
  ('irons_steamers', 3),
  ('conditioners_split_systems', 3);

-- TABLE_brands
DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  the_brand VARCHAR(100) NOT NULL COMMENT "Наименование брэндов"
  ) COMMENT "Брэнды";

 SELECT * from brands b ;

-- Заполнение таблицы
INSERT INTO brands
  (the_brand)
VALUES
  ('Honor'),
  ('Samsung'),
  ('Apple'),
  ('HP'),
  ('Acer'),
  ('ASUS'),
  ('LG'),
  ('Shivaki'),
  ('Huawei'),
  ('Arctic air'),
  ('Ostin'),
  ('Puma'),
  ('Decatlon'),
  ('Indesit'),
  ('Acoola'),
  ('Briggs'),
  ('Ralf Ringer'),
  ('Modis'),
  ('Strobbs'),
  ('Bronx'),
  ('Mascote'),
  ('Philips'),
  ('PlayToday'),
  ('Crosby'),
  ('GALAXY'),
  ('Goodzone'),
  ('Zolla'),
  ('Pioneer');

-- TABLE products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY  COMMENT "AUTO_INCREMENT пропустил, исправлять долго",
  name VARCHAR(255) COMMENT "Наименование",
  desription TEXT COMMENT "Описание",
  price DECIMAL (11,2) COMMENT "Цена",
  catalog_sections_id INT UNSIGNED COMMENT "Ссылка на раздел каталога",
  brands_id INT UNSIGNED COMMENT "Ссылка на брэнд",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) COMMENT = 'Товарные позиции';

 -- Исправил ошибку
ALTER TABLE products modify id INT UNSIGNED;

SELECT * from products;

-- Заполнение таблицы, часть ручное добавление, часть filldb.info
INSERT INTO products
  (name, desription, price, catalog_sections_id, brands_id)
VALUES
  ('Смартфон Honor 10 Lite 4/128GB', 'Смартфон Honor 10 Lite 4/128GB, небесный голубой', 11900, 1, 1),
  ('Смартфон Samsung Galaxy A51 6/128GB', 'Смартфон Samsung Galaxy A51 6/128GB, черный', 19900, 1, 2),
  ('Смартфон Apple iPhone 11 64GB', 'Смартфон Apple iPhone 11 64GB, черный', 49900, 1, 3),
  ('Смартфон Apple iPhone X "Как новый" 256GB', 'Смартфон Apple iPhone X "Как новый" 256GB, серый космос', 41900, 1, 3),
  ('Ноутбук HP 15s-eq1242ur', '15.6" Ноутбук HP 15s-eq1242ur, AMD Ryzen 3 3250U (2.6 ГГц), RAM 8 ГБ, SSD 256 ГБ, AMD, Без системы, (2P0G6EA)', 30800, 3, 4),
  ('Ноутбук Acer NX.HVRER.00GU', '15.6" Ноутбук Acer NX.HVRER.00GU, AMD Ryzen 3 3250U (2.6 ГГц), RAM 12 ГБ, HDD, SSD 756 ГБ, AMD, Windows 10 Pro, (100K)', 43390, 3, 5),
  ('Ноутбук ASUS A543MA-GQ1260T', '15.6" Ноутбук ASUS A543MA-GQ1260T, Intel Celeron N4020 (1.1 ГГц), RAM 4 ГБ, SSD 128 ГБ, Intel UHD Graphics, Windows 10 Home, (90NB0IR7-M24310)', 28900, 3, 6),
  ('Ноутбук Apple MacBook Air', '13.3" Ноутбук Apple MacBook Air, Apple M1 (3.2 ГГц), RAM 16 ГБ, SSD 2000 ГБ, Apple M1, macOS, (Z1250007P), золотой', 197690, 3, 3),
  ('4K UHD Телевизор Samsung UE43TU8000UX 43"', '4K UHD Телевизор Samsung UE43TU8000UX 43"', 36900, 4, 2),
  ('4K UHD Телевизор LG 43UM7020 43"', '4K UHD Телевизор LG 43UM7020 43"', 29900, 4, 7),
  ('4K UHD Телевизор Samsung UE50TU8510UXRU 50"', '4K UHD Телевизор Samsung UE50TU8510UXRU 50"', 47900, 4, 2),
  ('HD Телевизор Shivaki STV-32LED35 32"', 'HD Телевизор Shivaki STV-32LED35 32"', 9490, 4, 9),
  ('Планшет Apple iPad (2020), 10.2", 32 GB, серый', 'Планшет Apple iPad (2020), 10.2", 32 GB, серый', 28200, 2, 2),
  ('Планшет Samsung Galaxy Tab A 8.0', 'Планшет Samsung Galaxy Tab A 8.0 (2019), 8", 32 GB, черный', 11700, 2, 2),
  ('Планшет Huawei MatePad T 10s', 'Планшет Huawei MatePad T 10s, 10,1", 32 GB, синий', 14200, 2, 9),
  ('Планшет Honor PAD V6', 'Планшет Honor PAD V6, 10.4", 128 GB, черный. Уцененный товар', 18900, 2, 1),
  ('Мини кондиционер охладитель воздуха 4 в 1 Arctic Air Ultra', 'Мини кондиционер охладитель воздуха 4 в 1 Arctic Air Ultra', 1050, 18, 10),
  ('Настенный кондиционер Samsung', 'Настенный кондиционер Samsung AR07TQHQAURNER/AR07TQHQAURXER', 15990, 18, 2),
('Стиральная машина Samsung', 'Стиральная машина Samsung WF-60F1R2F2W, белый', 20900, 15, 2),
('Стиральная машина LG ', 'Стиральная машина LG F1096TD3, белый', 13400, 15, 7),
('Джинсы OSTIN', 'Джинсы OSTIN, 54 размер', 1300, 6, 11),
('Спортивный костюм PUMA Baseball Tricot Suit', 'Спортивный костюм PUMA Baseball Tricot Suit', 2900, 6, 12),
('Шорты для плавания Декатлон', 'Шорты для плавания Декатлон', 500, 6, 13),
('Холодильник LG GA-B509CQWL', 'Холодильник LG GA-B509CQWL, белый', 34900, 14, 7),
('Холодильник Indesit DS 4160 W', 'Холодильник Indesit DS 4160 W, белый', 1800, 14, 14),
('Холодильник Indesit DS 4200 W, белый', 'Холодильник Indesit DS 4200 W, белый', 21900, 14, 14),
('Сарафан Инсар Текстиль', 'Сарафан Инсар Текстиль', 500, 5, NULL),
('Платье Concept Club', 'Платье Concept Club', 680, 5, NULL),
('Пуловер JGo-Style Блеск', 'Пуловер JGo-Style Блеск', 1300, 5, NULL),
('Футболка для плавания Декатлон', 'Футболка для плавания Декатлон', 499, 7, 13),
('Платье Acoola', 'Платье Acoola', 41900, 7, 15),
('Футболка HappyFox', 'Футболка HappyFox', 41900, 7, NULL),
('Полуботинки Briggs', 'Полуботинки Briggs', 1400, 10, 16),
('Кеды Ralf Ringer', 'Кеды Ralf Ringer', 4500, 10, 17),
('Футболка Modis', 'Футболка Modis', 600, 8, 18),
('Шорты Acoola', 'Шорты Acoola', 900, 8, 15),
('Кроссовки Strobbs', 'Кроссовки Strobbs', 1900, 9, 19),
('Полусапоги Bronx', 'Полусапоги Bronx', 7300, 9, 20),
('Кроссовки Mascotte', 'Кроссовки Mascotte', 4200, 9, 21),
('Напольный отпариватель Pioneer', 'Напольный отпариватель Pioneer, 8 режимов, электронное управление, объем 2,1 л, 2000 Вт', 3900, 17, 28),
('Утюг Philips Azur GC4566/80', 'Утюг Philips Azur GC4566/80, с подошвой SteamGlide Advanced и контейнером для накипи, серый', 4900, 17, 22),
('Резиновые сапоги PlayToday', 'Резиновые сапоги PlayToday', 700, 12, NULL),
('Кроссовки Crosby', 'Кроссовки Crosby', 1900, 12, 24),
('Бытовой пылесос GALAXY GL 6256, голубой, белый', 'Бытовой пылесос GALAXY GL 6256, голубой, белый', 2900, 16, 25),
('Бытовой пылесос Samsung VCC4520S36, синий', 'Бытовой пылесос Samsung VCC4520S36, синий', 4300, 16, 2),
('Резиновые сапоги PlayToday', 'Резиновые сапоги PlayToday', 700, 11, NULL),
('Кеды Goodzone', 'Кеды Goodzone', 1900, 11, 26),
('Зонт Rain Lucky', 'Зонт Rain Lucky',690, 13, NULL),
('Очки солнцезащитные Zolla', 'Очки солнцезащитные Zolla', 210, 13, 27);

-- Связь таблицы products - catalog_sections
ALTER TABLE products
  ADD CONSTRAINT products_catalog_sections_id_fk
FOREIGN KEY (catalog_sections_id) REFERENCES catalog_sections(id);

-- Связь таблицы products - brands
ALTER TABLE products
  ADD CONSTRAINT products_brands_id_fk
FOREIGN KEY (brands_id) REFERENCES brands(id);

select * from products p ;
select * from brands b ;

-- TABLE review
DROP TABLE IF EXISTS review_users;
CREATE TABLE review_users (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю",
  user_name VARCHAR(255) COMMENT 'Имя посетителя оставившего отзыв',
  products_id INT UNSIGNED COMMENT 'Ссылка на товар',
  review TEXT COMMENT 'Текст отзыва',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) COMMENT = 'Отзывы';

 SELECT * from review_users ru ;

-- Связь таблицы rewiew_users - products
ALTER TABLE review_users
  ADD CONSTRAINT rewiew_users_products_fk
FOREIGN KEY (products_id) REFERENCES products(id);

-- TABLE users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  login_user VARCHAR(255) COMMENT 'Логин покупателя',
  busket_id INT UNSIGNED COMMENT 'Корзина покупателя',
  order_id INT UNSIGNED COMMENT 'Заказ покупателя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

 -- Исправил ошибку
ALTER TABLE users modify id INT UNSIGNED ;

-- Связь таблицы users - busket
ALTER TABLE users
  ADD CONSTRAINT user_busket_fk
FOREIGN KEY (busket_id) REFERENCES busket(id);

-- Связь таблицы users - orders
ALTER table users drop CONSTRAINT user_orders_fk; # Для исправления колонки orders.id
ALTER TABLE users
  ADD CONSTRAINT user_orders_fk
FOREIGN KEY (order_id) REFERENCES orders(id);

SELECT * FROM users u ;

UPDATE users SET
  busket_id = FLOOR(1 + RAND() * 20);

UPDATE users SET
  order_id = FLOOR(1 + RAND() * 15);


-- исправляю заказы, order_id не должен дублироваться, Также заказов меньше чем товаров в корзине.
-- Т.е. не на все товары оформлен заказ пользователем.
UPDATE users SET
  order_id = NULL WHERE id = 1;

UPDATE users SET
  order_id = NULL WHERE id = 9;

UPDATE users SET
  order_id = NULL WHERE id = 11;

UPDATE users SET
  order_id = NULL WHERE id = 12;
UPDATE users SET
  order_id = NULL WHERE id = 13;
UPDATE users SET
  order_id = 9 WHERE id = 16;
UPDATE users SET
  order_id = 11 WHERE id = 20;

-- исправляю busket_id не должен дублироваться

SELECT id, busket_id FROM users;
UPDATE users SET
  busket_id = 2 WHERE id = 7;

UPDATE users SET
  busket_id = 3 WHERE id = 20;

UPDATE users SET
  busket_id = 8 WHERE id = 6;

UPDATE users SET
  busket_id = 13 WHERE id = 15;

UPDATE users SET
  busket_id = 5 WHERE id = 17;
UPDATE users SET
  busket_id = 15 WHERE id = 19;
UPDATE users SET
  busket_id =  18 WHERE id = 9;

-- TABLE profiles
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  login_user_id INT UNSIGNED COMMENT 'Ссылка на логин покупателя',
  first_name VARCHAR(255) COMMENT 'Имя покупателя',
  last_name VARCHAR(255) COMMENT 'Фамилия покупателя',
  phone VARCHAR(255) COMMENT 'Телефон покупателя',
  email VARCHAR(255) COMMENT 'Почта покупателя',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Профиль покупателя';

SELECT * FROM profiles p ;

-- Связь таблицы users - profiles
ALTER TABLE profiles
  ADD CONSTRAINT login_users_profiles_fk
FOREIGN KEY (login_user_id) REFERENCES users(id);

-- TABLE busket
DROP TABLE IF EXISTS busket;
CREATE TABLE busket (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  proucts_id INT UNSIGNED COMMENT 'Ссылка на товар',
  quantity INT UNSIGNED COMMENT 'Количество',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  )COMMENT 'Корзина';

 -- Исправил ошибку
 ALTER TABLE busket modify id INT UNSIGNED;

-- Связь таблицы busket- products
ALTER TABLE busket
  ADD CONSTRAINT busket_users_products_fk
FOREIGN KEY (proucts_id) REFERENCES products(id);
SELECT * FROM busket b ;
INSERT INTO busket
  (proucts_id, quantity)
VALUES
  (FLOOR(1 + RAND() * 49), FLOOR(1+ RAND() * 5));

 -- TABLE orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  busket_id INT UNSIGNED COMMENT 'Ссылка на корзину',
  adress_for_delivery  VARCHAR(255) COMMENT 'Адресс доставки',
  date_of_delivery DATETIME COMMENT 'Дата доставки',
  method_of_delivery_id INT UNSIGNED COMMENT 'Ссылка на способ доставки',
  status_delivery_id INT UNSIGNED COMMENT 'Ссылка на статус доставки',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  )COMMENT 'Заказы';

 -- Исправил ошибку
ALTER TABLE orders modify id INT unsigned NOT NULL AUTO_INCREMENT;

SELECT * FROM orders o ;

-- Связь таблицы orders - busket
ALTER TABLE orders
  ADD CONSTRAINT orders_buskets_fk
FOREIGN KEY (buskets_id) REFERENCES busket(id);

-- Связь таблицы orders - method_of_delivery
ALTER TABLE orders
  ADD CONSTRAINT orders_method_of_delivery_fk
FOREIGN KEY (method_of_delivery_id) REFERENCES method_of_delivery(id);

-- Связь таблицы orders - method_of_delivery
ALTER TABLE orders
  ADD CONSTRAINT orders_status_of_delivery_fk
FOREIGN KEY (status_delivery_id) REFERENCES status_delivery(id);

-- Заполнение таблицы часть ручное добавление, часть filldb.info
UPDATE orders SET
  busket_id = FLOOR(1 + RAND() * 20);
ALTER TABLE orders MODIFY COLUMN date_of_delivery DATE;

INSERT INTO orders
  (id, date_of_delivery)
VALUES (1, '2021-08-16'), (2, '2021-03-22'),
       (3, '2020-08-21'), (4, '2021-09-12'),
       (5, '2021-06-02'), (6, NULL),
       (7, '2021-07-23'), (8, NULL),
       (9, NULL), (10, '2021-02-21'),
       (11, '2021-05-29'), (12, '2021-05-15'),
       (13, NULL), (14, '2021-05-05'),
       (15, '2021-06-01')
  ON DUPLICATE KEY UPDATE date_of_delivery = VALUES(date_of_delivery);

 INSERT INTO orders
  (id, status_delivery_id)
VALUES (1, 3), (2, 4),
       (3, 4), (4, 1),
       (5, 4), (6, 2),
       (7, 3), (8, 2),
       (9, 2), (10, 4),
       (11, 4), (12, 4),
       (13, 2), (14, 4),
       (15, 4)
  ON DUPLICATE KEY UPDATE status_delivery_id = VALUES(status_delivery_id);

 -- Добавил колонку "номер заказа"
ALTER TABLE orders
  ADD order_number INT AFTER id ;

UPDATE orders SET
  order_number = FLOOR(300 + RAND() * 15);

-- TABLE status_delivery
DROP TABLE IF EXISTS status_delivery;
CREATE TABLE status_delivery (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  status CHAR(20) COMMENT 'Вариации статуса'
  )COMMENT 'Статус доставки';

 -- Исправил ошибку
ALTER TABLE status_delivery modify id INT UNSIGNED;

-- Заполнение таблицы
INSERT INTO status_delivery
  (status)
VALUES
  ('Заказ оформляется'),
  ('Заказ ожидает оплаты'),
  ('Заказ в пути'),
  ('Заказ получен');

SELECT * FROM status_delivery ;

-- TABLE method_of_delivery
DROP TABLE IF EXISTS method_of_delivery;
CREATE TABLE method_of_delivery (
  id SERIAL PRIMARY KEY COMMENT "AUTO_INCREMENT пропустил исприть не успеваю, заметил после создания ключа",
  name_method CHAR(30) COMMENT 'Способ доставки'
  )COMMENT 'Способ доставки';

  -- Исправил ошибку
ALTER TABLE method_of_delivery modify id INT UNSIGNED;
SELECT * FROM method_of_delivery mod2 ;

-- Заполнение таблицы
INSERT INTO method_of_delivery
  (name_method)
VALUES
  ('Курьерская служба'),
  ('Почта России'),
  ('Логистическая компания');

 -- Вставил дынные статуса достваки в таблицу заказов
UPDATE  orders SET method_of_delivery_id = (SELECT id FROM method_of_delivery ORDER BY RAND() LIMIT 1);

-- Правка позиций  busket_id, order_id таблицы users с позицией busket_id таблицы orders
select * from busket ;
select * from orders ;
select * from users u ;

-- Пришлось переименовать колонку в таблице orders, ключ исправил.
ALTER TABLE orders RENAME COLUMN busket_id TO buskets_id;
SELECT  login_user , busket_id, order_id, buskets_id
    FROM users
         LEFT JOIN orders
            ON users.id = orders.id;

UPDATE orders SET buskets_id =
(SELECT busket_id FROM users WHERE id = orders.id);
