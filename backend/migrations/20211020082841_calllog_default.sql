ALTER TABLE ONLY public."calllog" ALTER COLUMN id SET DEFAULT nextval('public.calllog_id_seq'::regclass);