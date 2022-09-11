--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-11 23:07:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 221 (class 1255 OID 25553)
-- Name: add_client(character varying, numeric, character varying, integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.add_client(_fullname character varying, _passport numeric, _gender character varying, _age integer) RETURNS character
    LANGUAGE plpgsql
    AS $$begin
if (select count(passport) from clients where passport=_passport)<>0 then
return 'Ошибка: Проверьте паспортные данные!';
end if;
if _gender<>'м' AND _gender<>'ж' then
return 'Ошибка: Укажите верный пол!';
end if;
if _age<18 then
return 'Ошибка: Возраст не прошел проверку!';
end if;
insert into clients values (default, _fullname, _passport, _gender, _age);
return 'Клиент успешно добавлен!';
end;$$;


ALTER FUNCTION public.add_client(_fullname character varying, _passport numeric, _gender character varying, _age integer) OWNER TO nstu;

--
-- TOC entry 234 (class 1255 OID 25556)
-- Name: add_guide(character varying, date, numeric, integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.add_guide(_fullname character varying, _date_of_birth date, _phone numeric, _work_experience integer) RETURNS character
    LANGUAGE plpgsql
    AS $$declare _we int; 
begin
if (2022-extract(year from _date_of_birth))<25 then
return 'Ошибка: Проверьте год рождения!';
end if;
if _phone<0 then
return 'Ошибка: Неверно указан номер телефона!';
end if;
if _work_experience<0 then
return 'Ошибка: Проверьте стаж работы!';
end if;
select work_experience into _we from guides where phone=_phone;
if _we <> 0 then
update guides set work_experience = _work_experience 
where phone=_phone;
else
insert into guides (fullname, date_of_birth, phone, work_experience) values (_fullname, _date_of_birth, _phone, _work_experience);
end if;
return 'Успешно!';
end;$$;


ALTER FUNCTION public.add_guide(_fullname character varying, _date_of_birth date, _phone numeric, _work_experience integer) OWNER TO nstu;

--
-- TOC entry 235 (class 1255 OID 25557)
-- Name: add_guide(integer, character varying, date, numeric, integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.add_guide(_id integer, _fullname character varying, _date_of_birth date, _phone numeric, _work_experience integer) RETURNS character
    LANGUAGE plpgsql
    AS $$declare _we int; 
begin
if (select count(*) from guides where id=_id and fullname=_fullname and date_of_birth=_date_of_birth and phone=_phone and work_experience=_work_experience)<>0 then
return 'Ошибка: Гид уже существует!';
end if;
if (2022-extract(year from _date_of_birth))<25 then
return 'Ошибка: Проверьте год рождения!';
end if;
if _phone<0 then
return 'Ошибка: Неверно указан номер телефона!';
end if;
if _work_experience<0 then
return 'Ошибка: Проверьте стаж работы!';
end if;
select work_experience into _we from guides where phone=_phone;
if _we <> 0 then
update guides set work_experience = _work_experience where id=_id;
else
insert into guides values (_id, _fullname, _date_of_birth, _phone, _work_experience);
end if;
return 'Успешно!';
end;$$;


ALTER FUNCTION public.add_guide(_id integer, _fullname character varying, _date_of_birth date, _phone numeric, _work_experience integer) OWNER TO nstu;

--
-- TOC entry 222 (class 1255 OID 25554)
-- Name: delete_client(integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.delete_client(_id integer) RETURNS character
    LANGUAGE plpgsql
    AS $$begin
if (select count(id) from clients where id=_id)=0 then
return 'Ошибка: Такого клиента не существует!';
end if;
delete from clients where id=_id;
return 'Клиент успешно удален!';
end;$$;


ALTER FUNCTION public.delete_client(_id integer) OWNER TO nstu;

--
-- TOC entry 236 (class 1255 OID 25558)
-- Name: delete_guide(integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.delete_guide(_id integer) RETURNS character
    LANGUAGE plpgsql
    AS $$begin
if (select count(id) from guides where id=_id)=0 then
return 'Ошибка: Такого гида не существует!';
end if;
delete from guides where id=_id;
return 'Гид успешно удален!';
end;$$;


ALTER FUNCTION public.delete_guide(_id integer) OWNER TO nstu;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 25531)
-- Name: bookings; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    sale_date date NOT NULL,
    client_id integer NOT NULL,
    guide_id integer NOT NULL,
    tour_id integer NOT NULL
);


ALTER TABLE public.bookings OWNER TO nstu;

--
-- TOC entry 219 (class 1259 OID 25530)
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO nstu;

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 219
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- TOC entry 210 (class 1259 OID 25478)
-- Name: cities; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(35) NOT NULL
);


ALTER TABLE public.cities OWNER TO nstu;

--
-- TOC entry 209 (class 1259 OID 25477)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO nstu;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 209
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 216 (class 1259 OID 25503)
-- Name: clients; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    fullname character varying(255) NOT NULL,
    passport numeric NOT NULL,
    gender character varying(1) DEFAULT 'м'::character varying NOT NULL,
    age integer
);


ALTER TABLE public.clients OWNER TO nstu;

--
-- TOC entry 215 (class 1259 OID 25502)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO nstu;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- TOC entry 212 (class 1259 OID 25485)
-- Name: guides; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.guides (
    id integer NOT NULL,
    fullname character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    phone numeric NOT NULL,
    work_experience integer NOT NULL
);


ALTER TABLE public.guides OWNER TO nstu;

--
-- TOC entry 211 (class 1259 OID 25484)
-- Name: guides_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.guides_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guides_id_seq OWNER TO nstu;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 211
-- Name: guides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.guides_id_seq OWNED BY public.guides.id;


--
-- TOC entry 214 (class 1259 OID 25494)
-- Name: tour_types; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.tour_types (
    id integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE public.tour_types OWNER TO nstu;

--
-- TOC entry 213 (class 1259 OID 25493)
-- Name: tour_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.tour_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tour_types_id_seq OWNER TO nstu;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 213
-- Name: tour_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.tour_types_id_seq OWNED BY public.tour_types.id;


--
-- TOC entry 218 (class 1259 OID 25512)
-- Name: tours; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    tour_type_id integer NOT NULL,
    price numeric NOT NULL,
    departure date NOT NULL,
    city_id integer NOT NULL,
    members_count integer NOT NULL,
    duration integer NOT NULL
);


ALTER TABLE public.tours OWNER TO nstu;

--
-- TOC entry 217 (class 1259 OID 25511)
-- Name: tours_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.tours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tours_id_seq OWNER TO nstu;

--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 217
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- TOC entry 3200 (class 2604 OID 25534)
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 25481)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 25506)
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 25488)
-- Name: guides id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides ALTER COLUMN id SET DEFAULT nextval('public.guides_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 25497)
-- Name: tour_types id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tour_types ALTER COLUMN id SET DEFAULT nextval('public.tour_types_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 25515)
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- TOC entry 3368 (class 0 OID 25531)
-- Dependencies: 220
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (1, '2021-11-02', 5, 4, 1);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (2, '2022-07-22', 2, 7, 2);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (3, '2022-08-01', 7, 5, 3);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (4, '2022-06-15', 13, 4, 4);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (5, '2021-12-10', 14, 6, 5);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (6, '2022-06-19', 12, 5, 6);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (7, '2022-07-30', 3, 4, 7);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (10, '2022-09-08', 1, 2, 22);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (11, '2022-03-02', 6, 3, 15);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (8, '2022-09-01', 15, 6, 19);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (9, '2021-10-23', 10, 1, 17);
INSERT INTO public.bookings (id, sale_date, client_id, guide_id, tour_id) VALUES (12, '2022-01-02', 11, 5, 16);


--
-- TOC entry 3358 (class 0 OID 25478)
-- Dependencies: 210
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.cities (id, name) VALUES (1, 'Москва');
INSERT INTO public.cities (id, name) VALUES (2, 'Санкт-Петербург');
INSERT INTO public.cities (id, name) VALUES (3, 'Екатеринбург');
INSERT INTO public.cities (id, name) VALUES (4, 'Новосибирск');
INSERT INTO public.cities (id, name) VALUES (5, 'Сочи');
INSERT INTO public.cities (id, name) VALUES (6, 'Пермь');
INSERT INTO public.cities (id, name) VALUES (7, 'Самара');
INSERT INTO public.cities (id, name) VALUES (8, 'Челябинск');
INSERT INTO public.cities (id, name) VALUES (9, 'Уфа');
INSERT INTO public.cities (id, name) VALUES (10, 'Омск');
INSERT INTO public.cities (id, name) VALUES (11, 'Волгоград');
INSERT INTO public.cities (id, name) VALUES (12, 'Барнаул');
INSERT INTO public.cities (id, name) VALUES (13, 'Турция');
INSERT INTO public.cities (id, name) VALUES (14, 'Египет');
INSERT INTO public.cities (id, name) VALUES (15, 'Польша');
INSERT INTO public.cities (id, name) VALUES (16, 'Германия');


--
-- TOC entry 3364 (class 0 OID 25503)
-- Dependencies: 216
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (1, 'Иванов И. И.', 5010635987, 'м', 39);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (3, 'Глебов Р. Н.', 5011657963, 'м', 46);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (4, 'Петров Л. Д.', 5011653214, 'м', 28);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (5, 'Кузьмин А. П.', 5000654893, 'м', 42);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (7, 'Дудкин А. В.', 5000654789, 'м', 51);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (8, 'Филиппов И. Р.', 5000325869, 'м', 47);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (10, 'Мурашов П. Ю.', 5004365987, 'м', 51);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (12, 'Журов К. П.', 5005698357, 'м', 59);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (13, 'Володин А. А.', 5005346896, 'м', 57);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (14, '3инаков А. В.', 5005345712, 'м', 24);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (2, 'Сидорова А. Р.', 5010698345, 'ж', 56);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (6, 'Доронина П. П.', 5000324785, 'ж', 44);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (9, 'Шарикова В. Н.', 5002257986, 'ж', 30);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (11, 'Капустина А. И.', 5004365786, 'ж', 34);
INSERT INTO public.clients (id, fullname, passport, gender, age) VALUES (15, 'Варлакова С. С.', 5010635987, 'ж', 21);


--
-- TOC entry 3360 (class 0 OID 25485)
-- Dependencies: 212
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (2, 'Смирнов В.Ф.', '1996-04-17', 89137369654, 6);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (4, 'Попов К.Е.', '1992-03-15', 89131256789, 10);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (5, 'Васильев О.П.', '1994-05-09', 89136587548, 8);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (6, 'Петров М.М.', '1997-08-19', 89136589654, 5);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (7, 'Соколов Ф.А.', '1988-01-04', 89136578563, 14);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (8, 'Михайлов А.С.', '1982-02-13', 89135896575, 20);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (9, 'Новиков А.А.', '1987-04-12', 89136589545, 15);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (10, 'Фёдоров Л.К.', '1988-03-03', 89132531424, 14);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (3, 'Кузнецов А.Д.', '1993-06-20', 89136853496, 9);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (1, 'Иванов А.О.', '1994-08-07', 89139653780, 8);
INSERT INTO public.guides (id, fullname, date_of_birth, phone, work_experience) VALUES (13, 'Бутов А.К.', '1989-10-11', 89133862931, 12);


--
-- TOC entry 3362 (class 0 OID 25494)
-- Dependencies: 214
-- Data for Name: tour_types; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.tour_types (id, type) VALUES (1, 'автобусный');
INSERT INTO public.tour_types (id, type) VALUES (2, 'автомобильный');
INSERT INTO public.tour_types (id, type) VALUES (3, 'железнодорожный');
INSERT INTO public.tour_types (id, type) VALUES (4, 'авиа');
INSERT INTO public.tour_types (id, type) VALUES (5, 'водный');


--
-- TOC entry 3366 (class 0 OID 25512)
-- Dependencies: 218
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (1, 1, 50000, '2022-01-01', 13, 36, 35);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (2, 4, 23000, '2022-09-02', 10, 36, 6);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (3, 4, 91000, '2022-09-20', 6, 31, 16);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (4, 2, 68000, '2022-09-09', 9, 15, 22);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (5, 2, 14000, '2022-01-15', 7, 27, 8);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (6, 3, 56000, '2022-07-09', 13, 43, 6);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (7, 4, 26000, '2022-08-31', 9, 44, 15);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (8, 3, 96000, '2022-08-11', 12, 43, 5);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (9, 4, 75000, '2022-09-04', 12, 44, 19);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (10, 4, 26000, '2022-08-29', 11, 44, 21);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (11, 2, 83000, '2022-09-03', 8, 45, 25);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (12, 3, 8000, '2022-08-15', 2, 14, 5);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (13, 3, 80000, '2022-06-06', 12, 38, 19);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (14, 4, 25000, '2022-08-01', 14, 17, 39);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (15, 4, 38000, '2022-04-01', 15, 29, 14);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (16, 4, 20000, '2022-01-23', 12, 40, 10);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (17, 1, 97000, '2021-12-29', 8, 34, 29);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (18, 5, 42000, '2022-02-17', 2, 15, 17);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (19, 2, 97000, '2022-10-08', 13, 38, 32);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (20, 5, 18000, '2022-09-22', 2, 35, 3);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (21, 1, 57000, '2022-10-02', 3, 15, 5);
INSERT INTO public.tours (id, tour_type_id, price, departure, city_id, members_count, duration) VALUES (22, 5, 93000, '2022-10-01', 9, 29, 29);


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 219
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.bookings_id_seq', 12, true);


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 209
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, false);


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.clients_id_seq', 16, true);


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 211
-- Name: guides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.guides_id_seq', 3, true);


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 213
-- Name: tour_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.tour_types_id_seq', 5, true);


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 217
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.tours_id_seq', 22, true);


--
-- TOC entry 3212 (class 2606 OID 25536)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 25483)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 3208 (class 2606 OID 25510)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 25492)
-- Name: guides guides_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 25501)
-- Name: tour_types tour_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tour_types
    ADD CONSTRAINT tour_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 25519)
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- TOC entry 3215 (class 2606 OID 25537)
-- Name: bookings bookings_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- TOC entry 3216 (class 2606 OID 25542)
-- Name: bookings bookings_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guides(id);


--
-- TOC entry 3217 (class 2606 OID 25547)
-- Name: bookings bookings_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- TOC entry 3214 (class 2606 OID 25525)
-- Name: tours tours_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- TOC entry 3213 (class 2606 OID 25520)
-- Name: tours tours_tour_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_tour_type_id_fkey FOREIGN KEY (tour_type_id) REFERENCES public.tour_types(id);


-- Completed on 2022-09-11 23:07:16

--
-- PostgreSQL database dump complete
--

