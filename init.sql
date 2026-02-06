SET NAMES 'utf8' COLLATE 'utf8_unicode_ci';

CREATE DATABASE IF NOT EXISTS example;
USE example;

CREATE TABLE IF NOT EXISTS user (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(256) NOT NULL,
  password_salt VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS userLog (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  user_id INTEGER,
  entry VARCHAR(100),
  FOREIGN KEY(user_id) REFERENCES user(id)
);

DROP PROCEDURE IF EXISTS example.addUser;

DELIMITER //
CREATE PROCEDURE addUser
(
    IN username VARCHAR(50), 
    IN email VARCHAR(100), 
    IN password VARCHAR(100)
)
BEGIN
  DECLARE salt VARCHAR(32);
  DECLARE hash VARCHAR(256);

  SELECT REPLACE(UUID(), "-", "") INTO salt;
  SELECT SHA2(CONCAT(SHA2(password, 256), salt), 256) INTO hash; 

  INSERT INTO user (username, email, password_hash, password_salt) VALUES (username, email, hash, salt);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS example.afterUserCreate;

DELIMITER //
CREATE TRIGGER afterUserCreate
AFTER INSERT ON user
FOR EACH ROW
BEGIN
  INSERT INTO userLog (user_id, entry) VALUES (NEW.id, "Created");
END//
DELIMITER ;

CALL addUser("John Doe", "john_doe@gmail.com", "password");
