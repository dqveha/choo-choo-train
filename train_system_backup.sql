--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.7

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
-- Name: cities; Type: TABLE; Schema: public; Owner: whain
--

CREATE TABLE public.cities (
    city character varying,
    id integer NOT NULL
);


ALTER TABLE public.cities OWNER TO whain;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: whain
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO whain;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: whain
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: stops; Type: TABLE; Schema: public; Owner: whain
--

CREATE TABLE public.stops (
    id integer NOT NULL,
    city_id integer,
    train_id integer,
    arrival time without time zone,
    departure time without time zone
);


ALTER TABLE public.stops OWNER TO whain;

--
-- Name: stops_id_seq; Type: SEQUENCE; Schema: public; Owner: whain
--

CREATE SEQUENCE public.stops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stops_id_seq OWNER TO whain;

--
-- Name: stops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: whain
--

ALTER SEQUENCE public.stops_id_seq OWNED BY public.stops.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: whain
--

CREATE TABLE public.trains (
    train character varying,
    id integer NOT NULL
);


ALTER TABLE public.trains OWNER TO whain;

--
-- Name: trians_id_seq; Type: SEQUENCE; Schema: public; Owner: whain
--

CREATE SEQUENCE public.trians_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trians_id_seq OWNER TO whain;

--
-- Name: trians_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: whain
--

ALTER SEQUENCE public.trians_id_seq OWNED BY public.trains.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: stops id; Type: DEFAULT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.stops ALTER COLUMN id SET DEFAULT nextval('public.stops_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.trains ALTER COLUMN id SET DEFAULT nextval('public.trians_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: whain
--

COPY public.cities (city, id) FROM stdin;
Portland	18
Seattle	19
Baker&#39;s Field	23
Woopsie-daisy	25
\.


--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: whain
--

COPY public.stops (id, city_id, train_id, arrival, departure) FROM stdin;
8	19	20	13:10:00	14:10:00
11	19	20	03:10:00	14:15:00
\.


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: whain
--

COPY public.trains (train, id) FROM stdin;
Sole Train	18
Insane in the Train Train	20
DAT TRAIN	23
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: whain
--

SELECT pg_catalog.setval('public.cities_id_seq', 25, true);


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: whain
--

SELECT pg_catalog.setval('public.stops_id_seq', 15, true);


--
-- Name: trians_id_seq; Type: SEQUENCE SET; Schema: public; Owner: whain
--

SELECT pg_catalog.setval('public.trians_id_seq', 23, true);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: stops stops_pkey; Type: CONSTRAINT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


--
-- Name: trains trians_pkey; Type: CONSTRAINT; Schema: public; Owner: whain
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trians_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

