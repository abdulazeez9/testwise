--
-- PostgreSQL database dump
--

-- Dumped from database version 17.6 (Debian 17.6-1.pgdg12+1)
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: testwise_cbt_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO testwise_cbt_user;

--
-- Name: AttemptStatus; Type: TYPE; Schema: public; Owner: testwise_cbt_user
--

CREATE TYPE public."AttemptStatus" AS ENUM (
    'IN_PROGRESS',
    'COMPLETED',
    'TIMED_OUT'
);


ALTER TYPE public."AttemptStatus" OWNER TO testwise_cbt_user;

--
-- Name: QuestionType; Type: TYPE; Schema: public; Owner: testwise_cbt_user
--

CREATE TYPE public."QuestionType" AS ENUM (
    'MULTIPLE_CHOICE',
    'MULTIPLE_ANSWER',
    'TRUE_FALSE',
    'SHORT_ANSWER',
    'ESSAY'
);


ALTER TYPE public."QuestionType" OWNER TO testwise_cbt_user;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: testwise_cbt_user
--

CREATE TYPE public."Role" AS ENUM (
    'STUDENT',
    'ADMIN'
);


ALTER TYPE public."Role" OWNER TO testwise_cbt_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO testwise_cbt_user;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    "textAnswer" text,
    "isCorrect" boolean DEFAULT false NOT NULL,
    "pointsEarned" double precision DEFAULT 0 NOT NULL,
    "timeSpent" integer,
    "attemptId" integer NOT NULL,
    "questionId" integer NOT NULL,
    "optionId" integer
);


ALTER TABLE public.answers OWNER TO testwise_cbt_user;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answers_id_seq OWNER TO testwise_cbt_user;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: attempts; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.attempts (
    id integer NOT NULL,
    score double precision DEFAULT 0 NOT NULL,
    "maxScore" double precision,
    "percentScore" double precision,
    status public."AttemptStatus" DEFAULT 'IN_PROGRESS'::public."AttemptStatus" NOT NULL,
    "startedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "completedAt" timestamp(3) without time zone,
    "timeSpent" integer,
    "attemptNumber" integer NOT NULL,
    "ipAddress" text,
    "userId" integer NOT NULL,
    "testId" integer NOT NULL,
    "expiresAt" timestamp(3) without time zone
);


ALTER TABLE public.attempts OWNER TO testwise_cbt_user;

--
-- Name: attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attempts_id_seq OWNER TO testwise_cbt_user;

--
-- Name: attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.options (
    id integer NOT NULL,
    text text NOT NULL,
    "isCorrect" boolean DEFAULT false NOT NULL,
    "order" integer NOT NULL,
    "questionId" integer NOT NULL
);


ALTER TABLE public.options OWNER TO testwise_cbt_user;

--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO testwise_cbt_user;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    text text NOT NULL,
    "questionType" public."QuestionType" NOT NULL,
    points double precision DEFAULT 1.0 NOT NULL,
    "order" integer NOT NULL,
    "testId" integer NOT NULL
);


ALTER TABLE public.questions OWNER TO testwise_cbt_user;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO testwise_cbt_user;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.tests (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    duration integer NOT NULL,
    "maxAttempts" integer DEFAULT 1 NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "availableFrom" timestamp(3) without time zone,
    "availableUntil" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.tests OWNER TO testwise_cbt_user;

--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tests_id_seq OWNER TO testwise_cbt_user;

--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: testwise_cbt_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    name text,
    role public."Role" DEFAULT 'STUDENT'::public."Role" NOT NULL,
    avatar text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO testwise_cbt_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: testwise_cbt_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO testwise_cbt_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testwise_cbt_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: attempts id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: tests id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
12f229b3-9c85-4288-880b-9ee919ed16aa	a955a38cb56f6b6a2109a85478fc5c10f73609c9b463e30cc02fb19beae8be65	2025-10-13 15:49:38.948963+00	20251005110839_init	\N	\N	2025-10-13 15:49:38.690341+00	1
99410f36-da20-43a8-8767-0a9ef8dd200a	c84d1c6c5e3600b0b7f3cf0a9b04e386e3814205d60e088ca6b6280872348bb2	2025-10-13 15:49:38.963626+00	20251006211342_add_cascade_delete_to_attempts	\N	\N	2025-10-13 15:49:38.951842+00	1
8e99676a-d0ac-44f7-8491-22010996e87a	7e2dcf316b4b89d0d5bf3ca5f9d1fa9fbc34146087e552b04989c4edd2c972e3	2025-10-13 15:49:39.044254+00	20251009204758_remove_instructor_role	\N	\N	2025-10-13 15:49:38.966474+00	1
430e38b9-44bb-4224-93d0-c0f0dcd52772	447890f5e5e30be3b4d97e417a6c30bb22db29bbe58a2f8ba1adff7399a87277	2025-10-15 16:40:54.351238+00	20251015111944_add_expires_at	\N	\N	2025-10-15 16:40:54.308563+00	1
\.


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.answers (id, "textAnswer", "isCorrect", "pointsEarned", "timeSpent", "attemptId", "questionId", "optionId") FROM stdin;
1	\N	t	1	\N	1	1	3
2	\N	t	1	\N	1	2	6
3	\N	t	1	\N	1	3	11
4	\N	t	1	\N	1	4	14
5	\N	t	1	\N	1	5	17
6	\N	t	1	\N	1	6	22
7	\N	f	0	\N	2	31	118
10	\N	t	1	\N	2	32	125
11	\N	t	1	\N	2	33	128
12	\N	f	0	\N	4	1	2
13	\N	t	1	\N	4	2	6
14	\N	t	1	\N	5	1	3
15	\N	t	1	\N	5	2	6
16	\N	t	1	\N	5	3	11
17	\N	t	1	\N	5	4	14
18	\N	t	1	\N	5	5	17
19	\N	t	1	\N	5	6	22
20	\N	t	1	\N	5	7	24
21	\N	t	1	\N	5	8	29
22	\N	t	1	\N	5	9	32
23	\N	t	1	\N	5	10	36
24	\N	t	1	\N	5	11	38
25	\N	t	1	\N	5	12	43
141	\N	t	1	\N	15	40	156
26	\N	f	0	\N	8	34	130
29	\N	t	1	\N	8	35	138
30	\N	t	1	\N	8	36	141
31	\N	t	1	\N	9	6	22
32	\N	f	0	\N	9	7	25
33	\N	t	1	\N	9	1	3
34	\N	t	1	\N	10	1	3
36	\N	t	1	\N	10	2	6
37	\N	t	1	\N	10	3	11
38	\N	t	1	\N	10	4	14
39	\N	t	1	\N	10	6	22
40	\N	t	1	\N	10	7	24
41	\N	t	1	\N	10	8	29
42	\N	t	1	\N	10	9	32
43	\N	t	1	\N	10	10	36
44	\N	t	1	\N	10	11	38
45	\N	t	1	\N	10	12	43
46	\N	t	1	\N	10	13	46
47	\N	t	1	\N	10	14	50
48	\N	t	1	\N	10	15	53
49	\N	t	1	\N	10	16	59
50	\N	t	1	\N	10	17	61
51	\N	t	1	\N	10	18	67
52	\N	t	1	\N	10	19	69
53	\N	t	1	\N	10	20	74
54	\N	t	1	\N	10	21	77
55	\N	t	1	\N	10	22	84
56	\N	t	1	\N	10	23	86
57	\N	t	1	\N	10	24	92
58	\N	t	1	\N	10	25	96
59	\N	t	1	\N	10	26	98
60	\N	t	1	\N	10	27	103
61	\N	t	1	\N	10	28	106
62	\N	t	1	\N	10	29	110
63	\N	t	1	\N	10	30	115
64	\N	t	1	\N	10	5	17
65	\N	t	1	\N	12	1	3
66	\N	t	1	\N	12	2	6
67	\N	t	1	\N	12	3	11
68	\N	t	1	\N	12	4	14
69	\N	t	1	\N	13	1	3
70	\N	t	1	\N	13	2	6
71	\N	t	1	\N	13	3	11
72	\N	t	1	\N	13	4	14
73	\N	t	1	\N	13	6	22
74	\N	t	1	\N	13	7	24
75	\N	t	1	\N	13	8	29
76	\N	t	1	\N	13	9	32
77	\N	t	1	\N	13	10	36
78	\N	t	1	\N	13	11	38
79	\N	t	1	\N	13	12	43
80	\N	t	1	\N	13	13	46
81	\N	t	1	\N	13	14	50
82	\N	t	1	\N	13	15	53
83	\N	t	1	\N	13	16	59
84	\N	t	1	\N	13	17	61
85	\N	t	1	\N	13	18	67
86	\N	t	1	\N	13	19	69
87	\N	t	1	\N	13	20	74
88	\N	t	1	\N	13	21	77
89	\N	t	1	\N	13	22	84
128	\N	f	0	\N	15	31	122
90	\N	t	1	\N	13	23	86
93	\N	t	1	\N	13	24	92
94	\N	t	1	\N	13	25	96
95	\N	t	1	\N	13	26	98
96	\N	t	1	\N	13	27	103
97	\N	t	1	\N	13	28	106
98	\N	t	1	\N	13	29	110
99	\N	t	1	\N	13	30	115
100	\N	t	1	\N	13	5	17
101	\N	t	1	\N	14	111	428
102	\N	f	0	\N	14	112	433
103	\N	t	1	\N	14	113	436
131	\N	t	1	\N	15	32	125
104	\N	f	0	\N	14	114	439
107	\N	t	1	\N	14	115	446
109	\N	f	0	\N	14	116	451
111	\N	f	0	\N	14	117	452
113	\N	t	1	\N	14	118	459
114	\N	t	1	\N	14	119	464
115	\N	t	1	\N	14	120	466
132	\N	t	1	\N	15	33	128
116	\N	f	0	\N	14	121	469
119	\N	f	0	\N	14	122	477
120	\N	t	1	\N	14	123	480
121	\N	t	1	\N	14	124	484
122	\N	t	1	\N	14	125	486
123	\N	f	0	\N	14	127	493
124	\N	t	1	\N	14	128	496
125	\N	t	1	\N	14	129	501
126	\N	t	1	\N	14	130	504
127	\N	t	1	\N	14	126	491
143	\N	t	1	\N	15	41	158
133	\N	f	0	\N	15	34	132
136	\N	t	1	\N	15	35	138
137	\N	t	1	\N	15	36	141
138	\N	t	1	\N	15	37	145
139	\N	t	1	\N	15	38	148
140	\N	t	1	\N	15	39	151
144	\N	t	1	\N	15	42	161
145	\N	t	1	\N	15	43	166
146	\N	t	1	\N	15	44	168
147	\N	t	1	\N	15	45	172
148	\N	t	1	\N	15	46	175
149	\N	t	1	\N	15	47	178
150	\N	t	1	\N	15	48	182
151	\N	t	1	\N	15	49	185
152	\N	t	1	\N	15	50	188
153	\N	t	1	\N	15	51	192
154	\N	t	1	\N	15	52	196
155	\N	t	1	\N	15	53	199
156	\N	t	1	\N	15	54	204
157	\N	f	0	\N	15	55	209
158	\N	f	0	\N	15	56	213
159	\N	t	1	\N	15	57	214
160	\N	f	0	\N	15	58	219
161	\N	t	1	\N	15	59	223
162	\N	t	1	\N	15	60	228
\.


--
-- Data for Name: attempts; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.attempts (id, score, "maxScore", "percentScore", status, "startedAt", "completedAt", "timeSpent", "attemptNumber", "ipAddress", "userId", "testId", "expiresAt") FROM stdin;
1	6	30	20	COMPLETED	2025-10-14 17:59:41.694	2025-10-14 18:02:30.045	168	1	::1	1	1	\N
2	2	31	6.451612903225806	COMPLETED	2025-10-14 18:33:29.271	2025-10-14 18:34:32.728	63	1	::1	1	2	\N
3	0	30	0	COMPLETED	2025-10-14 19:06:00.725	2025-10-14 19:07:16.72	75	2	::1	1	1	\N
4	1	30	3.333333333333333	COMPLETED	2025-10-14 19:07:52.88	2025-10-14 19:09:40.898	108	3	::1	1	1	\N
5	12	30	40	COMPLETED	2025-10-14 19:34:45.654	2025-10-14 19:37:20.845	155	1	::1	3	1	\N
6	0	30	0	COMPLETED	2025-10-15 07:05:24.376	2025-10-15 07:06:11.114	46	4	::1	1	1	\N
7	0	30	0	COMPLETED	2025-10-15 07:23:31.079	2025-10-15 07:27:48.852	257	2	::1	3	1	\N
10	30	30	100	COMPLETED	2025-10-15 16:53:04.501	2025-10-15 16:57:32.608	268	4	::1	3	1	2025-10-15 17:08:04.495
11	0	31	0	COMPLETED	2025-10-15 20:06:58.265	2025-10-15 20:24:04.61	900	1	::1	3	2	2025-10-15 20:21:58.261
12	4	30	13.33333333333333	COMPLETED	2025-10-15 20:55:13.769	2025-10-15 20:56:09.756	55	5	::1	1	1	2025-10-15 21:10:13.765
9	0	\N	\N	COMPLETED	2025-10-15 10:48:31.42	\N	\N	3	::1	3	1	\N
8	0	\N	\N	COMPLETED	2025-10-15 09:35:18.718	\N	\N	2	::1	1	2	\N
13	30	30	100	COMPLETED	2025-10-16 11:07:33.148	2025-10-16 11:11:38.312	245	5	::1	3	1	2025-10-16 11:22:33.144
14	13	20	65	COMPLETED	2025-10-20 22:04:33.392	2025-10-20 22:08:03.208	209	1	::1	1	5	2025-10-20 22:19:33.388
15	25	31	80.64516129032258	COMPLETED	2025-11-03 13:19:09.91	2025-11-03 13:24:06.061	296	3	::1	1	2	2025-11-03 13:34:09.87
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.options (id, text, "isCorrect", "order", "questionId") FROM stdin;
1	Brazil	f	1	1
2	Germany	f	2	1
3	France	t	3	1
4	Argentina	f	4	1
5	 Ahmed Hegazi	f	1	2
6	Mohamed Salah	t	2	2
7	Essam El-Hadary	f	3	2
8	 Mahmoud Hassan  	f	4	2
9	Mohamed Sallahh	f	5	2
10	True	f	1	3
11	False	t	2	3
12	Barcelona	f	1	4
13	 Ac Milan 	f	2	4
14	Real Madrid	t	3	4
15	Liverpool 	f	4	4
16	 Ajax	f	5	4
21	True	f	1	6
22	False	t	2	6
23	80 minutes 	f	1	7
24	 90 minutes	t	2	7
25	 100 minutes  	f	3	7
26	120 minutes	f	4	7
27	 Brazil  	f	1	8
28	 Germany 	f	2	8
29	 South Africa	t	3	8
30	Russia	f	4	8
31	False	f	1	9
32	True	t	2	9
33	Yellow	f	1	10
34	Purple	f	2	10
35	Green	f	3	10
36	Red	t	4	10
37	Cristiano Ronaldo  	f	1	11
38	 Lionel Messi	t	2	11
39	 Michel Platini 	f	3	11
40	Johan Cruyff	f	4	11
41	3	f	1	12
42	4	f	2	12
43	5	t	3	12
44	6	f	4	12
45	Brazil	f	1	13
46	 Uruguay	t	2	13
47	France	f	3	13
48	Italy	f	4	13
49	 Messi 	f	1	14
50	 Ronaldo	t	2	14
51	 Lewandowski  	f	3	14
52	 Benzema	f	4	14
53	Maradona	t	1	15
54	Pelé  	f	2	15
55	Ronaldo  	f	3	15
56	 Messi	f	4	15
57	 San Siro  	f	1	16
58	Old Trafford 	f	2	16
59	 Camp Nou	t	3	16
60	Bernabéu	f	4	16
61	 Italy	t	1	17
62	 England 	f	2	17
63	 Spain 	f	3	17
64	 France	f	4	17
65	 Messi  	f	1	18
66	 Ronaldo  	f	2	18
67	 Pelé	t	3	18
68	Maradona	f	4	18
69	Inter Milan	t	1	19
70	Ac Milan  	f	2	19
71	 Juventus 	f	3	19
72	 Napoli	f	4	19
73	 Germany 	f	1	20
74	 Brazil	t	2	20
75	 England  	f	3	20
76	 Uruguay	f	4	20
77	Cameroon	t	1	21
78	 Ghana 	f	2	21
79	 Morocco  	f	3	21
80	 South Africa 	f	4	21
81	 Senegal	f	5	21
82	 David de Gea 	f	1	22
83	 Edwin van der Sar	f	2	22
84	Petr Čech 	t	3	22
85	Peter Schmeichel	f	4	22
86	Manchester United 	t	1	23
87	Liverpool 	f	2	23
88	Nottingham Forest 	f	3	23
89	Aston Villa	f	4	23
90	 Pelé 	f	1	24
91	Miroslav Klose	f	2	24
92	 Cristiano Ronaldo 	t	3	24
93	Lionel Messi	f	4	24
94	France	f	1	25
95	 Spain 	f	2	25
96	 Soviet Union 	t	3	25
97	 Italy	f	4	25
98	 10.8 seconds - Hakan Şükür 	t	1	26
99	15 seconds - Clint Dempsey 	f	2	26
100	 27 seconds - Bryan Robson 	f	3	26
101	 30 seconds - Emile Heskey	f	4	26
102	 Juventus 	f	1	27
103	 AC Milan 	t	2	27
104	 Real Madrid 	f	3	27
105	 Cannes	f	4	27
106	Clarence Seedorf 	t	1	28
107	 Zlatan Ibrahimović 	f	2	28
108	Cristiano Ronaldo 	f	3	28
109	 Samuel Eto'o	f	4	28
110	Ryan Giggs 	t	1	29
111	Paul Scholes 	f	2	29
112	 Gary Neville 	f	3	29
113	Roy Keane	f	4	29
114	2014 	f	1	30
115	2018	t	2	30
116	 2022 	f	3	30
117	 2010	f	4	30
118	1. France 	t	1	31
119	 Poland	t	2	31
120	 Austria 	t	3	31
121	 Italy  	f	4	31
122	Netherlands 	t	5	31
123	Spain	f	6	31
124	Singapore	f	1	32
125	Maldives	t	2	32
126	 Bahrain	f	3	32
127	 Brunei	f	4	32
128	True	t	1	33
129	False	f	2	33
130	Norway	t	1	34
131	 Sweden	t	2	34
132	 Denmark 	t	3	34
133	 Finland  	f	4	34
134	 Iceland  	f	5	34
135	 Netherlands	f	6	34
136	 Euro  	f	1	35
137	 Dollar  	f	2	35
138	Pound Sterling 	t	3	35
139	Franc	f	4	35
140	 Egypt  	f	1	36
141	 Jordan	t	2	36
142	Lebanon 	f	3	36
143	Syria	f	4	36
144	 Egypt  	f	1	37
145	 Jordan	t	2	37
146	Lebanon 	f	3	37
147	Syria	f	4	37
148	True	t	1	38
149	False	f	2	38
150	1. Lagos  	f	1	39
151	 Nairobi	t	2	39
152	Kampala 	f	3	39
153	Addis Ababa	f	4	39
154	Russia  	f	1	40
155	 United States 	f	2	40
156	France 	t	3	40
157	 China	f	4	40
158	True	t	1	41
159	False	f	2	41
160	Spanish 	f	1	42
161	 Portuguese 	t	2	42
162	French	f	3	42
163	English	f	4	42
164	China  	f	1	43
165	South Korea 	f	2	43
166	 Japan	t	3	43
167	Thailand	f	4	43
168	True	t	1	44
169	False	f	2	44
170	 44  	f	1	45
171	 50  	f	2	45
172	 54 	t	3	45
173	 58	f	4	45
174	 Somalia 	f	1	46
175	Ethiopia 	t	2	46
176	Eritrea	f	3	46
177	Sudan	f	4	46
178	True	t	1	47
179	False	f	2	47
180	Sydney 	f	1	48
181	Melbourne	f	2	48
182	Canberra	t	3	48
183	Brisbane	f	4	48
188	True	t	1	50
189	False	f	2	50
190	London  	f	1	51
191	Berlin 	f	2	51
192	 Paris	t	3	51
193	Madrid	f	4	51
194	 Canada 	f	1	52
195	China	f	2	52
196	 Russia 	t	3	52
197	United States	f	4	52
198	Greenland 	f	1	53
199	 Australia	t	2	53
200	Antarctica	f	3	53
201	Madagascar	f	4	53
202	Monaco 	f	1	54
203	 San Marino 	f	2	54
204	 Vatican City 	t	3	54
205	Liechtenstein	f	4	54
206	7	f	1	55
207	8	f	2	55
208	10	t	3	55
209	6	f	4	55
210	Australia 	f	1	56
211	Indonesia 	f	2	56
212	Canada 	t	3	56
213	 Norway	f	4	56
214	 South Africa 	t	1	57
215	 Australia 	f	2	57
216	 Brazil 	f	3	57
217	Madagascar	f	4	57
218	China 	f	1	58
219	France 	f	2	58
220	 Italy	t	3	58
221	Spain	f	4	58
222	Switzerland 	f	1	59
223	Nepal 	t	2	59
224	 Vatican City 	f	3	59
225	Bhutan	f	4	59
226	Sweden 	f	1	60
227	 Canada	f	2	60
228	 Finland	t	3	60
229	 Norway	f	4	60
17	 Hat-Trick   	t	1	5
18	Three-pointer	f	2	5
19	Trio 	f	3	5
20	Triple	f	4	5
230	20 	f	1	61
231	 25	f	2	61
232	 30	t	3	61
233	 35	f	4	61
234	 17 	f	1	62
235	24	t	2	62
236	 36 	t	3	62
237	 43	f	4	62
238	 58	t	5	62
239	20 cm²	f	1	63
240	30 cm²	f	2	63
241	40 cm²	t	3	63
242	50 cm²	f	4	63
243	45°	f	1	64
244	90°	t	2	64
245	180°	f	3	64
246	360°	f	4	64
247	-2x - 6	f	1	65
248	6 - 2x	t	2	65
249	2x + 6	f	3	65
250	2x - 4x	f	4	65
251	 2/4 	t	1	66
252	 3/5 	f	2	66
253	 4/8 	t	3	66
254	 5/10 	t	4	66
255	6/11	f	5	66
256	21 	f	1	67
257	 49 	f	2	67
258	343 	t	3	67
259	 2401	f	4	67
260	Addition	t	1	68
261	 Subtraction	f	2	68
262	Multiplication 	t	3	68
263	 Division	f	4	68
264	3/9 	f	1	69
265	13/20 	t	2	69
266	3/20 	f	3	69
267	 1/2	f	4	69
268	5	t	1	70
269	 90°	f	1	71
270	180°	t	2	71
271	 270°	f	3	71
272	360°	f	4	71
278	2/5	f	1	73
279	3/7	f	2	73
280	3/4	t	3	73
281	3/2	f	4	73
282	14	t	1	74
283	12	f	2	74
284	8	f	3	74
285	10	f	4	74
291	0.02	f	1	76
292	0.2 	t	2	76
293	2.0	f	3	76
294	 0.002	f	4	76
295	True	t	1	77
296	False	f	2	77
297	 Four equal sides	t	1	78
298	 Four right angles	t	2	78
299	 Opposite sides parallel	t	3	78
273	 4  	t	1	72
274	5 	f	2	72
275	 6  	t	3	72
276	9 	t	4	72
277	 11	f	5	72
184	United States  	f	1	49
185	India	t	2	49
186	 China	f	3	49
187	Indonesia	f	4	49
300	Three vertices 	f	4	78
301	All angles are equal	t	5	78
302	 Five sides	f	6	78
307	80 	f	1	80
308	90  	f	2	80
309	100	t	3	80
310	110	f	4	80
286	126 	t	1	75
287	 245 	f	2	75
288	 333 	t	3	75
289	 428 	f	4	75
290	 567	t	5	75
303	πr  	f	1	79
304	 2πr  	f	2	79
305	πr² 	t	3	79
306	2πr	f	4	79
311	Atlantic Ocean 	f	1	81
312	Indian Ocean  	f	2	81
313	Arctic Ocean 	f	3	81
314	Pacific Ocean	t	4	81
315	True	f	1	82
316	False	t	2	82
317	5	f	1	83
318	6	f	2	83
319	7	t	3	83
320	9	f	4	83
321	 Venus 	f	1	84
322	Mars	t	2	84
323	Jupiter  	f	3	84
324	Saturn	f	4	84
325	Monaco 	f	1	85
326	Vatican City	t	2	85
327	San Marino	f	3	85
328	Liechtenstein	f	4	85
329	True	t	1	86
330	False	f	2	86
331	Oxygen 	f	1	87
332	 Nitrogen  	f	2	87
333	Carbon Dioxide	t	3	87
334	Hydrogen	f	4	87
335	True	t	1	88
336	False	f	2	88
337	 186  	f	1	89
338	206	t	2	89
339	 226 	f	3	89
340	 246	f	4	89
341	True	t	1	90
342	False	f	2	90
343	Thomas Edison  	f	1	91
344	 Alexander Graham Bell	t	2	91
345	Nikola Tesla	f	3	91
346	 Benjamin Franklin	f	4	91
347	Yuan 	f	1	92
348	 Won	f	2	92
349	Yen	t	3	92
350	Ringgit	f	4	92
351	Lion  	f	1	93
352	Cheetah	t	2	93
353	Leopard	f	3	93
354	Gazelle	f	4	93
355	True	f	1	94
356	False	t	2	94
357	African Elephant 	f	1	95
358	Blue Whale	t	2	95
359	Giraffe 	f	3	95
360	Polar Bear	f	4	95
361	 Salt	f	1	96
362	Oxygen  	f	2	96
363	Water	t	3	96
364	Hydrogen	f	4	96
365	 Elephant  	f	1	97
366	Lion	t	2	97
367	Tiger	f	3	97
368	 Bear	f	4	97
369	364 	f	1	98
370	 365 	f	2	98
371	366	t	3	98
372	367	f	4	98
373	Gold 	f	1	99
374	 Iron 	f	2	99
375	Diamond	t	3	99
376	Silver	f	4	99
377	Canberra	t	1	100
378	Sydney  	f	2	100
379	 Melbourne 	f	3	100
380	 Hobart	f	4	100
381	Osmosis	f	1	101
382	 Photosynthesis	t	2	101
383	Enzyme  	f	3	101
384	Pollution	f	4	101
385	Paris	t	1	102
386	London  	f	2	102
387	Hong-kong	f	3	102
388	Madrid	f	4	102
389	 Great Pyramid of Giza	t	1	103
390	 Eiffel Tower 	f	2	103
391	 Colossus of Rhodes 	t	3	103
392	 Statue of Liberty 	f	4	103
393	Lighthouse of Alexandria	t	5	103
394	1980	f	1	104
395	1912	t	2	104
396	1812	f	3	104
397	1992	f	4	104
398	Tokyo 	t	1	105
399	 New York 	f	2	105
400	 Paris 	t	3	105
401	 Mumbai 	f	4	105
402	Berlin	t	5	105
403	 Spanish 	t	1	106
404	German 	f	2	106
405	 French 	t	3	106
406	 Italian 	t	4	106
407	Arabic	f	5	106
408	 K2 	f	1	107
409	Mount Kilimanjaro 	f	2	107
410	Mount Everest 	t	3	107
411	Mont Blanc	f	4	107
412	Gold	t	1	108
413	 Iron	f	2	108
414	Silver 	t	3	108
415	 Platinum 	t	4	108
416	Aluminum	f	5	108
417	United Nations Educational, Scientific and Cultural Organization	t	1	109
418	Universal Network for Education and Science Cooperation	f	2	109
419	United Nations Economic and Social Council	f	3	109
420	Universal Educational Standards and Culture Organization	f	4	109
421	United Kingdom	t	1	110
422	United States	f	2	110
423	Japan 	t	3	110
424	Australia	f	4	110
425	Germany	f	5	110
426	Liver	f	1	111
427	Brain	f	2	111
428	Skin	t	3	111
429	Heart	f	4	111
430	 Dark urine 	t	1	112
431	Excessive sweating	f	2	112
432	Headache 	t	3	112
433	 Dizziness 	t	4	112
434	 Increased appetite	f	5	112
435	35°C	f	1	113
436	37°C	t	2	113
437	39°C 	f	3	113
438	40°C	f	4	113
439	Arteries 	t	1	114
440	Neurons	f	2	114
441	Veins 	t	3	114
442	Capillaries	t	4	114
443	Tendons	f	5	114
444	2	f	1	115
445	3	f	2	115
446	4	t	3	115
447	5	f	4	115
448	Transport oxygen	t	1	116
449	Digestion	f	2	116
450	Breathing	f	3	116
451	Strength Immune	f	4	116
452	Fruits and vegetables 	t	1	117
453	 Whole grains	t	2	117
454	 Excessive sugar 	f	3	117
455	 Lean proteins 	t	4	117
456	Trans fats	f	5	117
457	 4-5 hours	f	1	118
458	 5-6 hours 	f	2	118
459	 7-9 hours 	t	3	118
460	10-12 hours	f	4	118
461	Heart	f	1	119
462	Lung	f	2	119
463	Liver	f	3	119
464	Kidney	t	4	119
465	Hypotension	f	1	120
466	 Hypertension 	t	2	120
467	 Diabetes	f	3	120
468	Anemia	f	4	120
469	Smoking	t	1	121
470	Regular exercise 	f	2	121
471	 High cholesterol 	t	3	121
472	 Obesity 	t	4	121
473	 Healthy diet	f	5	121
474	40%	f	1	122
475	 50%	f	2	122
476	 60% 	t	3	122
477	70%	f	4	122
478	Vitamin A	f	1	123
479	Vitamin C	f	2	123
480	Vitamin D	t	3	123
481	Vitamin E	f	4	123
482	Heart 	f	1	124
483	 Liver  	f	2	124
484	Kidney	t	3	124
485	Lungs	f	4	124
486	Body Mass Index 	t	1	125
487	Bone Mineral Index	f	2	125
488	Basic Medical Information	f	3	125
489	Blood Measurement Indicator	f	4	125
490	True	f	1	126
491	False	t	2	126
492	2	f	1	127
493	3	f	2	127
494	4	t	3	127
495	5	f	4	127
496	True	t	1	128
497	False	f	2	128
498	 A+	f	1	129
499	 AB+	f	2	129
500	 B+	f	3	129
501	O-	t	4	129
502	Iron	f	1	130
503	Calcium	f	2	130
504	Zinc	t	3	130
505	Magnesium	f	4	130
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.questions (id, text, "questionType", points, "order", "testId") FROM stdin;
1	Which country won the FIFA World Cup in 2018?	MULTIPLE_CHOICE	1	1	1
2	Who is known as 'The Egyptian King' in football?	MULTIPLE_CHOICE	1	1	1
3	A goalkeeper can use their hands anywhere on the field.	TRUE_FALSE	1	3	1
4	Which club has won the most UEFA Champions League titles?	MULTIPLE_CHOICE	1	4	1
6	The offside rule applies to throw-ins.	TRUE_FALSE	1	6	1
7	How long is a standard professional football match?	MULTIPLE_CHOICE	1	2	1
8	Which country hosted the 2010 FIFA World Cup?	MULTIPLE_CHOICE	1	8	1
9	Cristiano Ronaldo has played for Sporting CP.	TRUE_FALSE	1	9	1
10	What color card does a referee show for a serious foul?	MULTIPLE_CHOICE	1	10	1
11	Which player has won the most Ballon d'Or awards?	MULTIPLE_CHOICE	1	11	1
12	 What is the maximum number of substitutions allowed in a standard match?	MULTIPLE_CHOICE	1	12	1
13	Which country won the first ever FIFA World Cup in 1930?	MULTIPLE_CHOICE	1	13	1
14	Who is the all-time top scorer in UEFA Champions League?	MULTIPLE_CHOICE	1	14	1
15	 Who scored the “Hand of God” goal?	MULTIPLE_CHOICE	1	15	1
16	 What is the name of Barcelona’s home stadium?	MULTIPLE_CHOICE	1	16	1
17	Who won UEFA Euro 2020 (played in 2021)?	MULTIPLE_CHOICE	1	7	1
18	Who is often called “The King of Football”?	MULTIPLE_CHOICE	1	18	1
19	Which Italian club is famous for its black and blue stripes and is known as "Il Nerazzurri"?	MULTIPLE_CHOICE	1	19	1
20	Which country is the only one to have played in every FIFA World Cup tournament?	MULTIPLE_CHOICE	1	20	1
21	Which African nation was the first to reach a World Cup quarter-final (in 1990)?	MULTIPLE_CHOICE	1	21	1
22	Which goalkeeper has the most clean sheets in Premier League history?	MULTIPLE_CHOICE	1	17	1
23	Which English club was the first to win the European Cup?	MULTIPLE_CHOICE	1	23	1
24	Who was the first player to score at five different World Cup tournaments?	MULTIPLE_CHOICE	1	24	1
25	Which country won the first ever European Championship (Euro) in 1960?	MULTIPLE_CHOICE	1	25	1
26	What is the fastest goal ever scored in World Cup history?	MULTIPLE_CHOICE	1	26	1
27	Which club did Zinedine Zidane NOT play for during his career?	MULTIPLE_CHOICE	1	22	1
28	Who is the only player to have won the Champions League with three different clubs?	MULTIPLE_CHOICE	1	28	1
29	Which player has won the most Premier League titles?	MULTIPLE_CHOICE	1	29	1
30	What year was VAR (Video Assistant Referee) first used in the World Cup?	MULTIPLE_CHOICE	1	27	1
31	Which countries border Germany?	MULTIPLE_ANSWER	2	1	2
32	What is the smallest country in Asia by area?	MULTIPLE_CHOICE	1	2	2
33	The Sahara Desert spans multiple countries.	TRUE_FALSE	1	3	2
34	Which countries are part of Scandinavia?	MULTIPLE_ANSWER	1	4	2
35	What is the currency of the United Kingdom?	MULTIPLE_CHOICE	1	5	2
36	Which country is home to the ancient city of Petra?	MULTIPLE_CHOICE	1	1	2
37	Which country is home to the ancient city of Petra?	MULTIPLE_CHOICE	1	1	2
38	 Switzerland is landlocked.	TRUE_FALSE	1	7	2
39	What is the capital of Kenya?	MULTIPLE_CHOICE	1	8	2
40	Which country has the most time zones?	MULTIPLE_CHOICE	1	9	2
41	Egypt is located on two continents.	TRUE_FALSE	1	10	2
42	What is the official language of Brazil?	MULTIPLE_CHOICE	1	7	2
43	Which country is known as the Land of the Rising Sun?	MULTIPLE_CHOICE	1	13	2
44	 Canada shares a border with the United States.	TRUE_FALSE	1	14	2
45	How many countries are in Africa?	MULTIPLE_CHOICE	1	15	2
46	Which African country was formerly known as Abyssinia?	MULTIPLE_CHOICE	1	16	2
47	 Brazil is the largest country in South America.	TRUE_FALSE	1	18	2
48	What is the capital of Australia?	MULTIPLE_CHOICE	1	19	2
50	Nigeria is located in West Africa.	TRUE_FALSE	1	21	2
51	What is the capital of France?	MULTIPLE_CHOICE	1	22	2
52	Which is the largest country in the world by land area?	MULTIPLE_CHOICE	1	17	2
53	What is the only country that is also a continent?	MULTIPLE_CHOICE	1	23	2
54	What is the smallest country in the world?	MULTIPLE_CHOICE	1	24	2
55	How many countries share a border with Brazil?	MULTIPLE_CHOICE	1	25	2
56	Which country has the longest coastline in the world?	MULTIPLE_CHOICE	1	26	2
57	What is the only country that borders both the Atlantic and Indian Oceans?	MULTIPLE_CHOICE	1	22	2
58	Which country is home to the most UNESCO World Heritage Sites?	MULTIPLE_CHOICE	1	28	2
59	What is the only country whose flag is not rectangular or square?	MULTIPLE_CHOICE	1	29	2
60	Which country is known as the "Land of a Thousand Lakes"?	MULTIPLE_CHOICE	1	30	2
5	What is it called when a player scores three goals in one game?	MULTIPLE_CHOICE	1	5	1
61	What is 15% of 200?\n	MULTIPLE_CHOICE	1	1	3
62	Which of the following are even numbers?	MULTIPLE_ANSWER	2	2	3
63	What is the area of a rectangle with length 8 cm and width 5 cm?	MULTIPLE_CHOICE	1	3	3
64	How many degrees are in a right angle?	MULTIPLE_CHOICE	1	4	3
65	Simplify: 2(x + 3) - 4x	MULTIPLE_CHOICE	1	5	3
66	Which of the following fractions are equivalent to 1/2?	MULTIPLE_ANSWER	2	1	3
67	What is the value of 7³?	MULTIPLE_CHOICE	1	7	3
68	Which of these operations follow the commutative property?	MULTIPLE_ANSWER	1.5	8	3
69	What is 2/5 + 1/4?	MULTIPLE_CHOICE	1	9	3
70	5x - 8 = 17	SHORT_ANSWER	1.5	10	3
71	What is the sum of the interior angles of a triangle?	MULTIPLE_CHOICE	1	6	3
73	Convert 0.75 to a fraction in simplest form	MULTIPLE_CHOICE	1	13	3
74	If y = 3x + 2, what is y when x = 4?	MULTIPLE_CHOICE	1	14	3
76	 What is 20% expressed as a decimal?	MULTIPLE_CHOICE	1	11	3
77	All squares are rectangles.	TRUE_FALSE	1	17	3
72	Which of the following are factors of 36?	MULTIPLE_ANSWER	2	12	3
49	Which country has the largest population in the world?	MULTIPLE_CHOICE	1	20	2
78	Select all properties of a square:	MULTIPLE_ANSWER	1	18	3
80	 What is 40% of 250?	MULTIPLE_CHOICE	1	20	3
75	Which of these numbers are divisible by 3?	MULTIPLE_ANSWER	2	15	3
79	What is the area formula for a circle?	MULTIPLE_CHOICE	1	19	3
81	 What is the largest ocean on Earth?	MULTIPLE_CHOICE	1	1	4
82	The Great Wall of China is visible from space with the naked eye.	TRUE_FALSE	1	2	4
83	 How many continents are there in the world?	MULTIPLE_CHOICE	1	3	4
84	Which planet is known as the Red Planet?	MULTIPLE_CHOICE	1	4	4
85	What is the smallest country in the world?	MULTIPLE_CHOICE	1	5	4
86	The Statue of Liberty was a gift from France.	TRUE_FALSE	1	6	4
87	Which gas do plants absorb from the atmosphere?	MULTIPLE_CHOICE	1	7	4
88	Lightning is hotter than the surface of the sun.	TRUE_FALSE	1	8	4
89	 How many bones are in the adult human body?	MULTIPLE_CHOICE	1	9	4
90	The Amazon Rainforest is located primarily in Brazil.	TRUE_FALSE	1	10	4
91	 Who invented the telephone?	MULTIPLE_CHOICE	1	1	4
92	What is the currency of Japan?	MULTIPLE_CHOICE	1	12	4
93	 Which animal is the fastest land animal?	MULTIPLE_CHOICE	1	13	4
94	 The human body has four lungs.	TRUE_FALSE	1	14	4
95	What is the largest mammal in the world?	MULTIPLE_CHOICE	1	15	4
96	 What is H2O commonly known as?	MULTIPLE_CHOICE	1	16	4
97	 Which animal is known as the “King of the Jungle”?	MULTIPLE_CHOICE	1	17	4
98	How many days are in a leap year?	MULTIPLE_CHOICE	1	18	4
99	What is the hardest natural substance?	MULTIPLE_CHOICE	1	19	4
100	What is the capital of Australia?	MULTIPLE_CHOICE	1	20	4
101	What is the name of the process by which plants make their own food using sunlight?	MULTIPLE_CHOICE	1	11	4
102	In which city would you find the Eiffel Tower?	MULTIPLE_CHOICE	1	22	4
103	Which of the following are among the Seven Wonders of the Ancient World?	MULTIPLE_ANSWER	1	23	4
104	 In which year did the Titanic sink?	MULTIPLE_CHOICE	1	24	4
105	Which of these cities are capital cities?	MULTIPLE_ANSWER	1	25	4
106	Which of the following are Romance languages?	MULTIPLE_ANSWER	1	26	4
107	What is the tallest mountain in the world?	MULTIPLE_CHOICE	1	27	4
108	 Which of these are precious metals?	MULTIPLE_ANSWER	1	28	4
109	What does UNESCO stand for?	MULTIPLE_CHOICE	1	29	4
110	Which of the following countries drive on the left side of the road?	MULTIPLE_ANSWER	1	30	4
111	What is the largest organ in the human body?	MULTIPLE_CHOICE	1	1	5
112	Which of the following are symptoms of dehydration?	MULTIPLE_ANSWER	1	2	5
113	What is the normal body temperature for humans in Celsius?	MULTIPLE_CHOICE	1	3	5
114	Which of these are types of blood vessels?	MULTIPLE_ANSWER	1	4	5
115	How many chambers does the human heart have?	MULTIPLE_CHOICE	1	5	5
116	What is the main function of red blood cells?	MULTIPLE_CHOICE	1	6	5
117	 Which of the following are components of a healthy diet?	MULTIPLE_ANSWER	1	7	5
118	What is the recommended amount of sleep for adults per night?	MULTIPLE_CHOICE	1	8	5
119	Which organ filters blood to produce urine?	MULTIPLE_CHOICE	1	9	5
120	What is the medical term for high blood pressure?	MULTIPLE_CHOICE	1	10	5
121	 Which of the following are risk factors for heart disease?	MULTIPLE_ANSWER	1	11	5
122	What percentage of the human body is water (approximately)?	MULTIPLE_CHOICE	1	12	5
123	Which vitamin is produced when skin is exposed to sunlight?	MULTIPLE_CHOICE	1	13	5
124	Which organ in the human body filters blood?	MULTIPLE_CHOICE	1	14	5
125	What does BMI stand for?	MULTIPLE_CHOICE	1	15	5
126	 Antibiotics are effective against viral infections.	TRUE_FALSE	1	11	5
127	How many chambers does the human heart have?	MULTIPLE_CHOICE	1	17	5
128	 Drinking water helps maintain healthy skin.	TRUE_FALSE	1	18	5
129	 Which blood type is known as the universal donor?	MULTIPLE_CHOICE	1	19	5
130	Which mineral is essential for strong bones and teeth?	MULTIPLE_CHOICE	1	20	5
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.tests (id, title, description, duration, "maxAttempts", "isPublished", "availableFrom", "availableUntil", "createdAt", "updatedAt") FROM stdin;
3	MATHEMATICS 	Test your mathematical skills with this comprehensive quiz covering arithmetic, algebra, geometry, fractions, percentages, and problem-solving. Questions range from basic calculations to practical applications of mathematical concepts suitable for intermediate learners.	15	150	t	2025-10-16 07:21:00	2038-05-16 07:21:00	2025-10-16 09:21:33.199	2025-10-16 11:00:07.587
4	GENERAL KNOWLEDGE 	Explore your awareness of world geography, history, culture, famous landmarks, and important global facts. This quiz covers a diverse range of topics including capitals, historical events, world records, languages, and international organizations to broaden your general knowledge.	15	200	t	2025-10-16 08:56:00	2036-05-16 08:56:00	2025-10-16 09:57:01.548	2025-10-16 11:01:27.852
5	HEALTH AND MEDICINE 	Assess your understanding of human anatomy, physiology, nutrition, wellness, and medical terminology. This quiz covers topics including body systems, healthy lifestyle choices, disease prevention, and basic medical knowledge essential for maintaining good health.	15	300	t	2025-10-16 09:33:00	2037-10-16 09:33:00	2025-10-16 10:33:19.468	2025-10-16 11:01:58.57
1	FOOTBALL/SOCCER	Test your passion for the beautiful game with this comprehensive football quiz. Covering everything from legendary players and iconic clubs to World Cup history, famous tournaments, tactical knowledge, and memorable matches. Whether you call it football or soccer, this quiz challenges your understanding of the world's most popular sport.	15	300	t	2025-10-14 10:03:00	2039-01-14 10:03:00	2025-10-14 12:03:28.942	2025-10-16 11:05:10.983
2	COUNTRIES OF THE WORLD 	Take a global journey exploring countries, their capitals, flags, geographical features, currencies, and cultural highlights. This quiz tests your knowledge of world geography, including national landmarks, languages, population facts, and the political divisions that make up our diverse planet.	15	150	t	2025-10-14 12:06:00	2037-01-14 12:06:00	2025-10-14 16:07:14.825	2025-10-16 11:05:39.511
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: testwise_cbt_user
--

COPY public.users (id, email, name, role, avatar, "createdAt", "updatedAt") FROM stdin;
2	admin@testwise.com	Admin User	ADMIN	\N	2025-10-14 11:26:30.149	2025-10-14 11:26:30.149
1	muritador5050@gmail.com	Asadoye	ADMIN	https://res.cloudinary.com/dunxwifhk/image/upload/v1760371029/users/avatars/squ5cyzuwueisajscadk.jpg	2025-10-13 15:57:11.036	2025-10-14 11:28:36.07
3	asadoyealani47@gmail.com	Abdulazeez 	STUDENT	https://res.cloudinary.com/dunxwifhk/image/upload/v1760470424/users/avatars/wlrvmv8llkl3qylg7ahh.jpg	2025-10-14 19:33:52.685	2025-10-14 19:33:52.685
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.answers_id_seq', 162, true);


--
-- Name: attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.attempts_id_seq', 15, true);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.options_id_seq', 505, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.questions_id_seq', 130, true);


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.tests_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testwise_cbt_user
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: attempts attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: answers_attemptId_questionId_key; Type: INDEX; Schema: public; Owner: testwise_cbt_user
--

CREATE UNIQUE INDEX "answers_attemptId_questionId_key" ON public.answers USING btree ("attemptId", "questionId");


--
-- Name: attempts_userId_testId_attemptNumber_key; Type: INDEX; Schema: public; Owner: testwise_cbt_user
--

CREATE UNIQUE INDEX "attempts_userId_testId_attemptNumber_key" ON public.attempts USING btree ("userId", "testId", "attemptNumber");


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: testwise_cbt_user
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: answers answers_attemptId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT "answers_attemptId_fkey" FOREIGN KEY ("attemptId") REFERENCES public.attempts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: answers answers_optionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT "answers_optionId_fkey" FOREIGN KEY ("optionId") REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: answers answers_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT "answers_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public.questions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: attempts attempts_testId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT "attempts_testId_fkey" FOREIGN KEY ("testId") REFERENCES public.tests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attempts attempts_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT "attempts_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: options options_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT "options_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public.questions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: questions questions_testId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testwise_cbt_user
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT "questions_testId_fkey" FOREIGN KEY ("testId") REFERENCES public.tests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO testwise_cbt_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO testwise_cbt_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO testwise_cbt_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO testwise_cbt_user;


--
-- PostgreSQL database dump complete
--

