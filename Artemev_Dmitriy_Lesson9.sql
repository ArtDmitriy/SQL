                    Практическое задание по теме “Транзакции, переменные, представления”

1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users
SELECT id, name
FROM shop.users
WHERE id = 1;

DELETE FROM shop.users
WHERE id=1;

COMMIT;

2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW name_and_type AS
SELECT p.name, c.name AS `type`
FROM products p
JOIN
catalogs c
WHERE p.catalog_id = c.id

SELECT *
FROM name_and_type


             Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

1. Создайте двух пользователей которые имеют доступ к базе данных shop.
Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
второму пользователю shop — любые операции в пределах базы данных shop.

CREATE USER 'user1'@'localhost';
GRANT SELECT, SHOW VIEW ON shop.* TO 'user1'@'localhost';

CREATE USER 'user2'@'localhost';
GRANT ALL ON shop.* TO 'user2'@'localhost';


                 Практическое задание по теме “Хранимые процедуры и функции, триггеры"

1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER $$
$$
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE time INT;
	SET time = HOUR(now());
	CASE
		WHEN time BETWEEN 0 AND 5 THEN
			RETURN 'Доброй ночи!';
		WHEN time BETWEEN 6 AND 11 THEN
			RETURN 'Доброе утро!';
		WHEN time BETWEEN 12 AND 17 THEN
			RETURN 'Добрый день!';
		WHEN time BETWEEN 18 AND 23 THEN
			RETURN 'Добрый вечер!';
	END CASE;
END$$
DELIMITER ;
SELECT hello()


2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER $$
DROP TRIGGER IF EXISTS not_null $$
CREATE TRIGGER not_null BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Оба значения не могут быть NULL';
	END IF;
END $$
DELIMITER ;