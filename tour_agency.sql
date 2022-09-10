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

-- ЛР 3

CREATE TABLE contacts (
id serial PRIMARY KEY,
phones text[],
schedule text[][]);

INSERT INTO contacts VALUES (default, '{"(383)-123-45-67", "(383)-890-12-34", "(383)-567-89-01"}', '{{"09:00", "18:00"}, {"09:00", "18:00"}, {"09:00", "18:00"}, {"10:00", "18:00"}, {"10:00", "18:00"}}');

SELECT phones[1] FROM contacts;

SELECT schedule[2:4][1:1] FROM contacts WHERE id = 1;

SELECT array_dims(phones), array_dims(schedule) FROM contacts;

UPDATE contacts SET schedule[4:5][1:1] = '{{"12:00", "12:00"}}';

UPDATE contacts SET phones[2] = '+7-913-546-89-23' WHERE id = 5;

SELECT (id, type, price) FROM tours t
WHERE t.price =
(SELECT MIN(price) FROM tours t
WHERE t.type = 'авиа');

SELECT (id, type, price) FROM tours t
WHERE t.price =
(SELECT MAX(price) FROM tours t
WHERE t.type = 'железнодорожный');

SELECT COUNT(*) FROM tours t
WHERE t.type = 'автобусный';

SELECT AVG(price)
FROM tours t
JOIN cities c ON t.id_city = c.id
WHERE c.name = 'Москва';

ALTER TABLE guides ADD COLUMN work_experience integer;
UPDATE guides SET work_experience = 2002 - EXTRACT(year FROM date_of_birth);

SELECT SUM(t.price)
FROM tours t
JOIN journeys j ON j.tour_id = t.id
JOIN guides g ON j.tour_id = g.id
WHERE g.work_experience > 10;

-- ЛР 4

-- Найти всех руководителей туров, которые обслуживают 
-- только  автобусные  туры  и  выполнившие  заказы  на  туры  со  стоимостью 
-- больше,  чем  средняя  стоимость  заказов на  все  туры, выполненные за 
-- последние три месяца
SELECT g.surname
FROM guides g
JOIN journeys j ON j.guide_id = g.id
JOIN tours t ON j.tour_id = t.id
WHERE t.type = 'автобусный' AND t.type <> 'авиа'AND t.type <> 'железнодорожный' AND
t.price > (
SELECT AVG(price) FROM tours
WHERE (age('today', start_date) <= '3 months')
);

-- Найти все туры, выполненные за последний месяц, и 
-- со  стоимостью  больше,  чем  средняя  стоимость  железнодорожных  туров, 
-- выполненных за последние две недели
SELECT * FROM tours  
WHERE (age('today', start_date) <= interval '1 month') AND
price > (
SELECT AVG(price)
FROM tours 
WHERE type = 'железнодорожный' AND
(age('today', start_date) <= '2 weeks')
);

-- Нацелен на
ALTER TABLE tours ADD COLUMN objective text;

UPDATE TABLE tours SET objective = '' WHERE id = 1;

-- Найти все авиатуры в страны Турция 
-- и Египет,  предлагаемые для семейного отдыха и чья стоимость  больше, чем 
-- средняя стоимость туров, позиционируемых как туры-шопинги
SELECT t.type, t.price, t.objective, c.name
FROM tours t
JOIN cities c ON t.id_city = c.id
WHERE t.type = 'авиа' AND
t.objective = 'семейный отдых' AND
t.price > (
SELECT AVG(price) FROM tours
WHERE objective = 'шоппинг') AND
(c.name = 'Турция' OR c.name = 'Египет');

-- ЛР 5

CREATE TABLE tours2 (
id integer,
type varchar,
price numeric,
duration_days integer,
id_city integer,
PRIMARY KEY(id),
FOREIGN KEY(id_city) REFERENCES cities(id)
);

create function add_n(int) returns char 
as 'declare t int; begin
select max(id) into t from tours2;
for k in (t+1)..($1+t+1) loop
insert into tours2 values 
(k, ''авиа''||round(random()*1000), 
round(10000+random()*100000),
round(3+random()*18),
round(1+random()*13));
end loop; return''Done!'';
end;'
language 'plpgsql';

-- вставить значение перед вызовом функции add_n(int)

EXPLAIN ANALYZE select * from tours2 where price = 50000;
CREATE INDEX price_index ON tours2 USING BTREE(price);
CREATE INDEX price_index ON tours2 USING HASH(price);

EXPLAIN ANALYZE select * from tours2 where upper(type) = 'авиа500';
CREATE INDEX type_index ON tours2 (upper(type));

-- 1
SELECT g.id, g.surname, g.date_of_birth, g.work_experience
FROM guides g
JOIN journeys j ON j.guide_id = g.id
JOIN tours t ON j.tour_id = t.id
JOIN cities c ON t.id_city = c.id
WHERE t.type = 'авиа' AND
c.name = 'Москва';

-- 2
tour_agency=# SELECT * FROM tours t
tour_agency-# WHERE (t.duration BETWEEN 5 AND 15) AND
tour_agency-# (t.price BETWEEN 5000 AND 25000);

-- 3
SELECT * FROM tours
WHERE type = 'автобусный' AND
age('today', start_date) >= interval '-1 month' AND
age('today', start_date) <= interval '0 days';

-- 4
SELECT t.type, g.surname, g.work_experience
FROM tours t
JOIN journeys j ON j.tour_id = t.id
JOIN guides g ON j.guide_id = g.id
WHERE t.type = 'железнодорожный' AND
g.work_experience BETWEEN 5 AND 10;

-- 5
SELECT t.type, j.members_count, c.name
FROM tours t
JOIN journeys j ON j.tour_id = t.id
JOIN cities c ON t.id_city = c.id
WHERE (t.type = 'автобусный' OR t.type = 'авиа') AND
(c.name = 'Польша' OR c.name = 'Германия') AND
j.members_count > 20;