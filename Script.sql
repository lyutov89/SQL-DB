USE vk;

SHOW TABLES;

--users
SELECT * FROM users LIMIT 10;

--profiles

SELECT * FROM profiles LIMIT 10;

CREATE TEMPORARY TABLE sex(sex CHAR(1));
INSERT INTO sex VALUES ('M'), ('F');
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);

--messages 

SELECT * FROM messages LIMIT 10;
UPDATE messages SET
	from_user_id = FLOOR(1 + (RAND() * 100)),
	to_user_id = FLOOR(1 + (RAND() * 100));

--mediatypes

SELECT * FROM media_types LIMIT 10;
DELETE FROM media_types;
TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- media
SELECT * FROM media LIMIT 10;
UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);
UPDATE media SET metadata = CONCAT(
  '{"', 
  'owner', 
  '":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
   '"}');
DESC media;   
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- friendship
SELECT * FROM friendship LIMIT 10;
UPDATE friendship SET
  user_id = FLOOR(1 + (RAND() * 100)),
  friend_id = FLOOR(1 + (RAND() * 100))
;

DESC friendship;

-- friendship_statuses
SELECT * FROM friendship_statuses;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name)
  VALUES ('Requested'), ('Confirmed');
 
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 2));  

-- communities
SELECT * FROM communities LIMIT 10;
DELETE FROM communities WHERE id > 20;

-- communities_users
SELECT * FROM communities_users LIMIT 10;
UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 20)),
  user_id = FLOOR(1 + (RAND() * 100))
;

INSERT INTO friendship_statuses (name) VALUE ('INTERRUPTED');
SELECT * FROM friendship_statuses;

ALTER TABLE profiles ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()

SELECT * FROM posts LIMIT 10
DELETE FROM media_types;
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

SELECT * FROM meetings LIMIT 10


