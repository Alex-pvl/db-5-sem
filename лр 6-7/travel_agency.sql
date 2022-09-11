CREATE DATABASE travel_agency OWNER nstu;
CREATE TABLE cities (
  id serial NOT NULL,
  name varchar(35) NOT NULL,
  PRIMARY KEY(id)
);
CREATE TABLE guides (
  id serial NOT NULL,
  fullname varchar(255) NOT NULL,
  date_of_birth date NOT NULL,
  phone numeric NOT NULL,
  work_experience integer NOT NULL,
  PRIMARY KEY(id)
);
CREATE TABLE tour_types (
  id serial NOT NULL,
  type text NOT NULL,
  PRIMARY KEY(id)
);
CREATE TABLE clients (
  id serial NOT NULL,
  fullname varchar(255) NOT NULL,
  passport numeric NOT NULL,
  gender varchar(1) NOT NULL DEFAULT 'м',
  age integer,
  PRIMARY KEY(id)
);
CREATE TABLE tours (
  id serial NOT NULL,
  tour_type_id integer NOT NULL,
  price numeric NOT NULL,
  departure date NOT NULL,
  city_id integer NOT NULL,
  members_count integer NOT NULL,
  duration integer NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(tour_type_id) REFERENCES tour_types(id),
  FOREIGN KEY(city_id) REFERENCES cities(id)
);
CREATE TABLE bookings (
  id serial NOT NULL,
  sale_date date NOT NULL,
  client_id integer NOT NULL,
  guide_id integer NOT NULL,
  tour_id integer NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(client_id) REFERENCES clients(id),
  FOREIGN KEY(guide_id) REFERENCES guides(id),
  FOREIGN KEY(tour_id) REFERENCES tours(id)
);
INSERT INTO guides (
    id,
    fullname,
    date_of_birth,
    phone,
    work_experience
  )
VALUES (1, 'Иванов А.О.', '1994-08-07', 89139653780, 8),
  (2, 'Смирнов В.Ф.', '1996-04-17', 89137369654, 6),
  (4, 'Попов К.Е.', '1992-03-15', 89131256789, 10),
  (5, 'Васильев О.П.', '1994-05-09', 89136587548, 8),
  (6, 'Петров М.М.', '1997-08-19', 89136589654, 5),
  (7, 'Соколов Ф.А.', '1988-01-04', 89136578563, 14),
  (
    8,
    'Михайлов А.С.',
    '1982-02-13',
    89135896575,
    20
  ),
  (9, 'Новиков А.А.', '1987-04-12', 89136589545, 15),
  (
    10,
    'Фёдоров Л.К.',
    '1988-03-03',
    89132531424,
    14
  ),
  (3, 'Кузнецов А.Д.', '1993-06-20', 89136853496, 9);
INSERT INTO public.cities (id, name)
VALUES (1, 'Москва'),
  (2, 'Санкт-Петербург'),
  (3, 'Екатеринбург'),
  (4, 'Новосибирск'),
  (5, 'Сочи'),
  (6, 'Пермь'),
  (7, 'Самара'),
  (8, 'Челябинск'),
  (9, 'Уфа'),
  (10, 'Омск'),
  (11, 'Волгоград'),
  (12, 'Барнаул'),
  (13, 'Турция'),
  (14, 'Египет'),
  (15, 'Польша'),
  (16, 'Германия');
INSERT INTO tour_types (type)
VALUES ('автобусный'),
  ('автомобильный'),
  ('железнодорожный'),
  ('авиа'),
  ('водный');
INSERT INTO clients (fullname, passport)
VALUES ('Иванов И. И.', 5010635987),
  ('Сидоров А. Р.', 5010698345),
  ('Глебов Р. Н.', 5011657963),
  ('Петров Л. Д.', 5011653214),
  ('Кузьмин А. П.', 5000654893),
  ('Доронин П. П.', 5000324785),
  ('Дудкин А. В.', 5000654789),
  ('Филиппов И. Р.', 5000325869),
  ('Шариков А. Н.', 5002257986),
  ('Мурашов П. Ю.', 5004365987),
  ('Капустин А. И.', 5004365786),
  ('Журов К. П.', 5005698357),
  ('Володин А. А.', 5005346896),
  ('3инаков А. В.', 5005345712),
  ('Варлаков С. С.', 5010635987);
INSERT INTO tours (
    price,
    departure,
    city_id,
    members_count,
    duration,
    tour_type_id
  )
VALUES (
    round(1 + random() * 100) * 1000,
    'yyyy-mm-dd',
    round(1 + random() * 15),
    round(1 + random() * 24),
    round(1 + random() * 39),
    round(1 + random() * 4)
  );
INSERT INTO bookings (sale_date, client_id, guide_id, tour_id)
VALUES(
    '2021-11-02',
    round(1 + random() * 14),
    round(1 + random() * 9),
    1
  ),
  (
    '2022-07-22',
    round(1 + random() * 14),
    round(1 + random() * 9),
    2
  ),
  (
    '2022-08-01',
    round(1 + random() * 14),
    round(1 + random() * 9),
    3
  ),
  (
    '2022-06-15',
    round(1 + random() * 14),
    round(1 + random() * 9),
    4
  ),
  (
    '2021-12-10',
    round(1 + random() * 14),
    round(1 + random() * 9),
    5
  ),
  (
    '2022-06-19',
    round(1 + random() * 14),
    round(1 + random() * 9),
    6
  ),
  (
    '2022-07-30',
    round(1 + random() * 14),
    round(1 + random() * 9),
    7
  ),
  (
    '2022-09-01',
    round(1 + random() * 14),
    round(1 + random() * 9),
    19
  ),
  (
    '2021-10-23',
    round(1 + random() * 14),
    round(1 + random() * 9),
    17
  ),
  (
    '2022-09-08',
    round(1 + random() * 14),
    round(1 + random() * 9),
    22
  ),
  (
    '2022-03-02',
    round(1 + random() * 14),
    round(1 + random() * 9),
    15
  ),
  (
    '2022-01-02',
    round(1 + random() * 14),
    round(1 + random() * 9),
    16
  );
-- добавить клиента
create or replace function add_client(
    _fullname varchar(255),
    _passport numeric,
    _gender varchar(1),
    _age integer
  ) returns char(50) as 'begin
if (select count(passport) from clients where passport=_passport)<>0 then
return ''Ошибка: Проверьте паспортные данные!'';
end if;
if _gender<>''м'' AND _gender<>''ж'' then
return ''Ошибка: Укажите верный пол!'';
end if;
if _age<18 then
return ''Ошибка: Возраст не прошел проверку!'';
end if;
insert into clients values (default, _fullname, _passport, _gender, _age);
return ''Клиент успешно добавлен!'';
end;' language 'plpgsql';
-- удалить клиента
create or replace function delete_client(_id integer) returns char(50) as 'begin
if (select count(id) from clients where id=_id)=0 then
return ''Ошибка: Такого клиента не существует!'';
end if;
delete from clients where id=_id;
return ''Клиент успешно удален!'';
end;' language 'plpgsql';
-- нанять гида
create or replace function add_guide(
    _id integer,
    _fullname varchar(255),
    _date_of_birth date,
    _phone numeric,
    _work_experience integer
  ) returns char(50) as 'declare _we int; 
begin
if (select count(*) from guides where id=_id and fullname=_fullname 
and date_of_birth=_date_of_birth and phone=_phone and work_experience=_work_experience)<>0 then
return ''Ошибка: Гид уже существует!'';
end if;
if (2022-extract(year from _date_of_birth))<25 then
return ''Ошибка: Проверьте год рождения!'';
end if;
if _phone<0 then
return ''Ошибка: Неверно указан номер телефона!'';
end if;
if _work_experience<0 then
return ''Ошибка: Проверьте стаж работы!'';
end if;
select work_experience into _we from guides where phone=_phone;
if _we <> 0 then
update guides set work_experience = _work_experience where id=_id;
else
insert into guides values (_id, _fullname, _date_of_birth, _phone, _work_experience);
end if;
return ''Успешно!'';
end;' language 'plpgsql';
-- уволить гида
create or replace function delete_guide(_id integer) returns char(50) as 'begin
if (select count(id) from guides where id=_id)=0 then
return ''Ошибка: Такого гида не существует!'';
end if;
delete from guides where id=_id;
return ''Гид успешно удален!'';
end;' language 'plpgsql';
-- добавить тур
-- удалить тур
TODO: скрин тестов
create or replace function delete_tour(_id integer) returns char(50) as 'begin
if (select count(id) from tours where id=_id)=0 then
return ''Ошибка: Такого тура не существует!'';
end if;
delete from tours where id=_id;
return ''Тур успешно удален!'';
end;' language 'plpgsql';
-- добавить заказ
-- удалить заказ
TODO: скрин тестов
create or replace function delete_booking(_id integer) returns char(50) as 'begin
if (select count(id) from bookings where id=_id)=0 then
return ''Ошибка: Такого заказа не существует!'';
end if;
delete from bookings where id=_id;
return ''Заказ успешно удален!'';
end;' language 'plpgsql';