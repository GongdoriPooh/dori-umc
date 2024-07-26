-- movie
-- Initialize table structure
--
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS food_preferences;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS missions;
DROP TABLE IF EXISTS missions_selected;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS term;
DROP TABLE IF EXISTS agreement;
DROP TABLE IF EXISTS alarms_term;
DROP TABLE IF EXISTS alarms;


--
-- Create table structure
--
CREATE TABLE users (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  nickname VARCHAR(20) NOT NULL,
  gender ENUM('male', 'female', 'no answer') NOT NULL,
  birth_date DATE NOT NULL,
  address VARCHAR(50) NOT NULL,
  detail_address VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone_number VARCHAR(11) NOT NULL,
  point INT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  status ENUM('deleted', 'inactive', 'active') NOT NULL,
  deactivated_at DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE food_preferences (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  food_type ENUM('korean', 'japanese', 'chinese', 'italian', 'chicken', 'bunsik', 'grill', 'lunchbox', 'night', 'fast food', 'dessert', 'asian food') NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE stores (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  region VARCHAR(5) NOT NULL,
  address VARCHAR(50) NOT NULL,
  food_type ENUM('korean', 'japanese', 'chinese', 'italian', 'chicken', 'bunsik', 'grill', 'lunchbox', 'night', 'fast food', 'dessert', 'asian food') NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE regions (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(5) NOT NULL,
  PRIMARY KEY (id)
  );

CREATE TABLE reviews (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  store_id BIGINT NOT NULL,
  score INT NOT NULL,
  review_content TEXT NOT NULL,
  photos LONGBLOB NOT NULL,
  `time` DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE
);

CREATE TABLE missions (
  id BIGINT NOT NULL AUTO_INCREMENT,
  store_id BIGINT NOT NULL,
  mission_content TEXT NOT NULL,
  region_id BIGINT NOT NULL,
  reward INT NOT NULL,
  deadline DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE,
  FOREIGN KEY (region_id) REFERENCES regions (id) ON DELETE CASCADE
);


CREATE TABLE missions_selected (
  user_id BIGINT NOT NULL,
  mission_id BIGINT NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (mission_id) REFERENCES missions(id) ON DELETE CASCADE
);

  
CREATE TABLE term(
	id bigint not null,
    is_optional boolean,
    contents TEXT,
    is_agree boolean,
    
    primary key(id)
  );
  
CREATE TABLE agreement (
	term_id bigint not null,
    user_id bigint not null,
    
    primary key(term_id, user_id),
    foreign key(term_id) references term(id) on delete cascade,
    foreign key(user_id) references users(id) on delete cascade
);

create table alarms_term(
	id bigint not null,
    user_id bigint not null,
    alarm_type ENUM('event', 'review', 'inquiry') not null,
    is_agree boolean not null,
    
    primary key(id),
    foreign key(user_id) references users(id) on delete cascade
);

create table alarms(
	id bigint not null,
    type ENUM('event', 'review', 'inquiry') NOT NULL,
    alarm_time date not null,
    store_name varchar(50),
    
    primary key(id)
);