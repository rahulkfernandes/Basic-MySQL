CREATE DATABASE bnb;
SHOW DATABASES;

CREATE TABLE Users(
	id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(3)
);
INSERT INTO Users (email, bio, country)
Values
	('kf@email.com', 'text', 'US'),
    ('123@yahoo.com', 'text', 'IND'),
    ('456@gmx.com', 'text', 'IND');

-- get users from US and email with 'kf%'    
SELECT email, id, country FROM users
WHERE country = 'US' AND email LIKE 'kf%'
ORDER BY id DESC
LIMIT 2;

-- Email Index
CREATE INDEX email_index ON users(email);
INSERT INTO Users (email, bio, country)
VALUES
	('rahul@email.com', 'hi', 'RUS'),
    ('google@yahoo.com', 'hello', 'CAN'),
    ('rakesh@gmx.com', 'i am legend', 'IND');

CREATE TABLE rooms(
	id INT auto_increment,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
    
);
INSERT INTO rooms (owner_id, street)
VALUES
	(1, '3rd Cross Road'),
    (1, '2nd Main Road'),
    (1, '32nd Cross Road');
INSERT INTO rooms (owner_id, street)
VALUES
	(2, '5th Cross Road'),
    (2, '8th Main Road');

-- Inner join users & rooms tables    
SELECT * FROM users
INNER JOIN rooms
ON rooms.owner_id = users.id;

SELECT
	users.id AS user_id,
    rooms.id AS room_id,
    email,
    street
FROM users
INNER JOIN rooms ON rooms.owner_id = users.id;

CREATE TABLE bookings(
	id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(guest_id) REFERENCES users(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);
ALTER TABLE bookings
ADD checkin DATE;

INSERT INTO bookings(guest_id, room_id, checkin)
VALUES
	(1, 1, '2022-12-25'),
    (2, 2, '2023-1-15'),
    (3, 2, '2022-2-10');

-- all rooms user has booked
SELECT 
	guest_id, street, checkin
FROM bookings
INNER JOIN rooms ON rooms.owner_id = guest_id
WHERE room_id = 1;

-- History of all guests who stayed in a room
SELECT 
	guest_id, street, checkin
FROM bookings
INNER JOIN users ON users.owner_id = guest_id
WHERE room_id = 2;