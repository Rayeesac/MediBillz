--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

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

DROP DATABASE medibillz;
--
-- Name: medibillz; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE medibillz WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


\connect medibillz

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: billing_bill; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_bill (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    staff_id integer NOT NULL
);


--
-- Name: billing_bill_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.billing_bill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: billing_bill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.billing_bill_id_seq OWNED BY public.billing_bill.id;


--
-- Name: billing_billitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_billitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    packaging_type character varying(10) NOT NULL,
    price numeric(10,2) NOT NULL,
    bill_id bigint NOT NULL,
    medicine_id bigint NOT NULL,
    CONSTRAINT billing_billitem_quantity_check CHECK ((quantity >= 0))
);


--
-- Name: billing_billitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.billing_billitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: billing_billitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.billing_billitem_id_seq OWNED BY public.billing_billitem.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: medicines_medicine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicines_medicine (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(50) NOT NULL,
    single_price numeric(10,2) NOT NULL,
    strip_price numeric(10,2),
    pack_price numeric(10,2),
    box_price numeric(10,2),
    single_stock integer NOT NULL,
    strip_stock integer NOT NULL,
    pack_stock integer NOT NULL,
    box_stock integer NOT NULL,
    expiry_date date NOT NULL,
    created_at timestamp with time zone NOT NULL,
    inventory_manager_id integer NOT NULL,
    CONSTRAINT medicines_medicine_box_stock_check CHECK ((box_stock >= 0)),
    CONSTRAINT medicines_medicine_pack_stock_check CHECK ((pack_stock >= 0)),
    CONSTRAINT medicines_medicine_single_stock_check CHECK ((single_stock >= 0)),
    CONSTRAINT medicines_medicine_strip_stock_check CHECK ((strip_stock >= 0))
);


--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicines_medicine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicines_medicine_id_seq OWNED BY public.medicines_medicine.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: billing_bill id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_bill ALTER COLUMN id SET DEFAULT nextval('public.billing_bill_id_seq'::regclass);


--
-- Name: billing_billitem id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_billitem ALTER COLUMN id SET DEFAULT nextval('public.billing_billitem_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: medicines_medicine id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines_medicine ALTER COLUMN id SET DEFAULT nextval('public.medicines_medicine_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
1	Admin
2	Inventory Manager
3	Staff
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	2	25
38	2	26
39	2	27
40	2	28
41	3	32
42	3	33
43	3	34
44	3	35
45	3	36
46	3	28
47	3	29
48	3	30
49	3	31
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add medicine	7	add_medicine
26	Can change medicine	7	change_medicine
27	Can delete medicine	7	delete_medicine
28	Can view medicine	7	view_medicine
29	Can add bill	8	add_bill
30	Can change bill	8	change_bill
31	Can delete bill	8	delete_bill
32	Can view bill	8	view_bill
33	Can add bill item	9	add_billitem
34	Can change bill item	9	change_billitem
35	Can delete bill item	9	delete_billitem
36	Can view bill item	9	view_billitem
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$UG78sOLikoxiuh30h1ongO$5uEbETm/Gme64PkgUlgW6vO2C8OfjkyyxDJdxQxjvJU=	2025-03-17 08:58:24.831892+00	t	medi-billz-admin			info.rayeesac@gmail.com	t	t	2025-03-17 08:58:20.953011+00
2	pbkdf2_sha256$260000$V8FKdi1yFixzdA6HQ5hnXI$rEzUmnnokSFP0WrAouAJwnEBaA90IiMP5ilxsRVBGgo=	\N	f	staff01			staff01@gmail.com	f	t	2025-03-17 09:00:33.228971+00
3	pbkdf2_sha256$260000$fbo6fxxg4xDHNCnFgctLzY$zqmQVtpGS7QbVZ5zYj8h2xFIAAbENSCw1jYxLOLtAmY=	\N	f	staff02			staff02@gmail.com	f	t	2025-03-17 09:01:00.165658+00
4	pbkdf2_sha256$260000$7chgwZwmoHP8YaixFyaZVw$D0ImplnzHvycrY66M4RwC6WCdJyL3wjp51lUebeJB1M=	\N	f	staff03			staff03@gmail.com	f	t	2025-03-17 09:01:08.242304+00
5	pbkdf2_sha256$260000$SU0LfRX1sAyVrCnw5p1LYG$GblVdVhkFs2wmt03oQ26tCQc4gtJbPGhpyiv0WS+z4k=	\N	f	staff04			staff04@gmail.com	f	t	2025-03-17 09:01:17.216224+00
6	pbkdf2_sha256$260000$JbrxRxFZgNX4eKUCh0KqNb$ZXFCQdU13QiaeJfB9B95cs/qQMJ8nZICSA7WrgGwV4A=	\N	f	staff05			staff05@gmail.com	f	t	2025-03-17 09:01:23.948961+00
7	pbkdf2_sha256$260000$KniAilheBkRhATWOvwpmhn$kRX3hcekwcvoaR8bT+KRLEaRgb/2ZA0Xbbg/w5c5YuU=	\N	f	manager01			manager01@gmail.com	f	t	2025-03-17 09:01:44.268496+00
8	pbkdf2_sha256$260000$fKvPO95K5MJE06mFDelhsI$x9b+Bz8ClwZKk67jXwI7oXMhjVNuWw/xViANiKKF5hs=	\N	f	manager02			manager02@gmail.com	f	t	2025-03-17 09:01:54.090222+00
9	pbkdf2_sha256$260000$cY7ezkMWR21GOYUu0r96xe$DU4ojUgMjpbSpFo7D2ICqLWe4wmUqAgx8jTVCjdA3OI=	\N	f	manager03			manager03@gmail.com	f	t	2025-03-17 09:02:01.178087+00
10	pbkdf2_sha256$260000$RAdJoAHZt6kCiL9Ysdm71q$jwmCkrbFOBvx8c6T/ZBNvQnzfL9a+U7CTvJmjCOYLzg=	\N	f	manager04			manager04@gmail.com	f	t	2025-03-17 09:02:07.725992+00
11	pbkdf2_sha256$260000$0uHfItAt1DJgIWmHTgX3kd$0uQEwFQ0mlr3uZeJPLc7PBq3AwRB6W8u2avylwVLxZM=	\N	f	manager05			manager05@gmail.com	f	t	2025-03-17 09:02:13.244453+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	1	1
2	2	3
3	3	3
4	4	3
5	5	3
6	6	3
7	7	2
8	8	2
9	9	2
10	10	2
11	11	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: billing_bill; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.billing_bill (id, created_at, staff_id) FROM stdin;
1	2025-03-17 09:34:01.264613+00	2
2	2025-03-17 09:41:01.349339+00	2
3	2025-03-17 09:41:16.264395+00	2
4	2025-03-17 09:41:40.136013+00	2
\.


--
-- Data for Name: billing_billitem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.billing_billitem (id, quantity, packaging_type, price, bill_id, medicine_id) FROM stdin;
1	20	box	10000.00	1	1
2	10	pack	900.00	1	3
3	2	box	960.00	2	5
4	10	pack	1500.00	2	6
5	12	pack	2640.00	2	8
6	2	box	960.00	3	5
7	10	pack	1500.00	3	6
8	12	pack	2640.00	3	8
9	2	box	1040.00	4	2
10	1	pack	100.00	4	1
11	12	pack	2160.00	4	9
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2025-03-17 08:58:41.316397+00	1	Admin	1	[{"added": {}}]	3	1
2	2025-03-17 08:59:22.988485+00	2	Inventory Manager	1	[{"added": {}}]	3	1
3	2025-03-17 08:59:40.837268+00	3	Staff	1	[{"added": {}}]	3	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	medicines	medicine
8	billing	bill
9	billing	billitem
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-03-17 08:56:41.403344+00
2	auth	0001_initial	2025-03-17 08:56:41.539153+00
3	admin	0001_initial	2025-03-17 08:56:41.590256+00
4	admin	0002_logentry_remove_auto_add	2025-03-17 08:56:41.614747+00
5	admin	0003_logentry_add_action_flag_choices	2025-03-17 08:56:41.626811+00
6	contenttypes	0002_remove_content_type_name	2025-03-17 08:56:41.643975+00
7	auth	0002_alter_permission_name_max_length	2025-03-17 08:56:41.653139+00
8	auth	0003_alter_user_email_max_length	2025-03-17 08:56:41.661118+00
9	auth	0004_alter_user_username_opts	2025-03-17 08:56:41.669055+00
10	auth	0005_alter_user_last_login_null	2025-03-17 08:56:41.677165+00
11	auth	0006_require_contenttypes_0002	2025-03-17 08:56:41.679203+00
12	auth	0007_alter_validators_add_error_messages	2025-03-17 08:56:41.68665+00
13	auth	0008_alter_user_username_max_length	2025-03-17 08:56:41.697251+00
14	auth	0009_alter_user_last_name_max_length	2025-03-17 08:56:41.706091+00
15	auth	0010_alter_group_name_max_length	2025-03-17 08:56:41.714453+00
16	auth	0011_update_proxy_permissions	2025-03-17 08:56:41.723047+00
17	auth	0012_alter_user_first_name_max_length	2025-03-17 08:56:41.731377+00
18	medicines	0001_initial	2025-03-17 08:56:41.753976+00
19	billing	0001_initial	2025-03-17 08:56:41.786515+00
20	sessions	0001_initial	2025-03-17 08:56:41.797073+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
idcqxycrcyh0cm4411sr7o7q8fp8u1tp	.eJxVjDsOwjAUBO_iGlkB_ynpcwbrPa-NAyiR4qRC3J1ESgHtzsy-RaR1qXFteY4DxFWcxel3Y0rPPO4ADxrvk0zTuMwDy12RB22yn5Bft8P9O6jU6lazCzpDaRAXp60FGaiOvSsWwVyUd7Dg4IwqAHsTSjA2oFDnEm-i-HwB-k04iA:1tu6Ii:4-YnZcOeo-R2-_brGzxg_25C6vUAczvTOKjqWk-der8	2025-03-31 08:58:24.83609+00
\.


--
-- Data for Name: medicines_medicine; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medicines_medicine (id, name, category, single_price, strip_price, pack_price, box_price, single_stock, strip_stock, pack_stock, box_stock, expiry_date, created_at, inventory_manager_id) FROM stdin;
4	Aspirin	tablet	7.00	35.00	80.00	400.00	25	35	70	45	2027-01-15	2025-03-17 09:28:01.50699+00	7
7	Omeprazole	capsule	20.00	100.00	200.00	700.00	18	28	45	38	2026-08-10	2025-03-17 09:31:01.50699+00	8
10	Vitamin D3	capsule	22.00	110.00	230.00	780.00	20	30	55	47	2026-12-01	2025-03-17 09:34:01.50699+00	8
11	Ambroxol	syrup	60.00	10.00	10.00	500.00	25	10	10	20	2025-09-15	2025-03-17 09:35:01.50699+00	9
12	Cetirizine	syrup	65.00	10.00	10.00	520.00	22	10	10	18	2026-06-10	2025-03-17 09:36:01.50699+00	9
13	Domperidone	syrup	70.00	10.00	10.00	540.00	20	10	10	15	2027-03-20	2025-03-17 09:37:01.50699+00	9
14	Iron Syrup	syrup	80.00	10.00	10.00	600.00	18	10	10	12	2025-12-05	2025-03-17 09:38:01.50699+00	9
15	Lactulose	syrup	90.00	10.00	10.00	650.00	16	10	10	10	2026-05-25	2025-03-17 09:39:01.50699+00	9
16	Insulin	injection	200.00	200.00	200.00	1000.00	30	200	200	25	2025-11-01	2025-03-17 09:40:01.50699+00	10
17	Ceftriaxone	injection	180.00	200.00	200.00	950.00	28	200	200	22	2026-07-15	2025-03-17 09:41:01.50699+00	10
18	Adrenaline	injection	220.00	200.00	200.00	1100.00	25	200	200	20	2027-02-05	2025-03-17 09:42:01.50699+00	10
19	Ondansetron	injection	190.00	200.00	200.00	990.00	24	200	200	18	2025-08-20	2025-03-17 09:43:01.50699+00	10
20	Heparin	injection	210.00	200.00	200.00	1050.00	22	200	200	15	2026-10-30	2025-03-17 09:44:01.50699+00	10
3	Metformin	tablet	8.00	40.00	90.00	450.00	20	30	50	40	2025-09-30	2025-03-17 09:27:01.50699+00	7
5	Levothyroxine	tablet	9.00	45.00	95.00	480.00	30	40	50	46	2026-03-25	2025-03-17 09:29:01.50699+00	7
6	Amoxicillin	capsule	15.00	75.00	150.00	600.00	12	22	35	35	2025-11-20	2025-03-17 09:30:01.50699+00	8
8	Doxycycline	capsule	25.00	110.00	220.00	750.00	14	24	11	28	2027-04-05	2025-03-17 09:32:01.50699+00	8
2	Ibuprofen	tablet	12.00	55.00	110.00	520.00	15	25	40	28	2026-06-30	2025-03-17 09:25:01.50699+00	7
1	Paracetamol	tablet	10.00	50.00	100.00	500.00	10	20	49	30	2025-12-31	2025-03-17 09:22:01.50699+00	7
9	Fluoxetine	capsule	18.00	90.00	180.00	650.00	16	26	38	42	2025-07-15	2025-03-17 09:33:01.50699+00	8
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 49, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 36, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 11, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 11, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: billing_bill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.billing_bill_id_seq', 4, true);


--
-- Name: billing_billitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.billing_billitem_id_seq', 11, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 3, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 20, true);


--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicines_medicine_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: billing_bill billing_bill_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_bill
    ADD CONSTRAINT billing_bill_pkey PRIMARY KEY (id);


--
-- Name: billing_billitem billing_billitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_billitem
    ADD CONSTRAINT billing_billitem_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: medicines_medicine medicines_medicine_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines_medicine
    ADD CONSTRAINT medicines_medicine_name_key UNIQUE (name);


--
-- Name: medicines_medicine medicines_medicine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines_medicine
    ADD CONSTRAINT medicines_medicine_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: billing_bill_staff_id_24c12ad7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX billing_bill_staff_id_24c12ad7 ON public.billing_bill USING btree (staff_id);


--
-- Name: billing_billitem_bill_id_6cd8c774; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX billing_billitem_bill_id_6cd8c774 ON public.billing_billitem USING btree (bill_id);


--
-- Name: billing_billitem_medicine_id_903e409d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX billing_billitem_medicine_id_903e409d ON public.billing_billitem USING btree (medicine_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: medicines_medicine_inventory_manager_id_7ab9f294; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX medicines_medicine_inventory_manager_id_7ab9f294 ON public.medicines_medicine USING btree (inventory_manager_id);


--
-- Name: medicines_medicine_name_ef6bcb2d_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX medicines_medicine_name_ef6bcb2d_like ON public.medicines_medicine USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_bill billing_bill_staff_id_24c12ad7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_bill
    ADD CONSTRAINT billing_bill_staff_id_24c12ad7_fk_auth_user_id FOREIGN KEY (staff_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billitem billing_billitem_bill_id_6cd8c774_fk_billing_bill_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_billitem
    ADD CONSTRAINT billing_billitem_bill_id_6cd8c774_fk_billing_bill_id FOREIGN KEY (bill_id) REFERENCES public.billing_bill(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_billitem billing_billitem_medicine_id_903e409d_fk_medicines_medicine_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_billitem
    ADD CONSTRAINT billing_billitem_medicine_id_903e409d_fk_medicines_medicine_id FOREIGN KEY (medicine_id) REFERENCES public.medicines_medicine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: medicines_medicine medicines_medicine_inventory_manager_id_7ab9f294_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines_medicine
    ADD CONSTRAINT medicines_medicine_inventory_manager_id_7ab9f294_fk_auth_user FOREIGN KEY (inventory_manager_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

