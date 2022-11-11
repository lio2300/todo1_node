--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

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

DROP DATABASE IF EXISTS todo1;
--
-- Name: todo1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE todo1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Ecuador.1252';


ALTER DATABASE todo1 OWNER TO postgres;

\connect todo1

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
-- Name: DATABASE todo1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE todo1 IS 'Base de datos para test TODO1';


--
-- Name: todo1_user(character varying, json); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.todo1_user(option character varying, req json, OUT response json) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    _obj     json;
    _table   text='user';
    _code    int = 200;
    _total   int;
    _message text;
BEGIN

    IF option IS NULL OR (option <> 'user_table' AND option <> 'user_register' AND option <> 'user_update' AND option <> 'user_delete' AND option <> 'user_id')
    THEN
        _code := 400;
        _message := 'Debe ingresar la opción correcta';
    END IF;

    IF option = 'user_table'
    THEN
        _obj := (select json_agg(users)
                 from (select *
                       from users
                       where user_name like concat('%', req ->> 'search', '%')
                          or user_dni = req ->> 'search'
                          or user_firstname like concat('%', req ->> 'search', '%')
                          or user_lastname like concat('%', req ->> 'search', '%')
                       order by pk_user desc
                       limit (req ->> 'limit')::integer offset (req ->> 'offset')::integer) users);
        _total := (select count(*)
                   from users
                   where user_name like concat('%', req ->> 'search', '%')
                      or user_dni = req ->> 'search'
                      or user_firstname like concat('%', req ->> 'search', '%')
                      or user_lastname like concat('%', req ->> 'search', '%'));
        _message := 'Consulta ejecutada con éxito.';
    ELSEIF option = 'user_register'
    THEN
        WITH user_register AS (
            INSERT INTO users
                (user_name, user_firstname, user_lastname, user_email, user_phone, user_dni, user_age)
                values (req ->> 'user_name', req ->> 'user_firstname', req ->> 'user_lastname', req ->> 'user_email', req ->> 'user_phone', req ->> 'user_dni',
                        (req ->> 'user_age')::integer) RETURNING *)
        SELECT *
        into _obj
        FROM user_register;
        _obj := (select row_to_json("user") from (select * from users order by pk_user desc limit 1) "user");
        _message := 'Usuario registrado con éxito';
        _code := 201;
    ELSEIF option = 'user_update'
    THEN
        WITH user_update AS (
            UPDATE users SET
                user_name = req ->> 'user_name',
                user_firstname = req ->> 'user_firstname',
                user_email = req ->> 'user_email',
                user_phone = req ->> 'user_phone',
                user_dni = req ->> 'user_dni',
                user_age = (req ->> 'user_age')::integer,
                user_status = (req ->> 'user_status')::boolean
                where pk_user = (req ->> 'pk_user')::integer
                RETURNING *)
        SELECT *
        into _obj
        FROM user_update;
        _obj := (select row_to_json("user") from (select * from users where pk_user = (req ->> 'pk_user')::integer) "user");
        _message := 'Usuario actualizado con éxito';
    ELSEIF option = 'user_delete'
    THEN
        WITH user_delete AS (
            DELETE FROM users where pk_user = (req ->> 'pk_user')::integer
                RETURNING *)
        SELECT *
        into _obj
        FROM user_delete;
        if (_obj is not null) then
            _message := 'Usuario eliminado con éxito';
        else
            _message := 'El usuario no se pudo eliminar';
        end if;
    ELSEIF option = 'user_id'
    THEN
        _obj := (select row_to_json("user")
                 from (select *
                       from users
                       where pk_user = (req ->> 'pk_user')::integer) "user");
        _message := 'Consulta ejecutada con éxito.';
    END IF;
    response = json_build_object('code', _code, 'message', _message, 'table', _table, 'data', _obj, 'total', _total);
EXCEPTION
    WHEN OTHERS
        THEN
            response = json_build_object('code', 503, 'message', concat('Error-General: ', sqlerrm), 'tabla',
                                         _table);
END
$$;


ALTER FUNCTION public.todo1_user(option character varying, req json, OUT response json) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    pk_user bigint NOT NULL,
    user_name character varying(150),
    user_firstname character varying(255),
    user_lastname character varying(255),
    user_email character varying(200),
    user_phone character varying(15),
    user_dni character varying(15),
    user_age integer,
    "user_createdAt" timestamp without time zone DEFAULT now(),
    user_status boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.users IS 'Tabla para almacenar los registros de los usuarios';


--
-- Name: COLUMN users.pk_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.pk_user IS 'Identificador del registro';


--
-- Name: COLUMN users.user_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_name IS 'Nombre de usuario';


--
-- Name: COLUMN users.user_firstname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_firstname IS 'Nombres del usuario';


--
-- Name: COLUMN users.user_lastname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_lastname IS 'Apellidos del usuario';


--
-- Name: COLUMN users.user_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_email IS 'Email del usuario';


--
-- Name: COLUMN users.user_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_phone IS 'Telefóno del usuario';


--
-- Name: COLUMN users.user_dni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_dni IS 'Identificaión del usuario';


--
-- Name: COLUMN users.user_age; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_age IS 'Edad del usuario';


--
-- Name: COLUMN users."user_createdAt"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users."user_createdAt" IS 'Fecha de creacion del usuario';


--
-- Name: COLUMN users.user_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.user_status IS 'Estado del registro';


--
-- Name: user_pk_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_pk_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_pk_user_seq OWNER TO postgres;

--
-- Name: user_pk_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_pk_user_seq OWNED BY public.users.pk_user;


--
-- Name: users pk_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN pk_user SET DEFAULT nextval('public.user_pk_user_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (pk_user, user_name, user_firstname, user_lastname, user_email, user_phone, user_dni, user_age, "user_createdAt", user_status) FROM stdin;
1	sd	ds	s	ds	ds	ds	0	2022-11-11 09:20:04.887723	t
\.


--
-- Name: user_pk_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_pk_user_seq', 1, true);


--
-- Name: users user_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_email UNIQUE (user_email);


--
-- Name: CONSTRAINT user_email ON users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT user_email ON public.users IS 'Correo electrónico único del usuario';


--
-- Name: users user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pk PRIMARY KEY (pk_user);


--
-- Name: CONSTRAINT user_pk ON users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT user_pk ON public.users IS 'Identificador del registro';


--
-- Name: user_pk_user_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_pk_user_uindex ON public.users USING btree (pk_user);


--
-- PostgreSQL database dump complete
--

