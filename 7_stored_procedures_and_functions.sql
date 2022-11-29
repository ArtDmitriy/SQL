-- Check user by id
DROP FUNCTION IF EXISTS is_user_by_id_exists;
DELIMITER //

CREATE FUNCTION is_user_by_id_exists (user_id INT)
RETURNS BOOLEAN READS SQL DATA
BEGIN
  RETURN EXISTS(SELECT 1 FROM users WHERE id = user_id);
END//

DELIMITER ;

-- Get user info by id
DROP PROCEDURE IF EXISTS get_user_profile_by_user_id;
DELIMITER //
CREATE PROCEDURE get_user_info_by_id(id INT)
BEGIN
	SELECT * FROM profiles AS p WHERE p.user_id = id;
END //
DELIMITER ;


-- Get messages from user to user by ID
DROP PROCEDURE IF EXISTS get_user_messages_by_id;
DELIMITER //
CREATE PROCEDURE get_user_messages_by_id(user_id INT)
BEGIN
	SELECT
  messages.from_user_id,
  CONCAT(users_from.first_name, ' ', users_from.last_name) AS from_user,
  messages.to_user_id,
  CONCAT(users_to.first_name, ' ', users_to.last_name) AS to_user,
  messages.body,
  messages.created_at
  FROM profiles
    JOIN messages
      ON profiles.user_id = messages.to_user_id
        OR profiles.user_id = messages.from_user_id
    JOIN profiles AS users_from
      ON users_from.user_id = messages.from_user_id
    JOIN profiles AS users_to
      ON users_to.user_id = messages.to_user_id
  WHERE profiles.user_id = user_id;
END //
DELIMITER ;