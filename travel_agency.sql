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
-- Общий функционал для работы с бд
-- добавить клиента OK
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
-- удалить клиента OK
create or replace function delete_client(_id integer) returns char(50) as 'begin
if (select count(id) from clients where id=_id)=0 then
return ''Ошибка: Такого клиента не существует!'';
end if;
delete from clients where id=_id;
delete from bookings where client_id=_id;
return ''Клиент успешно удален!'';
end;' language 'plpgsql';
-- нанять гида ОК
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
-- уволить гида ОК
create or replace function delete_guide(_id integer) returns char(50) as 'begin
if (select count(id) from guides where id=_id)=0 then
return ''Ошибка: Такого гида не существует!'';
end if;
delete from guides where id=_id;
delete from bookings where guide_id=_id;
return ''Гид успешно удален!'';
end;' language 'plpgsql';
-- добавить тур ОК
create or replace function add_tour(
        _id integer,
        _tt_id integer,
        _price integer,
        _departure date,
        _city_id integer,
        _members_count integer,
        _duration integer
    ) returns char(50) as 'begin
if (select count(id) from tours where id=_id)<>0 then
return ''Ошибка: Тур с таким id уже существует!'';
end if;
if (select count(id) from tour_types where id=_tt_id)=0 then
return ''Ошибка: Некорректный тип тура!'';
end if;
if _price<0 then
return ''Ошибка: Цена должна быть положительной!'';
end if;
if age(''today'', _departure) >= interval ''1 day'' then
return ''Ошибка: Проверьте дату отправления!'';
end if;
if (select count(id) from cities where id=_city_id)=0 then
return ''Ошибка: Некорректный id города!'';
end if;
if (select count(*) from tour_types where id=_tt_id)=0 then
return ''Ошибка: Некорректный тип тура!'';
end if;
if (_members_count < 10 or _members_count > 45) then
return ''Ошибка: Проверьте количество участников тура!'';
end if;
if _duration<=0 then
return ''Ошибка: Проверьте продолжительность тура!'';
end if;
insert into tours values (_id, _tt_id, _price, _departure, _city_id, _members_count, _duration);
return ''Успешно: Тур создан!'';
end;' language 'plpgsql';
-- удалить тур ОК
create or replace function delete_tour(_id integer) returns char(50) as 'begin
if (select count(id) from tours where id=_id)=0 then
return ''Ошибка: Такого тура не существует!'';
end if;
delete from tours where id=_id;
delete from bookings where tour_id=_id;
return ''Тур успешно удален!'';
end;' language 'plpgsql';
-- добавить заказ ОК
create or replace function add_booking(
        _id integer,
        _sale_date date,
        _c_id integer,
        _g_id integer,
        _t_id integer
    ) returns char(50) as 'begin
if (select count(id) from bookings where id=_id)<>0 then
return ''Ошибка: Заказ с таким id уже существует!'';
end if;
if age(''today'', _sale_date) >= interval ''1 day'' then
return ''Ошибка: Проверьте дату заказа!'';
end if;
if (select count(id) from cities where id=_c_id)=0 then
return ''Ошибка: Проверьте id города!'';
end if;
if (select count(id) from guides where id=_g_id)=0 then
return ''Ошибка: Проверьте id гида!'';
end if;
if (select count(id) from tours where id=_t_id)=0 then
return ''Ошибка: Проверьте id тура!'';
end if;
insert into bookings values (_id, _sale_date, _c_id, _g_id, _t_id);
return ''Успешно: Заказ добавлен!'';
end;' language 'plpgsql';
-- удалить заказ ОК
create or replace function delete_booking(_id integer) returns char(50) as 'begin
if (select count(id) from bookings where id=_id)=0 then
return ''Ошибка: Такого заказа не существует!'';
end if;
delete from bookings where id=_id;
return ''Заказ успешно удален!'';
end;' language 'plpgsql';
-- выдать  рекомендации  для  клиента  с  учетом  его 
-- пола,  возраста  и  выполненных  туров  на  основании  общей  статистики
--
--          идея: выдавать для М(Ж) только туры из заказов, у которых клиет М(Ж) и возраст +-8 лет. ОК
create or replace function get_recomend_tours(_client_id integer) returns table (_tour_id integer) as '
declare _gender varchar(1);
declare _age integer;
begin 
if (select count(*) from clients where id=_client_id)=0 then return;
end if;
select gender into _gender from clients where id=_client_id;
select age into _age from clients where id=_client_id;
return query select tour_id from bookings b join clients c on b.client_id = c.id
where c.gender=_gender AND (c.age >= _age-8 AND c.age <= _age+8);
end;' language 'plpgsql';
--
-- популярность  туров  в  зависимости  от  вида  тура  (автобусный, 
-- железнодорожный, авиа)
--
--          идея: собрать кол-во туров (рейтинг) каждого вида и вывести по возрастанию кол-ва
--
CREATE TABLE tour_types_rating(varchar(30), integer);
INSERT INTO tour_types_rating
values ('автобусный', 0),
    ('железнодорожный', 0),
    ('авиа', 0);
create or replace function get_tour_types_rating() returns table (name varchar(30), c integer) as '
declare _count_bus integer;
declare _count_train integer;
declare _count_air integer;
begin
select count(*) into _count_bus from tours t join tour_types tt on t.tour_type_id = tt.id 
where tt.type=''автобусный'';
select count(*) into _count_train from tours t join tour_types tt on t.tour_type_id = tt.id 
where tt.type=''железнодорожный'';
select count(*) into _count_air from tours t join tour_types tt on t.tour_type_id = tt.id 
where tt.type=''авиа'';
update tour_types_rating set count = _count_bus where type = ''автобусный'';
update tour_types_rating set count = _count_train where type = ''железнодорожный'';
update tour_types_rating set count = _count_air where type = ''авиа'';
return query select * from tour_types_rating order by count desc;
end;' language 'plpgsql';
-- среднее время длительности тура в зависимости от сезона  
-- (например,  лето,  осень,  зима,  весна), 
--
--          идея: вывести среднее число дней. входной параместр - сезон.
--
create or replace function get_avg_duration_in_season(season varchar(5)) returns integer as '
declare month integer;
begin
if (upper(season)=''ЛЕТО'') then
return avg(duration) from tours where (select extract(month from departure)) >= 6 
and (select extract(month from departure)) <= 8;
end if;
if (upper(season)=''ЗИМА'') then
return avg(duration) from tours where (select extract(month from departure)) = 1 
or (select extract(month from departure)) = 2 or (select extract(month from departure)) = 12;
end if;
if (upper(season)=''ОСЕНЬ'') then
return avg(duration) from tours where (select extract(month from departure)) >= 9 
and (select extract(month from departure)) <= 11;
end if;
if (upper(season)=''ВЕСНА'') then
return avg(duration) from tours where (select extract(month from departure)) >= 3 
and (select extract(month from departure)) <= 5;
end if;
return -1;
end;' language 'plpgsql';
-- стоимость  тура  (средняя, максимальная, минимальная) 
-- в зависимости от города
--
create or replace function get_tours_prices_by_city_id(_city_id integer) returns table (
        city varchar(35),
        max numeric,
        avg numeric,
        min numeric
    ) as '
declare city varchar(30);
declare max numeric;
declare avg numeric;
declare min numeric;
begin
if (select count(id) from tours where city_id=_city_id)=0 then
return;
end if;
select name into city from cities where id=_city_id;
select MAX(price) into max from tours where city_id=_city_id;
select AVG(price) into avg from tours where city_id=_city_id;
select MIN(price) into min from tours where city_id=_city_id;
return query
select city, max, avg, min;
end;' language 'plpgsql';
-- анализ спроса туров среди путешественников местных и иногородних
--
--          идея: добавить столбец id города для клиента. входной параметр - id города. выходные - число туров с местными и число туров с иногородници клиентами.
ALTER TABLE clients
ADD COLUMN city_id integer REFERENCES cities(id);
UPDATE clients
SET city_id = round(1 + random() * 15);
create or replace function get_tour_city_demands(_city_id integer) returns table (_in integer, _out integer) as '
declare _in integer;
declare _out integer;
begin
if (select count(*) from cities where id=_city_id)=0 then
return;
end if;
select count(*) into _in from tours t join bookings b 
on b.tour_id=t.id join clients c on c.id=b.client_id 
where t.city_id=_city_id AND t.city_id=c.city_id;
select count(*) into _out from tours t join bookings b 
on b.tour_id=t.id join clients c on c.id=b.client_id 
where t.city_id=_city_id AND t.city_id<>c.city_id;
return query select _in, _out;
end;' language 'plpgsql';
-- индексы
-- наверное стоит добавить индесы только для полей:
-- clients.age, tours.duration, tours.price, tours.members_count.
CREATE INDEX age_index ON clients USING HASH(age);
CREATE INDEX duration_index ON tours USING HASH(duration);
CREATE INDEX price_index ON tours USING HASH(price);
CREATE INDEX members_index ON tours USING HASH(members_count);
-- роли
-- оператор
CREATE ROLE operator;
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON cities,
    clients,
    bookings,
    tours,
    tour_types,
    guides TO operator;
-- пользователь
CREATE ROLE user_db;
GRANT SELECT,
    INSERT,
    UPDATE ON cities,
    clients,
    bookings,
    tours,
    tour_types,
    guides TO user_db;
-- аналитик
CREATE ROLE analyst;
GRANT SELECT ON cities,
    clients,
    bookings,
    tours,
    tour_types,
    guides TO analyst;
GRANT EXECUTE ON FUNCTION get_tour_city_demands,
    get_tours_prices_by_city_id,
    get_avg_duration_in_season,
    get_tour_types_rating,
    get_recomend_tours TO analyst;
-- админ
CREATE ROLE admin SUPERUSER CREATEROLE CREATEDB;
-- 8
-- функция для удаления тура из таблицы заказов
create function delete_tour_trigger() returns trigger as '
begin
if (select count(*) from bookings b where b.tour_id=OLD.id)<>0 
then delete from bookings b where b.tour_id=OLD.id;
end if;
return OLD;
end;' language 'plpgsql';
-- триггер
create trigger tour_trigger before delete on tours for each row execute procedure delete_tour_trigger();
-- создание последовательности
create sequence seq1 increment by 1 start with 25;
-- alter
alter table tours
add column name text;
-- перегрузки
-- нет имени тура - Tur + seq1
create function f(text, text) returns text as '
begin 
if $1 is null then return $2;
else return $1;
end if;
end;' language 'plpgsql';
-- нет города - Калининград
create function f(integer, integer) returns integer as '
begin 
if $1 is null then return $2;
else return $1;
end if;
end;' language 'plpgsql';
-- длительность тура - нет/<=7 -> 7 для Калининграда, 0 - ост
-- создание функции перед добавлением тура
create function insert_tour_trigger() returns trigger as '
begin
NEW.name=f(NEW.name, ''Tur''||trim(to_char(nextval(''seq1''),''99999'')));
NEW.city_id=f(NEW.city_id, 17);
if (f(NEW.duration,7)<=7) then
if NEW.city_id=17 then NEW.duration=7;
else NEW.duration=0;
end if;
end if;
return NEW;
end;' language 'plpgsql';
-- триггер 2
create trigger tour_trigger2 before
insert on tours for each row 
execute procedure insert_tour_trigger();