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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO document_broker;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO document_broker;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO document_broker;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO document_broker;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO document_broker;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO document_broker;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_permission_id_seq', 30, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
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


ALTER TABLE public.auth_user OWNER TO document_broker;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO document_broker;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO document_broker;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO document_broker;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO document_broker;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO document_broker;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: configuration_client; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE configuration_client (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.configuration_client OWNER TO document_broker;

--
-- Name: configuration_client_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE configuration_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuration_client_id_seq OWNER TO document_broker;

--
-- Name: configuration_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE configuration_client_id_seq OWNED BY configuration_client.id;


--
-- Name: configuration_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('configuration_client_id_seq', 2, true);


--
-- Name: configuration_clientsystem; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE configuration_clientsystem (
    id integer NOT NULL,
    uuid character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    client_id integer NOT NULL,
    description text NOT NULL,
    user_authentication character varying(255) NOT NULL
);


ALTER TABLE public.configuration_clientsystem OWNER TO document_broker;

--
-- Name: configuration_clientsystem_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE configuration_clientsystem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuration_clientsystem_id_seq OWNER TO document_broker;

--
-- Name: configuration_clientsystem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE configuration_clientsystem_id_seq OWNED BY configuration_clientsystem.id;


--
-- Name: configuration_clientsystem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('configuration_clientsystem_id_seq', 4, true);


--
-- Name: configuration_pluginmapping; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE configuration_pluginmapping (
    id integer NOT NULL,
    extension character varying(16) NOT NULL,
    plugin character varying(255) NOT NULL,
    output_type character varying(16) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.configuration_pluginmapping OWNER TO document_broker;

--
-- Name: configuration_pluginmapping_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE configuration_pluginmapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuration_pluginmapping_id_seq OWNER TO document_broker;

--
-- Name: configuration_pluginmapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE configuration_pluginmapping_id_seq OWNED BY configuration_pluginmapping.id;


--
-- Name: configuration_pluginmapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('configuration_pluginmapping_id_seq', 4, true);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
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


ALTER TABLE public.django_admin_log OWNER TO document_broker;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO document_broker;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 16, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO document_broker;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO document_broker;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('django_content_type_id_seq', 10, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO document_broker;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO document_broker;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: document_broker
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO document_broker;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: document_broker
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: document_broker
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY configuration_client ALTER COLUMN id SET DEFAULT nextval('configuration_client_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY configuration_clientsystem ALTER COLUMN id SET DEFAULT nextval('configuration_clientsystem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY configuration_pluginmapping ALTER COLUMN id SET DEFAULT nextval('configuration_pluginmapping_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: document_broker
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
22	Can add client	8	add_client
23	Can change client	8	change_client
24	Can delete client	8	delete_client
25	Can add client system	9	add_clientsystem
26	Can change client system	9	change_clientsystem
27	Can delete client system	9	delete_clientsystem
28	Can add plugin mapping	10	add_pluginmapping
29	Can change plugin mapping	10	change_pluginmapping
30	Can delete plugin mapping	10	delete_pluginmapping
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
1	document_broker			carstena@magenta-aps.dk	pbkdf2_sha256$10000$y9huIACZu2Kt$Cy3ARA3gIO+LprK3BM5uf8S8Q9aPkPqQcqWnqUlHepg=	t	t	t	2012-06-07 11:36:53.286974+00	2012-05-15 11:14:56.228051+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: configuration_client; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY configuration_client (id, name, description) FROM stdin;
1	Gribskov Kommune	Vores måske kommende kunde.
2	Magenta	Test-kunde for Magentas udviklere.
\.


--
-- Data for Name: configuration_clientsystem; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY configuration_clientsystem (id, uuid, name, client_id, description, user_authentication) FROM stdin;
2	a1388f42-046f-49ff-a58d-2d681a8153dd	Skemalægning	1	Skemalægningsprogram for skolevæsnet i Gribskov kommune.\r\n\r\nSkal have adgang til følgende templates:\r\n\r\n* Skoleskema	0c4c3bfc12e22195ae280b2b3e793f1dfba43c97
3	a0f01abd-f60d-4b7d-ac00-beefb1d8383d	Kreditorstyring	1	Kreditorbogholderi ved Gribskov Kommune.\r\n\r\nSkal have adgang til følgende skabeloner:\r\n\r\n* Rykkerbrev\r\n* opkrævning\r\n* Inkassosag	8b429f4c0ce44c6985869f1d1069cbf1db480e48
4	553b6807-851d-4b76-a4c1-3f683fc20de3	Magenta test	2	Test-system for Magentas udviklere.	fa8019f4ea50a1eab471a816d111853dadbf52d7
\.


--
-- Data for Name: configuration_pluginmapping; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY configuration_pluginmapping (id, extension, plugin, output_type) FROM stdin;
1	ODT	ODFPlugin	odt
2	OTT	ODFPlugin	odt
3	DOC	OOXMLPlugin	doc
4	DOCX	OOXMLPlugin	docx
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2012-04-30 11:22:30.581437+00	1	8	1	Client object	1	
2	2012-04-30 11:46:25.210653+00	1	9	1	ClientSystem object	1	
3	2012-04-30 11:47:01.30854+00	1	9	1	ClientSystem object	2	Ingen felter ændret.
4	2012-04-30 11:48:07.366035+00	1	9	1	ClientSystem object	3	
5	2012-04-30 11:49:12.975324+00	1	9	2	ClientSystem object	1	
6	2012-04-30 11:55:06.075416+00	1	9	3	ClientSystem object	1	
7	2012-05-02 12:32:07.873563+00	1	8	2	Magenta	1	
8	2012-05-02 12:32:50.688857+00	1	9	4	ClientSystem object	1	
9	2012-05-29 13:48:27.227196+00	1	10	1	PluginMapping object	1	
10	2012-05-29 13:48:41.637924+00	1	10	2	PluginMapping object	1	
11	2012-05-29 13:48:51.042133+00	1	10	3	PluginMapping object	1	
12	2012-05-29 13:49:02.063676+00	1	10	4	PluginMapping object	1	
13	2012-05-30 09:14:01.135578+00	1	10	1	ODT	2	Ændrede output_type.
14	2012-05-30 09:14:09.387789+00	1	10	2	OTT	2	Ændrede output_type.
15	2012-05-30 09:14:17.367385+00	1	10	3	DOC	2	Ændrede output_type.
16	2012-05-30 09:14:26.508272+00	1	10	4	DOCX	2	Ændrede output_type.
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	client	configuration	client
9	client system	configuration	clientsystem
10	plugin mapping	configuration	pluginmapping
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
710fba8d5ab1a2f73399f8f5e4e126b6	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-30 13:44:39.727086+00
f810147d2f41517e6b4aa447f979e860	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-20 09:53:56.257549+00
534aae38a6c399b4838c3c6064be52d2	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-20 10:07:59.755525+00
55615aca6ce8b09f107365b07478a58d	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-30 14:12:50.100996+00
cef13a16f65cda1ed3b8ec0e87deb25b	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-14 10:58:42.755147+00
0b95692fd20d14612a52abb7006b6d40	OTZkNDgwMjYxNzMyZjYzNzZjODg0MDkzMDhmMzI0NmQxZGM4N2EwMTqAAn1xAS4=\n	2012-05-16 11:19:18.483041+00
9e036a6c54a73c177ff2958dc17c8d57	OTZkNDgwMjYxNzMyZjYzNzZjODg0MDkzMDhmMzI0NmQxZGM4N2EwMTqAAn1xAS4=\n	2012-05-16 12:15:35.337946+00
7192b831795400a96355f248a5105414	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-16 12:31:25.928745+00
731c34dfa1a788b5c4cafdea97027697	OTZkNDgwMjYxNzMyZjYzNzZjODg0MDkzMDhmMzI0NmQxZGM4N2EwMTqAAn1xAS4=\n	2012-05-17 08:23:53.391156+00
acbc67ad046e6a78f94e8d9c7b1eddfe	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 09:01:17.921831+00
3359c621eb923d9456450473858b72ab	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-01 09:04:45.569582+00
e3f36fa0e605e113a011a1645c0a0215	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-21 07:47:48.503992+00
f8869de232fe07d7f62b6e7db3646703	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-21 11:28:02.912719+00
4edf5fb4f1ee5f0711b5623117c4413c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 09:32:46.487367+00
e9e2c4ffabfa6bf0ecf40645c0450972	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-21 11:34:35.245387+00
28b555d7b18f0e4cb2026d0920e18ccf	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 10:21:20.319306+00
b8d677dc780b82bebcb3f5adeb7dd40c	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-21 11:36:53.292007+00
a41885058e574882e73e626c9de693fd	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 11:26:29.826551+00
5b0848fe7456676c553ab4dc44e25a84	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-01 13:35:56.049717+00
aaec49ddb266c767577cb7138a54eee3	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-04 12:15:05.67768+00
d42b52a7da2b8656bfb2e242053e2009	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-04 14:11:09.437516+00
50350235a3da48e80c1aaaa9aaf7e28e	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 09:06:02.77993+00
65a41406d89aff29be19170f1cbad399	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 09:10:42.431656+00
e86d1b621b140ef5fdccdd9548359f14	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-13 11:33:13.891335+00
045f028f4ba2cfba93dc82fb6b16415d	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-15 12:03:12.630154+00
67f7f74b717a4bc34d0cd47fc0aecc1a	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-17 12:44:50.268563+00
87b1ed482d7426efc1ae974307553bd1	MTJkNzJlZjlmOWViMmIyZGQxYjBjNjY2OTIzNGI2YjE3MjIzNjFkMTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n	2012-06-17 12:44:56.272772+00
372a4f77cce6595e74e6813a2095905b	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-19 11:04:51.497865+00
f53b0807b9b3cb64c6d0657bcbcffc9d	MTUwZWUwMDlhZDA1NzgzMDY3MmE3OTg1MGE1NDM2MmVhYmEwY2E4ZjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-20 08:20:49.673166+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: document_broker
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: configuration_client_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY configuration_client
    ADD CONSTRAINT configuration_client_pkey PRIMARY KEY (id);


--
-- Name: configuration_clientsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY configuration_clientsystem
    ADD CONSTRAINT configuration_clientsystem_pkey PRIMARY KEY (id);


--
-- Name: configuration_clientsystem_uuid_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY configuration_clientsystem
    ADD CONSTRAINT configuration_clientsystem_uuid_key UNIQUE (uuid);


--
-- Name: configuration_pluginmapping_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY configuration_pluginmapping
    ADD CONSTRAINT configuration_pluginmapping_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: document_broker; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: configuration_clientsystem_client_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX configuration_clientsystem_client_id ON configuration_clientsystem USING btree (client_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: document_broker; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: configuration_clientsystem_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY configuration_clientsystem
    ADD CONSTRAINT configuration_clientsystem_client_id_fkey FOREIGN KEY (client_id) REFERENCES configuration_client(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_831107f1; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_831107f1 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_f2045483; Type: FK CONSTRAINT; Schema: public; Owner: document_broker
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

