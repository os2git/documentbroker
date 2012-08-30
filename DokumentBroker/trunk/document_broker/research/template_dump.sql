--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO document_templates;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO document_templates;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO document_templates;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO document_templates;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO document_templates;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO document_templates;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_permission_id_seq', 39, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO document_templates;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO document_templates;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO document_templates;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO document_templates;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO document_templates;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO document_templates;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO document_templates;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO document_templates;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 143, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO document_templates;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO document_templates;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('django_content_type_id_seq', 13, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO document_templates;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO document_templates;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO document_templates;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: template_data_clientsystem; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE template_data_clientsystem (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uuid character varying(255) NOT NULL,
    description text NOT NULL,
    client character varying(255) NOT NULL
);


ALTER TABLE public.template_data_clientsystem OWNER TO document_templates;

--
-- Name: template_data_clientsystem_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE template_data_clientsystem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_data_clientsystem_id_seq OWNER TO document_templates;

--
-- Name: template_data_clientsystem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE template_data_clientsystem_id_seq OWNED BY template_data_clientsystem.id;


--
-- Name: template_data_clientsystem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('template_data_clientsystem_id_seq', 2, true);


--
-- Name: template_data_field; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE template_data_field (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    content_type character varying(255) NOT NULL,
    mandatory boolean NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.template_data_field OWNER TO document_templates;

--
-- Name: template_data_field_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE template_data_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_data_field_id_seq OWNER TO document_templates;

--
-- Name: template_data_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE template_data_field_id_seq OWNED BY template_data_field.id;


--
-- Name: template_data_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('template_data_field_id_seq', 195, true);


--
-- Name: template_data_template; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE template_data_template (
    id integer NOT NULL,
    uuid character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    version integer NOT NULL,
    type character varying(255) NOT NULL,
    status integer NOT NULL,
    file character varying(100) NOT NULL
);


ALTER TABLE public.template_data_template OWNER TO document_templates;

--
-- Name: template_data_template_available_for; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE template_data_template_available_for (
    id integer NOT NULL,
    template_id integer NOT NULL,
    clientsystem_id integer NOT NULL
);


ALTER TABLE public.template_data_template_available_for OWNER TO document_templates;

--
-- Name: template_data_template_available_for_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE template_data_template_available_for_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_data_template_available_for_id_seq OWNER TO document_templates;

--
-- Name: template_data_template_available_for_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE template_data_template_available_for_id_seq OWNED BY template_data_template_available_for.id;


--
-- Name: template_data_template_available_for_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('template_data_template_available_for_id_seq', 168, true);


--
-- Name: template_data_template_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE template_data_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_data_template_id_seq OWNER TO document_templates;

--
-- Name: template_data_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE template_data_template_id_seq OWNED BY template_data_template.id;


--
-- Name: template_data_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('template_data_template_id_seq', 22, true);


--
-- Name: templates_clientsystem; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE templates_clientsystem (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(1024) NOT NULL,
    client character varying(255) NOT NULL
);


ALTER TABLE public.templates_clientsystem OWNER TO document_templates;

--
-- Name: templates_clientsystem_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE templates_clientsystem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_clientsystem_id_seq OWNER TO document_templates;

--
-- Name: templates_clientsystem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE templates_clientsystem_id_seq OWNED BY templates_clientsystem.id;


--
-- Name: templates_clientsystem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('templates_clientsystem_id_seq', 2, true);


--
-- Name: templates_field; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE templates_field (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    content_type character varying(255) NOT NULL,
    mandatory boolean NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.templates_field OWNER TO document_templates;

--
-- Name: templates_field_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE templates_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_field_id_seq OWNER TO document_templates;

--
-- Name: templates_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE templates_field_id_seq OWNED BY templates_field.id;


--
-- Name: templates_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('templates_field_id_seq', 1, true);


--
-- Name: templates_template_available_for; Type: TABLE; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE TABLE templates_template_available_for (
    id integer NOT NULL,
    template_id integer NOT NULL,
    clientsystem_id integer NOT NULL
);


ALTER TABLE public.templates_template_available_for OWNER TO document_templates;

--
-- Name: templates_template_available_for_id_seq; Type: SEQUENCE; Schema: public; Owner: document_templates
--

CREATE SEQUENCE templates_template_available_for_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_template_available_for_id_seq OWNER TO document_templates;

--
-- Name: templates_template_available_for_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_templates
--

ALTER SEQUENCE templates_template_available_for_id_seq OWNED BY templates_template_available_for.id;


--
-- Name: templates_template_available_for_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_templates
--

SELECT pg_catalog.setval('templates_template_available_for_id_seq', 11, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_clientsystem ALTER COLUMN id SET DEFAULT nextval('template_data_clientsystem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_field ALTER COLUMN id SET DEFAULT nextval('template_data_field_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_template ALTER COLUMN id SET DEFAULT nextval('template_data_template_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_template_available_for ALTER COLUMN id SET DEFAULT nextval('template_data_template_available_for_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY templates_clientsystem ALTER COLUMN id SET DEFAULT nextval('templates_clientsystem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY templates_field ALTER COLUMN id SET DEFAULT nextval('templates_field_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY templates_template_available_for ALTER COLUMN id SET DEFAULT nextval('templates_template_available_for_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add client system	8	add_clientsystem
23	Can change client system	8	change_clientsystem
24	Can delete client system	8	delete_clientsystem
25	Can add template	9	add_template
26	Can change template	9	change_template
27	Can delete template	9	delete_template
28	Can add field	10	add_field
29	Can change field	10	change_field
30	Can delete field	10	delete_field
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
1	document_templates			carstena@magenta-aps.dk	pbkdf2_sha256$10000$EtwoGyECOY1G$fZPwr21lCootB0evf5P+Xlnr5yX0BKCtErmwRQm1xPo=	t	t	t	2012-06-11 08:24:50.309555+00	2012-05-15 11:20:52.678301+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
38	2012-05-30 07:36:29.533924+00	1	9	1	Template object	2	Ændrede file.
39	2012-05-30 10:01:34.075253+00	1	9	1	Template object	2	Tilføjede field "Field object". Tilføjede field "Field object". Tilføjede field "Field object".
40	2012-05-30 13:01:37.344636+00	1	9	1	Template object	2	Ændrede file.
41	2012-05-30 13:45:06.472813+00	1	9	1	Template object	2	Ændrede file.
42	2012-05-30 13:46:31.504519+00	1	9	1	Template object	2	Ingen felter ændret.
43	2012-05-30 13:47:35.516797+00	1	9	2	Template object	1	
44	2012-05-30 13:48:04.05459+00	1	9	2	Template object	2	Ændrede file.
45	2012-05-30 13:48:19.30315+00	1	9	1	Template object	2	Ændrede file.
46	2012-05-30 13:50:46.151337+00	1	9	1	Template object	2	Ændrede file.
47	2012-05-30 14:13:58.092006+00	1	9	1	Template object	2	Ingen felter ændret.
48	2012-05-31 09:06:39.226377+00	1	9	2	Template object	2	Ændrede file og type. Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
49	2012-05-31 09:07:50.301526+00	1	9	2	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
50	2012-05-31 09:08:05.972867+00	1	9	2	Template object	2	Ændrede file.
51	2012-05-31 09:11:23.938909+00	1	9	2	Template object	2	Ændrede mandatory for field "Field object".
52	2012-05-31 09:21:42.488895+00	1	9	8	Template object	1	
53	2012-05-31 09:22:04.012277+00	1	9	8	Template object	2	Ændrede name.
54	2012-05-31 11:16:58.199416+00	1	9	2	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
55	2012-05-31 11:17:28.794127+00	1	9	2	Template object	2	Ændrede file.
56	2012-05-31 12:14:28.56841+00	1	9	2	Template object	2	Ingen felter ændret.
57	2012-05-31 12:14:58.182529+00	1	9	9	Template object	1	
58	2012-05-31 12:35:52.418776+00	1	9	10	Template object	1	
59	2012-05-31 12:38:51.100727+00	1	9	10	Template object	2	Tilføjede field "Field object".
60	2012-05-31 13:02:01.554713+00	1	9	10	Template object	2	Slettede field "Field object".
61	2012-06-03 12:31:12.952324+00	1	9	11	Template object	1	
62	2012-06-03 12:32:11.461842+00	1	9	11	Template object	2	Ingen felter ændret.
63	2012-06-03 12:32:45.521204+00	1	9	11	Template object	2	Ændrede available_for.
64	2012-06-03 12:37:03.530186+00	1	9	11	Template object	2	Ændrede name og available_for.
65	2012-06-03 12:41:10.040418+00	1	9	8	Template object	2	Tilføjede field "Field object".
66	2012-06-03 12:43:00.541533+00	1	9	8	Template object	2	Slettede field "Field object".
67	2012-06-03 12:57:19.541719+00	1	9	10	Template object	2	Ændrede file.
68	2012-06-03 13:11:18.757203+00	1	9	10	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
69	2012-06-03 13:17:09.448974+00	1	9	10	Template object	2	Ingen felter ændret.
70	2012-06-03 13:18:04.951221+00	1	9	10	Template object	2	Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object".
71	2012-06-03 13:21:06.034288+00	1	9	12	Template object	1	
72	2012-06-03 13:21:32.684217+00	1	9	12	Template object	2	Ingen felter ændret.
73	2012-06-03 13:22:46.969995+00	1	9	12	Template object	2	Ændrede file.
74	2012-06-03 13:57:18.681277+00	1	9	10	Template object	2	Ændrede file.
75	2012-06-03 13:57:45.612902+00	1	9	10	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
76	2012-06-04 06:11:07.527849+00	1	9	12	Template object	2	Ændrede available_for.
77	2012-06-04 06:13:03.355183+00	1	9	12	Template object	2	Ændrede available_for.
78	2012-06-04 06:25:22.78993+00	1	9	12	Template object	2	Ændrede available_for.
79	2012-06-04 06:38:59.184396+00	1	9	12	Template object	2	Ændrede available_for.
80	2012-06-04 07:20:36.29733+00	1	9	12	Template object	2	Ændrede available_for.
81	2012-06-04 07:44:40.615323+00	1	9	13	Template object	1	
82	2012-06-04 08:49:36.838914+00	1	9	12	Template object	3	
83	2012-06-04 08:52:37.767284+00	1	9	10	Template object	3	
84	2012-06-04 08:52:58.509468+00	1	9	14	Template object	1	
85	2012-06-04 08:53:09.702156+00	1	9	14	Template object	2	Ingen felter ændret.
86	2012-06-04 08:57:32.715402+00	1	9	14	Template object	2	Ændrede file og version. Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
87	2012-06-04 08:57:40.419324+00	1	9	14	Template object	2	Ingen felter ændret.
88	2012-06-04 09:18:33.147396+00	1	9	14	Template object	2	Tilføjede field "Field object".
89	2012-06-04 09:19:30.02455+00	1	9	14	Template object	2	Slettede field "Field object".
90	2012-06-04 13:47:27.397355+00	1	9	14	Template object	2	Tilføjede field "Field object".
91	2012-06-04 13:47:57.835944+00	1	9	14	Template object	2	Slettede field "Field object".
92	2012-06-04 13:49:30.86044+00	1	9	14	Template object	2	Ændrede mandatory for field "Field object".
93	2012-06-05 11:29:27.525771+00	1	9	1	Template object	2	Ændrede type.
94	2012-06-05 11:32:41.001112+00	1	8	1	Skemalægning, Gribskov Kommune	2	Ændrede description.
95	2012-06-05 11:32:56.987719+00	1	9	2	Template object	2	Ændrede status.
96	2012-06-05 11:33:07.832515+00	1	9	1	Template object	2	Ændrede status.
97	2012-06-05 11:37:34.950084+00	1	9	15	Template object	1	
98	2012-06-05 11:40:36.97415+00	1	9	15	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
99	2012-06-05 11:41:34.002846+00	1	9	15	Template object	2	Ændrede file.
100	2012-06-05 11:41:42.857154+00	1	9	15	Template object	2	Slettede field "Field object".
101	2012-06-05 11:42:31.310395+00	1	9	15	Template object	2	Tilføjede field "Field object". Slettede field "Field object".
102	2012-06-05 11:43:55.577596+00	1	9	15	Template object	3	
103	2012-06-05 11:44:12.02155+00	1	9	1	Template object	2	Ændrede file.
104	2012-06-05 11:45:44.309403+00	1	9	1	Template object	2	Ændrede file.
105	2012-06-05 11:49:56.246239+00	1	9	1	Template object	2	Slettede field "Field object".
106	2012-06-05 11:50:14.076023+00	1	9	1	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
107	2012-06-05 11:50:26.478991+00	1	9	1	Template object	2	Ændrede file.
108	2012-06-05 11:57:26.770815+00	1	9	1	Template object	2	Ingen felter ændret.
109	2012-06-05 11:58:07.857962+00	1	9	1	Template object	2	Ændrede file.
110	2012-06-05 12:04:22.671685+00	1	9	1	Template object	2	Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object". Slettede field "Field object".
111	2012-06-05 12:04:30.652949+00	1	9	1	Template object	2	Ændrede file.
112	2012-06-05 12:04:42.080045+00	1	9	1	Template object	2	Ændrede file.
113	2012-06-05 12:04:47.067073+00	1	9	1	Template object	2	Ændrede mandatory for field "Field object".
114	2012-06-05 12:05:00.487878+00	1	9	1	Template object	2	Ændrede file.
115	2012-06-05 17:27:10.358204+00	1	9	14	Template object	2	Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object". Ændrede mandatory for field "Field object".
116	2012-06-05 17:28:20.415281+00	1	9	14	Template object	2	Tilføjede field "Field object".
117	2012-06-05 17:28:58.776751+00	1	9	14	Template object	2	Slettede field "Field object".
118	2012-06-05 17:29:15.236576+00	1	9	14	Template object	2	Ændrede file.
119	2012-06-06 09:35:18.113123+00	1	9	1	Template object	2	Ændrede file og status.
120	2012-06-06 09:36:38.751508+00	1	9	1	Template object	2	Ændrede file.
121	2012-06-06 09:36:47.045497+00	1	9	1	Template object	2	Ændrede status.
122	2012-06-06 09:37:40.483685+00	1	9	1	Template object	2	Ændrede file.
123	2012-06-06 09:38:57.916589+00	1	9	1	Template object	2	Ændrede file.
124	2012-06-06 11:29:49.243636+00	1	9	16	Template object	1	
125	2012-06-06 11:30:07.859267+00	1	9	16	Template object	2	Ændrede status.
126	2012-06-06 11:33:06.717655+00	1	9	16	Template object	2	Ændrede status.
127	2012-06-06 11:33:43.502585+00	1	9	16	Template object	3	
128	2012-06-07 07:31:08.060126+00	1	9	17	Template object	1	
129	2012-06-07 07:31:18.461301+00	1	9	17	Template object	2	Tilføjede field "Field object".
130	2012-06-07 07:32:04.481518+00	1	9	17	Template object	2	Ændrede name. Slettede field "Field object".
131	2012-06-07 11:39:45.133955+00	1	9	17	Template object	3	
132	2012-06-07 11:41:32.414896+00	1	9	18	Template object	1	
133	2012-06-07 11:41:51.364919+00	1	9	18	Template object	2	Ingen felter ændret.
134	2012-06-07 11:42:20.473401+00	1	9	18	Template object	3	
135	2012-06-07 12:29:05.171412+00	1	9	19	Template object	1	
136	2012-06-07 12:32:02.413331+00	1	9	19	Template object	2	Ændrede mandatory for field "Field object".
137	2012-06-12 09:50:04.985341+00	1	9	20	Template object	1	
138	2012-06-12 10:00:35.072206+00	1	9	20	Template object	2	Ingen felter ændret.
139	2012-06-22 07:41:00.341963+00	1	9	20	Template object	3	
140	2012-06-22 07:41:39.725569+00	1	9	21	Template object	1	
141	2012-06-22 07:42:05.724608+00	1	9	21	Template object	3	
142	2012-06-22 12:36:45.302463+00	1	9	22	Template object	1	
143	2012-06-22 12:38:11.35246+00	1	9	22	Template object	2	Ingen felter ændret.
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	client system	template_data	clientsystem
9	template	template_data	template
10	field	template_data	field
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
9dbe7d579909421a4abba927e05cf25b	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-20 08:33:50.055226+00
b2a6e9b9d5a9d98fbaa5ac7ae5f8ee4e	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-30 13:45:55.226503+00
34bf28d5c929278d77a18c1f8a5abbed	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-05-30 14:23:00.281977+00
586666a5c422ec7e2a0e35f0d8e7fee0	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-20 10:43:59.073629+00
474b5fe571dd6cd5e3f5f0d99c313c5b	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 08:22:27.955851+00
514be3f85018b0a5abfac570c91a12c5	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-08 09:27:22.861773+00
56bc070e52c9c5924cce9d0e7b61a8c5	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-14 06:59:19.42907+00
a78876840e4e4f056ff8cdcdc70e4069	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-14 12:21:08.157232+00
dd6192cbfd8d3cc7c57673b990101b9c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-16 12:11:31.506148+00
0e281f1d74549e158b63dff52a384f98	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-16 12:21:32.967808+00
2d40d71964b56cc1d284701c78e4a6b9	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-16 12:33:43.47918+00
285cd868e52c0d59b3ffbb9ade7a703e	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-17 09:45:54.991783+00
f5953a1794db43e47798080dfdb8e796	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-21 11:27:23.862602+00
f26da71f89478fe3a1798d3b4d2394e5	M2I5Y2MwZGVjNjkzZWI4OGQ1OTU4ZGMzZTY3MjFjOTNlYmI0ZjU5ODqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2VkcQJzLg==\n	2012-06-21 11:34:04.109475+00
fec64c805f5dcddc18c09dc6ec8fae15	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 09:15:56.835639+00
8f89a9da557bdcabe451a8de6b64633c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 09:33:53.7334+00
5f67cbaa645af1497746125aae9d0a5c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-21 11:36:16.708938+00
14e5b31e69ef85acc386565267253716	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 10:19:15.802075+00
6b70f7832325315e9d48ba0dfed507ad	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-01 11:05:21.068035+00
80e8ce7d514c6ac64c85cdda3d7c4e75	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-21 11:39:28.440093+00
9954574c8397aafe7ffba57c54e0da77	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-04 12:46:46.666207+00
e3cda547b382e83c5fc3c8b09aa3ee8f	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-05 08:24:38.982865+00
4b665a8106cf50eed5c496c4c4c5d2df	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 07:29:36.506844+00
3eb858fd393f282893e36286e3aeda10	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-13 09:06:36.873687+00
77d93bc8e76ee19ed1e7a935727ced4f	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 09:53:56.230199+00
7e8566dcb9ab855743c75300d5d18e3e	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 12:38:59.928499+00
691f1dba59261a93d5215487b79ca16d	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-14 07:47:48.255313+00
5401e32d99928f7413702a15c48c474c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-17 12:30:02.3285+00
d3103256ee18f94f8bf907af030bb444	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-17 12:30:10.625551+00
a36ac6d316872c6554d3e36addbe6093	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-17 12:46:31.704013+00
b01e3d1e24929ba975e99b7691b2fca9	OTZkNDgwMjYxNzMyZjYzNzZjODg0MDkzMDhmMzI0NmQxZGM4N2EwMTqAAn1xAS4=\n	2012-06-18 07:30:34.277147+00
1a9c07cea2a2bcb155d070a36aa0b5b5	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-19 11:28:50.889992+00
c052d9c62df1658d368d59e063d920a2	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-25 08:24:50.320772+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: template_data_clientsystem; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY template_data_clientsystem (id, name, uuid, description, client) FROM stdin;
2	Magenta test	553b6807-851d-4b76-a4c1-3f683fc20de3	Magenta test system	Magenta
1	Skemalægning	a1388f42-046f-49ff-a58d-2d681a8153dd	Test template 1	Gribskov Kommune
\.


--
-- Data for Name: template_data_field; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY template_data_field (id, name, type, content_type, mandatory, document_id) FROM stdin;
72	Kundeadresse	TEXT	string	t	14
74	PostBy	TEXT	string	t	14
75	MagentaSignatur	TEXT	string	t	14
76	BrevDato	TEXT	string	t	14
13	Kundenavn	TEXT	string	f	8
14	Kundeadresse	TEXT	string	f	8
15	Kundeadresse2	TEXT	string	f	8
16	KundeCVR	TEXT	string	f	8
17	MagentaSignatur	TEXT	string	f	8
18	Leif	TEXT	string	f	2
19	Svaret	TEXT	string	f	2
20	Dato	TEXT	string	f	2
21	Leif	TEXT	string	f	9
22	Svaret	TEXT	string	f	9
23	Dato	TEXT	string	f	9
31	Felt1	TEXT	string	f	11
32	Felt2	TEXT	string	f	11
33	Felt3	TEXT	string	f	11
164	Brevtype	TEXT	string	f	19
165	Dato	TEXT	string	f	19
166	Journalnummer	TEXT	string	f	19
167	AfsenderNavn	TEXT	string	f	19
168	AfsenderStilling	TEXT	string	f	19
170	ModtagerAdresse	TEXT	string	f	19
171	ModtagerPostBy	TEXT	string	f	19
169	ModtagerNavn	TEXT	string	t	19
59	Kundenavn	TEXT	string	f	13
60	Kundeadresse	TEXT	string	f	13
61	Kundeadresse2	TEXT	string	f	13
62	PostBy	TEXT	string	f	13
63	MagentaSignatur	TEXT	string	f	13
64	BrevDato	TEXT	string	f	13
128	Kundenavn	TEXT	string	t	14
188	Brevtype	TEXT	string	f	22
189	Dato	TEXT	string	f	22
73	Kundeadresse2	TEXT	string	f	14
190	Journalnummer	TEXT	string	f	22
191	AfsenderNavn	TEXT	string	f	22
192	AfsenderStilling	TEXT	string	f	22
136	Svaret	TEXT	string	f	1
137	Dato	TEXT	string	f	1
135	Leif	TEXT	string	t	1
193	ModtagerNavn	TEXT	string	f	22
194	ModtagerAdresse	TEXT	string	f	22
195	ModtagerPostBy	TEXT	string	f	22
\.


--
-- Data for Name: template_data_template; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY template_data_template (id, uuid, name, version, type, status, file) FROM stdin;
2	da105978-db62-4031-a37f-96098e799ab0	Ny Test Template	1	ODT	1	files/Test_3.ott
22	b5254a9b-193c-4438-8b53-69bf0bdac397	my new template	1	ODT	1	files/Minister_6.ott
9	befa4369-88f1-4b88-ac0c-80fbc2eb9780	Helt ny template	1	ODT	1	files/Test_4.ott
11	09089dc4-69a1-45d4-9c56-d554f80a6075	TestSkabelon2	1	ODT	1	files/TestSkabelon.ott
8	4bce7619-ac97-4e12-a30d-2e72bce719cb	Magenta samarbejdsaftale	1	ODT	1	files/Samarbejdsaftale_5.ott
13	071cea02-f9d1-4152-a2fb-9a51e232a03b	Test Upload	1	ODT	1	files/BrevSkabelon_5.ott
14	0e256113-1cdb-4067-beb4-70d9dc14fc49	Brevskabelon	2	ODT	1	files/BrevSkabelon_8.ott
1	2ca21031-72b2-4dd4-a81a-b433864e1673	OTT Test Template	2	ODT	1	files/Test_4.odt
19	58a00d54-bd79-43e4-945e-43ce48faa091	nY TEMPLATE	1	ODT	1	files/Minister_3.ott
\.


--
-- Data for Name: template_data_template_available_for; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY template_data_template_available_for (id, template_id, clientsystem_id) FROM stdin;
69	13	2
143	14	2
91	2	1
92	2	2
152	1	1
153	1	2
43	9	2
163	19	2
51	11	2
53	8	2
168	22	2
\.


--
-- Data for Name: templates_clientsystem; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY templates_clientsystem (id, name, description, client) FROM stdin;
1	Skemalægning	Skolevæsnet	Gribskov Kommune
2	Kreditorstyring	Udsendelse af rykkere mv.	Gribskov Kommune
\.


--
-- Data for Name: templates_field; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY templates_field (id, name, type, content_type, mandatory, document_id) FROM stdin;
1	Navn	String	Text	f	2
\.


--
-- Data for Name: templates_template_available_for; Type: TABLE DATA; Schema: public; Owner: document_templates
--

COPY templates_template_available_for (id, template_id, clientsystem_id) FROM stdin;
6	2	1
11	1	1
\.


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: template_data_clientsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_clientsystem
    ADD CONSTRAINT template_data_clientsystem_pkey PRIMARY KEY (id);


--
-- Name: template_data_field_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_field
    ADD CONSTRAINT template_data_field_pkey PRIMARY KEY (id);


--
-- Name: template_data_template_availabl_template_id_clientsystem_id_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_template_available_for
    ADD CONSTRAINT template_data_template_availabl_template_id_clientsystem_id_key UNIQUE (template_id, clientsystem_id);


--
-- Name: template_data_template_available_for_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_template_available_for
    ADD CONSTRAINT template_data_template_available_for_pkey PRIMARY KEY (id);


--
-- Name: template_data_template_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_template
    ADD CONSTRAINT template_data_template_pkey PRIMARY KEY (id);


--
-- Name: template_data_template_uuid_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY template_data_template
    ADD CONSTRAINT template_data_template_uuid_key UNIQUE (uuid);


--
-- Name: templates_clientsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY templates_clientsystem
    ADD CONSTRAINT templates_clientsystem_pkey PRIMARY KEY (id);


--
-- Name: templates_field_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY templates_field
    ADD CONSTRAINT templates_field_pkey PRIMARY KEY (id);


--
-- Name: templates_template_available_fo_template_id_clientsystem_id_key; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY templates_template_available_for
    ADD CONSTRAINT templates_template_available_fo_template_id_clientsystem_id_key UNIQUE (template_id, clientsystem_id);


--
-- Name: templates_template_available_for_pkey; Type: CONSTRAINT; Schema: public; Owner: document_templates; Tablespace: 
--

ALTER TABLE ONLY templates_template_available_for
    ADD CONSTRAINT templates_template_available_for_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: template_data_field_document_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX template_data_field_document_id ON template_data_field USING btree (document_id);


--
-- Name: template_data_template_available_for_clientsystem_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX template_data_template_available_for_clientsystem_id ON template_data_template_available_for USING btree (clientsystem_id);


--
-- Name: template_data_template_available_for_template_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX template_data_template_available_for_template_id ON template_data_template_available_for USING btree (template_id);


--
-- Name: templates_field_document_id; Type: INDEX; Schema: public; Owner: document_templates; Tablespace: 
--

CREATE INDEX templates_field_document_id ON templates_field USING btree (document_id);


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: template_data_field_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_field
    ADD CONSTRAINT template_data_field_document_id_fkey FOREIGN KEY (document_id) REFERENCES template_data_template(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: template_data_template_available_for_clientsystem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_template_available_for
    ADD CONSTRAINT template_data_template_available_for_clientsystem_id_fkey FOREIGN KEY (clientsystem_id) REFERENCES template_data_clientsystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: template_id_refs_id_2beee0ab; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY template_data_template_available_for
    ADD CONSTRAINT template_id_refs_id_2beee0ab FOREIGN KEY (template_id) REFERENCES template_data_template(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: templates_template_available_for_clientsystem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY templates_template_available_for
    ADD CONSTRAINT templates_template_available_for_clientsystem_id_fkey FOREIGN KEY (clientsystem_id) REFERENCES templates_clientsystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_831107f1; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_831107f1 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_f2045483; Type: FK CONSTRAINT; Schema: public; Owner: document_templates
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_f2045483 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

