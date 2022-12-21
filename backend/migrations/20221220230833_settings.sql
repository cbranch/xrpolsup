CREATE TABLE public.setting (
    "createdAt" bigint,
    "updatedAt" bigint,
    "id" integer NOT NULL,
    "name" text,
    "value" text
);
ALTER TABLE public.setting OWNER TO sails;
CREATE SEQUENCE public.setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.setting_id_seq OWNER TO sails;
ALTER SEQUENCE public.setting_id_seq OWNED BY public.setting.id;
ALTER TABLE ONLY public.setting ALTER COLUMN id SET DEFAULT nextval('public.setting_id_seq'::regclass);