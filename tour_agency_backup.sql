--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-10 19:51:22

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
-- TOC entry 3365 (class 0 OID 0)
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
-- TOC entry 3366 (class 0 OID 0)
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
-- TOC entry 3367 (class 0 OID 0)
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
-- TOC entry 3368 (class 0 OID 0)
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
    CONSTRAINT positive_price CHECK ((price > (0)::numeric)),
    CONSTRAINT valid_type CHECK (((type = 'автобусный'::text) OR (type = 'железнодорожный'::text) OR (type = 'авиа'::text)))
);


ALTER TABLE public.tours OWNER TO nstu;

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
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 213
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nstu
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- TOC entry 3188 (class 2604 OID 25122)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 25212)
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- TOC entry 3189 (class 2604 OID 25129)
-- Name: guides id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides ALTER COLUMN id SET DEFAULT nextval('public.guides_id_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 25150)
-- Name: journeys id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys ALTER COLUMN id SET DEFAULT nextval('public.journeys_id_seq'::regclass);


--
-- TOC entry 3191 (class 2604 OID 25136)
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- TOC entry 3350 (class 0 OID 25119)
-- Dependencies: 210
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.cities (id, name) FROM stdin;
1	Москва
2	Санкт-Петербург
3	Екатеринбург
4	Новосибирск
5	Сочи
6	Пермь
7	Самара
8	Челябинск
9	Уфа
10	Омск
11	Волгоград
13	Турция
14	Египет
\.


--
-- TOC entry 3359 (class 0 OID 25209)
-- Dependencies: 219
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.contacts (id, phones, schedule) FROM stdin;
1	{(383)-123-45-67,(383)-890-12-34,(383)-567-89-01}	{{09:00,18:00},{09:00,18:00},{09:00,18:00},{12:00,18:00},{12:00,18:00}}
2	{(383)-763-53-23,(383)-194-73-82,(383)-813-85-72}	{{08:00,17:00},{08:00,17:00},{08:00,17:00},{12:00,16:00},{12:00,16:00}}
3	{(383)-583-44-72,(383)-148-03-55,(383)-159-16-57}	{{07:20,17:10},{07:20,17:10},{07:20,17:10},{12:00,17:10},{12:00,17:10}}
4	{(383)-178-51-45,(383)-777-77-77,(383)-111-11-11}	{{08:00,14:40},{08:00,14:40},{08:00,14:40},{12:00,14:40},{12:00,14:40}}
5	{(383)-544-65-32}	{{09:00,16:00},{09:00,16:00},{09:00,16:00},{12:00,16:00},{12:00,16:00}}
6	{(383)-098-76-54,(383)-146-57-85}	{{07:00,14:00},{07:00,14:00},{07:00,14:00},{12:00,14:00},{12:00,14:00}}
7	{(383)-854-03-41}	{{12:00,20:00},{12:00,20:00},{12:00,20:00},{12:00,20:00},{12:00,20:00}}
8	{(383)-444-44-44,+7-913-546-89-23,(383)-999-99-99}	{{11:00,19:00},{11:00,19:00},{11:00,19:00},{12:00,19:00},{12:00,19:00}}
\.


--
-- TOC entry 3352 (class 0 OID 25126)
-- Dependencies: 212
-- Data for Name: guides; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.guides (id, surname, date_of_birth, work_experience) FROM stdin;
1	Иванов	1994-08-07	8
2	Смирнов	1996-04-17	6
4	Попов	1992-03-15	10
5	Васильев	1994-05-09	8
6	Петров	1997-08-19	5
7	Соколов	1988-01-04	14
8	Михайлов	1982-02-13	20
9	Новиков	1987-04-12	15
10	Фёдоров	1988-03-03	14
3	Кузнецов	1993-06-20	9
\.


--
-- TOC entry 3356 (class 0 OID 25147)
-- Dependencies: 216
-- Data for Name: journeys; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.journeys (id, order_date, order_no, tour_id, guide_id, members_count) FROM stdin;
1	2021-10-20	653244	1	6	25
2	2022-01-01	655492	2	2	13
3	2022-01-21	658563	3	9	21
4	2022-02-20	662904	4	1	19
5	2022-04-18	665290	5	10	15
7	2022-07-02	675920	7	5	23
12	2022-07-14	175723	13	2	23
9	2022-01-01	689542	9	8	19
10	2022-01-19	691435	10	7	23
6	2022-05-01	668924	6	1	21
8	2022-08-13	681289	8	2	20
13	2022-06-04	253431	15	1	16
\.


--
-- TOC entry 3357 (class 0 OID 25193)
-- Dependencies: 217
-- Data for Name: result; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.result (order_date, surname, type, name, start_date, price) FROM stdin;
2021-10-20	Петров	железнодорожный	Санкт-Петербург	2021-12-29	24000
2022-01-01	Смирнов	автобусный	Новосибирск	2022-01-23	5000
2022-01-21	Новиков	железнодорожный	Самара	2022-02-17	14000
2022-02-20	Иванов	авиа	Москва	2022-04-01	40000
2022-04-18	Фёдоров	авиа	Уфа	2022-05-22	27000
2022-05-01	Смирнов	автобусный	Волгоград	2022-06-06	9700
2022-07-02	Васильев	железнодорожный	Екатеринбург	2022-08-01	11200
2022-08-13	Петров	автобусный	Омск	2022-09-03	3500
2022-09-04	Михайлов	авиа	Челябинск	2022-10-15	40000
2022-10-28	Соколов	железнодорожный	Пермь	2022-12-28	33500
2022-07-14	Смирнов	автобусный	Екатеринбург	2022-08-15	13000
2022-06-04	Смирнов	автобусный	Москва	2022-07-09	14700
\.


--
-- TOC entry 3354 (class 0 OID 25133)
-- Dependencies: 214
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: nstu
--

COPY public.tours (id, type, price, start_date, id_city, objective) FROM stdin;
3	железнодорожный	14000	2022-02-17	7	семейный отдых
1	железнодорожный	24000	2021-12-29	2	шоппинг
4	авиа	40000	2022-04-01	1	шоппинг
7	железнодорожный	11200	2022-08-01	3	шоппинг
13	автобусный	13000	2022-08-15	3	шоппинг
10	железнодорожный	33500	2022-02-15	6	шоппинг
2	автобусный	5000	2022-01-23	4	образовательный
8	автобусный	3500	2022-09-03	10	образовательный
14	железнодорожный	8000	2022-08-29	6	образовательный
17	железнодорожный	1200	2022-09-04	1	образовательный
20	авиа	5000	2022-08-11	5	образовательный
5	авиа	27000	2022-05-22	13	образовательный
19	авиа	5000	2022-08-31	14	шоппинг
15	авиа	14700	2022-07-09	14	семейный отдых
6	авиа	9700	2022-06-06	13	семейный отдых
9	авиа	40000	2022-01-15	13	семейный отдых
18	авиа	22000	2022-09-09	14	семейный отдых
21	авиа	25000	2022-09-02	14	семейный отдых
\.


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 209
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.cities_id_seq', 14, true);


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 218
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.contacts_id_seq', 8, true);


--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 211
-- Name: guides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.guides_id_seq', 11, true);


--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 215
-- Name: journeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.journeys_id_seq', 14, true);


--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 213
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nstu
--

SELECT pg_catalog.setval('public.tours_id_seq', 21, true);


--
-- TOC entry 3198 (class 2606 OID 25124)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 25216)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3200 (class 2606 OID 25131)
-- Name: guides guides_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.guides
    ADD CONSTRAINT guides_pkey PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 25152)
-- Name: journeys journeys_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_pkey PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 25140)
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- TOC entry 3209 (class 2606 OID 25158)
-- Name: journeys journeys_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.guides(id);


--
-- TOC entry 3208 (class 2606 OID 25153)
-- Name: journeys journeys_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.journeys
    ADD CONSTRAINT journeys_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id);


--
-- TOC entry 3207 (class 2606 OID 25141)
-- Name: tours tours_id_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nstu
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.cities(id);


-- Completed on 2022-09-10 19:51:22

--
-- PostgreSQL database dump complete
--

