-- join 
-- number 1
SELECT *
FROM invoice
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.unit_price > .99;
-- number 2
SELECT invoice_date,first_name,last_name,total
FROM invoice
JOIN customer ON invoice.customer_id = customer.customer_id
-- number 3
SELECT customer.first_name,customer.last_name,employee.first_name,employee.last_name
FROM customer
JOIN employee ON customer.support_rep_id = employee.employee_id
-- number 4
SELECT artist.name,album.title
FROM artist
JOIN album ON artist.artist_id = album.artist_id;
-- number 5
SELECT pt.track_id
FROM playlist_track AS pt
JOIN playlist AS pl ON pt.playlist_id = pl.playlist_id
WHERE name = 'Music';
-- number 6
SELECT track.name
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5
-- number 7
SELECT track.name, playlist.name
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id
-- number 8
SELECT track.name, album.title
FROM track
JOIN album ON album.album_id = track.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk'

-- nested query
-- number 1
SELECT * 
FROM invoice 
WHERE invoice_id 
IN (SELECT invoice_id FROM invoice_line WHERE unit_price > .99)
-- number 2
SELECT * 
FROM playlist_track 
WHERE playlist_id 
IN (SELECT playlist_id FROM playlist WHERE name = 'Music')
-- number 3
SELECT name
FROM track
WHERE track_id 
IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5)
-- number 4
SELECT *
FROM track
WHERE genre_id 
IN (SELECT genre_id FROM genre WHERE name = 'Comedy')
-- number 5
SELECT * 
FROM track 
WHERE album_id 
IN (SELECT album_id FROM album WHERE title = 'Fireball')
-- number 6
SELECT * 
FROM track 
WHERE album_id 
IN (SELECT album_id FROM album WHERE artist_id
IN (SELECT album_id from artist WHERE name = 'Queen'))

-- updating rows
-- number 1
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL 
-- number 2
UPDATE customer
SET company = 'Self'
WHERE company IS NULL 
-- number 3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';
-- number 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'
-- number 5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS NULL

-- group by 
-- number 1
SELECT genre.name, count(*)
FROM track
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name
-- number 2
SELECT genre.name, count(*)
FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name
-- number 3
SELECT artist.name, count(*)
FROM artist
JOIN album ON artist.artist_id = album.artist_id
GROUP BY artist.name

-- distinct
-- number 1
SELECT DISTINCT composer FROM track
-- number 2
SELECT DISTINCT billing_postal_code FROM invoice
-- number 3
SELECT DISTINCT company FROM customer

-- delete
-- number 1
DELETE FROM practice_delete
WHERE type = 'bronze'
-- number 2
DELETE FROM practice_delete
WHERE type = 'silver'
-- number 3
DELETE FROM practice_delete
WHERE value = 150


-- e-commerce
CREATE TABLE users (user_id serial PRIMARY KEY, name VARCHAR(50), email VARCHAR(50));
CREATE TABLE products (product_id serial PRIMARY KEY, name VARCHAR(50), price VARCHAR(50));
CREATE TABLE orders (order_id serial PRIMARY KEY , product_id INTEGER REFERENCES products(product_id));

INSERT INTO users (name,email)
VALUES ('John','johnnyboi304@gow.co');
INSERT INTO users (name,email)
VALUES ('Donald','grandeDUCK@yafw.co');
INSERT INTO users (name,email)
VALUES ('Sandy','beach1@aws.co');

INSERT INTO products (name,price)
VALUES ('Sandwhich', 10);
INSERT INTO products (name,price)
VALUES ('Handburger',12);
INSERT INTO products (name,price)
VALUES ('Chicken',11);

INSERT INTO orders (product_id)
VALUES (1);
INSERT INTO orders (product_id)
VALUES (2);
INSERT INTO orders (product_id)
VALUES (3);

SELECT * FROM orders

SELECT price
FROM orders
JOIN products ON products.product_id = orders.product_id

ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id)

SELECT * FROM ORDERS
