-- Movies by genres
SELECT
 movie_id as id,
 (SELECT title FROM movies WHERE movies.id = genres_movies.movie_id) as title,
 (SELECT genre FROM genres WHERE genres.id = genres_movies.genre_id) AS genre
 FROM genres_movies;

-- Movies by actors
SELECT
 movie_id as id,
 (SELECT title FROM movies WHERE movies.id = actors_movies.movie_id) as title,
 (SELECT CONCAT(first_name, ' ', last_name) FROM actors WHERE actors.id = actors_movies.actor_id) as actor
 FROM actors_movies;


-- Get user info
SELECT
  u.id,
  u.user_name,
  u.email,
  u.token,
  u.avatar_blob_id,
  CONCAT(p.first_name, ' ', p.last_name) AS name,
  p.birthday,
  p.city,
  p.phone
  FROM users AS u
   JOIN profiles AS p
    ON u.id = p.user_id;


 -- Messages from user
SELECT messages.body, profiles.first_name, profiles.last_name, messages.created_at
  FROM messages
    JOIN profiles
      ON profiles.user_id = messages.to_user_id
  WHERE messages.from_user_id = 7;


-- Get messages from user to user by ID
SELECT
  messages.from_user_id,
  CONCAT(users_from.first_name, ' ', users_from.last_name) AS from_user,
  messages.to_user_id,
  CONCAT(users_to.first_name, ' ', users_to.last_name) AS to_user,
  messages.body,
  messages.created_at
  FROM profiles
   JOIN messages
    ON profiles.user_id = messages.to_user_id OR profiles.user_id = messages.from_user_id
   JOIN profiles AS users_from
    ON users_from.user_id = messages.from_user_id
   JOIN profiles AS users_to
    ON users_to.user_id = messages.to_user_id
  WHERE profiles.user_id = 7;