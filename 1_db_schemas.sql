-- Создаём БД
DROP DATABASE IF EXISTS movie_land;
CREATE DATABASE movie_land;

-- Делаем её текущей
USE movie_land;

-- Создаём таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_name VARCHAR(100) NOT NULL COMMENT "Логин пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  token VARCHAR(250) NOT NULL UNIQUE COMMENT "Токен для проверки пароля",
  avatar_blob_id VARCHAR(250) DEFAULT NULL COMMENT "Идентификатор картинки пользователя стороннего сервиса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";


-- Таблица профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя",
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  gender ENUM ('m', 'f', 'ng') DEFAULT 'ng' COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили";


-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;


-- Таблица сообщений
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Сообщения";


-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id);


-- Таблица дружбы
DROP TABLE IF EXISTS friendship;
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
DROP TABLE IF EXISTS friendship_statuses;
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name ENUM ('Requested', 'Confirmed', 'Rejected') DEFAULT 'Requested' COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Статусы дружбы";


-- Добавляем внешние ключи
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT friendship_friend_id_fk
    FOREIGN KEY (friend_id) REFERENCES users(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT friendship_status_id_fk
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id)
      ON DELETE CASCADE;


-- Таблица нотификаций
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Нотификации";

-- Добавляем внешние ключи
ALTER TABLE notifications
  ADD CONSTRAINT notifications_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);


-- Таблица фильмов
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  title VARCHAR(100) NOT NULL COMMENT "Название фильма",
  short_description VARCHAR(250) NOT NULL COMMENT "Короткое описание фильма",
  description TEXT NOT NULL COMMENT "Описание фильма",
  movie_link VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  image_blob_id VARCHAR(250) DEFAULT NULL COMMENT "Идентификатор картинки фильма",
  release_date DATE NOT NULL COMMENT "Год выпуска фильма",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Фильмы";


-- Таблица Стран
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  country VARCHAR(200) UNIQUE NOT NULL COMMENT "Страна"
) COMMENT "Страны";


-- Таблица связи стран и фильмов
CREATE TABLE countries_movies (
  country_id INT UNSIGNED NOT NULL COMMENT "Ссылка на страну",
  movie_id INT UNSIGNED NOT NULL COMMENT "Ссылка на фильм",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  PRIMARY KEY (country_id, movie_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между странами и фильмами";


-- Добавляем внешние ключи
ALTER TABLE countries_movies
  ADD CONSTRAINT countries_country_id_fk
    FOREIGN KEY (country_id) REFERENCES countries(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT movies_movie_id_fk
    FOREIGN KEY (movie_id) REFERENCES movies(id)
	  ON DELETE CASCADE;


-- Таблица жанров
DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  genre VARCHAR(200) UNIQUE NOT NULL COMMENT "Жанр"
) COMMENT "Жанры";


-- Таблица связи жанров и фильмов
CREATE TABLE genres_movies (
  genre_id INT UNSIGNED NOT NULL COMMENT "Ссылка на жанр",
  movie_id INT UNSIGNED NOT NULL COMMENT "Ссылка на фильм",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  PRIMARY KEY (genre_id, movie_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между жанрами и фильмами";


-- Добавляем внешние ключи
ALTER TABLE genres_movies
  ADD CONSTRAINT genres_genre_id_fk
    FOREIGN KEY (genre_id) REFERENCES genres(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT movies_genre_id_fk
    FOREIGN KEY (movie_id) REFERENCES movies(id)
	  ON DELETE CASCADE;


-- Таблица актёров
DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  birthday DATE COMMENT "Дата рождения",
  country_id INT UNSIGNED NOT NULL COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Актеры";


-- Таблица связи актёров и фильмов
CREATE TABLE actors_movies (
  actor_id INT UNSIGNED NOT NULL COMMENT "Ссылка на актёра",
  movie_id INT UNSIGNED NOT NULL COMMENT "Ссылка на фильм",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  PRIMARY KEY (actor_id, movie_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь между актёрами и фильмами";


-- Добавляем внешние ключи
ALTER TABLE actors_movies
  ADD CONSTRAINT actors_movies_actor_id_fk
    FOREIGN KEY (actor_id) REFERENCES actors(id)
	  ON DELETE CASCADE,
  ADD CONSTRAINT actors_movies_movie_id_fk
    FOREIGN KEY (movie_id) REFERENCES movies(id)
	  ON DELETE CASCADE;


-- Таблица комментариев
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  movie_id INT UNSIGNED NOT NULL COMMENT "Ссылка на фильм",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT DEFAULT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки"
) COMMENT "Комментарии";


-- Добавляем внешние ключи
ALTER TABLE comments
  ADD CONSTRAINT comments_movie_id_to_id_fk
    FOREIGN KEY (movie_id) REFERENCES movies(id),
  ADD CONSTRAINT comments_from_user_id_to_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id);