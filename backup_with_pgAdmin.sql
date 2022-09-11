--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-11 13:00:49

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
-- TOC entry 221 (class 1255 OID 25298)
-- Name: add_n(integer); Type: FUNCTION; Schema: public; Owner: nstu
--

CREATE FUNCTION public.add_n(integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$declare t integer; begin
select max(id) into t from tours2;
for k in (t+1)..($1+t+1) loop
insert into tours2 values 
(k, 'авиа'||round(random()*1000), 
round(10000+random()*100000),
round(3+random()*18),
round(1+random()*13));
end loop; return'Done!';
end;$_$;


ALTER FUNCTION public.add_n(integer) OWNER TO nstu;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 25119)
-- Name: cities; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(35) NOT NULL
);


ALTER TABLE public.cities OWNER TO nstu;

--
-- TOC entry 209 (class 1259 OID 25118)
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
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 209
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 219 (class 1259 OID 25209)
-- Name: contacts; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    phones text[],
    schedule text[]
);


ALTER TABLE public.contacts OWNER TO nstu;

--
-- TOC entry 218 (class 1259 OID 25208)
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO nstu;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 218
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- TOC entry 212 (class 1259 OID 25126)
-- Name: guides; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.guides (
    id integer NOT NULL,
    surname character varying(25) NOT NULL,
    date_of_birth date NOT NULL,
    work_experience integer,
    CONSTRAINT over_25 CHECK ((((2022)::numeric - EXTRACT(year FROM date_of_birth)) >= (25)::numeric))
);


ALTER TABLE public.guides OWNER TO nstu;

--
-- TOC entry 211 (class 1259 OID 25125)
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
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 211
-- Name: guides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.guides_id_seq OWNED BY public.guides.id;


--
-- TOC entry 216 (class 1259 OID 25147)
-- Name: journeys; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.journeys (
    id integer NOT NULL,
    order_date date NOT NULL,
    order_no integer NOT NULL,
    tour_id integer NOT NULL,
    guide_id integer NOT NULL,
    members_count integer NOT NULL,
    CONSTRAINT valid_amount CHECK (((members_count >= 10) AND (members_count <= 25)))
);


ALTER TABLE public.journeys OWNER TO nstu;

--
-- TOC entry 215 (class 1259 OID 25146)
-- Name: journeys_id_seq; Type: SEQUENCE; Schema: public; Owner: nstu
--

CREATE SEQUENCE public.journeys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journeys_id_seq OWNER TO nstu;

--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 215
-- Name: journeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.journeys_id_seq OWNED BY public.journeys.id;


--
-- TOC entry 217 (class 1259 OID 25193)
-- Name: result; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.result (
    order_date date,
    surname character varying(25),
    type text,
    name character varying(35),
    start_date date,
    price numeric
);


ALTER TABLE public.result OWNER TO nstu;

--
-- TOC entry 214 (class 1259 OID 25133)
-- Name: tours; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    type text NOT NULL,
    price numeric NOT NULL,
    start_date date NOT NULL,
    id_city integer NOT NULL,
    objective text,
    duration integer,
    CONSTRAINT positive_price CHECK ((price > (0)::numeric)),
    CONSTRAINT valid_type CHECK (((type = 'автобусный'::text) OR (type = 'железнодорожный'::text) OR (type = 'авиа'::text)))
);


ALTER TABLE public.tours OWNER TO nstu;

--
-- TOC entry 220 (class 1259 OID 25284)
-- Name: tours2; Type: TABLE; Schema: public; Owner: nstu
--

CREATE TABLE public.tours2 (
    id integer NOT NULL,
    type character varying,
    price numeric,
    duration_days integer,
    id_city integer
);


ALTER TABLE public.tours2 OWNER TO nstu;

--
-- TOC entry 213 (class 1259 OID 25132)
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
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 213
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- TOC entry 3193 (class 2604 OID 25122)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 25212)
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 25129)
-- Name: guides id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides ALTER COLUMN id SET DEFAULT nextval('public.guides_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 25150)
-- Name: journeys id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys ALTER COLUMN id SET DEFAULT nextval('public.journeys_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 25136)
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- TOC entry 3361 (class 0 OID 25119)
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
INSERT INTO public.cities (id, name) VALUES (13, 'Турция');
INSERT INTO public.cities (id, name) VALUES (14, 'Египет');
INSERT INTO public.cities (id, name) VALUES (12, 'Барнаул');
INSERT INTO public.cities (id, name) VALUES (15, 'Польша');
INSERT INTO public.cities (id, name) VALUES (16, 'Германия');


--
-- TOC entry 3370 (class 0 OID 25209)
-- Dependencies: 219
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.contacts (id, phones, schedule) VALUES (1, '{(383)-123-45-67,(383)-890-12-34,(383)-567-89-01}', '{{09:00,18:00},{09:00,18:00},{09:00,18:00},{12:00,18:00},{12:00,18:00}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (2, '{(383)-763-53-23,(383)-194-73-82,(383)-813-85-72}', '{{08:00,17:00},{08:00,17:00},{08:00,17:00},{12:00,16:00},{12:00,16:00}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (3, '{(383)-583-44-72,(383)-148-03-55,(383)-159-16-57}', '{{07:20,17:10},{07:20,17:10},{07:20,17:10},{12:00,17:10},{12:00,17:10}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (4, '{(383)-178-51-45,(383)-777-77-77,(383)-111-11-11}', '{{08:00,14:40},{08:00,14:40},{08:00,14:40},{12:00,14:40},{12:00,14:40}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (5, '{(383)-544-65-32}', '{{09:00,16:00},{09:00,16:00},{09:00,16:00},{12:00,16:00},{12:00,16:00}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (6, '{(383)-098-76-54,(383)-146-57-85}', '{{07:00,14:00},{07:00,14:00},{07:00,14:00},{12:00,14:00},{12:00,14:00}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (7, '{(383)-854-03-41}', '{{12:00,20:00},{12:00,20:00},{12:00,20:00},{12:00,20:00},{12:00,20:00}}');
INSERT INTO public.contacts (id, phones, schedule) VALUES (8, '{(383)-444-44-44,+7-913-546-89-23,(383)-999-99-99}', '{{11:00,19:00},{11:00,19:00},{11:00,19:00},{12:00,19:00},{12:00,19:00}}');


--
-- TOC entry 3363 (class 0 OID 25126)
-- Dependencies: 212
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (1, 'Иванов', '1994-08-07', 8);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (2, 'Смирнов', '1996-04-17', 6);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (4, 'Попов', '1992-03-15', 10);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (5, 'Васильев', '1994-05-09', 8);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (6, 'Петров', '1997-08-19', 5);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (7, 'Соколов', '1988-01-04', 14);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (8, 'Михайлов', '1982-02-13', 20);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (9, 'Новиков', '1987-04-12', 15);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (10, 'Фёдоров', '1988-03-03', 14);
INSERT INTO public.guides (id, surname, date_of_birth, work_experience) VALUES (3, 'Кузнецов', '1993-06-20', 9);


--
-- TOC entry 3367 (class 0 OID 25147)
-- Dependencies: 216
-- Data for Name: journeys; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (1, '2021-10-20', 653244, 1, 6, 25);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (2, '2022-01-01', 655492, 2, 2, 13);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (3, '2022-01-21', 658563, 3, 9, 21);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (4, '2022-02-20', 662904, 4, 1, 19);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (5, '2022-04-18', 665290, 5, 10, 15);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (7, '2022-07-02', 675920, 7, 5, 23);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (12, '2022-07-14', 175723, 13, 2, 23);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (9, '2022-01-01', 689542, 9, 8, 19);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (10, '2022-01-19', 691435, 10, 7, 23);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (6, '2022-05-01', 668924, 6, 1, 21);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (8, '2022-08-13', 681289, 8, 2, 20);
INSERT INTO public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) VALUES (13, '2022-06-04', 253431, 15, 1, 16);


--
-- TOC entry 3368 (class 0 OID 25193)
-- Dependencies: 217
-- Data for Name: result; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2021-10-20', 'Петров', 'железнодорожный', 'Санкт-Петербург', '2021-12-29', 24000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-01-01', 'Смирнов', 'автобусный', 'Новосибирск', '2022-01-23', 5000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-01-21', 'Новиков', 'железнодорожный', 'Самара', '2022-02-17', 14000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-02-20', 'Иванов', 'авиа', 'Москва', '2022-04-01', 40000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-04-18', 'Фёдоров', 'авиа', 'Уфа', '2022-05-22', 27000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-05-01', 'Смирнов', 'автобусный', 'Волгоград', '2022-06-06', 9700);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-07-02', 'Васильев', 'железнодорожный', 'Екатеринбург', '2022-08-01', 11200);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-08-13', 'Петров', 'автобусный', 'Омск', '2022-09-03', 3500);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-09-04', 'Михайлов', 'авиа', 'Челябинск', '2022-10-15', 40000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-10-28', 'Соколов', 'железнодорожный', 'Пермь', '2022-12-28', 33500);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-07-14', 'Смирнов', 'автобусный', 'Екатеринбург', '2022-08-15', 13000);
INSERT INTO public.result (order_date, surname, type, name, start_date, price) VALUES ('2022-06-04', 'Смирнов', 'автобусный', 'Москва', '2022-07-09', 14700);


--
-- TOC entry 3365 (class 0 OID 25133)
-- Dependencies: 214
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (22, 'автобусный', 5300, '2022-09-13', 7, 'шоппинг', 20);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (23, 'автобусный', 1200, '2022-09-20', 3, 'шоппинг', 19);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (24, 'авиа', 20000, '2022-10-01', 8, 'шоппинг', 6);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (25, 'железнодорожный', 8000, '2022-10-02', 5, 'шоппинг', 21);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (26, 'автобусный', 9900, '2022-09-22', 1, 'шоппинг', 15);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (27, 'авиа', 40000, '2022-10-08', 9, 'шоппинг', 13);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (3, 'железнодорожный', 14000, '2022-02-17', 15, 'семейный отдых', 14);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (1, 'железнодорожный', 24000, '2021-12-29', 15, 'шоппинг', 5);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (2, 'автобусный', 5000, '2022-01-23', 15, 'образовательный', 13);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (4, 'авиа', 40000, '2022-04-01', 16, 'шоппинг', 17);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (7, 'железнодорожный', 11200, '2022-08-01', 16, 'шоппинг', 15);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (5, 'авиа', 27000, '2022-05-22', 16, 'образовательный', 5);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (6, 'авиа', 9700, '2022-06-06', 16, 'семейный отдых', 11);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (13, 'автобусный', 13000, '2022-08-15', 3, 'шоппинг', 14);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (10, 'железнодорожный', 33500, '2022-02-15', 6, 'шоппинг', 3);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (8, 'автобусный', 3500, '2022-09-03', 10, 'образовательный', 14);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (14, 'железнодорожный', 8000, '2022-08-29', 6, 'образовательный', 18);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (17, 'железнодорожный', 1200, '2022-09-04', 1, 'образовательный', 13);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (20, 'авиа', 5000, '2022-08-11', 5, 'образовательный', 14);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (19, 'авиа', 5000, '2022-08-31', 14, 'шоппинг', 10);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (15, 'авиа', 14700, '2022-07-09', 14, 'семейный отдых', 4);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (9, 'авиа', 40000, '2022-01-15', 13, 'семейный отдых', 10);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (18, 'авиа', 22000, '2022-09-09', 14, 'семейный отдых', 3);
INSERT INTO public.tours (id, type, price, start_date, id_city, objective, duration) VALUES (21, 'авиа', 25000, '2022-09-02', 14, 'семейный отдых', 19);


--
-- TOC entry 3371 (class 0 OID 25284)
-- Dependencies: 220
-- Data for Name: tours2; Type: TABLE DATA; Schema: public; Owner: nstu
--

INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (1, 'авиа1', 100000, 22, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (2, 'авиа186', 77786, 8, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (3, 'авиа608', 51526, 15, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (4, 'авиа887', 69792, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (5, 'авиа329', 29712, 6, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (6, 'авиа371', 101419, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (7, 'авиа215', 50819, 18, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (8, 'авиа571', 22326, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (9, 'авиа76', 54185, 6, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (10, 'авиа93', 65354, 13, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (11, 'авиа824', 54227, 18, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (12, 'авиа214', 43689, 7, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (13, 'авиа924', 53516, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (14, 'авиа172', 66106, 16, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (15, 'авиа360', 12382, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (16, 'авиа107', 55822, 6, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (17, 'авиа211', 109458, 6, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (18, 'авиа670', 25758, 3, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (19, 'авиа689', 46407, 12, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (20, 'авиа499', 58436, 17, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (21, 'авиа220', 47055, 4, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (22, 'авиа217', 62277, 20, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (23, 'авиа708', 76257, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (24, 'авиа592', 27694, 5, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (25, 'авиа659', 57028, 14, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (26, 'авиа767', 86203, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (27, 'авиа237', 95839, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (28, 'авиа286', 83654, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (29, 'авиа644', 35442, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (30, 'авиа708', 14725, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (31, 'авиа442', 42176, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (32, 'авиа211', 29990, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (33, 'авиа563', 100444, 6, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (34, 'авиа518', 19161, 9, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (35, 'авиа789', 30896, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (36, 'авиа850', 94486, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (37, 'авиа426', 70811, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (38, 'авиа375', 46863, 5, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (39, 'авиа753', 55293, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (40, 'авиа810', 23848, 20, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (41, 'авиа561', 16093, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (42, 'авиа405', 83554, 7, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (43, 'авиа787', 71238, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (44, 'авиа530', 11324, 16, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (45, 'авиа784', 13108, 20, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (46, 'авиа493', 47114, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (47, 'авиа275', 15200, 3, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (48, 'авиа989', 60664, 16, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (49, 'авиа385', 68556, 11, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (50, 'авиа835', 28841, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (51, 'авиа462', 27646, 4, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (52, 'авиа206', 14927, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (53, 'авиа565', 92519, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (54, 'авиа652', 23183, 11, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (55, 'авиа608', 79079, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (56, 'авиа586', 103654, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (57, 'авиа168', 32610, 4, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (58, 'авиа745', 11984, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (59, 'авиа834', 20992, 14, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (60, 'авиа418', 86923, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (61, 'авиа840', 103541, 8, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (62, 'авиа815', 94225, 17, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (63, 'авиа420', 108991, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (64, 'авиа62', 99802, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (65, 'авиа957', 71870, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (66, 'авиа724', 77312, 21, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (67, 'авиа536', 70357, 11, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (68, 'авиа640', 25710, 19, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (69, 'авиа960', 80695, 9, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (70, 'авиа128', 70898, 11, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (71, 'авиа629', 13316, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (72, 'авиа276', 52207, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (73, 'авиа933', 24067, 5, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (74, 'авиа148', 49271, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (75, 'авиа984', 100279, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (76, 'авиа184', 87737, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (77, 'авиа566', 105874, 10, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (78, 'авиа13', 73316, 18, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (79, 'авиа169', 32321, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (80, 'авиа157', 42812, 15, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (81, 'авиа838', 42975, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (82, 'авиа846', 88070, 11, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (83, 'авиа368', 17155, 21, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (84, 'авиа259', 104189, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (85, 'авиа57', 97339, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (86, 'авиа24', 36884, 7, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (87, 'авиа839', 17882, 8, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (88, 'авиа767', 55527, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (89, 'авиа108', 46967, 8, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (90, 'авиа778', 58210, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (91, 'авиа978', 104770, 9, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (92, 'авиа669', 23051, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (93, 'авиа17', 30348, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (94, 'авиа974', 56025, 17, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (95, 'авиа734', 57332, 13, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (96, 'авиа262', 49744, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (97, 'авиа216', 24226, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (98, 'авиа232', 59911, 10, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (99, 'авиа364', 88974, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (100, 'авиа660', 26568, 8, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (101, 'авиа95', 39435, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (102, 'авиа830', 15803, 13, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (103, 'авиа756', 91464, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (104, 'авиа250', 34243, 21, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (105, 'авиа722', 44581, 10, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (106, 'авиа45', 73426, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (107, 'авиа826', 21503, 9, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (108, 'авиа409', 74094, 14, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (109, 'авиа844', 52317, 3, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (110, 'авиа881', 61431, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (111, 'авиа707', 76661, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (112, 'авиа31', 91483, 4, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (113, 'авиа521', 27997, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (114, 'авиа339', 66247, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (115, 'авиа737', 32930, 6, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (116, 'авиа655', 20336, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (117, 'авиа20', 105457, 9, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (118, 'авиа672', 55670, 15, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (119, 'авиа467', 41180, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (120, 'авиа252', 102292, 8, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (121, 'авиа815', 19700, 17, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (122, 'авиа282', 13197, 10, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (123, 'авиа197', 104767, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (124, 'авиа979', 58979, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (125, 'авиа833', 91252, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (126, 'авиа209', 74123, 7, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (127, 'авиа753', 85568, 6, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (128, 'авиа434', 20939, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (129, 'авиа276', 21939, 8, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (130, 'авиа361', 79421, 3, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (131, 'авиа521', 10703, 19, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (132, 'авиа227', 41714, 11, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (133, 'авиа660', 86873, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (134, 'авиа934', 88415, 19, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (135, 'авиа956', 77217, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (136, 'авиа912', 50606, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (137, 'авиа922', 32394, 4, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (138, 'авиа683', 16263, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (139, 'авиа58', 76980, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (140, 'авиа579', 22644, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (141, 'авиа708', 14742, 21, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (142, 'авиа972', 87267, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (143, 'авиа565', 89070, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (144, 'авиа661', 69241, 3, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (145, 'авиа205', 39226, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (146, 'авиа788', 20028, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (147, 'авиа837', 11916, 17, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (148, 'авиа756', 78092, 17, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (149, 'авиа141', 84648, 3, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (150, 'авиа136', 85454, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (151, 'авиа673', 32453, 7, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (152, 'авиа512', 55806, 8, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (153, 'авиа798', 22760, 16, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (154, 'авиа488', 103647, 15, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (155, 'авиа557', 54563, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (156, 'авиа880', 51793, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (157, 'авиа165', 67504, 4, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (158, 'авиа221', 70668, 21, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (159, 'авиа61', 34064, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (160, 'авиа277', 66922, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (161, 'авиа592', 13817, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (162, 'авиа218', 31223, 17, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (163, 'авиа398', 92512, 10, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (164, 'авиа475', 75475, 17, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (165, 'авиа558', 50749, 13, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (166, 'авиа48', 38253, 8, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (167, 'авиа367', 107088, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (168, 'авиа251', 13891, 19, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (169, 'авиа404', 58679, 8, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (170, 'авиа416', 65471, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (171, 'авиа168', 98827, 11, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (172, 'авиа111', 14839, 14, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (173, 'авиа173', 25382, 8, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (174, 'авиа792', 63844, 9, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (175, 'авиа837', 66461, 12, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (176, 'авиа625', 90119, 19, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (177, 'авиа885', 40705, 17, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (178, 'авиа413', 78046, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (179, 'авиа281', 38135, 21, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (180, 'авиа194', 90920, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (181, 'авиа888', 54647, 5, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (182, 'авиа68', 63893, 17, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (183, 'авиа156', 38273, 3, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (184, 'авиа278', 98930, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (185, 'авиа139', 108572, 13, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (186, 'авиа351', 72770, 13, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (187, 'авиа71', 91844, 14, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (188, 'авиа401', 26844, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (189, 'авиа516', 74350, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (190, 'авиа299', 94084, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (191, 'авиа864', 13310, 15, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (192, 'авиа478', 31759, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (193, 'авиа551', 61173, 8, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (194, 'авиа611', 71735, 7, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (195, 'авиа932', 52508, 11, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (196, 'авиа261', 69978, 19, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (197, 'авиа169', 74823, 6, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (198, 'авиа842', 35641, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (199, 'авиа852', 94739, 16, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (200, 'авиа966', 46754, 11, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (201, 'авиа317', 39147, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (202, 'авиа274', 14313, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (203, 'авиа794', 37331, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (204, 'авиа372', 39463, 15, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (205, 'авиа585', 14522, 10, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (206, 'авиа387', 19521, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (207, 'авиа441', 89932, 6, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (208, 'авиа943', 97750, 9, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (209, 'авиа186', 73049, 15, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (210, 'авиа86', 19041, 3, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (211, 'авиа432', 70812, 9, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (212, 'авиа779', 49141, 18, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (213, 'авиа909', 15271, 19, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (214, 'авиа133', 38511, 11, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (215, 'авиа541', 96428, 21, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (216, 'авиа444', 63648, 19, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (217, 'авиа904', 38162, 17, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (218, 'авиа452', 58413, 16, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (219, 'авиа101', 86528, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (220, 'авиа976', 55879, 10, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (221, 'авиа425', 89148, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (222, 'авиа223', 97196, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (223, 'авиа395', 32044, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (224, 'авиа615', 28175, 21, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (225, 'авиа871', 65954, 10, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (226, 'авиа953', 96546, 15, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (227, 'авиа11', 98063, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (228, 'авиа73', 83274, 18, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (229, 'авиа760', 47003, 8, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (230, 'авиа951', 49836, 6, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (231, 'авиа402', 59117, 18, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (232, 'авиа375', 60041, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (233, 'авиа496', 62170, 6, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (234, 'авиа869', 39750, 19, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (235, 'авиа128', 89074, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (236, 'авиа588', 70754, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (237, 'авиа27', 38626, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (238, 'авиа247', 76122, 12, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (239, 'авиа528', 52892, 5, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (240, 'авиа979', 43483, 13, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (241, 'авиа773', 81565, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (242, 'авиа235', 49980, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (243, 'авиа809', 72496, 17, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (244, 'авиа403', 98066, 9, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (245, 'авиа438', 74551, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (246, 'авиа917', 44829, 4, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (247, 'авиа788', 64050, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (248, 'авиа979', 109199, 10, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (249, 'авиа550', 109280, 10, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (250, 'авиа910', 71182, 7, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (251, 'авиа771', 68891, 4, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (252, 'авиа347', 35161, 15, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (253, 'авиа871', 79499, 13, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (254, 'авиа168', 15354, 6, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (255, 'авиа321', 25377, 20, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (256, 'авиа65', 15678, 12, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (257, 'авиа11', 98860, 3, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (258, 'авиа166', 18534, 11, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (259, 'авиа888', 53937, 8, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (260, 'авиа935', 67463, 10, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (261, 'авиа888', 27470, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (262, 'авиа889', 27152, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (263, 'авиа544', 52569, 10, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (264, 'авиа320', 30915, 6, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (265, 'авиа868', 16907, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (266, 'авиа299', 80565, 15, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (267, 'авиа323', 25058, 14, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (268, 'авиа746', 46531, 12, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (269, 'авиа722', 108462, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (270, 'авиа212', 27055, 17, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (271, 'авиа883', 89186, 5, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (272, 'авиа350', 64515, 12, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (273, 'авиа754', 44379, 8, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (274, 'авиа755', 84181, 7, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (275, 'авиа495', 37189, 4, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (276, 'авиа950', 16115, 19, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (277, 'авиа707', 76846, 8, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (278, 'авиа834', 84485, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (279, 'авиа592', 45738, 13, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (280, 'авиа826', 100200, 21, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (281, 'авиа327', 84526, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (282, 'авиа281', 72568, 13, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (283, 'авиа366', 57693, 8, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (284, 'авиа474', 63595, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (285, 'авиа675', 31367, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (286, 'авиа616', 44560, 12, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (287, 'авиа150', 82918, 17, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (288, 'авиа910', 78687, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (289, 'авиа580', 27473, 9, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (290, 'авиа592', 45992, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (291, 'авиа576', 90405, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (292, 'авиа315', 46817, 20, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (293, 'авиа809', 76798, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (294, 'авиа948', 69086, 7, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (295, 'авиа746', 88974, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (296, 'авиа74', 80976, 14, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (297, 'авиа859', 21430, 12, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (298, 'авиа57', 15489, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (299, 'авиа901', 18830, 6, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (300, 'авиа503', 46320, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (301, 'авиа446', 17225, 5, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (302, 'авиа380', 15444, 13, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (303, 'авиа337', 101218, 6, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (304, 'авиа826', 62016, 16, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (305, 'авиа84', 100561, 17, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (306, 'авиа910', 19446, 17, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (307, 'авиа540', 18470, 10, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (308, 'авиа197', 92947, 10, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (309, 'авиа347', 30979, 14, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (310, 'авиа31', 103364, 17, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (311, 'авиа795', 21680, 4, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (312, 'авиа815', 84767, 15, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (313, 'авиа685', 19477, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (314, 'авиа470', 53072, 4, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (315, 'авиа743', 88300, 16, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (316, 'авиа436', 20855, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (317, 'авиа916', 77209, 6, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (318, 'авиа259', 19590, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (319, 'авиа635', 76901, 17, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (320, 'авиа839', 104651, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (321, 'авиа735', 44381, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (322, 'авиа894', 60756, 16, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (323, 'авиа266', 51379, 9, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (324, 'авиа29', 95910, 19, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (325, 'авиа880', 84086, 9, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (326, 'авиа107', 10440, 19, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (327, 'авиа824', 71866, 14, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (328, 'авиа250', 54391, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (329, 'авиа797', 50849, 3, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (330, 'авиа936', 41324, 5, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (331, 'авиа155', 74608, 11, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (332, 'авиа91', 69473, 10, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (333, 'авиа927', 68661, 12, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (334, 'авиа13', 12251, 21, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (335, 'авиа168', 88082, 10, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (336, 'авиа247', 79250, 21, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (337, 'авиа979', 78249, 14, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (338, 'авиа240', 16177, 14, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (339, 'авиа371', 57618, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (340, 'авиа725', 107580, 4, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (341, 'авиа795', 38356, 6, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (342, 'авиа296', 69718, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (343, 'авиа790', 75785, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (344, 'авиа564', 72647, 12, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (345, 'авиа686', 90805, 18, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (346, 'авиа634', 10330, 20, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (347, 'авиа736', 40812, 8, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (348, 'авиа345', 45509, 10, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (349, 'авиа327', 24095, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (350, 'авиа904', 92122, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (351, 'авиа183', 90306, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (352, 'авиа62', 62179, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (353, 'авиа597', 95305, 15, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (354, 'авиа966', 96329, 18, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (355, 'авиа722', 82538, 6, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (356, 'авиа148', 17740, 16, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (357, 'авиа972', 95078, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (358, 'авиа938', 97449, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (359, 'авиа348', 22557, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (360, 'авиа701', 96015, 3, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (361, 'авиа326', 65435, 14, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (362, 'авиа936', 51071, 7, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (363, 'авиа561', 55404, 3, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (364, 'авиа225', 13303, 8, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (365, 'авиа258', 105198, 4, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (366, 'авиа441', 94401, 15, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (367, 'авиа511', 73677, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (368, 'авиа417', 79700, 3, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (369, 'авиа313', 22775, 15, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (370, 'авиа469', 75507, 4, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (371, 'авиа196', 11738, 4, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (372, 'авиа822', 106521, 17, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (373, 'авиа704', 21091, 9, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (374, 'авиа962', 52296, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (375, 'авиа927', 23802, 3, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (376, 'авиа391', 13337, 4, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (377, 'авиа403', 24413, 10, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (378, 'авиа92', 27238, 10, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (379, 'авиа563', 68186, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (380, 'авиа246', 13141, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (381, 'авиа707', 81837, 3, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (382, 'авиа381', 108859, 7, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (383, 'авиа259', 44987, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (384, 'авиа211', 79163, 13, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (385, 'авиа648', 107219, 20, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (386, 'авиа838', 16003, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (387, 'авиа697', 59446, 10, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (388, 'авиа904', 21851, 4, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (389, 'авиа869', 40291, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (390, 'авиа513', 65903, 11, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (391, 'авиа51', 108265, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (392, 'авиа431', 29518, 19, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (393, 'авиа802', 38749, 8, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (394, 'авиа167', 12053, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (395, 'авиа179', 11151, 18, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (396, 'авиа5', 51198, 13, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (397, 'авиа296', 36063, 20, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (398, 'авиа972', 22905, 3, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (399, 'авиа765', 34843, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (400, 'авиа20', 25199, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (401, 'авиа31', 24789, 19, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (402, 'авиа410', 17420, 3, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (403, 'авиа412', 81889, 13, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (404, 'авиа392', 81887, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (405, 'авиа344', 50133, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (406, 'авиа816', 98463, 11, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (407, 'авиа919', 41447, 7, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (408, 'авиа213', 74211, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (409, 'авиа330', 23548, 4, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (410, 'авиа225', 50078, 18, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (411, 'авиа229', 24361, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (412, 'авиа23', 14477, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (413, 'авиа327', 91113, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (414, 'авиа451', 89654, 11, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (415, 'авиа794', 29798, 5, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (416, 'авиа247', 20906, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (417, 'авиа147', 16480, 16, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (418, 'авиа583', 90988, 10, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (419, 'авиа332', 15683, 14, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (420, 'авиа598', 102464, 4, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (421, 'авиа678', 63138, 17, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (422, 'авиа309', 19278, 12, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (423, 'авиа228', 70235, 17, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (424, 'авиа500', 35510, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (425, 'авиа706', 85760, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (426, 'авиа762', 44040, 4, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (427, 'авиа62', 106827, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (428, 'авиа830', 10754, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (429, 'авиа75', 65414, 6, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (430, 'авиа794', 20990, 9, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (431, 'авиа993', 29478, 12, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (432, 'авиа523', 54047, 9, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (433, 'авиа552', 48386, 17, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (434, 'авиа871', 58882, 8, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (435, 'авиа8', 41204, 16, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (436, 'авиа858', 49532, 13, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (437, 'авиа11', 73391, 9, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (438, 'авиа3', 12331, 18, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (439, 'авиа250', 92528, 17, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (440, 'авиа458', 18645, 19, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (441, 'авиа787', 96935, 11, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (442, 'авиа389', 66641, 19, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (443, 'авиа937', 92386, 8, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (444, 'авиа310', 33514, 11, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (445, 'авиа334', 51589, 14, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (446, 'авиа709', 105637, 9, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (447, 'авиа589', 28713, 13, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (448, 'авиа365', 68240, 20, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (449, 'авиа526', 96952, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (450, 'авиа221', 78535, 10, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (451, 'авиа567', 70970, 19, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (452, 'авиа504', 16598, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (453, 'авиа238', 48053, 18, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (454, 'авиа115', 106852, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (455, 'авиа152', 51869, 20, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (456, 'авиа931', 29667, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (457, 'авиа51', 90978, 11, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (458, 'авиа774', 97376, 10, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (459, 'авиа663', 50581, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (460, 'авиа294', 51898, 9, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (461, 'авиа209', 20460, 16, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (462, 'авиа884', 52221, 4, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (463, 'авиа337', 24666, 5, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (464, 'авиа78', 59144, 7, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (465, 'авиа178', 59228, 8, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (466, 'авиа563', 91960, 12, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (467, 'авиа974', 63018, 8, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (468, 'авиа72', 27171, 4, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (469, 'авиа434', 43858, 14, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (470, 'авиа932', 32881, 12, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (471, 'авиа579', 57071, 19, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (472, 'авиа970', 84144, 16, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (473, 'авиа328', 86900, 9, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (474, 'авиа818', 84352, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (475, 'авиа490', 12540, 16, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (476, 'авиа395', 25639, 9, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (477, 'авиа160', 50050, 16, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (478, 'авиа489', 57338, 4, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (479, 'авиа724', 48958, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (480, 'авиа906', 95659, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (481, 'авиа805', 88127, 18, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (482, 'авиа628', 100061, 4, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (483, 'авиа544', 59287, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (484, 'авиа776', 62197, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (485, 'авиа518', 48619, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (486, 'авиа938', 101838, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (487, 'авиа472', 26849, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (488, 'авиа613', 40852, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (489, 'авиа782', 36574, 20, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (490, 'авиа93', 31101, 10, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (491, 'авиа239', 21855, 6, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (492, 'авиа103', 45010, 21, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (493, 'авиа298', 79589, 17, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (494, 'авиа916', 98623, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (495, 'авиа416', 24802, 16, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (496, 'авиа436', 66108, 14, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (497, 'авиа496', 52672, 4, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (498, 'авиа2', 61952, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (499, 'авиа707', 48993, 14, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (500, 'авиа218', 12506, 3, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (501, 'авиа178', 47734, 6, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (502, 'авиа184', 12087, 13, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (503, 'авиа148', 59444, 17, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (504, 'авиа913', 60464, 4, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (505, 'авиа144', 97490, 12, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (506, 'авиа528', 108399, 15, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (507, 'авиа700', 10460, 7, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (508, 'авиа124', 95758, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (509, 'авиа925', 88519, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (510, 'авиа778', 52812, 7, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (511, 'авиа961', 49130, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (512, 'авиа255', 49438, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (513, 'авиа992', 23256, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (514, 'авиа440', 19273, 21, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (515, 'авиа16', 57008, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (516, 'авиа355', 56252, 14, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (517, 'авиа33', 15688, 6, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (518, 'авиа911', 79505, 21, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (519, 'авиа623', 27258, 8, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (520, 'авиа213', 89245, 20, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (521, 'авиа189', 30507, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (522, 'авиа342', 91079, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (523, 'авиа258', 99512, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (524, 'авиа973', 49052, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (525, 'авиа334', 100493, 14, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (526, 'авиа160', 38813, 8, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (527, 'авиа738', 99718, 20, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (528, 'авиа847', 11404, 7, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (529, 'авиа788', 81892, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (530, 'авиа421', 45508, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (531, 'авиа417', 57242, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (532, 'авиа719', 61352, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (533, 'авиа57', 32556, 20, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (534, 'авиа418', 93044, 12, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (535, 'авиа188', 96480, 8, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (536, 'авиа680', 67739, 17, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (537, 'авиа473', 22606, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (538, 'авиа228', 19851, 19, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (539, 'авиа793', 25268, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (540, 'авиа811', 76420, 13, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (541, 'авиа847', 12384, 3, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (542, 'авиа112', 85766, 16, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (543, 'авиа156', 67324, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (544, 'авиа753', 25763, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (545, 'авиа493', 57470, 11, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (546, 'авиа962', 20297, 19, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (547, 'авиа752', 11017, 11, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (548, 'авиа876', 12931, 4, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (549, 'авиа243', 25510, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (550, 'авиа194', 95303, 14, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (551, 'авиа233', 71713, 8, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (552, 'авиа77', 64464, 12, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (553, 'авиа309', 34647, 9, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (554, 'авиа789', 88119, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (555, 'авиа806', 89962, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (556, 'авиа539', 89692, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (557, 'авиа111', 48288, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (558, 'авиа398', 26118, 9, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (559, 'авиа105', 12806, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (560, 'авиа970', 20467, 4, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (561, 'авиа435', 86007, 17, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (562, 'авиа673', 28757, 3, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (563, 'авиа532', 30453, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (564, 'авиа146', 65759, 5, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (565, 'авиа530', 35320, 7, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (566, 'авиа276', 88091, 12, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (567, 'авиа324', 65606, 9, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (568, 'авиа797', 34603, 10, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (569, 'авиа3', 74121, 11, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (570, 'авиа223', 53791, 6, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (571, 'авиа817', 37691, 15, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (572, 'авиа139', 105941, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (573, 'авиа643', 38526, 5, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (574, 'авиа491', 13682, 6, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (575, 'авиа657', 49259, 9, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (576, 'авиа604', 48852, 9, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (577, 'авиа518', 95905, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (578, 'авиа71', 85798, 4, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (579, 'авиа942', 66840, 3, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (580, 'авиа570', 21697, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (581, 'авиа962', 107858, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (582, 'авиа886', 62992, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (583, 'авиа526', 93483, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (584, 'авиа138', 103693, 15, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (585, 'авиа333', 92903, 10, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (586, 'авиа255', 76105, 5, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (587, 'авиа993', 55284, 17, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (588, 'авиа263', 37425, 8, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (589, 'авиа625', 23648, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (590, 'авиа823', 66706, 21, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (591, 'авиа16', 49142, 19, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (592, 'авиа776', 85830, 5, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (593, 'авиа326', 18204, 3, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (594, 'авиа136', 85434, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (595, 'авиа107', 24019, 4, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (596, 'авиа121', 32138, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (597, 'авиа116', 10604, 3, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (598, 'авиа291', 56935, 8, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (599, 'авиа981', 92967, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (600, 'авиа832', 76319, 16, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (601, 'авиа281', 10009, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (602, 'авиа323', 77435, 10, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (603, 'авиа45', 98190, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (604, 'авиа74', 106530, 21, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (605, 'авиа943', 83440, 14, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (606, 'авиа279', 35942, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (607, 'авиа718', 76404, 11, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (608, 'авиа774', 49081, 5, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (609, 'авиа484', 21832, 6, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (610, 'авиа124', 75108, 10, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (611, 'авиа604', 96764, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (612, 'авиа174', 25442, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (613, 'авиа765', 74149, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (614, 'авиа930', 32760, 20, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (615, 'авиа731', 68616, 11, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (616, 'авиа824', 69805, 6, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (617, 'авиа15', 59345, 19, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (618, 'авиа14', 30117, 10, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (619, 'авиа358', 41350, 18, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (620, 'авиа338', 85706, 20, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (621, 'авиа486', 90922, 3, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (622, 'авиа948', 97707, 8, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (623, 'авиа79', 43616, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (624, 'авиа457', 45244, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (625, 'авиа260', 73863, 13, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (626, 'авиа623', 55000, 8, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (627, 'авиа226', 34156, 4, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (628, 'авиа223', 59387, 7, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (629, 'авиа799', 58698, 15, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (630, 'авиа789', 84780, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (631, 'авиа794', 61547, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (632, 'авиа299', 72903, 10, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (633, 'авиа118', 62468, 7, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (634, 'авиа745', 68259, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (635, 'авиа384', 55083, 11, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (636, 'авиа763', 62415, 21, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (637, 'авиа688', 91360, 15, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (638, 'авиа115', 71954, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (639, 'авиа899', 94098, 14, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (640, 'авиа907', 41110, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (641, 'авиа425', 24773, 12, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (642, 'авиа865', 102350, 17, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (643, 'авиа993', 27967, 11, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (644, 'авиа839', 98603, 11, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (645, 'авиа393', 45574, 8, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (646, 'авиа17', 69354, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (647, 'авиа489', 44066, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (648, 'авиа961', 29487, 7, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (649, 'авиа74', 26332, 19, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (650, 'авиа703', 24559, 14, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (651, 'авиа276', 105956, 13, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (652, 'авиа594', 29067, 20, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (653, 'авиа321', 106263, 11, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (654, 'авиа512', 65337, 8, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (655, 'авиа410', 109051, 18, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (656, 'авиа333', 59809, 14, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (657, 'авиа356', 18685, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (658, 'авиа285', 20770, 15, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (659, 'авиа414', 26033, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (660, 'авиа897', 17018, 18, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (661, 'авиа428', 53724, 14, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (662, 'авиа802', 60448, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (663, 'авиа11', 39298, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (664, 'авиа563', 47246, 19, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (665, 'авиа995', 66047, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (666, 'авиа24', 92124, 21, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (667, 'авиа780', 82672, 10, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (668, 'авиа448', 97965, 17, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (669, 'авиа542', 62389, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (670, 'авиа814', 39277, 7, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (671, 'авиа477', 39681, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (672, 'авиа223', 102007, 11, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (673, 'авиа396', 28634, 15, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (674, 'авиа329', 14564, 19, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (675, 'авиа3', 70640, 18, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (676, 'авиа32', 25294, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (677, 'авиа158', 81220, 18, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (678, 'авиа493', 30203, 20, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (679, 'авиа256', 65816, 15, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (680, 'авиа682', 31369, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (681, 'авиа604', 52632, 12, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (682, 'авиа230', 11281, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (683, 'авиа367', 46941, 11, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (684, 'авиа409', 41245, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (685, 'авиа182', 45750, 13, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (686, 'авиа385', 103028, 6, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (687, 'авиа48', 64332, 6, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (688, 'авиа753', 92094, 17, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (689, 'авиа458', 16812, 11, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (690, 'авиа518', 88040, 21, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (691, 'авиа38', 61895, 19, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (692, 'авиа359', 23276, 6, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (693, 'авиа131', 71764, 4, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (694, 'авиа970', 54503, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (695, 'авиа897', 107267, 7, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (696, 'авиа750', 43243, 12, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (697, 'авиа468', 85769, 15, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (698, 'авиа914', 81401, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (699, 'авиа625', 109365, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (700, 'авиа365', 55818, 12, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (701, 'авиа295', 80617, 9, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (702, 'авиа278', 31745, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (703, 'авиа851', 70614, 16, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (704, 'авиа430', 49375, 9, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (705, 'авиа882', 19826, 6, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (706, 'авиа751', 69831, 13, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (707, 'авиа576', 46113, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (708, 'авиа441', 77426, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (709, 'авиа354', 106195, 11, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (710, 'авиа268', 43541, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (711, 'авиа710', 107004, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (712, 'авиа331', 84141, 11, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (713, 'авиа477', 91555, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (714, 'авиа675', 97707, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (715, 'авиа897', 30313, 18, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (716, 'авиа606', 53310, 11, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (717, 'авиа949', 33519, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (718, 'авиа478', 109549, 10, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (719, 'авиа352', 62531, 11, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (720, 'авиа7', 84264, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (721, 'авиа541', 58954, 21, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (722, 'авиа871', 62207, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (723, 'авиа715', 29189, 12, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (724, 'авиа501', 23269, 15, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (725, 'авиа716', 18986, 15, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (726, 'авиа448', 97383, 12, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (727, 'авиа146', 87714, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (728, 'авиа651', 103915, 18, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (729, 'авиа577', 45259, 16, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (730, 'авиа300', 13097, 7, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (731, 'авиа164', 45803, 13, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (732, 'авиа656', 75005, 12, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (733, 'авиа271', 42251, 10, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (734, 'авиа402', 97594, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (735, 'авиа946', 92609, 17, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (736, 'авиа626', 19473, 10, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (737, 'авиа200', 75394, 17, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (738, 'авиа469', 15397, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (739, 'авиа106', 14981, 11, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (740, 'авиа890', 92834, 7, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (741, 'авиа656', 39754, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (742, 'авиа718', 86536, 15, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (743, 'авиа161', 96047, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (744, 'авиа374', 34685, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (745, 'авиа752', 19071, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (746, 'авиа202', 24956, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (747, 'авиа188', 18378, 17, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (748, 'авиа369', 31785, 18, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (749, 'авиа741', 69879, 11, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (750, 'авиа645', 27132, 21, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (751, 'авиа415', 19028, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (752, 'авиа230', 36206, 7, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (753, 'авиа118', 90519, 16, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (754, 'авиа949', 26899, 12, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (755, 'авиа719', 68688, 11, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (756, 'авиа800', 67093, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (757, 'авиа81', 59763, 19, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (758, 'авиа809', 57517, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (759, 'авиа285', 72244, 6, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (760, 'авиа629', 49535, 17, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (761, 'авиа252', 54862, 16, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (762, 'авиа101', 86977, 11, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (763, 'авиа897', 12987, 10, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (764, 'авиа270', 69074, 11, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (765, 'авиа735', 83740, 6, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (766, 'авиа977', 17583, 16, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (767, 'авиа622', 87748, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (768, 'авиа208', 45346, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (769, 'авиа908', 91134, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (770, 'авиа834', 65802, 15, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (771, 'авиа850', 105227, 13, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (772, 'авиа234', 53404, 12, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (773, 'авиа535', 23426, 5, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (774, 'авиа594', 63413, 6, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (775, 'авиа952', 44766, 14, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (776, 'авиа296', 46200, 6, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (777, 'авиа79', 61935, 14, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (778, 'авиа962', 45973, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (779, 'авиа23', 97861, 10, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (780, 'авиа144', 56775, 17, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (781, 'авиа320', 59447, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (782, 'авиа590', 19598, 12, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (783, 'авиа465', 39641, 4, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (784, 'авиа307', 83652, 17, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (785, 'авиа643', 39728, 13, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (786, 'авиа324', 22097, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (787, 'авиа389', 102615, 18, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (788, 'авиа220', 87953, 14, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (789, 'авиа618', 44807, 7, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (790, 'авиа959', 19454, 15, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (791, 'авиа76', 49926, 3, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (792, 'авиа525', 55756, 13, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (793, 'авиа716', 39778, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (794, 'авиа176', 103694, 12, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (795, 'авиа991', 70396, 19, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (796, 'авиа875', 104216, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (797, 'авиа296', 109895, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (798, 'авиа597', 83126, 18, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (799, 'авиа77', 42615, 4, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (800, 'авиа778', 34946, 7, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (801, 'авиа212', 109728, 10, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (802, 'авиа112', 80999, 20, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (803, 'авиа328', 40346, 20, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (804, 'авиа275', 63194, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (805, 'авиа656', 49133, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (806, 'авиа927', 83577, 20, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (807, 'авиа870', 76513, 7, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (808, 'авиа519', 76319, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (809, 'авиа109', 25819, 10, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (810, 'авиа999', 103647, 8, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (811, 'авиа54', 108030, 16, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (812, 'авиа544', 100089, 12, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (813, 'авиа495', 39264, 6, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (814, 'авиа776', 50480, 9, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (815, 'авиа275', 48748, 13, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (816, 'авиа783', 76306, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (817, 'авиа924', 45751, 5, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (818, 'авиа437', 22259, 4, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (819, 'авиа529', 62772, 15, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (820, 'авиа123', 80292, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (821, 'авиа619', 39287, 7, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (822, 'авиа33', 61990, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (823, 'авиа929', 35424, 21, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (824, 'авиа562', 31730, 4, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (825, 'авиа896', 68179, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (826, 'авиа232', 42908, 8, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (827, 'авиа683', 44122, 21, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (828, 'авиа761', 77391, 9, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (829, 'авиа317', 22021, 13, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (830, 'авиа569', 74407, 5, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (831, 'авиа260', 76414, 12, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (832, 'авиа48', 49258, 19, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (833, 'авиа369', 48861, 17, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (834, 'авиа395', 44484, 14, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (835, 'авиа732', 67476, 15, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (836, 'авиа661', 26563, 13, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (837, 'авиа289', 87321, 18, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (838, 'авиа937', 39741, 4, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (839, 'авиа548', 54293, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (840, 'авиа297', 55246, 7, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (841, 'авиа894', 23429, 20, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (842, 'авиа158', 108942, 20, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (843, 'авиа205', 68828, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (844, 'авиа262', 103367, 12, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (845, 'авиа532', 106926, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (846, 'авиа329', 61150, 18, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (847, 'авиа567', 17414, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (848, 'авиа765', 55967, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (849, 'авиа522', 86821, 20, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (850, 'авиа503', 14450, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (851, 'авиа821', 18660, 15, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (852, 'авиа172', 77916, 13, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (853, 'авиа682', 50955, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (854, 'авиа308', 36285, 3, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (855, 'авиа303', 97119, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (856, 'авиа255', 98237, 4, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (857, 'авиа824', 79339, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (858, 'авиа727', 41417, 6, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (859, 'авиа687', 54985, 14, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (860, 'авиа745', 94450, 13, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (861, 'авиа318', 46036, 12, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (862, 'авиа815', 38516, 16, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (863, 'авиа267', 69100, 17, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (864, 'авиа747', 80427, 3, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (865, 'авиа98', 29350, 11, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (866, 'авиа504', 41420, 15, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (867, 'авиа334', 85516, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (868, 'авиа796', 26293, 14, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (869, 'авиа714', 15082, 11, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (870, 'авиа935', 86050, 12, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (871, 'авиа874', 108893, 19, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (872, 'авиа631', 63871, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (873, 'авиа298', 102635, 5, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (874, 'авиа989', 19019, 10, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (875, 'авиа80', 108987, 20, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (876, 'авиа967', 56203, 16, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (877, 'авиа559', 48707, 11, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (878, 'авиа942', 48943, 9, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (879, 'авиа417', 91512, 14, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (880, 'авиа829', 34655, 19, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (881, 'авиа162', 108370, 15, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (882, 'авиа426', 76461, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (883, 'авиа228', 105609, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (884, 'авиа239', 32114, 8, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (885, 'авиа121', 58274, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (886, 'авиа107', 43999, 13, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (887, 'авиа117', 85231, 4, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (888, 'авиа315', 65809, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (889, 'авиа48', 11753, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (890, 'авиа780', 71275, 5, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (891, 'авиа599', 46666, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (892, 'авиа80', 48262, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (893, 'авиа385', 60599, 7, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (894, 'авиа778', 67565, 19, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (895, 'авиа757', 89499, 10, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (896, 'авиа526', 29880, 9, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (897, 'авиа981', 103268, 20, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (898, 'авиа894', 36759, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (899, 'авиа891', 73255, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (900, 'авиа746', 101714, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (901, 'авиа628', 44281, 4, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (902, 'авиа231', 16205, 13, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (903, 'авиа396', 67000, 6, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (904, 'авиа170', 11898, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (905, 'авиа405', 74593, 8, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (906, 'авиа656', 15361, 8, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (907, 'авиа370', 94165, 6, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (908, 'авиа222', 74274, 11, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (909, 'авиа970', 67682, 14, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (910, 'авиа788', 45280, 13, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (911, 'авиа665', 19853, 5, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (912, 'авиа930', 72736, 20, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (913, 'авиа136', 51145, 8, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (914, 'авиа692', 54938, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (915, 'авиа402', 52899, 12, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (916, 'авиа310', 89789, 9, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (917, 'авиа367', 38541, 6, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (918, 'авиа706', 15409, 12, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (919, 'авиа151', 59949, 13, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (920, 'авиа558', 12857, 19, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (921, 'авиа35', 31270, 9, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (922, 'авиа77', 17924, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (923, 'авиа306', 13827, 14, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (924, 'авиа360', 96841, 4, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (925, 'авиа573', 25236, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (926, 'авиа334', 76818, 7, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (927, 'авиа353', 23436, 19, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (928, 'авиа868', 86453, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (929, 'авиа874', 82070, 6, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (930, 'авиа566', 53372, 13, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (931, 'авиа48', 17495, 10, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (932, 'авиа144', 26833, 4, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (933, 'авиа549', 49678, 10, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (934, 'авиа43', 41590, 20, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (935, 'авиа729', 79336, 9, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (936, 'авиа121', 15974, 20, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (937, 'авиа918', 41872, 21, 3);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (938, 'авиа843', 81898, 5, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (939, 'авиа258', 55062, 4, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (940, 'авиа380', 77461, 18, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (941, 'авиа835', 11857, 18, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (942, 'авиа420', 93800, 12, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (943, 'авиа320', 82309, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (944, 'авиа303', 57048, 7, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (945, 'авиа714', 79337, 19, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (946, 'авиа289', 43506, 4, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (947, 'авиа86', 11885, 6, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (948, 'авиа392', 71581, 6, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (949, 'авиа378', 96012, 16, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (950, 'авиа239', 87535, 20, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (951, 'авиа456', 19556, 13, 6);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (952, 'авиа806', 63792, 9, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (953, 'авиа580', 59212, 17, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (954, 'авиа775', 58316, 4, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (955, 'авиа390', 30237, 19, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (956, 'авиа426', 41467, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (957, 'авиа318', 108461, 21, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (958, 'авиа691', 82814, 17, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (959, 'авиа49', 101860, 14, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (960, 'авиа990', 104515, 9, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (961, 'авиа308', 64716, 19, 9);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (962, 'авиа967', 50170, 4, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (963, 'авиа751', 41177, 4, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (964, 'авиа98', 88453, 14, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (965, 'авиа225', 97056, 21, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (966, 'авиа398', 69396, 15, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (967, 'авиа962', 48773, 19, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (968, 'авиа149', 77807, 5, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (969, 'авиа573', 26580, 16, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (970, 'авиа655', 83133, 8, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (971, 'авиа826', 15548, 18, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (972, 'авиа495', 67973, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (973, 'авиа303', 102288, 18, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (974, 'авиа679', 28475, 18, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (975, 'авиа963', 17936, 17, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (976, 'авиа374', 79022, 18, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (977, 'авиа544', 108708, 11, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (978, 'авиа602', 60894, 5, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (979, 'авиа526', 84126, 19, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (980, 'авиа419', 49990, 17, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (981, 'авиа43', 90027, 13, 2);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (982, 'авиа604', 82268, 14, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (983, 'авиа759', 28548, 17, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (984, 'авиа798', 67154, 16, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (985, 'авиа209', 100500, 18, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (986, 'авиа407', 39037, 20, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (987, 'авиа534', 76901, 12, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (988, 'авиа274', 104812, 6, 8);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (989, 'авиа835', 15905, 8, 1);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (990, 'авиа301', 81494, 9, 13);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (991, 'авиа617', 28968, 8, 11);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (992, 'авиа750', 82096, 19, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (993, 'авиа902', 65798, 14, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (994, 'авиа898', 100228, 12, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (995, 'авиа648', 31508, 15, 10);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (996, 'авиа95', 64303, 16, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (997, 'авиа39', 71344, 18, 14);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (998, 'авиа43', 80745, 15, 5);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (999, 'авиа62', 58466, 7, 4);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (1000, 'авиа293', 62299, 8, 12);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (1001, 'авиа539', 98484, 13, 7);
INSERT INTO public.tours2 (id, type, price, duration_days, id_city) VALUES (1002, 'авиа533', 42268, 6, 4);


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 209
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.cities_id_seq', 16, true);


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 218
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.contacts_id_seq', 8, true);


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 211
-- Name: guides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.guides_id_seq', 11, true);


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 215
-- Name: journeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.journeys_id_seq', 14, true);


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 213
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.tours_id_seq', 27, true);


--
-- TOC entry 3203 (class 2606 OID 25124)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 3211 (class 2606 OID 25216)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3205 (class 2606 OID 25131)
-- Name: guides guides_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pkey PRIMARY KEY (id);


--
-- TOC entry 3213 (class 2606 OID 25303)
-- Name: tours2 id_unique; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours2
    ADD CONSTRAINT id_unique UNIQUE (id);


--
-- TOC entry 3209 (class 2606 OID 25152)
-- Name: journeys journeys_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_pkey PRIMARY KEY (id);


--
-- TOC entry 3215 (class 2606 OID 25290)
-- Name: tours2 tours2_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours2
    ADD CONSTRAINT tours2_pkey PRIMARY KEY (id);


--
-- TOC entry 3207 (class 2606 OID 25140)
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 1259 OID 25305)
-- Name: type_index; Type: INDEX; Schema: public; Owner: nstu
--

CREATE INDEX type_index ON public.tours2 USING btree (upper((type)::text));


--
-- TOC entry 3219 (class 2606 OID 25158)
-- Name: journeys journeys_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guides(id);


--
-- TOC entry 3218 (class 2606 OID 25153)
-- Name: journeys journeys_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- TOC entry 3220 (class 2606 OID 25291)
-- Name: tours2 tours2_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours2
    ADD CONSTRAINT tours2_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.cities(id);


--
-- TOC entry 3217 (class 2606 OID 25141)
-- Name: tours tours_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.cities(id);


-- Completed on 2022-09-11 13:00:50

--
-- PostgreSQL database dump complete
--

