/* 2) Написать скрипт, возвращающий список имен
(только firstname) пользователей без повторений
в алфавитном порядке */
USE vk;
SELECT DISTINCT firstname FROM users ORDER BY firstname;

/* 3) Написать скрипт, отмечающий несовершеннолетних пользователей
как неактивных (поле is_active = false).
Предварительно добавить такое поле в таблицу profiles
со значением по умолчанию = true (или 1) */

ALTER TABLE profile ADD COLUMN is_active ENUM('true', 'false') DEFAULT 'true';


UPDATE profile SET is_active = 'false' WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;
SELECT * FROM profile WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;



/*
    4) Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
*/


INSERT INTO messages (from_user_id, to_user_id, body, created_at) VALUES ('1', '2', 'Lorem', '2021-01-01'),
										('3', '4', 'Lorem10', '2022-05-05'),
										('3', '4', 'Lorem10', '2022-05-05'),
										('3', '4', 'Lorem10', '2022-05-05');



DELETE FROM messages WHERE
created_at > CURRENT_DATE();