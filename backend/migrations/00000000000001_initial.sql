--
-- PostgreSQL database dump
--

-- Dumped from database version 11.12 (Debian 11.12-1.pgdg90+1)
-- Dumped by pg_dump version 11.12 (Debian 11.12-1.pgdg90+1)

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

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: backoffice_calllog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_calllog (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    comment text NOT NULL,
    "createdBy_id" integer
);


ALTER TABLE public.backoffice_calllog OWNER TO postgres;

--
-- Name: backoffice_calllog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_calllog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_calllog_id_seq OWNER TO postgres;

--
-- Name: backoffice_calllog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_calllog_id_seq OWNED BY public.backoffice_calllog.id;


--
-- Name: backoffice_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_identity (
    id integer NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.backoffice_identity OWNER TO postgres;

--
-- Name: backoffice_identity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_identity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_identity_id_seq OWNER TO postgres;

--
-- Name: backoffice_identity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_identity_id_seq OWNED BY public.backoffice_identity.id;


--
-- Name: backoffice_legalobserverlog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_legalobserverlog (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    comment text NOT NULL,
    "createdBy_id" integer,
    location text NOT NULL,
    name text NOT NULL,
    "onShift" boolean NOT NULL,
    phone text NOT NULL
);


ALTER TABLE public.backoffice_legalobserverlog OWNER TO postgres;

--
-- Name: backoffice_legalobserverlog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_legalobserverlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_legalobserverlog_id_seq OWNER TO postgres;

--
-- Name: backoffice_legalobserverlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_legalobserverlog_id_seq OWNED BY public.backoffice_legalobserverlog.id;


--
-- Name: backoffice_observation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_observation (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    court text NOT NULL,
    date timestamp with time zone NOT NULL,
    bench text NOT NULL,
    "defendantName" text NOT NULL,
    "defendantNumber" text NOT NULL,
    charges text NOT NULL,
    representation text NOT NULL,
    outline text NOT NULL,
    "evidenceSubmitted" text NOT NULL,
    "evidenceInPerson" text NOT NULL,
    verdict text NOT NULL,
    sentence text NOT NULL,
    costs text NOT NULL,
    notes text NOT NULL,
    identity_id integer NOT NULL
);


ALTER TABLE public.backoffice_observation OWNER TO postgres;

--
-- Name: backoffice_observation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_observation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_observation_id_seq OWNER TO postgres;

--
-- Name: backoffice_observation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_observation_id_seq OWNED BY public.backoffice_observation.id;


--
-- Name: backoffice_pleahearing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_pleahearing (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    hometown text NOT NULL,
    charge text NOT NULL,
    "lawFirm" text NOT NULL,
    "consentToContact" boolean NOT NULL,
    "canShareWithLocalXRGroup" boolean NOT NULL,
    "consentToRecord" boolean NOT NULL,
    "consentToPress" boolean NOT NULL,
    identity_id integer NOT NULL
);


ALTER TABLE public.backoffice_pleahearing OWNER TO postgres;

--
-- Name: backoffice_pleahearing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_pleahearing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_pleahearing_id_seq OWNER TO postgres;

--
-- Name: backoffice_pleahearing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_pleahearing_id_seq OWNED BY public.backoffice_pleahearing.id;


--
-- Name: backoffice_release; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_release (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    name text NOT NULL,
    "arrestTime" timestamp with time zone NOT NULL,
    location text NOT NULL,
    offence text NOT NULL,
    "termsOfRelease" text NOT NULL,
    charges text NOT NULL,
    "bailConditions" text NOT NULL,
    "courtDate" text NOT NULL,
    "courtLocation" text NOT NULL,
    "localXRGroup" text NOT NULL,
    "nearestCity" text NOT NULL,
    injuries text NOT NULL,
    "adverseEvents" text NOT NULL,
    "heldMoreThan24Hours" boolean NOT NULL,
    "helpNeeded" text NOT NULL,
    "specialRequest" text NOT NULL,
    "numberRebels" integer NOT NULL,
    "rebelsStillHeld" integer NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    "canShareWithLocalXRGroup" boolean NOT NULL,
    "canShareWithXRPress" boolean NOT NULL,
    comment text NOT NULL,
    "isHS2Action" boolean NOT NULL,
    "isPartOfXR" boolean NOT NULL,
    identity_id integer,
    "policeStation_id" integer
);


ALTER TABLE public.backoffice_release OWNER TO postgres;

--
-- Name: backoffice_release_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_release_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_release_id_seq OWNER TO postgres;

--
-- Name: backoffice_release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_release_id_seq OWNED BY public.backoffice_release.id;


--
-- Name: backoffice_report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_report (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "arrestTime" timestamp with time zone NOT NULL,
    location text NOT NULL,
    name text NOT NULL,
    "arrestingOfficerId" text NOT NULL,
    "consentToContact" boolean NOT NULL,
    "concernMentalDistress" boolean NOT NULL,
    "concernPhysicalDistress" boolean NOT NULL,
    "concernMinor" boolean NOT NULL,
    "concernPoliceBehaviour" boolean NOT NULL,
    "concernPolicePrejudice" boolean NOT NULL,
    "concernMedicationNeed" boolean NOT NULL,
    "medicationName" text NOT NULL,
    "concernHandcuffs" boolean NOT NULL,
    observations text NOT NULL,
    comment text NOT NULL,
    "isHS2Action" boolean NOT NULL,
    station_id integer,
    witness_id integer NOT NULL
);


ALTER TABLE public.backoffice_report OWNER TO postgres;

--
-- Name: backoffice_report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_report_id_seq OWNER TO postgres;

--
-- Name: backoffice_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_report_id_seq OWNED BY public.backoffice_report.id;


--
-- Name: backoffice_station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_station (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    name text NOT NULL,
    verified boolean NOT NULL,
    rejected boolean NOT NULL,
    region_id integer
);


ALTER TABLE public.backoffice_station OWNER TO postgres;

--
-- Name: backoffice_station_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_station_id_seq OWNER TO postgres;

--
-- Name: backoffice_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_station_id_seq OWNED BY public.backoffice_station.id;


--
-- Name: backoffice_stationregion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_stationregion (
    id integer NOT NULL,
    deleted_at timestamp with time zone,
    name text NOT NULL
);


ALTER TABLE public.backoffice_stationregion OWNER TO postgres;

--
-- Name: backoffice_stationregion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_stationregion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_stationregion_id_seq OWNER TO postgres;

--
-- Name: backoffice_stationregion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_stationregion_id_seq OWNED BY public.backoffice_stationregion.id;


--
-- Name: backoffice_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_user (
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


ALTER TABLE public.backoffice_user OWNER TO postgres;

--
-- Name: backoffice_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.backoffice_user_groups OWNER TO postgres;

--
-- Name: backoffice_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_user_groups_id_seq OWNER TO postgres;

--
-- Name: backoffice_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_user_groups_id_seq OWNED BY public.backoffice_user_groups.id;


--
-- Name: backoffice_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_user_id_seq OWNER TO postgres;

--
-- Name: backoffice_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_user_id_seq OWNED BY public.backoffice_user.id;


--
-- Name: backoffice_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backoffice_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.backoffice_user_user_permissions OWNER TO postgres;

--
-- Name: backoffice_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backoffice_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backoffice_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: backoffice_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backoffice_user_user_permissions_id_seq OWNED BY public.backoffice_user_user_permissions.id;


--
-- Name: calllog; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.calllog (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    comment text,
    "isHidden" boolean,
    "createdBy" integer
);


ALTER TABLE public.calllog OWNER TO sails;

--
-- Name: calllog_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.calllog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calllog_id_seq OWNER TO sails;

--
-- Name: calllog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.calllog_id_seq OWNED BY public.calllog.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: knex_migrations; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.knex_migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.knex_migrations OWNER TO sails;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.knex_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knex_migrations_id_seq OWNER TO sails;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.knex_migrations_id_seq OWNED BY public.knex_migrations.id;


--
-- Name: knex_migrations_lock; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.knex_migrations_lock (
    is_locked integer
);


ALTER TABLE public.knex_migrations_lock OWNER TO sails;

--
-- Name: legalobserverlog; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.legalobserverlog (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    name text,
    phone text,
    "onShift" boolean,
    "isHidden" boolean,
    "createdBy" integer,
    location text,
    comment text
);


ALTER TABLE public.legalobserverlog OWNER TO sails;

--
-- Name: legalobserverlog_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.legalobserverlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.legalobserverlog_id_seq OWNER TO sails;

--
-- Name: legalobserverlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.legalobserverlog_id_seq OWNED BY public.legalobserverlog.id;


--
-- Name: release; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.release (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    name text,
    "arrestTime" timestamp with time zone,
    location text,
    offence text,
    "termsOfRelease" text,
    charges text,
    "bailConditions" text,
    "courtDate" text,
    "courtLocation" text,
    "policeStation" text,
    "localXRGroup" text,
    "nearestCity" text,
    injuries text,
    "adverseEvents" text,
    "heldMoreThan24Hours" boolean,
    "helpNeeded" text,
    "specialRequest" text,
    "numberRebels" real,
    "rebelsStillHeld" real,
    email text,
    phone text,
    comment text,
    "isHidden" boolean,
    "canShareWithLocalXRGroup" boolean,
    "canShareWithXRPress" boolean,
    "isHS2Action" boolean,
    "isPartOfXR" boolean
);


ALTER TABLE public.release OWNER TO sails;

--
-- Name: release_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.release_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.release_id_seq OWNER TO sails;

--
-- Name: release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.release_id_seq OWNED BY public.release.id;


--
-- Name: report; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.report (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    station text,
    "arrestTime" timestamp with time zone,
    location text,
    name text,
    "arrestingOfficerId" text,
    "concernMentalDistress" boolean,
    "concernPhysicalDistress" boolean,
    "concernMinor" boolean,
    "concernPoliceBehaviour" boolean,
    "concernPolicePrejudice" boolean,
    "concernMedicationNeed" boolean,
    "medicationName" text,
    observations text,
    comment text,
    "isHidden" boolean,
    witness integer,
    "concernHandcuffs" boolean,
    "isHS2Action" boolean
);


ALTER TABLE public.report OWNER TO sails;

--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_id_seq OWNER TO sails;

--
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.report_id_seq OWNED BY public.report.id;


--
-- Name: softdelete_changeset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.softdelete_changeset (
    id integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    object_id character varying(100) NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.softdelete_changeset OWNER TO postgres;

--
-- Name: softdelete_changeset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.softdelete_changeset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.softdelete_changeset_id_seq OWNER TO postgres;

--
-- Name: softdelete_changeset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.softdelete_changeset_id_seq OWNED BY public.softdelete_changeset.id;


--
-- Name: softdelete_softdeleterecord; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.softdelete_softdeleterecord (
    id integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    object_id character varying(100) NOT NULL,
    changeset_id integer NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.softdelete_softdeleterecord OWNER TO postgres;

--
-- Name: softdelete_softdeleterecord_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.softdelete_softdeleterecord_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.softdelete_softdeleterecord_id_seq OWNER TO postgres;

--
-- Name: softdelete_softdeleterecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.softdelete_softdeleterecord_id_seq OWNED BY public.softdelete_softdeleterecord.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public."user" (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    username text,
    password text,
    nickname text,
    expires timestamp with time zone,
    "isAdmin" boolean,
    "canViewRelease" boolean,
    "lastSeenAt" timestamp with time zone
);


ALTER TABLE public."user" OWNER TO sails;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO sails;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: witness; Type: TABLE; Schema: public; Owner: sails
--

CREATE TABLE public.witness (
    "createdAt" bigint,
    "updatedAt" bigint,
    id integer NOT NULL,
    "witnessEmail" text
);


ALTER TABLE public.witness OWNER TO sails;

--
-- Name: witness_id_seq; Type: SEQUENCE; Schema: public; Owner: sails
--

CREATE SEQUENCE public.witness_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.witness_id_seq OWNER TO sails;

--
-- Name: witness_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sails
--

ALTER SEQUENCE public.witness_id_seq OWNED BY public.witness.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: backoffice_calllog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_calllog ALTER COLUMN id SET DEFAULT nextval('public.backoffice_calllog_id_seq'::regclass);


--
-- Name: backoffice_identity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_identity ALTER COLUMN id SET DEFAULT nextval('public.backoffice_identity_id_seq'::regclass);


--
-- Name: backoffice_legalobserverlog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_legalobserverlog ALTER COLUMN id SET DEFAULT nextval('public.backoffice_legalobserverlog_id_seq'::regclass);


--
-- Name: backoffice_observation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_observation ALTER COLUMN id SET DEFAULT nextval('public.backoffice_observation_id_seq'::regclass);


--
-- Name: backoffice_pleahearing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_pleahearing ALTER COLUMN id SET DEFAULT nextval('public.backoffice_pleahearing_id_seq'::regclass);


--
-- Name: backoffice_release id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_release ALTER COLUMN id SET DEFAULT nextval('public.backoffice_release_id_seq'::regclass);


--
-- Name: backoffice_report id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_report ALTER COLUMN id SET DEFAULT nextval('public.backoffice_report_id_seq'::regclass);


--
-- Name: backoffice_station id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_station ALTER COLUMN id SET DEFAULT nextval('public.backoffice_station_id_seq'::regclass);


--
-- Name: backoffice_stationregion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_stationregion ALTER COLUMN id SET DEFAULT nextval('public.backoffice_stationregion_id_seq'::regclass);


--
-- Name: backoffice_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user ALTER COLUMN id SET DEFAULT nextval('public.backoffice_user_id_seq'::regclass);


--
-- Name: backoffice_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_groups ALTER COLUMN id SET DEFAULT nextval('public.backoffice_user_groups_id_seq'::regclass);


--
-- Name: backoffice_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.backoffice_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: knex_migrations id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.knex_migrations ALTER COLUMN id SET DEFAULT nextval('public.knex_migrations_id_seq'::regclass);


--
-- Name: legalobserverlog id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.legalobserverlog ALTER COLUMN id SET DEFAULT nextval('public.legalobserverlog_id_seq'::regclass);


--
-- Name: release id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.release ALTER COLUMN id SET DEFAULT nextval('public.release_id_seq'::regclass);


--
-- Name: report id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.report ALTER COLUMN id SET DEFAULT nextval('public.report_id_seq'::regclass);


--
-- Name: softdelete_changeset id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_changeset ALTER COLUMN id SET DEFAULT nextval('public.softdelete_changeset_id_seq'::regclass);


--
-- Name: softdelete_softdeleterecord id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_softdeleterecord ALTER COLUMN id SET DEFAULT nextval('public.softdelete_softdeleterecord_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: witness id; Type: DEFAULT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.witness ALTER COLUMN id SET DEFAULT nextval('public.witness_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	Release Editor
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add user	2	add_user
2	Can change user	2	change_user
3	Can delete user	2	delete_user
4	Can view user	2	view_user
5	Can add identity	3	add_identity
6	Can change identity	3	change_identity
7	Can delete identity	3	delete_identity
8	Can view identity	3	view_identity
9	Can undelete this object	3	can_undelete
10	Can add station region	4	add_stationregion
11	Can change station region	4	change_stationregion
12	Can delete station region	4	delete_stationregion
13	Can view station region	4	view_stationregion
14	Can undelete this object	4	can_undelete
15	Can add station	5	add_station
16	Can change station	5	change_station
17	Can delete station	5	delete_station
18	Can view station	5	view_station
19	Can undelete this object	5	can_undelete
20	Can add report	6	add_report
21	Can change report	6	change_report
22	Can delete report	6	delete_report
23	Can view report	6	view_report
24	Can undelete this object	6	can_undelete
25	Can add release	1	add_release
26	Can change release	1	change_release
27	Can delete release	1	delete_release
28	Can view release	1	view_release
29	Can undelete this object	1	can_undelete
30	Can add plea hearing	7	add_pleahearing
31	Can change plea hearing	7	change_pleahearing
32	Can delete plea hearing	7	delete_pleahearing
33	Can view plea hearing	7	view_pleahearing
34	Can undelete this object	7	can_undelete
35	Can add observation	8	add_observation
36	Can change observation	8	change_observation
37	Can delete observation	8	delete_observation
38	Can view observation	8	view_observation
39	Can undelete this object	8	can_undelete
40	Can add legal observer log	9	add_legalobserverlog
41	Can change legal observer log	9	change_legalobserverlog
42	Can delete legal observer log	9	delete_legalobserverlog
43	Can view legal observer log	9	view_legalobserverlog
44	Can undelete this object	9	can_undelete
45	Can add call log	10	add_calllog
46	Can change call log	10	change_calllog
47	Can delete call log	10	delete_calllog
48	Can view call log	10	view_calllog
49	Can undelete this object	10	can_undelete
50	Can add change set	11	add_changeset
51	Can change change set	11	change_changeset
52	Can delete change set	11	delete_changeset
53	Can view change set	11	view_changeset
54	Can add soft delete record	12	add_softdeleterecord
55	Can change soft delete record	12	change_softdeleterecord
56	Can delete soft delete record	12	delete_softdeleterecord
57	Can view soft delete record	12	view_softdeleterecord
58	Can add log entry	13	add_logentry
59	Can change log entry	13	change_logentry
60	Can delete log entry	13	delete_logentry
61	Can view log entry	13	view_logentry
62	Can add permission	14	add_permission
63	Can change permission	14	change_permission
64	Can delete permission	14	delete_permission
65	Can view permission	14	view_permission
66	Can add group	15	add_group
67	Can change group	15	change_group
68	Can delete group	15	delete_group
69	Can view group	15	view_group
70	Can add content type	16	add_contenttype
71	Can change content type	16	change_contenttype
72	Can delete content type	16	delete_contenttype
73	Can view content type	16	view_contenttype
74	Can add session	17	add_session
75	Can change session	17	change_session
76	Can delete session	17	delete_session
77	Can view session	17	view_session
\.


--
-- Data for Name: backoffice_calllog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_calllog (id, deleted_at, "createdAt", comment, "createdBy_id") FROM stdin;
\.


--
-- Data for Name: backoffice_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_identity (id, deleted_at) FROM stdin;
\.


--
-- Data for Name: backoffice_legalobserverlog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_legalobserverlog (id, deleted_at, "createdAt", comment, "createdBy_id", location, name, "onShift", phone) FROM stdin;
\.


--
-- Data for Name: backoffice_observation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_observation (id, deleted_at, "createdAt", court, date, bench, "defendantName", "defendantNumber", charges, representation, outline, "evidenceSubmitted", "evidenceInPerson", verdict, sentence, costs, notes, identity_id) FROM stdin;
\.


--
-- Data for Name: backoffice_pleahearing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_pleahearing (id, deleted_at, "createdAt", name, email, phone, hometown, charge, "lawFirm", "consentToContact", "canShareWithLocalXRGroup", "consentToRecord", "consentToPress", identity_id) FROM stdin;
\.


--
-- Data for Name: backoffice_release; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_release (id, deleted_at, "createdAt", name, "arrestTime", location, offence, "termsOfRelease", charges, "bailConditions", "courtDate", "courtLocation", "localXRGroup", "nearestCity", injuries, "adverseEvents", "heldMoreThan24Hours", "helpNeeded", "specialRequest", "numberRebels", "rebelsStillHeld", email, phone, "canShareWithLocalXRGroup", "canShareWithXRPress", comment, "isHS2Action", "isPartOfXR", identity_id, "policeStation_id") FROM stdin;
\.


--
-- Data for Name: backoffice_report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_report (id, deleted_at, "createdAt", "arrestTime", location, name, "arrestingOfficerId", "consentToContact", "concernMentalDistress", "concernPhysicalDistress", "concernMinor", "concernPoliceBehaviour", "concernPolicePrejudice", "concernMedicationNeed", "medicationName", "concernHandcuffs", observations, comment, "isHS2Action", station_id, witness_id) FROM stdin;
\.


--
-- Data for Name: backoffice_station; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_station (id, deleted_at, "createdAt", name, verified, rejected, region_id) FROM stdin;
1	\N	2021-05-31 23:05:33.839837+00	Patchway	t	f	1
2	\N	2021-05-31 23:05:33.839912+00	Keynsham	t	f	1
3	\N	2021-05-31 23:05:33.839941+00	Bridgewater	t	f	1
4	\N	2021-05-31 23:05:33.843575+00	Luton	t	f	2
5	\N	2021-05-31 23:05:33.84362+00	Kempston Police Station	t	f	2
6	\N	2021-05-31 23:05:33.844876+00	Huntingdon	t	f	3
7	\N	2021-05-31 23:05:33.844913+00	March	t	f	3
8	\N	2021-05-31 23:05:33.84494+00	Parkside	t	f	3
9	\N	2021-05-31 23:05:33.844966+00	Thorpewood	t	f	3
10	\N	2021-05-31 23:05:33.84625+00	Runcorn	t	f	4
11	\N	2021-05-31 23:05:33.84629+00	Middlewich	t	f	4
12	\N	2021-05-31 23:05:33.846317+00	Blacon	t	f	4
13	\N	2021-05-31 23:05:33.847467+00	Middlehaven	t	f	5
14	\N	2021-05-31 23:05:33.847503+00	Kirkleatham (reserve)	t	f	5
15	\N	2021-05-31 23:05:33.848687+00	Barrow	t	f	6
16	\N	2021-05-31 23:05:33.848724+00	Durranhill	t	f	6
17	\N	2021-05-31 23:05:33.848751+00	Workington	t	f	6
18	\N	2021-05-31 23:05:33.848777+00	Kendal	t	f	6
19	\N	2021-05-31 23:05:33.850022+00	Buxton	t	f	7
20	\N	2021-05-31 23:05:33.85006+00	Chesterfield	t	f	7
21	\N	2021-05-31 23:05:33.850087+00	Derby	t	f	7
22	\N	2021-05-31 23:05:33.850112+00	Ripley	t	f	7
23	\N	2021-05-31 23:05:33.85147+00	Exeter	t	f	8
24	\N	2021-05-31 23:05:33.851506+00	Plymouth	t	f	8
25	\N	2021-05-31 23:05:33.851532+00	Barnstaple	t	f	8
26	\N	2021-05-31 23:05:33.851558+00	Torquay	t	f	8
27	\N	2021-05-31 23:05:33.851584+00	Newquay	t	f	8
28	\N	2021-05-31 23:05:33.851609+00	Camborne	t	f	8
29	\N	2021-05-31 23:05:33.853031+00	Weymouth	t	f	9
30	\N	2021-05-31 23:05:33.853067+00	Poole	t	f	9
31	\N	2021-05-31 23:05:33.853094+00	Bournemouth	t	f	9
32	\N	2021-05-31 23:05:33.854418+00	Durham	t	f	10
33	\N	2021-05-31 23:05:33.854453+00	Darlington	t	f	10
34	\N	2021-05-31 23:05:33.85448+00	Bishop	t	f	10
35	\N	2021-05-31 23:05:33.854506+00	Peterlee	t	f	10
36	\N	2021-05-31 23:05:33.854531+00	Consett	t	f	10
37	\N	2021-05-31 23:05:33.854557+00	Spennymoor	t	f	10
38	\N	2021-05-31 23:05:33.856122+00	Southend	t	f	11
39	\N	2021-05-31 23:05:33.856162+00	Colchester	t	f	11
40	\N	2021-05-31 23:05:33.856191+00	Harlow	t	f	11
41	\N	2021-05-31 23:05:33.856219+00	Basildon	t	f	11
42	\N	2021-05-31 23:05:33.856247+00	Grays	t	f	11
43	\N	2021-05-31 23:05:33.856275+00	Clacton	t	f	11
44	\N	2021-05-31 23:05:33.856302+00	Chelmsford	t	f	11
45	\N	2021-05-31 23:05:33.857771+00	Gloucestershire	t	f	12
46	\N	2021-05-31 23:05:33.859144+00	North Manchester	t	f	13
47	\N	2021-05-31 23:05:33.859183+00	Longsight	t	f	13
48	\N	2021-05-31 23:05:33.859212+00	Swinton	t	f	13
49	\N	2021-05-31 23:05:33.85924+00	Ashton	t	f	13
50	\N	2021-05-31 23:05:33.859268+00	Cheadle Heath	t	f	13
51	\N	2021-05-31 23:05:33.859295+00	Bolton	t	f	13
52	\N	2021-05-31 23:05:33.859322+00	Wigan	t	f	13
53	\N	2021-05-31 23:05:33.859349+00	Pendleton	t	f	13
54	\N	2021-05-31 23:05:33.859377+00	Bury	t	f	13
55	\N	2021-05-31 23:05:33.859404+00	Chadderton	t	f	13
56	\N	2021-05-31 23:05:33.861112+00	Basingstoke	t	f	14
57	\N	2021-05-31 23:05:33.861152+00	Portsmouth	t	f	14
58	\N	2021-05-31 23:05:33.861182+00	Southampton	t	f	14
59	\N	2021-05-31 23:05:33.86121+00	Newport	t	f	14
60	\N	2021-05-31 23:05:33.863143+00	Hatfield	t	f	15
61	\N	2021-05-31 23:05:33.863206+00	Stevenage	t	f	15
62	\N	2021-05-31 23:05:33.86514+00	Clough Road	t	f	16
63	\N	2021-05-31 23:05:33.865205+00	Southbank (Birchin way)	t	f	16
64	\N	2021-05-31 23:05:33.865253+00	Grimsby	t	f	16
65	\N	2021-05-31 23:05:33.865298+00	Priory Road	t	f	16
66	\N	2021-05-31 23:05:33.867586+00	Medway	t	f	17
67	\N	2021-05-31 23:05:33.86765+00	Northfleet (North Kent)	t	f	17
68	\N	2021-05-31 23:05:33.867699+00	Canterbury	t	f	17
69	\N	2021-05-31 23:05:33.867744+00	Folkestone	t	f	17
70	\N	2021-05-31 23:05:33.867788+00	Maidstone	t	f	17
71	\N	2021-05-31 23:05:33.867832+00	Margate	t	f	17
72	\N	2021-05-31 23:05:33.867929+00	Tonbridge	t	f	17
73	\N	2021-05-31 23:05:33.870334+00	Blackburn	t	f	18
74	\N	2021-05-31 23:05:33.8704+00	Blackpoool	t	f	18
75	\N	2021-05-31 23:05:33.870447+00	Burnley	t	f	18
76	\N	2021-05-31 23:05:33.870492+00	Lancaster	t	f	18
77	\N	2021-05-31 23:05:33.870536+00	Preston	t	f	18
78	\N	2021-05-31 23:05:33.872307+00	Beaumont Lays	t	f	19
79	\N	2021-05-31 23:05:33.872353+00	Euston Street	t	f	19
80	\N	2021-05-31 23:05:33.872387+00	Keyham	t	f	19
81	\N	2021-05-31 23:05:33.874043+00	Lincoln	t	f	20
82	\N	2021-05-31 23:05:33.874091+00	Grantham	t	f	20
83	\N	2021-05-31 23:05:33.874126+00	Boston	t	f	20
84	\N	2021-05-31 23:05:33.874158+00	Skegness	t	f	20
85	\N	2021-05-31 23:05:33.875891+00	Wirral	t	f	21
86	\N	2021-05-31 23:05:33.875941+00	St Annes St	t	f	21
87	\N	2021-05-31 23:05:33.875975+00	Copy Lane	t	f	21
88	\N	2021-05-31 23:05:33.876008+00	Belle Valle	t	f	21
89	\N	2021-05-31 23:05:33.876039+00	Wavertree Road	t	f	21
90	\N	2021-05-31 23:05:33.878608+00	Acton	t	f	22
91	\N	2021-05-31 23:05:33.878655+00	Dagenham and Barking	t	f	22
92	\N	2021-05-31 23:05:33.878689+00	Bethnal Green	t	f	22
93	\N	2021-05-31 23:05:33.87872+00	Brixton	t	f	22
94	\N	2021-05-31 23:05:33.87875+00	Bromley	t	f	22
95	\N	2021-05-31 23:05:33.878781+00	Charing Cross	t	f	22
96	\N	2021-05-31 23:05:33.878811+00	Colindale	t	f	22
97	\N	2021-05-31 23:05:33.878841+00	Croydon	t	f	22
98	\N	2021-05-31 23:05:33.878871+00	Forest Gate	t	f	22
99	\N	2021-05-31 23:05:33.878902+00	Heathrow	t	f	22
100	\N	2021-05-31 23:05:33.878932+00	Holborn	t	f	22
101	\N	2021-05-31 23:05:33.878963+00	Hounslow	t	f	22
102	\N	2021-05-31 23:05:33.878994+00	Ilford	t	f	22
103	\N	2021-05-31 23:05:33.879024+00	Islington	t	f	22
104	\N	2021-05-31 23:05:33.879053+00	Kingston	t	f	22
105	\N	2021-05-31 23:05:33.879083+00	Lewisham	t	f	22
106	\N	2021-05-31 23:05:33.879113+00	Leyton	t	f	22
107	\N	2021-05-31 23:05:33.879144+00	Romford	t	f	22
108	\N	2021-05-31 23:05:33.879173+00	Stoke Newington	t	f	22
109	\N	2021-05-31 23:05:33.879203+00	Walworth	t	f	22
110	\N	2021-05-31 23:05:33.879233+00	Wandsworth	t	f	22
111	\N	2021-05-31 23:05:33.879263+00	Wembley	t	f	22
112	\N	2021-05-31 23:05:33.879293+00	Woodgreen	t	f	22
113	\N	2021-05-31 23:05:33.879323+00	Belgravia	t	f	22
114	\N	2021-05-31 23:05:33.879352+00	Edmonton	t	f	22
115	\N	2021-05-31 23:05:33.879382+00	Harrow	t	f	22
116	\N	2021-05-31 23:05:33.879412+00	Peckham	t	f	22
117	\N	2021-05-31 23:05:33.879442+00	West End Central	t	f	22
118	\N	2021-05-31 23:05:33.879472+00	Plumstead	t	f	22
119	\N	2021-05-31 23:05:33.879501+00	Sutton	t	f	22
120	\N	2021-05-31 23:05:33.882539+00	Brewery Road	t	f	23
121	\N	2021-05-31 23:05:33.8841+00	Bishopsgate	t	f	24
122	\N	2021-05-31 23:05:33.885777+00	Aylsham	t	f	25
123	\N	2021-05-31 23:05:33.885825+00	Great Yarmouth	t	f	25
124	\N	2021-05-31 23:05:33.885868+00	King's Lynn	t	f	25
125	\N	2021-05-31 23:05:33.8859+00	Wymondham	t	f	25
126	\N	2021-05-31 23:05:33.885931+00	Bury	t	f	25
127	\N	2021-05-31 23:05:33.885961+00	Ipswich	t	f	25
128	\N	2021-05-31 23:05:33.887671+00	Harrogate	t	f	26
129	\N	2021-05-31 23:05:33.887713+00	Scarborough	t	f	26
130	\N	2021-05-31 23:05:33.887744+00	York	t	f	26
131	\N	2021-05-31 23:05:33.889899+00	Criminal Justice Centre	t	f	27
132	\N	2021-05-31 23:05:33.889967+00	Weekley Woods	t	f	27
133	\N	2021-05-31 23:05:33.892131+00	New Castle City Centre	t	f	28
134	\N	2021-05-31 23:05:33.892195+00	Middle Engine	t	f	28
135	\N	2021-05-31 23:05:33.892242+00	Southwick	t	f	28
136	\N	2021-05-31 23:05:33.892287+00	Berwick	t	f	28
137	\N	2021-05-31 23:05:33.892331+00	Bedlington	t	f	28
138	\N	2021-05-31 23:05:33.892375+00	Etal Lane	t	f	28
139	\N	2021-05-31 23:05:33.892418+00	South Shields	t	f	28
140	\N	2021-05-31 23:05:33.894642+00	Nottingham Bridewell	t	f	29
141	\N	2021-05-31 23:05:33.894704+00	Mansfield	t	f	29
142	\N	2021-05-31 23:05:33.894752+00	Newark	t	f	29
143	\N	2021-05-31 23:05:33.896648+00	Doncaster Custody Suite	t	f	30
144	\N	2021-05-31 23:05:33.896703+00	Shepcote Lane Custody Suite	t	f	30
145	\N	2021-05-31 23:05:33.896745+00	Barnsley Custody Suite	t	f	30
146	\N	2021-05-31 23:05:33.898494+00	NACF	t	f	31
147	\N	2021-05-31 23:05:33.898549+00	Watling Custody Facility	t	f	31
148	\N	2021-05-31 23:05:33.898591+00	Burton	t	f	31
149	\N	2021-05-31 23:05:33.900482+00	Guildford	t	f	32
150	\N	2021-05-31 23:05:33.90054+00	Salford	t	f	32
151	\N	2021-05-31 23:05:33.900582+00	Staines	t	f	32
152	\N	2021-05-31 23:05:33.900623+00	Woking	t	f	32
153	\N	2021-05-31 23:05:33.902567+00	Crawley Police Station	t	f	33
154	\N	2021-05-31 23:05:33.902623+00	Hastings Police Station	t	f	33
155	\N	2021-05-31 23:05:33.902665+00	Brighton Custody Suite	t	f	33
156	\N	2021-05-31 23:05:33.902706+00	Eastbourne Custody Suite	t	f	33
157	\N	2021-05-31 23:05:33.902745+00	Chichester Custody Suite	t	f	33
158	\N	2021-05-31 23:05:33.902785+00	Worthington Custody Suite	t	f	33
159	\N	2021-05-31 23:05:33.904954+00	Abingdon	t	f	34
160	\N	2021-05-31 23:05:33.90501+00	Aylesbury	t	f	34
161	\N	2021-05-31 23:05:33.905053+00	Banbury	t	f	34
162	\N	2021-05-31 23:05:33.905093+00	High Wycombe	t	f	34
163	\N	2021-05-31 23:05:33.905133+00	Loddon Valley	t	f	34
164	\N	2021-05-31 23:05:33.905172+00	Maidenhead	t	f	34
165	\N	2021-05-31 23:05:33.90521+00	Milton Keynes	t	f	34
166	\N	2021-05-31 23:05:33.905249+00	Newbury	t	f	34
167	\N	2021-05-31 23:05:33.907417+00	Nuneaton	t	f	35
168	\N	2021-05-31 23:05:33.907473+00	Leamington	t	f	35
169	\N	2021-05-31 23:05:33.907515+00	Rugby	t	f	35
170	\N	2021-05-31 23:05:33.909169+00	Hereford	t	f	36
171	\N	2021-05-31 23:05:33.909209+00	Kidderminster	t	f	36
172	\N	2021-05-31 23:05:33.909239+00	Shrewsbury	t	f	36
173	\N	2021-05-31 23:05:33.909268+00	Telford	t	f	36
174	\N	2021-05-31 23:05:33.909296+00	Worcestor	t	f	36
175	\N	2021-05-31 23:05:33.910922+00	Bloxwich	t	f	37
176	\N	2021-05-31 23:05:33.910961+00	Central Custody	t	f	37
177	\N	2021-05-31 23:05:33.910991+00	Coventry Central	t	f	37
178	\N	2021-05-31 23:05:33.911019+00	Stechford	t	f	37
179	\N	2021-05-31 23:05:33.911046+00	Western Custody	t	f	37
180	\N	2021-05-31 23:05:33.911074+00	Wolverhampton Central	t	f	37
181	\N	2021-05-31 23:05:33.912801+00	Trafalgar House	t	f	38
182	\N	2021-05-31 23:05:33.91284+00	Halifax	t	f	38
183	\N	2021-05-31 23:05:33.91287+00	Dewsbury	t	f	38
184	\N	2021-05-31 23:05:33.912897+00	Huddersfield	t	f	38
185	\N	2021-05-31 23:05:33.912925+00	Elland Road	t	f	38
186	\N	2021-05-31 23:05:33.912953+00	Stainbeck	t	f	38
187	\N	2021-05-31 23:05:33.914561+00	Havertop	t	f	39
188	\N	2021-05-31 23:05:33.914602+00	Melksham	t	f	39
189	\N	2021-05-31 23:05:33.914632+00	Swindon	t	f	39
190	\N	2021-05-31 23:05:33.916228+00	Aberystwyth	t	f	40
191	\N	2021-05-31 23:05:33.916269+00	Ammanford	t	f	40
192	\N	2021-05-31 23:05:33.9163+00	Brecon	t	f	40
193	\N	2021-05-31 23:05:33.916329+00	Cardigan	t	f	40
194	\N	2021-05-31 23:05:33.916357+00	Haverfordwest	t	f	40
195	\N	2021-05-31 23:05:33.916385+00	Llanelli	t	f	40
196	\N	2021-05-31 23:05:33.916413+00	Newtown	t	f	40
197	\N	2021-05-31 23:05:33.91812+00	Newport	t	f	41
198	\N	2021-05-31 23:05:33.918162+00	Ystrad Mynach	t	f	41
199	\N	2021-05-31 23:05:33.919598+00	Llay	t	f	42
200	\N	2021-05-31 23:05:33.919638+00	Caernarfon	t	f	42
201	\N	2021-05-31 23:05:33.919669+00	St Asaph	t	f	42
202	\N	2021-05-31 23:05:33.919697+00	Mold	t	f	42
203	\N	2021-05-31 23:05:33.919725+00	Dolgellau	t	f	42
204	\N	2021-05-31 23:05:33.921396+00	Cardiff	t	f	43
205	\N	2021-05-31 23:05:33.921438+00	Swansea	t	f	43
206	\N	2021-05-31 23:05:33.92147+00	Merthyr Bridewell	t	f	43
207	\N	2021-05-31 23:05:33.921499+00	Bridgend Bridewell	t	f	43
\.


--
-- Data for Name: backoffice_stationregion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_stationregion (id, deleted_at, name) FROM stdin;
1	\N	Avon & Somerset
2	\N	Bedfordshire
3	\N	Cambridgeshire
4	\N	Cheshire
5	\N	Cleveland
6	\N	Cumbria
7	\N	Derbyshire
8	\N	Devon & Cornwall
9	\N	Dorset
10	\N	Durham
11	\N	Essex
12	\N	Gloucestershire
13	\N	Greater Manchester
14	\N	Hampshire
15	\N	Hertfordshire
16	\N	Humberside
17	\N	Kent
18	\N	Lancashire
19	\N	Leicestershire
20	\N	Lincolnshire
21	\N	Merseyside
22	\N	Metropolitan Police
23	\N	British Transport Police
24	\N	City of London
25	\N	Norfolk / Suffolk
26	\N	North Yorkshire
27	\N	Northamptonshire
28	\N	Northumbria
29	\N	Nottinghamshire
30	\N	South Yorkshire
31	\N	Staffordshire
32	\N	Surrey
33	\N	Sussex
34	\N	Thames Valley
35	\N	Warwickshire
36	\N	West Mercia
37	\N	West Midlands
38	\N	West Yorkshire
39	\N	Wiltshire
40	\N	Dyfed-Powys
41	\N	Gwent
42	\N	North Wales
43	\N	South Wales
\.


--
-- Data for Name: backoffice_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: backoffice_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: backoffice_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backoffice_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: calllog; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.calllog ("createdAt", "updatedAt", id, comment, "isHidden", "createdBy") FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	backoffice	release
2	backoffice	user
3	backoffice	identity
4	backoffice	stationregion
5	backoffice	station
6	backoffice	report
7	backoffice	pleahearing
8	backoffice	observation
9	backoffice	legalobserverlog
10	backoffice	calllog
11	softdelete	changeset
12	softdelete	softdeleterecord
13	admin	logentry
14	auth	permission
15	auth	group
16	contenttypes	contenttype
17	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-05-31 23:05:33.364136+00
2	contenttypes	0002_remove_content_type_name	2021-05-31 23:05:33.377271+00
3	auth	0001_initial	2021-05-31 23:05:33.408004+00
4	auth	0002_alter_permission_name_max_length	2021-05-31 23:05:33.436331+00
5	auth	0003_alter_user_email_max_length	2021-05-31 23:05:33.444753+00
6	auth	0004_alter_user_username_opts	2021-05-31 23:05:33.452692+00
7	auth	0005_alter_user_last_login_null	2021-05-31 23:05:33.460419+00
8	auth	0006_require_contenttypes_0002	2021-05-31 23:05:33.463308+00
9	auth	0007_alter_validators_add_error_messages	2021-05-31 23:05:33.470468+00
10	auth	0008_alter_user_username_max_length	2021-05-31 23:05:33.479953+00
11	auth	0009_alter_user_last_name_max_length	2021-05-31 23:05:33.518363+00
12	auth	0010_alter_group_name_max_length	2021-05-31 23:05:33.526188+00
13	auth	0011_update_proxy_permissions	2021-05-31 23:05:33.534003+00
14	auth	0012_alter_user_first_name_max_length	2021-05-31 23:05:33.542062+00
15	backoffice	0001_initial	2021-05-31 23:05:33.69053+00
16	admin	0001_initial	2021-05-31 23:05:33.791166+00
17	admin	0002_logentry_remove_auto_add	2021-05-31 23:05:33.811726+00
18	admin	0003_logentry_add_action_flag_choices	2021-05-31 23:05:33.822306+00
19	backoffice	0002_station_list	2021-05-31 23:05:33.923366+00
20	backoffice	0003_create_release_group	2021-05-31 23:05:33.962144+00
21	backoffice	0004_auto_20210201_0005	2021-05-31 23:05:34.002504+00
22	sessions	0001_initial	2021-05-31 23:05:34.012051+00
23	softdelete	0001_initial	2021-05-31 23:05:34.065349+00
24	softdelete	0002_auto_20170912_0537	2021-05-31 23:05:34.100082+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: knex_migrations; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.knex_migrations (id, name, batch, migration_time) FROM stdin;
1	20191008122715_add_legal_observer_log_location_comment.js	1	2019-10-08 11:44:32.018+00
2	20191012091046_add_xr_press_column.js	2	2019-10-12 08:39:20.595+00
4	20191013095701_user_columns_as_timestamp.js	3	2019-10-17 21:12:18.053+00
5	20191017211134_report_columns_as_timestamp.js	3	2019-10-17 21:12:18.173+00
6	20200826223323_add_handcuffs_column.js	4	2020-08-26 21:44:36.129+00
\.


--
-- Data for Name: knex_migrations_lock; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.knex_migrations_lock (is_locked) FROM stdin;
0
\.


--
-- Data for Name: legalobserverlog; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.legalobserverlog ("createdAt", "updatedAt", id, name, phone, "onShift", "isHidden", "createdBy", location, comment) FROM stdin;
\.


--
-- Data for Name: release; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.release ("createdAt", "updatedAt", id, name, "arrestTime", location, offence, "termsOfRelease", charges, "bailConditions", "courtDate", "courtLocation", "policeStation", "localXRGroup", "nearestCity", injuries, "adverseEvents", "heldMoreThan24Hours", "helpNeeded", "specialRequest", "numberRebels", "rebelsStillHeld", email, phone, comment, "isHidden", "canShareWithLocalXRGroup", "canShareWithXRPress", "isHS2Action", "isPartOfXR") FROM stdin;
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.report ("createdAt", "updatedAt", id, station, "arrestTime", location, name, "arrestingOfficerId", "concernMentalDistress", "concernPhysicalDistress", "concernMinor", "concernPoliceBehaviour", "concernPolicePrejudice", "concernMedicationNeed", "medicationName", observations, comment, "isHidden", witness, "concernHandcuffs", "isHS2Action") FROM stdin;
\.


--
-- Data for Name: softdelete_changeset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.softdelete_changeset (id, created_date, object_id, content_type_id) FROM stdin;
\.


--
-- Data for Name: softdelete_softdeleterecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.softdelete_softdeleterecord (id, created_date, object_id, changeset_id, content_type_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public."user" ("createdAt", "updatedAt", id, username, password, nickname, expires, "isAdmin", "canViewRelease", "lastSeenAt") FROM stdin;
1622499203432	1622499203432	1	rebel	$2a$10$paGaj8.0sdnWWmCO.OchXOaccKRpjHvfjWeMpxKnjiuIargFWU5he	Rebel	\N	t	t	\N
\.


--
-- Data for Name: witness; Type: TABLE DATA; Schema: public; Owner: sails
--

COPY public.witness ("createdAt", "updatedAt", id, "witnessEmail") FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 77, true);


--
-- Name: backoffice_calllog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_calllog_id_seq', 1, false);


--
-- Name: backoffice_identity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_identity_id_seq', 1, false);


--
-- Name: backoffice_legalobserverlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_legalobserverlog_id_seq', 1, false);


--
-- Name: backoffice_observation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_observation_id_seq', 1, false);


--
-- Name: backoffice_pleahearing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_pleahearing_id_seq', 1, false);


--
-- Name: backoffice_release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_release_id_seq', 1, false);


--
-- Name: backoffice_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_report_id_seq', 1, false);


--
-- Name: backoffice_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_station_id_seq', 207, true);


--
-- Name: backoffice_stationregion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_stationregion_id_seq', 43, true);


--
-- Name: backoffice_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_user_groups_id_seq', 1, false);


--
-- Name: backoffice_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_user_id_seq', 1, false);


--
-- Name: backoffice_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backoffice_user_user_permissions_id_seq', 1, false);


--
-- Name: calllog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.calllog_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- Name: knex_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.knex_migrations_id_seq', 6, true);


--
-- Name: legalobserverlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.legalobserverlog_id_seq', 1, false);


--
-- Name: release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.release_id_seq', 1, false);


--
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.report_id_seq', 1, false);


--
-- Name: softdelete_changeset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.softdelete_changeset_id_seq', 1, false);


--
-- Name: softdelete_softdeleterecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.softdelete_softdeleterecord_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: witness_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sails
--

SELECT pg_catalog.setval('public.witness_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: backoffice_calllog backoffice_calllog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_calllog
    ADD CONSTRAINT backoffice_calllog_pkey PRIMARY KEY (id);


--
-- Name: backoffice_identity backoffice_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_identity
    ADD CONSTRAINT backoffice_identity_pkey PRIMARY KEY (id);


--
-- Name: backoffice_legalobserverlog backoffice_legalobserverlog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_legalobserverlog
    ADD CONSTRAINT backoffice_legalobserverlog_pkey PRIMARY KEY (id);


--
-- Name: backoffice_observation backoffice_observation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_observation
    ADD CONSTRAINT backoffice_observation_pkey PRIMARY KEY (id);


--
-- Name: backoffice_pleahearing backoffice_pleahearing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_pleahearing
    ADD CONSTRAINT backoffice_pleahearing_pkey PRIMARY KEY (id);


--
-- Name: backoffice_release backoffice_release_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_release
    ADD CONSTRAINT backoffice_release_pkey PRIMARY KEY (id);


--
-- Name: backoffice_report backoffice_report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_report
    ADD CONSTRAINT backoffice_report_pkey PRIMARY KEY (id);


--
-- Name: backoffice_station backoffice_station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_station
    ADD CONSTRAINT backoffice_station_pkey PRIMARY KEY (id);


--
-- Name: backoffice_stationregion backoffice_stationregion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_stationregion
    ADD CONSTRAINT backoffice_stationregion_pkey PRIMARY KEY (id);


--
-- Name: backoffice_user_groups backoffice_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_groups
    ADD CONSTRAINT backoffice_user_groups_pkey PRIMARY KEY (id);


--
-- Name: backoffice_user_groups backoffice_user_groups_user_id_group_id_cea656de_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_groups
    ADD CONSTRAINT backoffice_user_groups_user_id_group_id_cea656de_uniq UNIQUE (user_id, group_id);


--
-- Name: backoffice_user backoffice_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user
    ADD CONSTRAINT backoffice_user_pkey PRIMARY KEY (id);


--
-- Name: backoffice_user_user_permissions backoffice_user_user_per_user_id_permission_id_ef9d3d21_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_user_permissions
    ADD CONSTRAINT backoffice_user_user_per_user_id_permission_id_ef9d3d21_uniq UNIQUE (user_id, permission_id);


--
-- Name: backoffice_user_user_permissions backoffice_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_user_permissions
    ADD CONSTRAINT backoffice_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: backoffice_user backoffice_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user
    ADD CONSTRAINT backoffice_user_username_key UNIQUE (username);


--
-- Name: calllog calllog_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.calllog
    ADD CONSTRAINT calllog_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: knex_migrations knex_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.knex_migrations
    ADD CONSTRAINT knex_migrations_pkey PRIMARY KEY (id);


--
-- Name: legalobserverlog legalobserverlog_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.legalobserverlog
    ADD CONSTRAINT legalobserverlog_pkey PRIMARY KEY (id);


--
-- Name: release release_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.release
    ADD CONSTRAINT release_pkey PRIMARY KEY (id);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- Name: softdelete_changeset softdelete_changeset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_changeset
    ADD CONSTRAINT softdelete_changeset_pkey PRIMARY KEY (id);


--
-- Name: softdelete_softdeleterecord softdelete_softdeleterec_changeset_id_content_typ_3c233c43_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_softdeleterecord
    ADD CONSTRAINT softdelete_softdeleterec_changeset_id_content_typ_3c233c43_uniq UNIQUE (changeset_id, content_type_id, object_id);


--
-- Name: softdelete_softdeleterecord softdelete_softdeleterecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_softdeleterecord
    ADD CONSTRAINT softdelete_softdeleterecord_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: witness witness_pkey; Type: CONSTRAINT; Schema: public; Owner: sails
--

ALTER TABLE ONLY public.witness
    ADD CONSTRAINT witness_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: backoffice_calllog_createdBy_id_141f9a29; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backoffice_calllog_createdBy_id_141f9a29" ON public.backoffice_calllog USING btree ("createdBy_id");


--
-- Name: backoffice_calllog_deleted_at_90ab8f48; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_calllog_deleted_at_90ab8f48 ON public.backoffice_calllog USING btree (deleted_at);


--
-- Name: backoffice_identity_deleted_at_417dc94c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_identity_deleted_at_417dc94c ON public.backoffice_identity USING btree (deleted_at);


--
-- Name: backoffice_legalobserverlog_createdBy_id_81828d3c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backoffice_legalobserverlog_createdBy_id_81828d3c" ON public.backoffice_legalobserverlog USING btree ("createdBy_id");


--
-- Name: backoffice_legalobserverlog_deleted_at_2990e1d8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_legalobserverlog_deleted_at_2990e1d8 ON public.backoffice_legalobserverlog USING btree (deleted_at);


--
-- Name: backoffice_observation_deleted_at_16e95344; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_observation_deleted_at_16e95344 ON public.backoffice_observation USING btree (deleted_at);


--
-- Name: backoffice_observation_identity_id_49e6b2a0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_observation_identity_id_49e6b2a0 ON public.backoffice_observation USING btree (identity_id);


--
-- Name: backoffice_pleahearing_deleted_at_bb8a0e26; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_pleahearing_deleted_at_bb8a0e26 ON public.backoffice_pleahearing USING btree (deleted_at);


--
-- Name: backoffice_pleahearing_identity_id_37c8f784; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_pleahearing_identity_id_37c8f784 ON public.backoffice_pleahearing USING btree (identity_id);


--
-- Name: backoffice_release_deleted_at_243be866; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_release_deleted_at_243be866 ON public.backoffice_release USING btree (deleted_at);


--
-- Name: backoffice_release_identity_id_85d6ef26; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_release_identity_id_85d6ef26 ON public.backoffice_release USING btree (identity_id);


--
-- Name: backoffice_release_policeStation_id_57b269c2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backoffice_release_policeStation_id_57b269c2" ON public.backoffice_release USING btree ("policeStation_id");


--
-- Name: backoffice_report_deleted_at_95ff259e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_report_deleted_at_95ff259e ON public.backoffice_report USING btree (deleted_at);


--
-- Name: backoffice_report_station_id_8b5faa0c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_report_station_id_8b5faa0c ON public.backoffice_report USING btree (station_id);


--
-- Name: backoffice_report_witness_id_1e1d9efc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_report_witness_id_1e1d9efc ON public.backoffice_report USING btree (witness_id);


--
-- Name: backoffice_station_deleted_at_3cc03f0b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_station_deleted_at_3cc03f0b ON public.backoffice_station USING btree (deleted_at);


--
-- Name: backoffice_station_region_id_0a26ad42; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_station_region_id_0a26ad42 ON public.backoffice_station USING btree (region_id);


--
-- Name: backoffice_stationregion_deleted_at_e2ac60a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_stationregion_deleted_at_e2ac60a5 ON public.backoffice_stationregion USING btree (deleted_at);


--
-- Name: backoffice_user_groups_group_id_76fb6381; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_user_groups_group_id_76fb6381 ON public.backoffice_user_groups USING btree (group_id);


--
-- Name: backoffice_user_groups_user_id_11757979; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_user_groups_user_id_11757979 ON public.backoffice_user_groups USING btree (user_id);


--
-- Name: backoffice_user_user_permissions_permission_id_625e2e76; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_user_user_permissions_permission_id_625e2e76 ON public.backoffice_user_user_permissions USING btree (permission_id);


--
-- Name: backoffice_user_user_permissions_user_id_a65b42c2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_user_user_permissions_user_id_a65b42c2 ON public.backoffice_user_user_permissions USING btree (user_id);


--
-- Name: backoffice_user_username_c60c10ce_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backoffice_user_username_c60c10ce_like ON public.backoffice_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: softdelete_changeset_content_type_id_121bb923; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softdelete_changeset_content_type_id_121bb923 ON public.softdelete_changeset USING btree (content_type_id);


--
-- Name: softdelete_changeset_content_type_id_object_id_9cc85984_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softdelete_changeset_content_type_id_object_id_9cc85984_idx ON public.softdelete_changeset USING btree (content_type_id, object_id);


--
-- Name: softdelete_softdeleterec_content_type_id_object_i_4de3f07d_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softdelete_softdeleterec_content_type_id_object_i_4de3f07d_idx ON public.softdelete_softdeleterecord USING btree (content_type_id, object_id);


--
-- Name: softdelete_softdeleterecord_changeset_id_077905cb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softdelete_softdeleterecord_changeset_id_077905cb ON public.softdelete_softdeleterecord USING btree (changeset_id);


--
-- Name: softdelete_softdeleterecord_content_type_id_58770c81; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softdelete_softdeleterecord_content_type_id_58770c81 ON public.softdelete_softdeleterecord USING btree (content_type_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_calllog backoffice_calllog_createdBy_id_141f9a29_fk_backoffice_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_calllog
    ADD CONSTRAINT "backoffice_calllog_createdBy_id_141f9a29_fk_backoffice_user_id" FOREIGN KEY ("createdBy_id") REFERENCES public.backoffice_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_legalobserverlog backoffice_legalobse_createdBy_id_81828d3c_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_legalobserverlog
    ADD CONSTRAINT "backoffice_legalobse_createdBy_id_81828d3c_fk_backoffic" FOREIGN KEY ("createdBy_id") REFERENCES public.backoffice_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_observation backoffice_observati_identity_id_49e6b2a0_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_observation
    ADD CONSTRAINT backoffice_observati_identity_id_49e6b2a0_fk_backoffic FOREIGN KEY (identity_id) REFERENCES public.backoffice_identity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_pleahearing backoffice_pleaheari_identity_id_37c8f784_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_pleahearing
    ADD CONSTRAINT backoffice_pleaheari_identity_id_37c8f784_fk_backoffic FOREIGN KEY (identity_id) REFERENCES public.backoffice_identity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_release backoffice_release_identity_id_85d6ef26_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_release
    ADD CONSTRAINT backoffice_release_identity_id_85d6ef26_fk_backoffic FOREIGN KEY (identity_id) REFERENCES public.backoffice_identity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_release backoffice_release_policeStation_id_57b269c2_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_release
    ADD CONSTRAINT "backoffice_release_policeStation_id_57b269c2_fk_backoffic" FOREIGN KEY ("policeStation_id") REFERENCES public.backoffice_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_report backoffice_report_station_id_8b5faa0c_fk_backoffice_station_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_report
    ADD CONSTRAINT backoffice_report_station_id_8b5faa0c_fk_backoffice_station_id FOREIGN KEY (station_id) REFERENCES public.backoffice_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_report backoffice_report_witness_id_1e1d9efc_fk_backoffice_identity_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_report
    ADD CONSTRAINT backoffice_report_witness_id_1e1d9efc_fk_backoffice_identity_id FOREIGN KEY (witness_id) REFERENCES public.backoffice_identity(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_station backoffice_station_region_id_0a26ad42_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_station
    ADD CONSTRAINT backoffice_station_region_id_0a26ad42_fk_backoffic FOREIGN KEY (region_id) REFERENCES public.backoffice_stationregion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_user_groups backoffice_user_groups_group_id_76fb6381_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_groups
    ADD CONSTRAINT backoffice_user_groups_group_id_76fb6381_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_user_groups backoffice_user_groups_user_id_11757979_fk_backoffice_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_groups
    ADD CONSTRAINT backoffice_user_groups_user_id_11757979_fk_backoffice_user_id FOREIGN KEY (user_id) REFERENCES public.backoffice_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_user_user_permissions backoffice_user_user_permission_id_625e2e76_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_user_permissions
    ADD CONSTRAINT backoffice_user_user_permission_id_625e2e76_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backoffice_user_user_permissions backoffice_user_user_user_id_a65b42c2_fk_backoffic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backoffice_user_user_permissions
    ADD CONSTRAINT backoffice_user_user_user_id_a65b42c2_fk_backoffic FOREIGN KEY (user_id) REFERENCES public.backoffice_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_backoffice_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_backoffice_user_id FOREIGN KEY (user_id) REFERENCES public.backoffice_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: softdelete_changeset softdelete_changeset_content_type_id_121bb923_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_changeset
    ADD CONSTRAINT softdelete_changeset_content_type_id_121bb923_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: softdelete_softdeleterecord softdelete_softdelet_changeset_id_077905cb_fk_softdelet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_softdeleterecord
    ADD CONSTRAINT softdelete_softdelet_changeset_id_077905cb_fk_softdelet FOREIGN KEY (changeset_id) REFERENCES public.softdelete_changeset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: softdelete_softdeleterecord softdelete_softdelet_content_type_id_58770c81_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softdelete_softdeleterecord
    ADD CONSTRAINT softdelete_softdelet_content_type_id_58770c81_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

