CREATE DATABASE tour_agency;

CREATE TABLE cities (
id serial NOT NULL,
name varchar(35) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE guides (
id serial NOT NULL,
surname varchar(25) NOT NULL,
date_of_birth date NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE tours (
id serial NOT NULL,
type text NOT NULL,
price numeric NOT NULL,
start_date date NOT NULL,
id_city integer NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(id_city) REFERENCES cities(id)
);

CREATE TABLE journeys (
id serial NOT NULL,
order_date date NOT NULL,
order_no integer NOT NULL,
tour_id integer NOT NULL,
guide_id integer NOT NULL,
members_count integer NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(tour_id) REFERENCES tours(id),
FOREIGN KEY(guide_id) REFERENCES guides(id)
);

INSERT INTO journeys (order_date, order_no, tour_id, guide_id, members_count) VALUES 
('2022-10-20', 653244, 1, 6, 60), 
('2023-01-01', 655492, 2, 2, 13), 
('2023-01-21', 658563, 3, 9, 54), 
('2023-02-20', 662904, 4, 1, 28), 
('2023-04-18', 665290, 5, 10, 15), 
('2023-05-01', 668924, 6, 2, 21), 
('2023-07-02', 675920, 7, 5, 48), 
('2023-08-13', 681289, 8, 6, 20), 
('2023-09-04', 689542, 9, 8, 19), 
('2023-10-28', 691435, 10, 7, 23);

INSERT INTO cities (name) VALUES ('Москва'), ('Санкт-Петербург'), ('Екатеринбург'), ('Новосибирск'), ('Сочи'), ('Пермь'), ('Самара'), ('Челябинск'), ('Уфа'), ('Омск'), ('Волгоград');

-- автобусный, железнодорожный, авиа
INSERT INTO tours (type, price, start_date, id_city) VALUES ('железнодорожный', 24000, '2022-12-29', 2), 
('автобусный', 5000, '2023-01-23', 4), 
('железнодорожный', 14000, '2023-02-17', 7), 
('авиа', 40000, '2023-04-01', 1), 
('авиа', 27000, '2023-05-22', 9), 
('автобусный', 9700, '2023-06-06', 11), 
('железнодорожный', 11200, '2023-08-01', 3), 
('автобусный', 3500, '2023-09-03', 10), 
('авиа', 800000, '2023-10-15', 8), 
('железнодорожный', 33500, '2023-12-28', 6);

INSERT INTO guides (surname, date_of_birth) VALUES 
('Иванов', '1994-08-07'), 
('Смирнов', '1996-04-17'), 
('Кузнецов', '2001-06-20'), 
('Попов', '1992-03-15'), 
('Васильев', '1994-05-09'), 
('Петров', '1997-08-19'), 
('Соколов', '1988-01-04'), 
('Михайлов', '1982-02-13'), 
('Новиков', '1987-04-12'),
('Фёдоров', '1988-03-03');

CREATE TABLE result AS
SELECT j.order_date, g.surname, t.type, c.name, t.start_date, t.price
FROM journeys j
JOIN guides g ON j.guide_id = g.id
JOIN tours t ON j.tour_id = t.id
JOIN cities c ON t.id_city = c.id;

-- ЛР 2

ALTER TABLE tours ADD CONSTRAINT valid_type CHECK (type = 'автобусный' OR type = 'железнодорожный' OR type = 'авиа');

ALTER TABLE guides ADD CONSTRAINT over_25 CHECK (2022 - EXTRACT(year FROM date_of_birth) >= 25);

ALTER TABLE tours ADD CONSTRAINT positive_price CHECK (price > 0);

ALTER TABLE journeys ADD CONSTRAINT valid_amount CHECK (members_count >= 10 AND members_count <= 25);

BEGIN;
ALTER TABLE cities ADD COLUMN population integer;
ROLLBACK;