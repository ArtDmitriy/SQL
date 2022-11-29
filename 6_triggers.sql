-- Actor first name and last name validation
DELIMITER //
CREATE TRIGGER validate_actors_first_name_last_name_insert BEFORE INSERT ON actors
FOR EACH ROW BEGIN
  IF NEW.first_name IS NULL AND NEW.last_name IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both fist name and last name are NULL';
  END IF;
END//


-- Comments first name and last name validation
DELIMITER //
CREATE TRIGGER validate_comments_body_insert BEFORE INSERT ON comments
FOR EACH ROW BEGIN
  IF NEW.body IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Comments body is NULL';
  END IF;
END//

-- Messages first name and last name validation
DELIMITER //
CREATE TRIGGER validate_messages_body_insert BEFORE INSERT ON messages
FOR EACH ROW BEGIN
  IF NEW.body IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Messages body is NULL';
  END IF;
END//

-- Movies first name and last name validation
DELIMITER //
CREATE TRIGGER validate_movies_title_movie_link_insert BEFORE INSERT ON movies
FOR EACH ROW BEGIN
  IF NEW.title IS NULL AND NEW.movie_link IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Movies title and link are NULL';
  END IF;
END//

DELIMITER //
CREATE TRIGGER validate_movies_title_movie_link_update BEFORE UPDATE ON movies
FOR EACH ROW BEGIN
  IF NEW.title IS NULL AND NEW.movie_link IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Movies title and link are NULL';
  END IF;
END//


-- Profiles first name and last name validation
DELIMITER //
CREATE TRIGGER validate_profiles_first_name_last_name_insert BEFORE INSERT ON profiles
FOR EACH ROW BEGIN
  IF NEW.first_name IS NULL AND NEW.last_name IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both fist name and last name are NULL';
  END IF;
END//

-- Users first name and last name validation
DELIMITER //
CREATE TRIGGER validate_users_user_name_email_insert BEFORE INSERT ON users
FOR EACH ROW BEGIN
  IF NEW.user_name IS NULL AND NEW.email IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both user name and email are NULL';
  END IF;
END//