-- Movie view
CREATE OR REPLACE VIEW movies_view AS
SELECT id, title, short_description, image_blob_id, release_date FROM movies;


CREATE OR REPLACE VIEW movies_genres_view AS
SELECT m.id, m.title, gm.genre_id, g.genre
  FROM movies m
   LEFT JOIN genres_movies AS gm
    ON m.id = gm.movie_id
   LEFT JOIN genres AS g
    ON g.id = gm.genre_id;


CREATE OR REPLACE VIEW movies_actors_view AS
SELECT m.id, m.title, am.actor_id, CONCAT(a.first_name, ' ', a.last_name) as actor
  FROM movies m
   LEFT JOIN actors_movies AS am
    ON m.id = am.movie_id
   LEFT JOIN actors AS a
    ON a.id = am.actor_id;