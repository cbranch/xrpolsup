COPY public.backoffice_stationregion (id, deleted_at, name) FROM stdin;
44	\N	Scotland
\.

COPY public.backoffice_station (id, deleted_at, "createdAt", name, verified, rejected, region_id) FROM stdin;
208	\N	2021-10-20 20:20:00.000000+00	Elgin	t	f	1
209	\N	2021-10-20 20:20:00.000000+00	Fraserburgh	t	f	1
210	\N	2021-10-20 20:20:00.000000+00	Kittybrewster	t	f	1
211	\N	2021-10-20 20:20:00.000000+00	Ballater	t	f	1
212	\N	2021-10-20 20:20:00.000000+00	Banchory	t	f	1
213	\N	2021-10-20 20:20:00.000000+00	Banff	t	f	1
214	\N	2021-10-20 20:20:00.000000+00	Ellon	t	f	1
215	\N	2021-10-20 20:20:00.000000+00	Forres	t	f	1
216	\N	2021-10-20 20:20:00.000000+00	Huntly	t	f	1
217	\N	2021-10-20 20:20:00.000000+00	Inverurie	t	f	1
218	\N	2021-10-20 20:20:00.000000+00	Peterhead	t	f	1
219	\N	2021-10-20 20:20:00.000000+00	Stonehaven	t	f	1
220	\N	2021-10-20 20:20:00.000000+00	Arbroath	t	f	1
221	\N	2021-10-20 20:20:00.000000+00	Dundee	t	f	1
222	\N	2021-10-20 20:20:00.000000+00	Perth	t	f	1
223	\N	2021-10-20 20:20:00.000000+00	Inverness	t	f	1
224	\N	2021-10-20 20:20:00.000000+00	Alness	t	f	1
225	\N	2021-10-20 20:20:00.000000+00	Aviemore	t	f	1
226	\N	2021-10-20 20:20:00.000000+00	Benbecula	t	f	1
227	\N	2021-10-20 20:20:00.000000+00	Castlebay (Barra)	t	f	1
228	\N	2021-10-20 20:20:00.000000+00	Dingwall	t	f	1
229	\N	2021-10-20 20:20:00.000000+00	Fort William	t	f	1
230	\N	2021-10-20 20:20:00.000000+00	Kirkwall	t	f	1
231	\N	2021-10-20 20:20:00.000000+00	Kyle of Lochalsh	t	f	1
232	\N	2021-10-20 20:20:00.000000+00	Lerwick	t	f	1
233	\N	2021-10-20 20:20:00.000000+00	Nairn	t	f	1
234	\N	2021-10-20 20:20:00.000000+00	Portree	t	f	1
235	\N	2021-10-20 20:20:00.000000+00	Stornoway	t	f	1
236	\N	2021-10-20 20:20:00.000000+00	Thurso	t	f	1
237	\N	2021-10-20 20:20:00.000000+00	Ullapool	t	f	1
238	\N	2021-10-20 20:20:00.000000+00	Wick	t	f	1
239	\N	2021-10-20 20:20:00.000000+00	Falkirk	t	f	1
240	\N	2021-10-20 20:20:00.000000+00	Dalkeith	t	f	1
241	\N	2021-10-20 20:20:00.000000+00	Hawick	t	f	1
242	\N	2021-10-20 20:20:00.000000+00	Livingston	t	f	1
243	\N	2021-10-20 20:20:00.000000+00	St Leonards	t	f	1
244	\N	2021-10-20 20:20:00.000000+00	Drylaw	t	f	1
245	\N	2021-10-20 20:20:00.000000+00	Duns	t	f	1
246	\N	2021-10-20 20:20:00.000000+00	Eyemouth	t	f	1
247	\N	2021-10-20 20:20:00.000000+00	Galashiels	t	f	1
248	\N	2021-10-20 20:20:00.000000+00	Peebles	t	f	1
249	\N	2021-10-20 20:20:00.000000+00	Dunfermline	t	f	1
250	\N	2021-10-20 20:20:00.000000+00	Kirkcaldy	t	f	1
251	\N	2021-10-20 20:20:00.000000+00	Levenmouth	t	f	1
252	\N	2021-10-20 20:20:00.000000+00	GCCPO (Stewart Street)	t	f	1
253	\N	2021-10-20 20:20:00.000000+00	London Road	t	f	1
254	\N	2021-10-20 20:20:00.000000+00	Baird Street	t	f	1
255	\N	2021-10-20 20:20:00.000000+00	Maryhill	t	f	1
256	\N	2021-10-20 20:20:00.000000+00	Partick	t	f	1
257	\N	2021-10-20 20:20:00.000000+00	Greenock	t	f	1
258	\N	2021-10-20 20:20:00.000000+00	Dunoon	t	f	1
259	\N	2021-10-20 20:20:00.000000+00	Rothesay	t	f	1
260	\N	2021-10-20 20:20:00.000000+00	Cathcart	t	f	1
261	\N	2021-10-20 20:20:00.000000+00	Govan	t	f	1
262	\N	2021-10-20 20:20:00.000000+00	Ayr	t	f	1
263	\N	2021-10-20 20:20:00.000000+00	Kilmarnock	t	f	1
264	\N	2021-10-20 20:20:00.000000+00	Saltcoats	t	f	1
265	\N	2021-10-20 20:20:00.000000+00	Dumfries	t	f	1
266	\N	2021-10-20 20:20:00.000000+00	Stranraer	t	f	1
267	\N	2021-10-20 20:20:00.000000+00	Annan	t	f	1
268	\N	2021-10-20 20:20:00.000000+00	Castle Douglas	t	f	1
269	\N	2021-10-20 20:20:00.000000+00	Lamlash	t	f	1
270	\N	2021-10-20 20:20:00.000000+00	Lockerbie	t	f	1
271	\N	2021-10-20 20:20:00.000000+00	Millport	t	f	1
272	\N	2021-10-20 20:20:00.000000+00	Newton Stewart	t	f	1
273	\N	2021-10-20 20:20:00.000000+00	Sanquhar	t	f	1
274	\N	2021-10-20 20:20:00.000000+00	Coatbridge	t	f	1
275	\N	2021-10-20 20:20:00.000000+00	Hamilton	t	f	1
276	\N	2021-10-20 20:20:00.000000+00	Lanark	t	f	1
277	\N	2021-10-20 20:20:00.000000+00	Motherwell	t	f	1
278	\N	2021-10-20 20:20:00.000000+00	East Kilbride	t	f	1
279	\N	2021-10-20 20:20:00.000000+00	Campbeltown	t	f	1
280	\N	2021-10-20 20:20:00.000000+00	Clydebank	t	f	1
281	\N	2021-10-20 20:20:00.000000+00	Lochgilphead	t	f	1
282	\N	2021-10-20 20:20:00.000000+00	Oban	t	f	1
283	\N	2021-10-20 20:20:00.000000+00	Bowmore	t	f	1
284	\N	2021-10-20 20:20:00.000000+00	Craignure	t	f	1
285	\N	2021-10-20 20:20:00.000000+00	Tiree	t	f	1
286	\N	2021-10-20 20:20:00.000000+00	Tobermory	t	f	1
\.
