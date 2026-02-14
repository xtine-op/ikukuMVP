SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict 4PMl8bg3uqIqEgGkDARaIE45hVGsoSBR2w1btYBKQANA1vgBmlajzFwGDZDbDPS

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.6

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
00000000-0000-0000-0000-000000000000	d944a077-0705-4e3e-bffc-dfb2e4bf8066	{"action":"user_confirmation_requested","actor_id":"8c23da63-3d8b-4999-af4c-d28f8fa6f3de","actor_username":"xtineopwapo@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-09 12:49:11.350021+00	
00000000-0000-0000-0000-000000000000	ac574896-5e8c-4299-852c-5d7a920f7c14	{"action":"user_signedup","actor_id":"8c23da63-3d8b-4999-af4c-d28f8fa6f3de","actor_username":"xtineopwapo@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-09 12:50:55.242117+00	
00000000-0000-0000-0000-000000000000	4c74042b-f537-466b-8fce-da6f149f641e	{"action":"user_signedup","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-09 13:42:32.915838+00	
00000000-0000-0000-0000-000000000000	67e8c243-b040-47a1-b4d4-4eafa6ad920b	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 13:42:32.920478+00	
00000000-0000-0000-0000-000000000000	bf45d7b5-d4b4-4ee3-b033-de72933c154a	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 13:43:54.355219+00	
00000000-0000-0000-0000-000000000000	0d61bbf0-616e-4369-8e17-0bc085f3557b	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 13:44:20.35644+00	
00000000-0000-0000-0000-000000000000	6f4bf803-66e4-4574-9622-1cfee539e815	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 13:49:18.910844+00	
00000000-0000-0000-0000-000000000000	818394ab-bd9c-434b-a2f5-6a08e5fa2227	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 14:48:42.175693+00	
00000000-0000-0000-0000-000000000000	db388f3c-1470-446d-8f16-f24b241d3c55	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 14:48:42.177116+00	
00000000-0000-0000-0000-000000000000	0890f504-1bf5-4d54-a110-6c7fd2b72283	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 15:48:05.954133+00	
00000000-0000-0000-0000-000000000000	db77cd27-ee0a-446c-bc1e-c469d6969f59	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 15:48:05.956252+00	
00000000-0000-0000-0000-000000000000	198f0254-a96b-4905-9e9b-fec396a667d2	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 16:47:33.958286+00	
00000000-0000-0000-0000-000000000000	3bf55de6-d09f-4daf-aaee-775b004d5a98	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 16:47:33.960387+00	
00000000-0000-0000-0000-000000000000	e82d1c7c-63fa-456b-bad5-00e4ab683adb	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 18:59:22.451831+00	
00000000-0000-0000-0000-000000000000	b88cefd1-e536-4fe7-9490-b4f24ac5fa86	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 18:59:22.453199+00	
00000000-0000-0000-0000-000000000000	5689399b-915b-40bb-bff9-eec87aa69829	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 19:58:44.706773+00	
00000000-0000-0000-0000-000000000000	8fdc9d60-a70d-4c59-82fb-679ec2f03c73	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 19:58:44.708251+00	
00000000-0000-0000-0000-000000000000	5b3fae0f-587e-4975-add1-0eebea37b3e0	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 21:18:05.251307+00	
00000000-0000-0000-0000-000000000000	cbdc8cde-de38-48d3-868e-63e8eff2aab6	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 21:18:05.253521+00	
00000000-0000-0000-0000-000000000000	c5701d9c-894a-4628-9d99-ac6e45b23c74	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 22:17:34.975998+00	
00000000-0000-0000-0000-000000000000	9ed00563-8fa6-4317-8d20-1b8fd34154ef	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 22:17:34.978058+00	
00000000-0000-0000-0000-000000000000	af1cf64a-cca8-400b-8c8d-a94923d51606	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 23:17:01.911017+00	
00000000-0000-0000-0000-000000000000	773b09ad-1eae-4bdd-be69-3ce26749ce25	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 23:17:01.914394+00	
00000000-0000-0000-0000-000000000000	076c1ddf-9aee-4a69-a5ad-ef45d1bc3f6c	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:21:06.998264+00	
00000000-0000-0000-0000-000000000000	fdbad879-11cd-407b-9908-f31574e2f8c4	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:21:07.00149+00	
00000000-0000-0000-0000-000000000000	70ed9e44-b5e7-410d-ae24-a1fc90da1a52	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 06:11:08.798291+00	
00000000-0000-0000-0000-000000000000	13c9276d-e5d8-48f9-9e2d-67c2058e98ca	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 06:11:08.800674+00	
00000000-0000-0000-0000-000000000000	66f47f1f-0eae-4ed7-af83-b0665fa58646	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:09:13.903338+00	
00000000-0000-0000-0000-000000000000	8c89c3b3-7295-40d6-ad70-e07192a9b5b8	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:09:13.91129+00	
00000000-0000-0000-0000-000000000000	1a792f13-43c4-4509-8a4e-856fb54ee94e	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:08:42.599226+00	
00000000-0000-0000-0000-000000000000	b19ace4f-5869-4eac-be36-47067e8858fe	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:08:42.601338+00	
00000000-0000-0000-0000-000000000000	6c23c9aa-a508-4a9e-b40c-9f45bc2fd09c	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 23:08:10.029418+00	
00000000-0000-0000-0000-000000000000	9c11f46e-6090-4996-bd3e-37037d8ef8fa	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 23:08:10.031028+00	
00000000-0000-0000-0000-000000000000	43b46126-bb44-4d8e-9946-57712ea2c520	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 00:07:47.053431+00	
00000000-0000-0000-0000-000000000000	f2e77728-5584-47c1-a80e-1782ffcf7b18	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 00:07:47.054805+00	
00000000-0000-0000-0000-000000000000	ca705126-3222-4128-a8f9-64c9ecdea795	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 21:10:16.123078+00	
00000000-0000-0000-0000-000000000000	5e6fde58-95bc-45f4-a5a8-5c99375f027e	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 21:10:16.137188+00	
00000000-0000-0000-0000-000000000000	6b119dfd-3c31-4cf8-88e7-b41bcb128842	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:09:39.798396+00	
00000000-0000-0000-0000-000000000000	f595a971-0d80-4c8f-ab2e-df398d630b13	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:09:39.799811+00	
00000000-0000-0000-0000-000000000000	039b7858-bf41-44fd-af0d-469637d8e727	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 23:09:09.473061+00	
00000000-0000-0000-0000-000000000000	2a0c7e2a-2438-4b71-b4a4-6fb02714dfef	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 23:09:09.475007+00	
00000000-0000-0000-0000-000000000000	7a3445dd-47ff-4c5d-a407-59c474f85857	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 00:08:39.615605+00	
00000000-0000-0000-0000-000000000000	fe1c5fd8-060d-4ae7-9515-c9188093fa97	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 00:08:39.617624+00	
00000000-0000-0000-0000-000000000000	75a61bbf-c901-4d87-9d29-3fee691afda2	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:09:18.731153+00	
00000000-0000-0000-0000-000000000000	1b508b75-0cc3-4c35-8a22-7d23307d2602	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:09:18.74949+00	
00000000-0000-0000-0000-000000000000	b5b5977c-4cee-4830-acc6-cbe851ed5b86	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 15:08:45.625374+00	
00000000-0000-0000-0000-000000000000	991e56ad-77c8-4574-9cff-b24500d6e6f4	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 15:08:45.628192+00	
00000000-0000-0000-0000-000000000000	035caeaf-11f9-4eb6-b8bf-fb14cf8e6253	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 15:13:13.505119+00	
00000000-0000-0000-0000-000000000000	ebd10347-5356-44ee-b1d6-9815ae9efa08	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 15:13:13.512663+00	
00000000-0000-0000-0000-000000000000	2aed1ccf-5346-4d0c-9a5f-a801169886ac	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 17:40:51.65451+00	
00000000-0000-0000-0000-000000000000	665986ab-7f22-42ff-9561-ede24f6208b6	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 17:40:51.658789+00	
00000000-0000-0000-0000-000000000000	325f76f3-1139-4297-8d12-19c52bf7071a	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 18:40:27.604493+00	
00000000-0000-0000-0000-000000000000	b56bd0b5-a279-47ee-8d1a-703cab82ec3e	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 18:40:27.607027+00	
00000000-0000-0000-0000-000000000000	e93f2741-5500-429e-9532-6b9c3d2b572c	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 20:07:22.251623+00	
00000000-0000-0000-0000-000000000000	5d10ec9a-b22c-428a-ab01-09d0bd48a605	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 20:07:22.257083+00	
00000000-0000-0000-0000-000000000000	599ef0f8-265d-4a5d-92ee-f5335c23752b	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 21:06:44.215402+00	
00000000-0000-0000-0000-000000000000	f777affd-34c3-406b-8fd2-baf05e3570ce	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 21:06:44.21734+00	
00000000-0000-0000-0000-000000000000	d2798628-4828-44d7-84cc-a648caf7f587	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 22:06:09.025597+00	
00000000-0000-0000-0000-000000000000	1ceb88c9-c226-4242-a33a-abccad0f9e1e	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 22:06:09.027648+00	
00000000-0000-0000-0000-000000000000	71e06fd2-0e9c-41f1-80ea-28d3d20cfe65	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 09:42:00.631925+00	
00000000-0000-0000-0000-000000000000	fdfc7b47-f0bf-4f35-a4d6-63b89682b056	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 09:42:00.645976+00	
00000000-0000-0000-0000-000000000000	0094152e-23c2-49ef-9714-9b5976a6dc4b	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 10:41:22.697185+00	
00000000-0000-0000-0000-000000000000	2b46ec56-2a40-4217-ac36-a69bd4136b1b	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 10:41:22.701779+00	
00000000-0000-0000-0000-000000000000	9c476c47-3191-41ec-9b38-265b70258fe1	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 11:40:53.429771+00	
00000000-0000-0000-0000-000000000000	96b2e2d6-7197-4bc2-b20e-7483b294f8f6	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 11:40:53.431749+00	
00000000-0000-0000-0000-000000000000	72f4ef17-1f99-481b-ba06-2909cc2a95ca	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:42:31.694326+00	
00000000-0000-0000-0000-000000000000	7eb59791-eb9e-42a1-a90f-cd7c0e455b67	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:42:31.697152+00	
00000000-0000-0000-0000-000000000000	1d6af410-305d-4e71-88c4-c27b607e8432	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 13:42:01.123701+00	
00000000-0000-0000-0000-000000000000	c250e2a2-c304-4d71-bb94-1691393b0b58	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 13:42:01.125763+00	
00000000-0000-0000-0000-000000000000	2b37334b-9da4-4909-ad75-f0506eda9ae1	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:41:29.289824+00	
00000000-0000-0000-0000-000000000000	344b16b6-e598-412d-b1a9-572e3c0dfb3e	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:41:29.297384+00	
00000000-0000-0000-0000-000000000000	c0f28fc4-3f0c-4fe6-baf5-ebb2d6d869b5	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 15:40:54.665686+00	
00000000-0000-0000-0000-000000000000	0a7b52fe-aab9-4bf3-9af6-8f6365646dec	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 15:40:54.66782+00	
00000000-0000-0000-0000-000000000000	86954a0d-34a1-445f-9e87-0cd1b9b7a8f7	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:40:23.332252+00	
00000000-0000-0000-0000-000000000000	e1f70394-5eb9-4acf-82a1-d62bd9d5d872	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:40:23.336037+00	
00000000-0000-0000-0000-000000000000	502a0c6f-36d3-4350-9a91-84052452ad6f	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 17:39:45.110102+00	
00000000-0000-0000-0000-000000000000	146cca2d-2a1f-4939-9007-b959a603c275	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 17:39:45.111592+00	
00000000-0000-0000-0000-000000000000	bb152b4b-a3f1-4767-940f-b115c590861c	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:39:15.588828+00	
00000000-0000-0000-0000-000000000000	c735d755-ee09-41f4-bc31-40d6b982bf5c	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:39:15.592169+00	
00000000-0000-0000-0000-000000000000	3426103b-7f8d-4b16-88e7-5d4c7a7776b9	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 19:39:16.036022+00	
00000000-0000-0000-0000-000000000000	de6cfb78-56ec-4a43-b8e6-9f5ab8f4ccdb	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 19:39:16.03752+00	
00000000-0000-0000-0000-000000000000	85323b9c-79b8-4446-944d-04837f507fea	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:39:18.555168+00	
00000000-0000-0000-0000-000000000000	4c1d979c-1832-4c74-8b71-7de574794697	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:39:18.557222+00	
00000000-0000-0000-0000-000000000000	ed2c9f48-555c-40f4-a963-074f7cbd2a0e	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 21:39:24.433364+00	
00000000-0000-0000-0000-000000000000	6e472c9f-5dd0-483b-aafd-6ba1ce91108d	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 21:39:24.435997+00	
00000000-0000-0000-0000-000000000000	9694d71a-eb89-4ce7-9dba-446a9d65ff87	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 22:39:30.096929+00	
00000000-0000-0000-0000-000000000000	418da2b3-6457-4224-bbc0-09aa2a1045ed	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 22:39:30.098455+00	
00000000-0000-0000-0000-000000000000	8fcb4409-ca98-4daa-a7e1-c964ff1926a1	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 09:34:50.349442+00	
00000000-0000-0000-0000-000000000000	5da1b252-b7ea-4831-8231-eb14bf2c5026	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 09:34:50.360159+00	
00000000-0000-0000-0000-000000000000	2aaa3693-40f1-405f-8439-07b9e5d548de	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 10:34:15.460061+00	
00000000-0000-0000-0000-000000000000	ccbff517-2573-4766-a75a-2decfd8d27e0	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 10:34:15.464082+00	
00000000-0000-0000-0000-000000000000	55624da8-fa7c-4e88-b853-4abcf7479a51	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:33:46.253316+00	
00000000-0000-0000-0000-000000000000	edab5d71-c1bb-48f9-9d56-3ff6486b3df6	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:33:46.25732+00	
00000000-0000-0000-0000-000000000000	a4c1da21-c0f2-4b49-807c-f72bd620ed3c	{"action":"logout","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-18 12:21:35.331589+00	
00000000-0000-0000-0000-000000000000	2490181a-d8c9-40b8-a662-a19dbff4703a	{"action":"user_repeated_signup","actor_id":"8c23da63-3d8b-4999-af4c-d28f8fa6f3de","actor_username":"xtineopwapo@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-18 12:23:43.073288+00	
00000000-0000-0000-0000-000000000000	f4883657-ccf6-4eff-849a-dbc886bf3e9c	{"action":"user_repeated_signup","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-18 14:28:49.424118+00	
00000000-0000-0000-0000-000000000000	e0680e13-5833-483f-b571-f050a0153065	{"action":"user_repeated_signup","actor_id":"8c23da63-3d8b-4999-af4c-d28f8fa6f3de","actor_username":"xtineopwapo@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-18 14:29:19.658835+00	
00000000-0000-0000-0000-000000000000	2954f2bd-156e-4ef1-a584-56ebbeda66ed	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 14:29:53.801762+00	
00000000-0000-0000-0000-000000000000	ed60f53b-37b2-4b49-920f-f9496f953fe0	{"action":"logout","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-18 14:30:33.061979+00	
00000000-0000-0000-0000-000000000000	c81bc890-54fd-40f7-b5d5-a8df8e3be2ef	{"action":"user_signedup","actor_id":"46052f9c-ba77-46fe-a5f2-6195c2f2ae0b","actor_username":"opwapochristine@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-18 14:31:16.285828+00	
00000000-0000-0000-0000-000000000000	64a22b9f-a699-4b8c-8132-2d4c63fdb892	{"action":"login","actor_id":"46052f9c-ba77-46fe-a5f2-6195c2f2ae0b","actor_username":"opwapochristine@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 14:31:16.295472+00	
00000000-0000-0000-0000-000000000000	77e7e4db-6e73-4527-a879-f75c8bdffc0b	{"action":"logout","actor_id":"46052f9c-ba77-46fe-a5f2-6195c2f2ae0b","actor_username":"opwapochristine@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-18 14:36:50.447856+00	
00000000-0000-0000-0000-000000000000	2566aeee-d0c6-4131-a085-a0920e5bbe4f	{"action":"login","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 14:38:03.765651+00	
00000000-0000-0000-0000-000000000000	0caa575c-3114-4efa-998f-f11d23ab59c4	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 15:37:27.841831+00	
00000000-0000-0000-0000-000000000000	df74adb6-67d3-4492-8ef0-279a6670b3ef	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 15:37:27.843808+00	
00000000-0000-0000-0000-000000000000	a0f96c7b-aff9-40ec-b587-db6b01b1e729	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 16:36:57.560475+00	
00000000-0000-0000-0000-000000000000	880955f2-6498-490f-b8ea-4c3e519a3fd3	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 16:36:57.56535+00	
00000000-0000-0000-0000-000000000000	7ab154ee-9aff-45ea-a441-215b3a66cb2e	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 17:36:28.305499+00	
00000000-0000-0000-0000-000000000000	e8c2717d-31a9-4e64-a910-eef0623fed95	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 17:36:28.307666+00	
00000000-0000-0000-0000-000000000000	b2a279f7-e099-4ab4-b1f2-8d427d2a8239	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:35:58.943393+00	
00000000-0000-0000-0000-000000000000	027fadf9-dd1d-4387-8847-9fffbaa24507	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:35:58.94596+00	
00000000-0000-0000-0000-000000000000	eb85a93d-5dc8-4388-9f31-17cfc78dafa9	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 19:36:45.576919+00	
00000000-0000-0000-0000-000000000000	44028cab-65cb-41fd-85cb-338c7f986c91	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 19:36:45.581335+00	
00000000-0000-0000-0000-000000000000	37d8a9ea-e575-46c9-8640-c3767a7a0b6e	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 20:36:15.777127+00	
00000000-0000-0000-0000-000000000000	e359e15a-255d-4740-807e-709a5bee65f5	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 20:36:15.779769+00	
00000000-0000-0000-0000-000000000000	a0817aec-d95c-4e1e-9bce-45e3af76a326	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 21:35:45.285649+00	
00000000-0000-0000-0000-000000000000	ea0b8ed0-9375-441a-8cdf-b39601e01ced	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 21:35:45.288341+00	
00000000-0000-0000-0000-000000000000	a82299ed-bacc-48e9-86bf-7d9ee44517f9	{"action":"user_signedup","actor_id":"67c4a209-c6b6-499f-900e-33d9c1c82012","actor_username":"try@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-19 00:29:13.058736+00	
00000000-0000-0000-0000-000000000000	37f67d7f-69d8-47a5-b1ed-370c6692fc42	{"action":"login","actor_id":"67c4a209-c6b6-499f-900e-33d9c1c82012","actor_username":"try@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 00:29:13.068774+00	
00000000-0000-0000-0000-000000000000	77133bf5-53fa-4683-aacb-3c409f4dd998	{"action":"token_refreshed","actor_id":"67c4a209-c6b6-499f-900e-33d9c1c82012","actor_username":"try@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 07:40:08.601031+00	
00000000-0000-0000-0000-000000000000	b0e4eeba-0cb9-4dee-91df-e003babd4c0e	{"action":"token_revoked","actor_id":"67c4a209-c6b6-499f-900e-33d9c1c82012","actor_username":"try@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 07:40:08.60823+00	
00000000-0000-0000-0000-000000000000	8e550e76-c42d-4db4-b1bd-83312d608510	{"action":"token_refreshed","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:13:04.513428+00	
00000000-0000-0000-0000-000000000000	959eb1b5-d0c4-4d11-81f9-b57a1f881194	{"action":"token_revoked","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:13:04.51666+00	
00000000-0000-0000-0000-000000000000	6d69e365-0da6-4ffc-8fac-db77dc909139	{"action":"user_signedup","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-19 12:08:43.258909+00	
00000000-0000-0000-0000-000000000000	a6a8b325-7ad5-4ed4-b851-831741b5d20b	{"action":"login","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 12:08:43.268426+00	
00000000-0000-0000-0000-000000000000	29b30cb7-8a51-4c53-8b62-5d785463a112	{"action":"user_repeated_signup","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-19 12:40:33.588081+00	
00000000-0000-0000-0000-000000000000	c4713e1c-b85d-47e5-b008-a2d6b4c59961	{"action":"login","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 12:40:54.662607+00	
00000000-0000-0000-0000-000000000000	ad6419ed-fba5-44ec-8cf3-cdc823bd1734	{"action":"login","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 13:08:21.72294+00	
00000000-0000-0000-0000-000000000000	bafa67fa-91d6-45a4-ab81-8df0815be37f	{"action":"token_refreshed","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 16:27:09.306931+00	
00000000-0000-0000-0000-000000000000	a85a4933-10d0-48c1-abe9-5938630600a1	{"action":"token_revoked","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 16:27:09.312983+00	
00000000-0000-0000-0000-000000000000	cc031297-a79f-4b71-9a0d-570d35dc4339	{"action":"token_refreshed","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 20:15:42.631598+00	
00000000-0000-0000-0000-000000000000	7017bb3c-5965-44d6-9932-6b160a356c95	{"action":"token_revoked","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 20:15:42.634816+00	
00000000-0000-0000-0000-000000000000	f78d43cb-6c37-4881-83ef-9579d2e5ad78	{"action":"user_signedup","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-20 13:44:41.680166+00	
00000000-0000-0000-0000-000000000000	7b1af865-69c1-4f90-b5a9-745ad6215ebe	{"action":"login","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 13:44:41.697964+00	
00000000-0000-0000-0000-000000000000	903ecdca-152d-4cdf-b2ef-512e945a47bc	{"action":"logout","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"account"}	2025-07-20 13:46:41.091374+00	
00000000-0000-0000-0000-000000000000	236f0b3a-0391-40ba-b073-e819e62461d3	{"action":"login","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 13:46:53.062593+00	
00000000-0000-0000-0000-000000000000	a8f048f8-eb9c-4089-b1b1-c4485d4298e2	{"action":"token_refreshed","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 06:15:48.492163+00	
00000000-0000-0000-0000-000000000000	95fb0615-867c-429d-b01e-88b5632164bf	{"action":"token_revoked","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 06:15:48.495776+00	
00000000-0000-0000-0000-000000000000	17c72f95-a927-44ba-a166-c4c98f479eaf	{"action":"logout","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"account"}	2025-07-21 06:16:59.087253+00	
00000000-0000-0000-0000-000000000000	0bd0c54a-4a1d-4a80-889b-747152d6d968	{"action":"login","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 06:17:36.813731+00	
00000000-0000-0000-0000-000000000000	a1ca7682-72bb-4fdf-bd18-cb57b6490ebc	{"action":"token_refreshed","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 07:46:30.829055+00	
00000000-0000-0000-0000-000000000000	1cdf0063-368f-44a1-a869-e3acb7201722	{"action":"token_revoked","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 07:46:30.83128+00	
00000000-0000-0000-0000-000000000000	8a561280-922d-4383-9b68-3cbcdfd53788	{"action":"logout","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-21 07:49:55.246814+00	
00000000-0000-0000-0000-000000000000	f586d8d4-5e9a-479d-86f5-cda26a465435	{"action":"user_signedup","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-22 05:43:14.323593+00	
00000000-0000-0000-0000-000000000000	821fea9a-98b0-4f7c-8304-174df04b27fb	{"action":"login","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 05:43:14.332811+00	
00000000-0000-0000-0000-000000000000	48bd9423-2417-4d5c-ac92-6d3b32a47034	{"action":"token_refreshed","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-24 06:48:03.431073+00	
00000000-0000-0000-0000-000000000000	ef0b4288-ac03-4ec7-9dd0-4067d73fd1a0	{"action":"token_revoked","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-24 06:48:03.44289+00	
00000000-0000-0000-0000-000000000000	42c4d009-7291-4767-88c7-53878add6b24	{"action":"user_signedup","actor_id":"835c60e8-fc39-4b88-9cab-adb4e41abb2e","actor_username":"me@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-28 08:51:14.458933+00	
00000000-0000-0000-0000-000000000000	2d7214a3-87e1-4e4c-9a87-195736d761a5	{"action":"login","actor_id":"835c60e8-fc39-4b88-9cab-adb4e41abb2e","actor_username":"me@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-28 08:51:14.481767+00	
00000000-0000-0000-0000-000000000000	1eb23a94-ef54-45ef-a16c-0a265075fb49	{"action":"logout","actor_id":"835c60e8-fc39-4b88-9cab-adb4e41abb2e","actor_username":"me@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-28 09:02:42.878972+00	
00000000-0000-0000-0000-000000000000	763af679-21bd-4a8a-be16-1b10c90a2320	{"action":"user_signedup","actor_id":"e78ba560-9542-4f67-8dc9-f2823b0f13d2","actor_username":"wewe@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-28 09:03:17.984921+00	
00000000-0000-0000-0000-000000000000	2ed0d722-0b2a-4253-97db-ba6c74090d3d	{"action":"login","actor_id":"e78ba560-9542-4f67-8dc9-f2823b0f13d2","actor_username":"wewe@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-28 09:03:17.989911+00	
00000000-0000-0000-0000-000000000000	baa25fa4-2be3-447e-aa36-35c01abf3b99	{"action":"logout","actor_id":"e78ba560-9542-4f67-8dc9-f2823b0f13d2","actor_username":"wewe@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-28 09:21:33.449338+00	
00000000-0000-0000-0000-000000000000	f2449db1-c4ce-4de0-ae8e-52274727719f	{"action":"user_signedup","actor_id":"6df1069c-e9d9-4525-bed8-0ce4243d1b5c","actor_username":"mimi@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-28 09:22:56.18256+00	
00000000-0000-0000-0000-000000000000	75fd1813-5931-410f-bbb5-d03f90f46bb1	{"action":"login","actor_id":"6df1069c-e9d9-4525-bed8-0ce4243d1b5c","actor_username":"mimi@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-28 09:22:56.187124+00	
00000000-0000-0000-0000-000000000000	a35f80af-0adf-4c92-820d-b1ee36131309	{"action":"user_repeated_signup","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-28 09:26:34.068728+00	
00000000-0000-0000-0000-000000000000	0b6df55b-6e92-4207-8900-d0425e55a4fc	{"action":"user_signedup","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-28 09:26:46.58195+00	
00000000-0000-0000-0000-000000000000	13111a43-3df9-4d37-bee3-58d1f9308501	{"action":"login","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-28 09:26:46.587721+00	
00000000-0000-0000-0000-000000000000	0b14673b-0374-49cc-b3f3-5adf7b93b6b7	{"action":"logout","actor_id":"6df1069c-e9d9-4525-bed8-0ce4243d1b5c","actor_username":"mimi@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-28 09:52:52.718889+00	
00000000-0000-0000-0000-000000000000	42d0376c-6d7b-43a6-a715-8a73b4064a16	{"action":"user_signedup","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-28 09:53:52.391956+00	
00000000-0000-0000-0000-000000000000	7c22a53b-6789-48e7-bf88-7d5bf46252f2	{"action":"login","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-28 09:53:52.398425+00	
00000000-0000-0000-0000-000000000000	2e12fed8-853f-4e4b-b45b-d8df7e17fb5b	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 10:54:13.679315+00	
00000000-0000-0000-0000-000000000000	4b2212d5-089b-4bfd-b8e6-c999ddbf3781	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 18:07:13.857154+00	
00000000-0000-0000-0000-000000000000	fa2eeff1-aeed-4916-857a-9cc1da98a30c	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 10:54:13.682525+00	
00000000-0000-0000-0000-000000000000	b0b83bed-0a5a-48c2-8d01-ddee5c8903ff	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 11:36:48.604813+00	
00000000-0000-0000-0000-000000000000	a99a9288-fe44-4340-83e8-24867fbffb05	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 11:36:48.606338+00	
00000000-0000-0000-0000-000000000000	f0eab465-6802-42e1-9228-b526bac1e8c4	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 11:54:32.590489+00	
00000000-0000-0000-0000-000000000000	3c1439a4-ba5b-4777-a022-ee7841e4c127	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 11:54:32.591313+00	
00000000-0000-0000-0000-000000000000	61490004-5a91-409b-82f2-220fc74b4157	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 12:53:08.401308+00	
00000000-0000-0000-0000-000000000000	1dbc4209-21f8-4ac6-ab54-64b60eae19cb	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 12:53:08.404181+00	
00000000-0000-0000-0000-000000000000	fc4f6861-3a91-4012-a3ad-b38a77198b6e	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 12:54:50.353294+00	
00000000-0000-0000-0000-000000000000	3697ddcb-8aed-4402-b6b7-d056becf4891	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 12:54:50.354123+00	
00000000-0000-0000-0000-000000000000	5a13fa7b-6c4f-4082-a90c-d47f94666e65	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 13:55:11.03943+00	
00000000-0000-0000-0000-000000000000	ea997816-ad7b-4b59-9cd6-858475cc07fb	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 13:55:11.042652+00	
00000000-0000-0000-0000-000000000000	193ede9f-c07e-43cc-af47-bff4c336047a	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 14:55:30.985534+00	
00000000-0000-0000-0000-000000000000	3903b943-748a-4b90-a7a9-0411638496de	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 14:55:30.987039+00	
00000000-0000-0000-0000-000000000000	4313a9fa-5df4-4617-ad7f-153325b6b705	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 15:55:45.804919+00	
00000000-0000-0000-0000-000000000000	5add8ced-588a-490e-9d16-b209562f5426	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 15:55:45.805781+00	
00000000-0000-0000-0000-000000000000	9c3e98cc-8195-4c60-bc02-84795d08a395	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 16:55:55.825437+00	
00000000-0000-0000-0000-000000000000	666911cf-2d7a-4b27-84e3-33649a0ceff6	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 16:55:55.827632+00	
00000000-0000-0000-0000-000000000000	b4f1278e-1204-4652-8bac-c97912cc3224	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 19:49:35.074225+00	
00000000-0000-0000-0000-000000000000	eee6243a-0ff1-4119-9459-fa90a6fff53f	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 19:49:35.076417+00	
00000000-0000-0000-0000-000000000000	25e24114-94dd-4ed7-88b8-1160a75b0638	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 20:43:09.861977+00	
00000000-0000-0000-0000-000000000000	4db7cbd9-a96c-4769-8a3c-382ba8fbeb5f	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 20:43:09.865744+00	
00000000-0000-0000-0000-000000000000	d14b81a3-f4e4-407c-af62-23494e301113	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 21:42:34.120921+00	
00000000-0000-0000-0000-000000000000	cc33052d-67ec-468d-bc13-d33e8cc267c2	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-28 21:42:34.123445+00	
00000000-0000-0000-0000-000000000000	9fd9d695-83b9-4e96-837f-1e7fbb6854c1	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 08:10:19.020794+00	
00000000-0000-0000-0000-000000000000	2939c17d-1204-4601-b12c-6137d561c8a8	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 08:10:19.034787+00	
00000000-0000-0000-0000-000000000000	5f92616e-f3e3-4334-874b-63f8d01f2c59	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 09:10:29.936579+00	
00000000-0000-0000-0000-000000000000	034a261d-5e16-4ed5-a5c8-df29a134711c	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 09:10:29.938147+00	
00000000-0000-0000-0000-000000000000	c94fc5c6-4048-439e-a3ab-877fca570a55	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 10:10:00.780343+00	
00000000-0000-0000-0000-000000000000	abc84cab-cbe7-4131-8506-148586010967	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 10:10:00.783114+00	
00000000-0000-0000-0000-000000000000	f7864ab1-6b7c-4dd8-9a0e-0c6f95a3eb3e	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 11:10:59.521823+00	
00000000-0000-0000-0000-000000000000	16addb03-e09f-4fee-9e29-d207a889ed89	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 11:10:59.526192+00	
00000000-0000-0000-0000-000000000000	dba15b35-9edb-4f9e-844a-8453acc623a5	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 12:20:45.036099+00	
00000000-0000-0000-0000-000000000000	528b246a-1ad1-470a-8d3c-2d9ea3d44b4a	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 12:20:45.039551+00	
00000000-0000-0000-0000-000000000000	5019d468-d295-455f-ab73-15cee9ccb258	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 13:20:07.517679+00	
00000000-0000-0000-0000-000000000000	7fafe6a4-f494-43ce-9d09-592d49c5fb99	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 13:20:07.521895+00	
00000000-0000-0000-0000-000000000000	e99c8dcd-fdd4-4325-ad98-78b308191328	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 14:24:10.814034+00	
00000000-0000-0000-0000-000000000000	b0698467-ef06-4b1b-bacd-8f0d89e52b30	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 14:24:10.816328+00	
00000000-0000-0000-0000-000000000000	2e13f28f-6e4e-46cd-a222-32d8ca9f877d	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 15:24:10.010724+00	
00000000-0000-0000-0000-000000000000	5644b6cb-aec8-4a31-a3e5-0d64c8207c18	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 15:24:10.012907+00	
00000000-0000-0000-0000-000000000000	5409b706-5e50-472c-94aa-f3d54b42a471	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 16:40:32.830192+00	
00000000-0000-0000-0000-000000000000	19199323-9446-4c58-848a-b711fc4f38b4	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 16:40:32.832846+00	
00000000-0000-0000-0000-000000000000	5ace618b-5dff-4274-9f41-4d41a70fcbcb	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 16:47:17.77295+00	
00000000-0000-0000-0000-000000000000	870f58ce-60bd-469f-8cdf-3b32af8b26a6	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-29 16:47:17.775734+00	
00000000-0000-0000-0000-000000000000	fdef1e65-397e-46c2-b84c-f61444ffb69a	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 11:21:45.919983+00	
00000000-0000-0000-0000-000000000000	d6ae15a7-b540-46d3-a2da-647d38bc1bec	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 11:21:45.929176+00	
00000000-0000-0000-0000-000000000000	8e2b6830-dbeb-4dd2-b99b-78c41f574bda	{"action":"token_refreshed","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 14:55:24.8115+00	
00000000-0000-0000-0000-000000000000	09b1afb9-376f-4ea9-964b-08d3fe671710	{"action":"token_revoked","actor_id":"b46499fb-122c-4a98-a506-09254fa8451c","actor_username":"ha@ha.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 14:55:24.813676+00	
00000000-0000-0000-0000-000000000000	ab57423e-40a5-47a9-b481-cf86404c2f37	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 14:56:37.275451+00	
00000000-0000-0000-0000-000000000000	b12d52fc-6efd-4f3b-a64a-ec22886cce40	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 14:56:37.276267+00	
00000000-0000-0000-0000-000000000000	e1a93a27-a612-4c9a-bb47-45487f68265a	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 20:18:24.933786+00	
00000000-0000-0000-0000-000000000000	c382fc6b-1694-490a-ad86-39ebbdd9feb3	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 20:18:24.942656+00	
00000000-0000-0000-0000-000000000000	ace73170-12f2-44ff-a548-db92a38bb973	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 21:17:51.980867+00	
00000000-0000-0000-0000-000000000000	13108dcd-7675-4644-9793-ff45786672a7	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 21:17:51.983681+00	
00000000-0000-0000-0000-000000000000	dff0978e-d0a5-4c60-abfb-91ea213ec989	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 22:31:15.377834+00	
00000000-0000-0000-0000-000000000000	8ca98950-858a-4c3d-a0c3-5cf29fdf9685	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 22:31:15.379788+00	
00000000-0000-0000-0000-000000000000	cf1bdc36-dfa2-4936-8999-681b5d5b76a8	{"action":"token_refreshed","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 23:30:40.677526+00	
00000000-0000-0000-0000-000000000000	a7450ce2-b381-46e2-be44-97fd47f75504	{"action":"token_revoked","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-30 23:30:40.680709+00	
00000000-0000-0000-0000-000000000000	60ce51f9-dc1c-477f-8bfa-3b2c80f43c4a	{"action":"logout","actor_id":"722f50f8-20f7-4da4-8070-3c644ff1b096","actor_username":"test6@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-31 00:14:00.330555+00	
00000000-0000-0000-0000-000000000000	e64fb59f-99fe-4acf-b4b0-83f11f081d82	{"action":"user_signedup","actor_id":"e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2","actor_username":"heee@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-31 00:14:46.482006+00	
00000000-0000-0000-0000-000000000000	1e768b75-5afc-40fa-8549-c436eeb3710a	{"action":"login","actor_id":"e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2","actor_username":"heee@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-31 00:14:46.494233+00	
00000000-0000-0000-0000-000000000000	edd84c09-ccf8-4a6b-a0ec-fce0a6d219b1	{"action":"user_signedup","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-31 00:57:11.464759+00	
00000000-0000-0000-0000-000000000000	34a2dba5-6632-4318-8b71-d62ef4a93d96	{"action":"login","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-31 00:57:11.472276+00	
00000000-0000-0000-0000-000000000000	2e1793a8-ce9b-423a-9da1-c94f4b90357b	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 01:56:38.477405+00	
00000000-0000-0000-0000-000000000000	3d2f4770-a605-42d9-9817-49ef586e9bd1	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 01:56:38.48064+00	
00000000-0000-0000-0000-000000000000	82e2ad7e-3bec-4055-a01a-c487e2b07f4f	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 02:56:02.252249+00	
00000000-0000-0000-0000-000000000000	b330c17b-0ee9-4935-a814-dd822bcc3317	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 02:56:02.256207+00	
00000000-0000-0000-0000-000000000000	ba35ae5b-0328-473c-8102-27439e06eea3	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 04:00:47.261272+00	
00000000-0000-0000-0000-000000000000	901524af-7dd9-4f42-9b15-197486a3511c	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 04:00:47.26524+00	
00000000-0000-0000-0000-000000000000	3ada70c5-80e5-4ada-9bf8-3ee5f4990a2c	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 05:07:37.693071+00	
00000000-0000-0000-0000-000000000000	1036d331-a627-4239-b179-0df2e748f736	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 05:07:37.69538+00	
00000000-0000-0000-0000-000000000000	7a351afb-4184-403f-befb-24ccced2fd9f	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 08:44:40.360674+00	
00000000-0000-0000-0000-000000000000	77ec8070-bd16-48f7-8767-abaa9a75a988	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 08:44:40.378293+00	
00000000-0000-0000-0000-000000000000	f92319a0-e690-4eef-9afa-e102dd4f35e9	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 09:47:05.962647+00	
00000000-0000-0000-0000-000000000000	92d4ba4d-86e1-49ac-922f-3b120382b6b2	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 09:47:05.965625+00	
00000000-0000-0000-0000-000000000000	a45039bf-f375-4785-8783-6284715a377b	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 10:46:35.571993+00	
00000000-0000-0000-0000-000000000000	9e79e5fe-5341-4786-9964-6b65990122fb	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 10:46:35.574172+00	
00000000-0000-0000-0000-000000000000	da23a23a-464f-4c79-a3c8-4cc2469cb8f3	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 11:46:05.469353+00	
00000000-0000-0000-0000-000000000000	bc0c365f-d695-4561-bd6d-90398ae8294a	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 11:46:05.47745+00	
00000000-0000-0000-0000-000000000000	31bf281e-5a73-4192-8f82-72fc4991397a	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 21:14:33.380517+00	
00000000-0000-0000-0000-000000000000	82f4f55d-ddd1-4959-9b05-d4ba104fbebf	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 21:14:33.390226+00	
00000000-0000-0000-0000-000000000000	2762d8d9-7156-4c92-af6e-ad8b1a3f37ab	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 22:14:00.75468+00	
00000000-0000-0000-0000-000000000000	9d2f4e73-4ec0-4d41-93f3-0a27a80d8d03	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 22:14:00.75924+00	
00000000-0000-0000-0000-000000000000	fece5c1e-cac6-44d4-a9d7-b151149818bd	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 23:13:30.888611+00	
00000000-0000-0000-0000-000000000000	0c5f1805-37d3-48de-a256-a6ff777e7311	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-31 23:13:30.890102+00	
00000000-0000-0000-0000-000000000000	1c9544c2-67ae-45fe-89ad-d8d651fbd4e6	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 00:13:00.922856+00	
00000000-0000-0000-0000-000000000000	090da6d5-9f28-4716-889e-c711409254c7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 00:13:00.928224+00	
00000000-0000-0000-0000-000000000000	0042757a-5ead-4ab5-b92a-d34e5325dd37	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 01:12:30.799728+00	
00000000-0000-0000-0000-000000000000	b1d3f20c-b39d-45bd-969f-73567d281eb0	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 01:12:30.805326+00	
00000000-0000-0000-0000-000000000000	362a5d5d-1def-45d0-b75a-8c5d1a9c0524	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 02:12:00.795414+00	
00000000-0000-0000-0000-000000000000	56d275f4-9348-4765-84a5-435c321e37f6	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 02:12:00.799199+00	
00000000-0000-0000-0000-000000000000	4162f0ac-72b0-4739-91ff-fc7f3ec21b50	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 03:11:31.327124+00	
00000000-0000-0000-0000-000000000000	dcbde0aa-a77b-4631-a702-28fadebfec69	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 03:11:31.329403+00	
00000000-0000-0000-0000-000000000000	7df7d74a-315a-4b60-a216-0e24b9c9d214	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 06:43:09.322745+00	
00000000-0000-0000-0000-000000000000	43e8474f-ebe2-409f-9127-809ba45e653e	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 06:43:09.329184+00	
00000000-0000-0000-0000-000000000000	66d3a530-1db2-44e7-83dd-5df9b48449f0	{"action":"token_refreshed","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 07:17:06.816402+00	
00000000-0000-0000-0000-000000000000	9aee9b70-dbfb-4b8a-836c-ed71b1ea304e	{"action":"token_revoked","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 07:17:06.820962+00	
00000000-0000-0000-0000-000000000000	1dbeea92-7276-4478-ab0a-8aa747f918c3	{"action":"logout","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-01 07:17:51.475703+00	
00000000-0000-0000-0000-000000000000	4223502e-c595-4e93-adad-a2fedb47dbd1	{"action":"login","actor_id":"2bd5f804-d025-4d99-8e8e-3cc978369df7","actor_username":"shemaiahngala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-01 07:18:05.389234+00	
00000000-0000-0000-0000-000000000000	fedce6f3-70af-47d5-ac3f-0ca0a3327f85	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 07:48:00.185822+00	
00000000-0000-0000-0000-000000000000	48c266c1-4683-471a-8183-0de7a626c0e6	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 07:48:00.188765+00	
00000000-0000-0000-0000-000000000000	6be063bc-a572-47ad-b90e-87bbf8a373d4	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 09:20:32.170762+00	
00000000-0000-0000-0000-000000000000	0368a211-7c22-4934-8064-afb489f3ee3a	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 09:20:32.173284+00	
00000000-0000-0000-0000-000000000000	e32f77df-bdef-4a02-91e4-a9f457289fa2	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 11:24:05.313221+00	
00000000-0000-0000-0000-000000000000	63c2b8bb-1d3a-46bd-8cd5-c78cb12f8481	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 11:24:05.317634+00	
00000000-0000-0000-0000-000000000000	3f890a31-c5c3-450d-ab8c-d61cacf23879	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 12:23:52.298765+00	
00000000-0000-0000-0000-000000000000	9d9a4227-f0a5-4b4c-9072-9c2e4f3e40b7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 12:23:52.300272+00	
00000000-0000-0000-0000-000000000000	602ace80-72cc-47d6-8101-0137c94f9305	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 13:23:27.720131+00	
00000000-0000-0000-0000-000000000000	bf6b84c4-4ce4-4b0d-877e-5fcadf0d26ce	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 13:23:27.72289+00	
00000000-0000-0000-0000-000000000000	504fa2c0-b17b-45c6-b2ad-e829072f8a2e	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 14:23:12.955279+00	
00000000-0000-0000-0000-000000000000	3dfd17a5-0cbc-4f67-9df0-eaef6fd3cab5	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 14:23:12.958602+00	
00000000-0000-0000-0000-000000000000	490c486f-7479-499b-a519-348a007fe81d	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 15:22:49.472504+00	
00000000-0000-0000-0000-000000000000	40fd776e-9dc0-4f99-9a52-b810e1aafdc9	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 15:22:49.475799+00	
00000000-0000-0000-0000-000000000000	93f7c878-af73-42e9-891a-5445ccdaffbb	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 16:22:21.092797+00	
00000000-0000-0000-0000-000000000000	139ebe47-c117-4e56-8642-a9d612dd1759	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 16:22:21.095004+00	
00000000-0000-0000-0000-000000000000	6765988a-80c9-42bd-ae38-252b10029b58	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 17:21:53.150453+00	
00000000-0000-0000-0000-000000000000	cf0815b8-b395-4ec2-a6ef-1e31153cef66	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 17:21:53.153133+00	
00000000-0000-0000-0000-000000000000	2d099547-e11a-4ead-b044-2cdab0febd13	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 18:21:42.809424+00	
00000000-0000-0000-0000-000000000000	623418d9-d716-4964-95f7-64a0cf54e719	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 18:21:42.811605+00	
00000000-0000-0000-0000-000000000000	0f1f92e2-88d7-4d75-8593-cdc77770fec7	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 19:21:16.911858+00	
00000000-0000-0000-0000-000000000000	8461183a-5c83-4332-8199-f6f5ca5b6305	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 19:21:16.915675+00	
00000000-0000-0000-0000-000000000000	2f349610-50ee-4dd1-9311-2d4f88088598	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 20:20:51.664901+00	
00000000-0000-0000-0000-000000000000	20671988-c24c-4db9-80a8-a9c9256f154b	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 20:20:51.668018+00	
00000000-0000-0000-0000-000000000000	327f92e1-acc2-42f6-a8c1-9e94664919f7	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 21:20:25.098828+00	
00000000-0000-0000-0000-000000000000	1b45293c-0aa5-41a3-94d8-292d90e65e15	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 21:20:25.102436+00	
00000000-0000-0000-0000-000000000000	ae526e70-e633-462f-90c9-704d88be825f	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 22:20:05.752451+00	
00000000-0000-0000-0000-000000000000	4224a251-57e7-468b-acaf-2787aafda72d	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 22:20:05.754985+00	
00000000-0000-0000-0000-000000000000	5e340a37-5f5a-4070-8b27-32ad8d767b11	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 23:19:35.880058+00	
00000000-0000-0000-0000-000000000000	b317a536-fc11-4de6-a2cb-73af10da7917	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-01 23:19:35.884719+00	
00000000-0000-0000-0000-000000000000	ead4404d-1c9d-4ea1-a7ae-b03b136f5b27	{"action":"token_refreshed","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-03 09:32:27.855939+00	
00000000-0000-0000-0000-000000000000	323512f2-6c47-4af5-bdcc-127509f01706	{"action":"token_revoked","actor_id":"2a48727b-7bea-49d2-bcae-f6c70ed8c74a","actor_username":"test5@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-03 09:32:27.877184+00	
00000000-0000-0000-0000-000000000000	ea0201e4-75b4-4602-b16e-17c198a97fb6	{"action":"user_signedup","actor_id":"a7386c56-a39f-4e2c-b25c-4f75f2daa891","actor_username":"ha@example.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-04 12:42:35.692291+00	
00000000-0000-0000-0000-000000000000	6d303605-43af-43a9-a438-191d0436873b	{"action":"login","actor_id":"a7386c56-a39f-4e2c-b25c-4f75f2daa891","actor_username":"ha@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-04 12:42:35.725584+00	
00000000-0000-0000-0000-000000000000	56d1f444-8a3c-45bd-8ff5-05e82d1c144b	{"action":"logout","actor_id":"a7386c56-a39f-4e2c-b25c-4f75f2daa891","actor_username":"ha@example.com","actor_via_sso":false,"log_type":"account"}	2025-08-04 12:43:49.979215+00	
00000000-0000-0000-0000-000000000000	70a85744-d919-4b43-bfe5-ba54dbc8142b	{"action":"login","actor_id":"a7386c56-a39f-4e2c-b25c-4f75f2daa891","actor_username":"ha@example.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-04 12:44:06.908498+00	
00000000-0000-0000-0000-000000000000	03f8e41a-ba9e-446d-80b9-59ca16bd9816	{"action":"user_signedup","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-04 13:33:39.467041+00	
00000000-0000-0000-0000-000000000000	b830cb21-6db2-4ff8-8db5-876ca4968578	{"action":"login","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-04 13:33:39.47582+00	
00000000-0000-0000-0000-000000000000	f01453e5-dd71-4542-832d-b48c9839db28	{"action":"logout","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-08-04 13:40:27.620526+00	
00000000-0000-0000-0000-000000000000	24be7ca1-d193-4595-9663-f3bb01785bf3	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 13:54:13.992905+00	
00000000-0000-0000-0000-000000000000	ea91ce61-4fa0-487e-9ded-17c7417ebc9f	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 13:54:13.996489+00	
00000000-0000-0000-0000-000000000000	b18c7ab4-490b-4c83-988f-51afc3869e0e	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 14:53:46.589534+00	
00000000-0000-0000-0000-000000000000	96548b06-cdad-4e19-859b-4565845c9844	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 14:53:46.592208+00	
00000000-0000-0000-0000-000000000000	b879d215-e6ef-4027-a1e7-db04ccc0785f	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 15:53:16.264154+00	
00000000-0000-0000-0000-000000000000	662e7126-e4b6-4e2c-9ac3-af973424a581	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-04 15:53:16.266965+00	
00000000-0000-0000-0000-000000000000	64df2801-e045-40c0-ad00-5e7aebe10636	{"action":"login","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-04 16:57:09.383229+00	
00000000-0000-0000-0000-000000000000	c1cab614-e346-450e-85ff-46ca570bb969	{"action":"user_signedup","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-05 00:38:58.960059+00	
00000000-0000-0000-0000-000000000000	6b1f1206-ff42-4e1f-bb55-bd7f853be3ec	{"action":"login","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-05 00:38:58.975708+00	
00000000-0000-0000-0000-000000000000	590522a3-e730-407b-8f0a-e393274d1d09	{"action":"token_refreshed","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-05 06:05:20.371755+00	
00000000-0000-0000-0000-000000000000	02972ebf-ebac-4a21-b20c-a246af5eb245	{"action":"token_revoked","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-05 06:05:20.376089+00	
00000000-0000-0000-0000-000000000000	32a5daf6-5b32-436a-bbbe-42238cc8f23b	{"action":"token_refreshed","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 06:15:03.138222+00	
00000000-0000-0000-0000-000000000000	30dee6e6-b889-49b3-aad8-82da69943df4	{"action":"token_revoked","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 06:15:03.153562+00	
00000000-0000-0000-0000-000000000000	2ca328da-5612-4967-8966-7470c26dd818	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 16:42:08.327436+00	
00000000-0000-0000-0000-000000000000	284eb7a3-8333-4dc7-a52e-b1341b85cfb7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 16:42:08.339126+00	
00000000-0000-0000-0000-000000000000	09313003-1d5c-4d27-891b-eb85013f5aff	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 17:41:44.740617+00	
00000000-0000-0000-0000-000000000000	d02ee702-a412-494d-82d6-4434d8ced928	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 17:41:44.743377+00	
00000000-0000-0000-0000-000000000000	1d91158a-5848-4565-aecd-7e786b521942	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 19:10:14.399095+00	
00000000-0000-0000-0000-000000000000	448f5116-0d69-4b50-a39d-0eb8ace22efd	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 19:10:14.404595+00	
00000000-0000-0000-0000-000000000000	da72cf43-eb40-4cbb-aa0d-cec949f51f45	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 20:09:41.503388+00	
00000000-0000-0000-0000-000000000000	bb9a3199-ec5b-4cfe-bc0c-e98a56e7fe86	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-06 20:09:41.506048+00	
00000000-0000-0000-0000-000000000000	44003659-5a5c-4771-823b-de36a33394f4	{"action":"token_refreshed","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-10 21:13:00.983071+00	
00000000-0000-0000-0000-000000000000	6b8924c0-80a7-42f8-8290-c79a2e058f9d	{"action":"token_revoked","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-10 21:13:01.008485+00	
00000000-0000-0000-0000-000000000000	42511c85-fabe-4c66-9046-5ed04cd47aa6	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 07:20:54.311193+00	
00000000-0000-0000-0000-000000000000	0717af67-a9a3-45c0-856f-e22f6f549da7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 07:20:54.328378+00	
00000000-0000-0000-0000-000000000000	ff0d0c12-d8b3-491d-b14b-4d69ce7b5cea	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 08:32:55.507392+00	
00000000-0000-0000-0000-000000000000	d3fe11ef-072c-4f9b-aa4e-bd362a0a7019	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 08:32:55.510172+00	
00000000-0000-0000-0000-000000000000	d20a762d-7f1a-4c37-a3b9-e4e88c375cb3	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 10:23:20.886729+00	
00000000-0000-0000-0000-000000000000	c073db5b-2394-4ef3-90fa-b1df9e5a82e7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 10:23:20.889586+00	
00000000-0000-0000-0000-000000000000	1fdb7236-4e87-4ea2-aa65-2538cc96dda4	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 11:22:57.278707+00	
00000000-0000-0000-0000-000000000000	e4a50abe-5c4e-4a8f-9677-717d0849eeb7	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 11:22:57.28093+00	
00000000-0000-0000-0000-000000000000	a19d1f6d-c43d-4a23-b872-345caf4f48cf	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 12:22:22.774357+00	
00000000-0000-0000-0000-000000000000	048ba6ee-d1f3-4801-b1f9-029c0bceb4e2	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 12:22:22.778295+00	
00000000-0000-0000-0000-000000000000	20a73207-1608-4b14-9d7f-e6069c8ff8c5	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 14:23:52.351508+00	
00000000-0000-0000-0000-000000000000	18705b64-044a-447b-a9f7-e6475aad4b9d	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 14:23:52.355544+00	
00000000-0000-0000-0000-000000000000	6b6af32f-de4f-45e6-b3b5-0d7e82fd4f2c	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 15:24:00.43956+00	
00000000-0000-0000-0000-000000000000	5fbc0aac-9f05-4f63-80ab-7e9aa4011a9d	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 15:24:00.442361+00	
00000000-0000-0000-0000-000000000000	2e5f9164-d15e-4776-aa9c-dc268352f53b	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 16:24:10.176871+00	
00000000-0000-0000-0000-000000000000	4cad91d0-d5cc-4c16-ac89-a3ad217bcd2d	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 16:24:10.179521+00	
00000000-0000-0000-0000-000000000000	a7dbe172-03cd-4736-966b-19c6caf3d177	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 17:24:30.980267+00	
00000000-0000-0000-0000-000000000000	f4e4e5e2-cb20-41ce-8759-b0fa3a1cc7e5	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 17:24:30.982368+00	
00000000-0000-0000-0000-000000000000	eebdb4f7-34a8-4de6-8075-875a1d6ce5f9	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 18:24:44.133128+00	
00000000-0000-0000-0000-000000000000	a3451d10-1616-4ff9-91c6-8e395153bc9d	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 18:24:44.135171+00	
00000000-0000-0000-0000-000000000000	190e4c8c-e654-495f-9e9c-0e20a156bd0b	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 19:24:14.288485+00	
00000000-0000-0000-0000-000000000000	27b71fca-5fb5-4738-8712-4bfcb338d9e2	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-11 19:24:14.291983+00	
00000000-0000-0000-0000-000000000000	2d842ae4-7e95-46b9-8266-6357478236e8	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 16:17:16.495299+00	
00000000-0000-0000-0000-000000000000	13d6965f-b4e8-4178-8411-3eb3a87f33b0	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 16:17:16.514275+00	
00000000-0000-0000-0000-000000000000	5d61b4ab-ab95-4de1-adae-898267223d75	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 17:17:00.415928+00	
00000000-0000-0000-0000-000000000000	4b240f49-a0c1-4f33-ad5e-a9e436fe1a25	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 17:17:00.420823+00	
00000000-0000-0000-0000-000000000000	5151461b-6ee2-47ae-9851-3b4fd7560d4f	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 18:16:50.844337+00	
00000000-0000-0000-0000-000000000000	14b03397-fe76-4176-b6ba-e7eb34db7a68	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 18:16:50.847258+00	
00000000-0000-0000-0000-000000000000	4b0c182b-1125-46c1-b381-2fbfba9e2ff6	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 19:16:41.38461+00	
00000000-0000-0000-0000-000000000000	b721e48a-dc79-4c69-b7c8-ef6e7edfc367	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 19:16:41.387508+00	
00000000-0000-0000-0000-000000000000	16050129-d4b5-45de-bb30-511ed4aa83eb	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 20:16:30.889572+00	
00000000-0000-0000-0000-000000000000	d453422c-7349-464a-80a8-18f3cc16a2fe	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 20:16:30.893057+00	
00000000-0000-0000-0000-000000000000	eb0fe0b7-3d75-48c0-a311-d4df1e2e5f70	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 21:16:21.550103+00	
00000000-0000-0000-0000-000000000000	908be542-6e5c-42a0-892b-ab86ec180686	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-12 21:16:21.554449+00	
00000000-0000-0000-0000-000000000000	8ef7049e-fcb2-4c4b-8c92-be16f1d31333	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 10:31:17.430204+00	
00000000-0000-0000-0000-000000000000	81c238bc-af73-4122-8d15-2e1aaca11c10	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 10:31:17.446265+00	
00000000-0000-0000-0000-000000000000	340d095e-b1ba-423b-99b6-2bc9ddfd1413	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 11:31:05.507538+00	
00000000-0000-0000-0000-000000000000	3b84145f-b625-40f4-ae2e-fc0e3d977682	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 11:31:05.51217+00	
00000000-0000-0000-0000-000000000000	8f45a605-4860-4664-bb92-c93567923c5c	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 12:30:33.024698+00	
00000000-0000-0000-0000-000000000000	ca07af49-cf4f-466b-bd61-373fef850253	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 12:30:33.028849+00	
00000000-0000-0000-0000-000000000000	a9b12eff-b4b8-4fd9-9b25-c72c10d93de6	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 13:35:06.569418+00	
00000000-0000-0000-0000-000000000000	d3d46391-21c9-4a4e-b223-9c932702776a	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 13:35:06.572244+00	
00000000-0000-0000-0000-000000000000	adbfabd5-e84d-4607-a759-9cba3241ac65	{"action":"token_refreshed","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 14:34:54.044145+00	
00000000-0000-0000-0000-000000000000	aa9cc47c-8b12-45d9-ab2f-5b333489ed32	{"action":"token_revoked","actor_id":"ffbcebc8-ae9d-42db-a927-c1f1985d5877","actor_username":"hehe@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-13 14:34:54.047053+00	
00000000-0000-0000-0000-000000000000	663ac46d-1a28-4f87-be18-bf58dd42ce7f	{"action":"user_signedup","actor_id":"45e66ac4-dc43-45c9-910a-e92646926526","actor_username":"yvvonjemymahmajala@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-19 13:36:16.396394+00	
00000000-0000-0000-0000-000000000000	440dfae1-d785-4687-bc55-da9c4ccbcbe1	{"action":"login","actor_id":"45e66ac4-dc43-45c9-910a-e92646926526","actor_username":"yvvonjemymahmajala@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-19 13:36:16.416843+00	
00000000-0000-0000-0000-000000000000	7762194c-fd7d-4d20-9a5e-dcfdefdf7300	{"action":"user_signedup","actor_id":"a13fba99-ccb5-48ad-a2e5-eb379767a5e6","actor_username":"catekim612@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-25 09:19:12.908498+00	
00000000-0000-0000-0000-000000000000	1efe84cf-763c-458d-a64f-d95bca7db844	{"action":"login","actor_id":"a13fba99-ccb5-48ad-a2e5-eb379767a5e6","actor_username":"catekim612@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-25 09:19:12.933271+00	
00000000-0000-0000-0000-000000000000	ddbc1340-0992-42d9-adfa-7335a54f22a5	{"action":"user_signedup","actor_id":"8b8056e7-e34f-474c-986c-ac698413736b","actor_username":"eugenenabiswa@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-25 13:10:05.129439+00	
00000000-0000-0000-0000-000000000000	c73b1251-e9c2-4aa6-ad4a-d62648446ad7	{"action":"login","actor_id":"8b8056e7-e34f-474c-986c-ac698413736b","actor_username":"eugenenabiswa@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-25 13:10:05.142896+00	
00000000-0000-0000-0000-000000000000	43b65c98-2330-4753-8e5c-35ade7f2680a	{"action":"user_repeated_signup","actor_id":"ea361323-5bae-4576-b105-60431ab12a9f","actor_username":"opwapo.design@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-08-25 13:22:39.155143+00	
00000000-0000-0000-0000-000000000000	9ffaa5af-53f7-4427-94f8-00da70e8d1bc	{"action":"user_signedup","actor_id":"43e35414-aa55-4234-a9c1-3e32246ceac0","actor_username":"opwapo.desig@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-25 13:22:49.945422+00	
00000000-0000-0000-0000-000000000000	657155b4-d421-40c6-8f67-00be1dde5c8a	{"action":"login","actor_id":"43e35414-aa55-4234-a9c1-3e32246ceac0","actor_username":"opwapo.desig@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-25 13:22:49.951281+00	
00000000-0000-0000-0000-000000000000	20c21de0-da67-475c-8e72-a78c005869bb	{"action":"login","actor_id":"43e35414-aa55-4234-a9c1-3e32246ceac0","actor_username":"opwapo.desig@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-25 14:12:13.036575+00	
00000000-0000-0000-0000-000000000000	a0ed8f93-ba92-401e-98e4-db1712255613	{"action":"user_signedup","actor_id":"08fa5c97-9a7d-41cf-860c-0b61b0c3c14f","actor_username":"clara.kahurani@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-08-26 13:13:06.493796+00	
00000000-0000-0000-0000-000000000000	ff4c7f51-590b-4a53-9da7-03073f9864ca	{"action":"login","actor_id":"08fa5c97-9a7d-41cf-860c-0b61b0c3c14f","actor_username":"clara.kahurani@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-08-26 13:13:06.52507+00	
00000000-0000-0000-0000-000000000000	e73e1668-ca2b-462d-8562-08178a922df9	{"action":"token_refreshed","actor_id":"43e35414-aa55-4234-a9c1-3e32246ceac0","actor_username":"opwapo.desig@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-26 20:43:24.234459+00	
00000000-0000-0000-0000-000000000000	43104015-3426-4617-a29e-57a37c9ad263	{"action":"token_revoked","actor_id":"43e35414-aa55-4234-a9c1-3e32246ceac0","actor_username":"opwapo.desig@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-08-26 20:43:24.242341+00	
00000000-0000-0000-0000-000000000000	04c88040-2442-4d82-a12e-e49c410138ff	{"action":"user_repeated_signup","actor_id":"835c60e8-fc39-4b88-9cab-adb4e41abb2e","actor_username":"me@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-09-01 12:28:14.55504+00	
00000000-0000-0000-0000-000000000000	c4397a77-277a-4504-9fb4-0bb1d18bda60	{"action":"user_signedup","actor_id":"11bccca2-f952-4946-ac1c-00afcb665580","actor_username":"meme@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-01 12:28:24.221115+00	
00000000-0000-0000-0000-000000000000	bf0d08f6-281c-476c-81d3-6b87dad7ba2f	{"action":"login","actor_id":"11bccca2-f952-4946-ac1c-00afcb665580","actor_username":"meme@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-01 12:28:24.236406+00	
00000000-0000-0000-0000-000000000000	32a097cf-d9b1-4831-af2c-08cc15b025a0	{"action":"user_signedup","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-09-22 10:28:55.250634+00	
00000000-0000-0000-0000-000000000000	df54e9be-2bd2-4275-bdfa-050dabc3e51b	{"action":"login","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-09-22 10:28:55.277128+00	
00000000-0000-0000-0000-000000000000	be31c059-95cf-41b4-8657-d6b707abdd49	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 11:33:39.98245+00	
00000000-0000-0000-0000-000000000000	f7e45840-6c90-4603-9314-f4018e969283	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 11:33:39.99092+00	
00000000-0000-0000-0000-000000000000	5fa719ea-287f-4d58-9b7a-56d1bd9b9403	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 13:20:21.759277+00	
00000000-0000-0000-0000-000000000000	5d42ce7f-1046-4cee-beda-90377034edee	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 13:20:21.761795+00	
00000000-0000-0000-0000-000000000000	a6717072-cce8-40be-96ee-1f41e4e54181	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 16:21:33.83049+00	
00000000-0000-0000-0000-000000000000	b6e8f414-b9b8-45e1-9203-673512b7d965	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 16:21:33.845091+00	
00000000-0000-0000-0000-000000000000	c91d4d56-27ff-4aa2-8fb5-20d936c53544	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 17:21:01.351074+00	
00000000-0000-0000-0000-000000000000	a03dea3c-7c46-401e-9e7d-a571872a8a75	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 17:21:01.35255+00	
00000000-0000-0000-0000-000000000000	017696f0-4fbe-4ec7-af45-d76add3c2c92	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 18:20:31.526381+00	
00000000-0000-0000-0000-000000000000	d73bf57d-bd7c-4fdf-8488-2bd60c939fd6	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 18:20:31.52911+00	
00000000-0000-0000-0000-000000000000	a695de07-4720-42ae-9b8d-0dc9a643cff9	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 19:20:01.221899+00	
00000000-0000-0000-0000-000000000000	64ce715c-f08a-4cf7-83ff-6410f2c8d88a	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 19:20:01.222715+00	
00000000-0000-0000-0000-000000000000	996f59fd-2240-4793-b13d-e5928fddbd0a	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 20:32:02.65481+00	
00000000-0000-0000-0000-000000000000	25d60168-d207-4e6a-82da-a5936fc927ca	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 20:32:02.655687+00	
00000000-0000-0000-0000-000000000000	466323c4-86d6-45ac-9825-dc48a2df57df	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 21:32:26.193449+00	
00000000-0000-0000-0000-000000000000	bfdb81c4-7d87-4ee0-94a1-face3a343f67	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 21:32:26.19771+00	
00000000-0000-0000-0000-000000000000	2ee9b586-5e10-4b36-869f-607040e4ccd7	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 22:39:10.343418+00	
00000000-0000-0000-0000-000000000000	729aaabc-eac5-486d-a671-2ae6b6bcc514	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 22:39:10.346222+00	
00000000-0000-0000-0000-000000000000	b7f45e66-8eb3-4687-997c-9f3be926b2f9	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 23:44:00.994548+00	
00000000-0000-0000-0000-000000000000	7782cea7-f1dc-4398-af2b-91bd69a833f0	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-22 23:44:00.995461+00	
00000000-0000-0000-0000-000000000000	6524fd1b-26dd-43de-ba8d-7183dbfb2ac2	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 10:57:46.059582+00	
00000000-0000-0000-0000-000000000000	15b5cd07-2795-4a72-b231-04fb74829d0e	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 10:57:46.076836+00	
00000000-0000-0000-0000-000000000000	7e0bb1f9-4c82-4e84-8ae8-b0c92cad3a1e	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 11:57:17.004268+00	
00000000-0000-0000-0000-000000000000	8fef10ff-7902-4b06-9f78-05a441783a4d	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 11:57:17.006398+00	
00000000-0000-0000-0000-000000000000	94da0fc5-7bdb-4425-9fe1-bf0bd68d36f1	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 12:56:52.811788+00	
00000000-0000-0000-0000-000000000000	8a087cc7-608b-4a2e-b10d-adf62833bb35	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-09-23 12:56:52.812667+00	
00000000-0000-0000-0000-000000000000	e98718ff-583e-4936-bd20-5a8c78c7e490	{"action":"token_refreshed","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-02 11:54:17.219671+00	
00000000-0000-0000-0000-000000000000	29bc8423-6c4f-4c70-a35a-044d49325150	{"action":"token_revoked","actor_id":"2ce65c9c-3a94-42c7-b603-52b7abfa1858","actor_username":"agwingidaisy@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-02 11:54:17.248593+00	
00000000-0000-0000-0000-000000000000	74b5a0cb-f5c3-490b-a08c-e3d956870a0e	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 14:50:09.144165+00	
00000000-0000-0000-0000-000000000000	cfe5d454-5055-4a98-aed2-e87b151b25c7	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 14:50:09.161802+00	
00000000-0000-0000-0000-000000000000	d9e189e1-cd35-4c2e-a167-78022b9a7dbc	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 09:31:59.092933+00	
00000000-0000-0000-0000-000000000000	1ee5b17b-d200-49ab-8654-76d475c624a8	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 09:31:59.113378+00	
00000000-0000-0000-0000-000000000000	1c92411d-209b-46a2-ba37-a5b38e7849a7	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 11:09:07.243002+00	
00000000-0000-0000-0000-000000000000	fe2e68eb-cb89-48ee-87c0-983715b85136	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 11:09:07.249554+00	
00000000-0000-0000-0000-000000000000	401d4e0b-b44d-496e-8f65-27e3526f899c	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 12:14:08.039508+00	
00000000-0000-0000-0000-000000000000	9b8ab3cc-10b2-4d5e-8f67-1dbe91a5a45b	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 12:14:08.042526+00	
00000000-0000-0000-0000-000000000000	bc287eea-1129-4bad-83d1-f6458b41586b	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 13:13:40.192515+00	
00000000-0000-0000-0000-000000000000	2ecb3341-f4fb-48ef-a9a6-00e853860d7a	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 13:13:40.196139+00	
00000000-0000-0000-0000-000000000000	ea065f95-7e64-4fc0-8a0a-d2f06339503a	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:18:12.980853+00	
00000000-0000-0000-0000-000000000000	2b15a189-72b1-4bda-af0f-071aeded8fce	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:18:12.989385+00	
00000000-0000-0000-0000-000000000000	336d59da-5bed-4dc5-a2cb-aefb39cf3e18	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 15:57:16.417515+00	
00000000-0000-0000-0000-000000000000	07444f07-e1aa-42cd-a5d3-366cb4ce41be	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 15:57:16.423424+00	
00000000-0000-0000-0000-000000000000	53e326ec-5935-4947-8566-93d55ecc79ba	{"action":"user_signedup","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-31 07:56:22.046386+00	
00000000-0000-0000-0000-000000000000	6efc7428-5d70-438a-94cb-059e7508256e	{"action":"login","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:56:22.055703+00	
00000000-0000-0000-0000-000000000000	c89ca4be-3c39-4cfa-ae7e-4ce2f1c28e06	{"action":"user_signedup","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-31 09:28:09.375419+00	
00000000-0000-0000-0000-000000000000	f1c667c4-efb4-428b-a789-09b200cd5f78	{"action":"login","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 09:28:09.385511+00	
00000000-0000-0000-0000-000000000000	7183c17e-a331-460a-b727-51579023795d	{"action":"token_refreshed","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 13:33:28.451683+00	
00000000-0000-0000-0000-000000000000	019e3dd3-9feb-41d9-8b68-7cacc3e92e83	{"action":"token_revoked","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 13:33:28.453283+00	
00000000-0000-0000-0000-000000000000	73027d18-9e0c-4d06-a59d-e1ef4d9ded4e	{"action":"token_refreshed","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 16:33:15.819454+00	
00000000-0000-0000-0000-000000000000	82e5a682-29ee-4f59-9563-711ba169f626	{"action":"token_revoked","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 16:33:15.821225+00	
00000000-0000-0000-0000-000000000000	d45a9f25-7bbf-4ee8-b5f2-b629442a5c38	{"action":"token_refreshed","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 09:59:41.286403+00	
00000000-0000-0000-0000-000000000000	d91b2e35-4dfa-46c4-bf9f-e543e0642287	{"action":"token_revoked","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 09:59:41.295376+00	
00000000-0000-0000-0000-000000000000	ead72cf7-f615-4a7a-8c18-cb370d75dee5	{"action":"token_refreshed","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 13:59:48.000079+00	
00000000-0000-0000-0000-000000000000	5968b78f-0c9f-4548-b56d-ebd5aeb337b1	{"action":"token_revoked","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 13:59:48.006291+00	
00000000-0000-0000-0000-000000000000	df11a3d6-1639-417f-96f4-f082d53fb558	{"action":"token_refreshed","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 14:11:32.515033+00	
00000000-0000-0000-0000-000000000000	da4556b9-7200-476e-9a12-2fbfc644a998	{"action":"token_revoked","actor_id":"0c0104ab-723d-45c1-9603-a9f12aeaab20","actor_username":"abc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 14:11:32.517773+00	
00000000-0000-0000-0000-000000000000	430ea0f0-8976-4041-bb31-2e10647eab19	{"action":"token_refreshed","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 17:20:42.783572+00	
00000000-0000-0000-0000-000000000000	91521a85-4ad7-45a9-8c05-120d7eda9660	{"action":"token_revoked","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 17:20:42.802328+00	
00000000-0000-0000-0000-000000000000	c3629aa5-2326-48ba-96ff-764e2a840332	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 08:03:53.928546+00	
00000000-0000-0000-0000-000000000000	c5326d85-13fe-4ed0-ad25-74f2dbcf4d25	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 08:03:53.945719+00	
00000000-0000-0000-0000-000000000000	8f5c1b1c-15b3-45de-9542-049068adbde7	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 09:54:10.956834+00	
00000000-0000-0000-0000-000000000000	9cbc2e92-9173-4f29-8a66-ef73854f1a0c	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 09:54:10.959661+00	
00000000-0000-0000-0000-000000000000	353ea4bb-1254-4c32-99a5-a50533dee8dc	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 11:15:33.979436+00	
00000000-0000-0000-0000-000000000000	4c03bcbb-faf1-47f1-9254-676d03f8c25c	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 11:15:33.981421+00	
00000000-0000-0000-0000-000000000000	78325a93-b03a-4b77-9620-87450bdbf0f5	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 12:47:20.945185+00	
00000000-0000-0000-0000-000000000000	3de2b891-80b7-4699-9595-a4c875c5764d	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 12:47:20.946704+00	
00000000-0000-0000-0000-000000000000	aeddf96c-f48e-4232-8e4c-79ce897a31e8	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 10:36:42.320087+00	
00000000-0000-0000-0000-000000000000	a19d1415-5276-4fb1-8864-3824f0f25159	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 10:36:42.337292+00	
00000000-0000-0000-0000-000000000000	75b80b63-21d9-4bb8-b78c-e3ba90b7c730	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 11:36:52.119329+00	
00000000-0000-0000-0000-000000000000	cb0e8d2d-98da-4834-aaf6-fdb8c3b66438	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 11:36:52.123885+00	
00000000-0000-0000-0000-000000000000	c332f050-730c-4fd4-88e7-b2bd564ddd85	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 12:36:47.345854+00	
00000000-0000-0000-0000-000000000000	0a04a65b-141c-43ac-905a-2d3d72d2ad3c	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 12:36:47.346722+00	
00000000-0000-0000-0000-000000000000	3e63b249-5389-4ffe-897f-aae52c1a7352	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 13:51:20.562182+00	
00000000-0000-0000-0000-000000000000	1c18e080-f57a-4475-a640-507f5b464a9a	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 13:51:20.563152+00	
00000000-0000-0000-0000-000000000000	1089fb14-03a3-4559-8942-2032d31ee188	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:05:58.651504+00	
00000000-0000-0000-0000-000000000000	f32c8666-87e3-4cf3-872c-53ecf5efba64	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:05:58.662806+00	
00000000-0000-0000-0000-000000000000	a26c89f7-7461-4b06-9107-e387818693ae	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 13:05:24.770961+00	
00000000-0000-0000-0000-000000000000	d400cb29-c369-4acb-b76c-f63a9f5c451d	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 13:05:24.776417+00	
00000000-0000-0000-0000-000000000000	72130470-f08e-49ca-9994-74b9f398027e	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 14:05:01.99618+00	
00000000-0000-0000-0000-000000000000	4c9ef4cd-bf7e-476f-8c51-5f10ab7544af	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 14:05:02.006511+00	
00000000-0000-0000-0000-000000000000	a1b384d6-c363-48a6-bfff-a8d7b65cde87	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 15:16:42.987221+00	
00000000-0000-0000-0000-000000000000	d1130a52-d8c9-45aa-a802-b2fcaba86054	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 15:16:42.990782+00	
00000000-0000-0000-0000-000000000000	eb668f7d-60dd-4111-b7a4-60d12fb76d1c	{"action":"token_refreshed","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 16:16:10.833381+00	
00000000-0000-0000-0000-000000000000	59b0cc7f-55d9-451d-8866-7b526e6338e3	{"action":"token_revoked","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 16:16:10.842663+00	
00000000-0000-0000-0000-000000000000	9f8f578a-709a-4db3-81ad-9d854b8e6f0f	{"action":"logout","actor_id":"1225139c-666f-434a-aabc-48e9d40003af","actor_username":"her@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 16:26:54.320204+00	
00000000-0000-0000-0000-000000000000	4e41457d-e9f6-4541-9d65-c09c290e56f8	{"action":"user_signedup","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-09 16:33:46.507656+00	
00000000-0000-0000-0000-000000000000	355ae97d-b198-4199-89e3-1c406a23157e	{"action":"login","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 16:33:46.514583+00	
00000000-0000-0000-0000-000000000000	0623ea30-360d-497a-a1db-f30a371602d4	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 20:59:23.990635+00	
00000000-0000-0000-0000-000000000000	90621525-0c2e-4fa3-848d-5257e7ee50f5	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 20:59:23.998596+00	
00000000-0000-0000-0000-000000000000	7b06e12f-34d6-4d7b-a224-de88d9249afa	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:01:01.427648+00	
00000000-0000-0000-0000-000000000000	539ff519-e8ec-40a1-a889-9d8e0544563a	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:01:01.432262+00	
00000000-0000-0000-0000-000000000000	841bd945-f8fe-4bbc-a1e3-62951ed34542	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 23:12:29.30081+00	
00000000-0000-0000-0000-000000000000	4aad9ac4-0f8d-4c1e-b0d8-9bbdb952e966	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 23:12:29.310977+00	
00000000-0000-0000-0000-000000000000	baadca56-7ef6-4ab3-85c9-bbdeffce91e3	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 00:32:18.43155+00	
00000000-0000-0000-0000-000000000000	ecb1e2b1-8519-4559-8d3b-444d82af5229	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 00:32:18.433185+00	
00000000-0000-0000-0000-000000000000	564442cd-e914-4fa7-beaf-4b2e33d06033	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 01:36:18.831+00	
00000000-0000-0000-0000-000000000000	b28bdf68-7604-4768-9e8d-9eed42e324f5	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 01:36:18.839399+00	
00000000-0000-0000-0000-000000000000	4cb6bd65-3f4d-4b89-a387-2d5ff31a4688	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 02:48:11.717757+00	
00000000-0000-0000-0000-000000000000	95535428-843c-4958-a501-baf643f80718	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 02:48:11.72076+00	
00000000-0000-0000-0000-000000000000	d3b0a504-7a83-4aa7-becc-8dca6e7795ea	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 04:44:54.190731+00	
00000000-0000-0000-0000-000000000000	4d0ed4f9-9919-4af8-8c5b-1762fb038408	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 04:44:54.192317+00	
00000000-0000-0000-0000-000000000000	1ab9d0ac-74e0-457d-a143-ef9d0bdace47	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 04:44:55.501086+00	
00000000-0000-0000-0000-000000000000	d22b1562-72c5-48da-8c4d-09a3bfbe3a21	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 11:26:29.559406+00	
00000000-0000-0000-0000-000000000000	25d3ad1e-281a-47f0-b8a4-391cdc4cb161	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 11:26:29.563941+00	
00000000-0000-0000-0000-000000000000	5e5cb15f-d4a7-4997-af02-0fca4fd181c7	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 12:25:52.189522+00	
00000000-0000-0000-0000-000000000000	add16809-03d4-4c29-be48-bcc8d5c0a712	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 12:25:52.198766+00	
00000000-0000-0000-0000-000000000000	89a9292f-2c55-405c-9f34-fc94d4c67499	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 13:25:27.05727+00	
00000000-0000-0000-0000-000000000000	c124449a-6a60-499d-bc37-e161c9e3fcbe	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 13:25:27.072806+00	
00000000-0000-0000-0000-000000000000	a9d6b933-966c-4a11-9ae4-d350c56675d6	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 15:02:17.399916+00	
00000000-0000-0000-0000-000000000000	dd9ad5e5-17f5-45b1-893d-035d49f1211d	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 15:02:17.421286+00	
00000000-0000-0000-0000-000000000000	6445fb2f-4e19-47f6-8c5c-b161bd1558f7	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 16:02:41.744413+00	
00000000-0000-0000-0000-000000000000	f943b13c-0a3d-4a68-8f22-b65d823cc5ad	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 16:02:41.756376+00	
00000000-0000-0000-0000-000000000000	93b0011b-8ea1-4497-9198-1a2df2d785ec	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 17:07:43.471313+00	
00000000-0000-0000-0000-000000000000	76b2aa73-6d41-42c9-9be7-3d59a71803b5	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 17:07:43.493155+00	
00000000-0000-0000-0000-000000000000	7b351e47-752f-43aa-800d-f3f33ff97d04	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 18:07:13.846927+00	
00000000-0000-0000-0000-000000000000	5c3f817b-6ee2-4aab-beb6-6b2fcd45f979	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 19:16:41.384121+00	
00000000-0000-0000-0000-000000000000	bb4bcf9f-d929-4921-96d8-49a209349fad	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 19:16:41.401481+00	
00000000-0000-0000-0000-000000000000	0bbb5da5-ec59-4ecc-a4a5-185daa167354	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 20:16:09.740049+00	
00000000-0000-0000-0000-000000000000	08c7b668-1b99-4d25-8fd8-fa0c9eed211a	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 20:16:09.750439+00	
00000000-0000-0000-0000-000000000000	7e37182f-bf8a-40fd-8874-8b72bf2ae43a	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 21:15:38.934257+00	
00000000-0000-0000-0000-000000000000	4353fa9a-5c61-45f3-b398-9384a7dfc826	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 21:15:38.950962+00	
00000000-0000-0000-0000-000000000000	b18d4f06-6706-40ad-bb84-e4393999ab66	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 23:26:20.738859+00	
00000000-0000-0000-0000-000000000000	a7f0798d-e1d7-4148-83a8-6064075c78e0	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 23:26:20.757513+00	
00000000-0000-0000-0000-000000000000	5e9f597c-2d32-47dd-96ca-58bf15a9fb1f	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 00:26:29.779307+00	
00000000-0000-0000-0000-000000000000	502dfe97-95f1-4247-8e67-2ca2f4d14336	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 00:26:29.794235+00	
00000000-0000-0000-0000-000000000000	6640ebf2-c588-4524-9c85-65e2257c3392	{"action":"token_refreshed","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 01:26:25.657588+00	
00000000-0000-0000-0000-000000000000	afea649b-c6a9-4a7a-9c12-0842ecf5f863	{"action":"token_revoked","actor_id":"a1d57ac1-f3e1-4c99-a01b-d494d6e76414","actor_username":"s@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 01:26:25.669345+00	
00000000-0000-0000-0000-000000000000	1023c38f-6db2-49ac-8dd5-fac71fb97a46	{"action":"token_refreshed","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 05:00:44.779583+00	
00000000-0000-0000-0000-000000000000	940643c0-38d6-487a-a2bd-b8cbdc1789bf	{"action":"token_revoked","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 05:00:44.806518+00	
00000000-0000-0000-0000-000000000000	05b0d2dd-e37e-4532-a33b-d974d0278cb9	{"action":"token_refreshed","actor_id":"65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e","actor_username":"stephenmushiyi803@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-11 05:02:39.553335+00	
00000000-0000-0000-0000-000000000000	79cda574-a044-400f-9aba-a7e5c6b303e4	{"action":"user_signedup","actor_id":"11c89725-d719-4aa3-b1d6-d5808e415385","actor_username":"user@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 09:33:24.084077+00	
00000000-0000-0000-0000-000000000000	15101cff-4175-48b5-a202-f5a6a01cb1f0	{"action":"login","actor_id":"11c89725-d719-4aa3-b1d6-d5808e415385","actor_username":"user@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 09:33:24.107+00	
00000000-0000-0000-0000-000000000000	8249f50e-cd50-4d10-9b3a-9ab68c9136de	{"action":"user_signedup","actor_id":"f05b7d85-385c-451b-915b-336bb7611aa3","actor_username":"user2@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 10:16:59.391583+00	
00000000-0000-0000-0000-000000000000	20b045bb-8619-4201-aef8-8a8f5941d8ff	{"action":"login","actor_id":"f05b7d85-385c-451b-915b-336bb7611aa3","actor_username":"user2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 10:16:59.415634+00	
00000000-0000-0000-0000-000000000000	07cfab17-47af-4e37-985b-afb8e6aa3b2d	{"action":"user_signedup","actor_id":"7307b2d1-0767-44b9-b1e8-a59e222ffa2a","actor_username":"user3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 10:21:08.186271+00	
00000000-0000-0000-0000-000000000000	df4f2c83-123d-4f85-a3c3-69e97c052b74	{"action":"login","actor_id":"7307b2d1-0767-44b9-b1e8-a59e222ffa2a","actor_username":"user3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 10:21:08.193795+00	
00000000-0000-0000-0000-000000000000	94bf657e-913e-4fde-8818-1f42f8bd8dd7	{"action":"user_signedup","actor_id":"2c738a07-f482-4f35-99e3-0de3ef3798a9","actor_username":"oppo@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 10:58:06.742799+00	
00000000-0000-0000-0000-000000000000	a8c2cceb-f044-454e-941e-6d89716a7b1f	{"action":"login","actor_id":"2c738a07-f482-4f35-99e3-0de3ef3798a9","actor_username":"oppo@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 10:58:06.76542+00	
00000000-0000-0000-0000-000000000000	bd8fb762-cce3-4276-b851-77ca0634944e	{"action":"user_repeated_signup","actor_id":"7307b2d1-0767-44b9-b1e8-a59e222ffa2a","actor_username":"user3@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-02 11:06:54.970836+00	
00000000-0000-0000-0000-000000000000	37be2f53-81ce-476a-845c-9c26fcbc5a7e	{"action":"user_signedup","actor_id":"d202bc66-2e79-4bd8-a630-bcb6df1e09ef","actor_username":"user4@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 11:07:16.114429+00	
00000000-0000-0000-0000-000000000000	439575c7-79a3-48ca-a14d-36d579c9e1dc	{"action":"login","actor_id":"d202bc66-2e79-4bd8-a630-bcb6df1e09ef","actor_username":"user4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 11:07:16.127111+00	
00000000-0000-0000-0000-000000000000	20e5b22c-2626-4263-9b57-e03c6d4f2586	{"action":"user_signedup","actor_id":"8f57cb78-e830-47f6-a492-e590a63f834d","actor_username":"user5@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 11:13:33.008939+00	
00000000-0000-0000-0000-000000000000	9f0733cc-aa9e-4d44-add5-59040493d08c	{"action":"login","actor_id":"8f57cb78-e830-47f6-a492-e590a63f834d","actor_username":"user5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 11:13:33.023814+00	
00000000-0000-0000-0000-000000000000	f4670404-ba80-4fee-a40c-76434d64ffa9	{"action":"user_signedup","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-02 12:07:36.570367+00	
00000000-0000-0000-0000-000000000000	57f8b49f-9e41-4b68-9c49-ef5d8a3e6afe	{"action":"login","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-02 12:07:36.586003+00	
00000000-0000-0000-0000-000000000000	eaaf7eea-8a91-4106-98ed-4451a6dcd516	{"action":"token_refreshed","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 13:07:11.29888+00	
00000000-0000-0000-0000-000000000000	58e266d6-f7ca-4938-a267-cc6dcba8fb54	{"action":"token_revoked","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 13:07:11.316525+00	
00000000-0000-0000-0000-000000000000	d0c82169-916a-43e9-950c-f49d05cde557	{"action":"token_refreshed","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 14:06:41.679648+00	
00000000-0000-0000-0000-000000000000	73d9ab4f-173b-49ab-bcca-d3a7120298da	{"action":"token_revoked","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 14:06:41.703256+00	
00000000-0000-0000-0000-000000000000	abe3c758-b718-4246-ba86-f17f0ee2ed86	{"action":"token_refreshed","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 15:16:46.445705+00	
00000000-0000-0000-0000-000000000000	1401e2f9-1cc6-4802-8d57-493e9f224d2f	{"action":"token_revoked","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 15:16:46.466246+00	
00000000-0000-0000-0000-000000000000	4845af4f-9e6f-4390-a6c7-336775918ba6	{"action":"token_refreshed","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 16:16:17.679277+00	
00000000-0000-0000-0000-000000000000	139521ba-58a6-4506-95ae-0f9131c43659	{"action":"token_revoked","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-02 16:16:17.699943+00	
00000000-0000-0000-0000-000000000000	dcaba420-a909-4bd0-96ac-48ef1de94da8	{"action":"user_signedup","actor_id":"bdf11f2a-687c-4e37-890a-8e7794e0e9ec","actor_username":"kri@stin.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-05 10:14:16.849752+00	
00000000-0000-0000-0000-000000000000	787be067-3362-42c3-892f-978ac6173870	{"action":"login","actor_id":"bdf11f2a-687c-4e37-890a-8e7794e0e9ec","actor_username":"kri@stin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-05 10:14:16.890511+00	
00000000-0000-0000-0000-000000000000	686ad451-8fe9-417f-a6a9-eb1d9d79bf9f	{"action":"token_refreshed","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 13:36:16.783766+00	
00000000-0000-0000-0000-000000000000	2ad2c6e2-5dc2-4a3d-9c2c-3e9fbf5a6199	{"action":"token_revoked","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 13:36:16.803282+00	
00000000-0000-0000-0000-000000000000	72843662-0679-457c-bb89-194ced959f6f	{"action":"logout","actor_id":"2c22e4af-e515-4f40-b2b2-f743f29eb7d5","actor_username":"user6@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-06 13:37:09.020949+00	
00000000-0000-0000-0000-000000000000	d619a7ad-900b-413a-95a7-8939a2fb83a3	{"action":"user_signedup","actor_id":"593b4915-f840-4faf-b8ea-5639581e5ba6","actor_username":"testuser@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 13:37:52.828837+00	
00000000-0000-0000-0000-000000000000	1ad6112b-2304-4583-be7b-6b75f163008c	{"action":"login","actor_id":"593b4915-f840-4faf-b8ea-5639581e5ba6","actor_username":"testuser@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 13:37:52.835705+00	
00000000-0000-0000-0000-000000000000	0b97e559-03b2-4f2e-a38d-fbefab821630	{"action":"token_refreshed","actor_id":"593b4915-f840-4faf-b8ea-5639581e5ba6","actor_username":"testuser@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 15:05:47.048055+00	
00000000-0000-0000-0000-000000000000	1f699409-a40f-4354-a96c-f2caf6b16900	{"action":"token_revoked","actor_id":"593b4915-f840-4faf-b8ea-5639581e5ba6","actor_username":"testuser@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 15:05:47.067609+00	
00000000-0000-0000-0000-000000000000	271e83c5-5063-4467-9f2c-6d43c3e59559	{"action":"user_repeated_signup","actor_id":"57693c4b-8462-4c29-ad82-9103d5b3e33c","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-06 16:37:11.621762+00	
00000000-0000-0000-0000-000000000000	ab62aac9-1e3c-41bb-9682-2b91489ea1a0	{"action":"user_signedup","actor_id":"74e9227f-a16f-4af0-be98-176cf7727933","actor_username":"test3@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 16:37:18.542161+00	
00000000-0000-0000-0000-000000000000	f5c54a9e-93b6-437a-a970-3955f61763f8	{"action":"login","actor_id":"74e9227f-a16f-4af0-be98-176cf7727933","actor_username":"test3@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 16:37:18.550604+00	
00000000-0000-0000-0000-000000000000	8ccbbb94-1531-420c-a7c7-25583be1f787	{"action":"logout","actor_id":"74e9227f-a16f-4af0-be98-176cf7727933","actor_username":"test3@gmail.com","actor_via_sso":false,"log_type":"account"}	2026-02-06 16:46:26.448478+00	
00000000-0000-0000-0000-000000000000	4dc5aa00-7466-4610-9912-f76cf1f61ce5	{"action":"user_signedup","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 17:04:00.443017+00	
00000000-0000-0000-0000-000000000000	327ac4cf-e3d2-4e19-972e-6d0d85c30d5e	{"action":"login","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 17:04:00.455733+00	
00000000-0000-0000-0000-000000000000	ba7588be-fd2f-4c91-adaa-1f9e7e0cf0f3	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:10:55.961106+00	
00000000-0000-0000-0000-000000000000	46e22437-0b9e-48bc-a5ec-0d526d95bd11	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 18:10:55.978577+00	
00000000-0000-0000-0000-000000000000	fa279687-a34a-4770-9502-766bfc595b83	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 19:10:34.992519+00	
00000000-0000-0000-0000-000000000000	510f2f1e-6b62-44de-8112-bacb5c62775f	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 19:10:35.010344+00	
00000000-0000-0000-0000-000000000000	fe6dab03-4ad5-424e-bf00-6fb2c2f6f19b	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:14:44.77409+00	
00000000-0000-0000-0000-000000000000	76995385-220c-45b9-b18d-4d2c09763eda	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 20:14:44.794511+00	
00000000-0000-0000-0000-000000000000	db791abe-b4f0-4500-9bb9-8278adc05569	{"action":"user_signedup","actor_id":"fe953905-9ef8-4c6d-be09-442444285581","actor_username":"brandononyango9@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-06 21:16:41.117838+00	
00000000-0000-0000-0000-000000000000	239a7c51-b182-49e4-83c1-ca7dff611d1c	{"action":"login","actor_id":"fe953905-9ef8-4c6d-be09-442444285581","actor_username":"brandononyango9@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-06 21:16:41.141875+00	
00000000-0000-0000-0000-000000000000	6f0328c5-5480-4b4c-8302-c94ed53cdbba	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 21:58:48.48026+00	
00000000-0000-0000-0000-000000000000	cf276916-90b6-4c7b-ac17-af9d2703b178	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 21:58:48.498732+00	
00000000-0000-0000-0000-000000000000	6d72ffb5-2a18-43cd-acad-ad85dcd71070	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:58:14.014953+00	
00000000-0000-0000-0000-000000000000	c4eea174-7432-47c3-ae09-b9e217218a43	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-06 22:58:14.032301+00	
00000000-0000-0000-0000-000000000000	21c0fa24-13a3-4baa-b681-64efcd728b4d	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 00:35:08.536991+00	
00000000-0000-0000-0000-000000000000	f2578f56-0142-4151-a136-bac34dcb4cf5	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 00:35:08.562415+00	
00000000-0000-0000-0000-000000000000	6ae6fc89-7409-435c-9c81-b065e169061c	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 12:11:45.026992+00	
00000000-0000-0000-0000-000000000000	9b326d76-c3ce-4f4f-b44d-c36ccf779267	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 12:11:45.042261+00	
00000000-0000-0000-0000-000000000000	239633e2-eb6e-47e7-b24e-0f0b713f32d9	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 13:11:08.572133+00	
00000000-0000-0000-0000-000000000000	8df9d9df-193e-41d9-8d26-1d035908c434	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-07 13:11:08.586228+00	
00000000-0000-0000-0000-000000000000	b1af2fac-a3d8-4ca7-8e4c-6b8b0e5cd8fa	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 10:44:27.951784+00	
00000000-0000-0000-0000-000000000000	f1fa16e2-d6de-4361-88b6-d3291008e6bc	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 10:44:27.973214+00	
00000000-0000-0000-0000-000000000000	21e198ce-8a62-4682-b947-0c04bb020b24	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 11:45:54.879126+00	
00000000-0000-0000-0000-000000000000	e537dcca-941c-4d2a-beb4-2d2fc72dbf51	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 11:45:54.896992+00	
00000000-0000-0000-0000-000000000000	a6b683e6-057f-40ae-a6f5-3ed7e890937d	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 12:45:25.789246+00	
00000000-0000-0000-0000-000000000000	5011e1bc-bcca-478b-8984-94e6f0f5384a	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 12:45:25.804239+00	
00000000-0000-0000-0000-000000000000	1745024f-501a-49fb-bd4d-302bffe4e07f	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 13:45:03.661783+00	
00000000-0000-0000-0000-000000000000	9d879826-eba2-4e20-83e0-9395ed6c8385	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 13:45:03.674658+00	
00000000-0000-0000-0000-000000000000	e29031b8-16c0-450f-a7bf-9f691e537d7c	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 14:44:29.798395+00	
00000000-0000-0000-0000-000000000000	d24e696a-2bfc-42b7-86c9-d201258b33dc	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 14:44:29.819497+00	
00000000-0000-0000-0000-000000000000	c2e8072c-1053-489d-9fc9-a8c7c4f784ba	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 15:43:58.845647+00	
00000000-0000-0000-0000-000000000000	1e3bb570-46dc-4141-ab7a-9019ca9a162a	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 15:43:58.863073+00	
00000000-0000-0000-0000-000000000000	0beddc3f-c468-452c-b9bc-85457398e2e7	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 16:43:48.185142+00	
00000000-0000-0000-0000-000000000000	e5011bad-b189-49ce-81f1-a7dfdd1da9bd	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 16:43:48.198416+00	
00000000-0000-0000-0000-000000000000	bfe72a68-1b36-4468-8c1f-2fe1e55feefb	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 17:43:23.827703+00	
00000000-0000-0000-0000-000000000000	5925de04-9f65-40ad-9023-663a9daec1a7	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 17:43:23.849581+00	
00000000-0000-0000-0000-000000000000	495281a8-d3ae-49ab-b134-c31a986a7ada	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 21:46:53.16746+00	
00000000-0000-0000-0000-000000000000	5bf40cd0-fc43-4178-a29f-87f9cc802292	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-08 21:46:53.191779+00	
00000000-0000-0000-0000-000000000000	a716ea8e-2881-4c52-9825-072e76fe43f8	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 04:26:36.720213+00	
00000000-0000-0000-0000-000000000000	40d2a54c-bc60-4cd4-99a5-2b1765e80f10	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 04:26:36.744712+00	
00000000-0000-0000-0000-000000000000	631a185b-ef85-491b-96c6-6bee3973bee0	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 07:40:24.130765+00	
00000000-0000-0000-0000-000000000000	015a2515-2e3a-4652-85ff-553365d699d5	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 07:40:24.14787+00	
00000000-0000-0000-0000-000000000000	80817d9b-27eb-451e-b614-ee49a4a23fbb	{"action":"token_refreshed","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 08:39:54.947974+00	
00000000-0000-0000-0000-000000000000	b0f821c5-8815-4a7c-bf1d-73722f3b69d0	{"action":"token_revoked","actor_id":"7720f8b9-5587-4fac-a275-3c59cf19f5d3","actor_username":"tester@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-09 08:39:54.967013+00	
00000000-0000-0000-0000-000000000000	4805fdf4-6498-40d9-82f6-010ad2809f23	{"action":"user_repeated_signup","actor_id":"8c23da63-3d8b-4999-af4c-d28f8fa6f3de","actor_username":"xtineopwapo@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-10 10:54:13.095619+00	
00000000-0000-0000-0000-000000000000	264c5fcc-7d28-4a28-afcb-f4333723228a	{"action":"user_repeated_signup","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-10 13:35:45.780766+00	
00000000-0000-0000-0000-000000000000	daf329c6-77a3-4a53-b311-5670ba25ac57	{"action":"user_repeated_signup","actor_id":"89f818c2-c79f-4eb1-b931-a2029983f13f","actor_username":"christine@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2026-02-12 10:41:17.6368+00	
00000000-0000-0000-0000-000000000000	c821d4bc-7c8a-4b51-b483-eed382e657fd	{"action":"user_signedup","actor_id":"749539bf-ce98-420c-8093-d3ea0de95610","actor_username":"christine2@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-02-12 10:41:28.226822+00	
00000000-0000-0000-0000-000000000000	d37f55fb-b4d9-4ef1-ac1b-4796f93a3b36	{"action":"login","actor_id":"749539bf-ce98-420c-8093-d3ea0de95610","actor_username":"christine2@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-12 10:41:28.25107+00	
00000000-0000-0000-0000-000000000000	29d131fe-c055-42ea-9027-5cc418c5680f	{"action":"token_refreshed","actor_id":"749539bf-ce98-420c-8093-d3ea0de95610","actor_username":"christine2@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 11:48:06.540463+00	
00000000-0000-0000-0000-000000000000	5ffa457a-9ea3-4780-8e93-563b5d710aee	{"action":"token_revoked","actor_id":"749539bf-ce98-420c-8093-d3ea0de95610","actor_username":"christine2@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-02-12 11:48:06.56195+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
8e98a836-89a8-48b2-9dda-014312cbfd14	8c23da63-3d8b-4999-af4c-d28f8fa6f3de	d563cbfe-e034-403f-ae77-9d9adafd5948	s256	-3nLKlI7X7Xo-6i6-bVRjPmV9Xb08bA9rvhyYQmXnK0	email			2025-07-09 12:49:11.361243+00	2025-07-09 12:50:55.249161+00	email/signup	2025-07-09 12:50:55.249125+00	\N	\N	\N	\N	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	57693c4b-8462-4c29-ad82-9103d5b3e33c	authenticated	authenticated	test@gmail.com	$2a$10$sDo/ktTH5ZgbXV8DcRA9pOZs.HGIQvr/C.WgQfpbA8Lm5wRyz.QRa	2025-07-19 12:08:43.261339+00	\N		\N		\N			\N	2025-07-19 13:08:21.72529+00	{"provider": "email", "providers": ["email"]}	{"sub": "57693c4b-8462-4c29-ad82-9103d5b3e33c", "email": "test@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-19 12:08:43.242265+00	2025-07-21 07:46:30.838344+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2	authenticated	authenticated	heee@gmail.com	$2a$10$N..60mWfUSZNpG.5BkOww.wwWYnmMxDyZ0MPcfjCQ4OgKm5aKHC/y	2025-07-31 00:14:46.48511+00	\N		\N		\N			\N	2025-07-31 00:14:46.495715+00	{"provider": "email", "providers": ["email"]}	{"sub": "e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2", "email": "heee@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-31 00:14:46.459415+00	2025-07-31 00:14:46.509251+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e78ba560-9542-4f67-8dc9-f2823b0f13d2	authenticated	authenticated	wewe@gmail.com	$2a$10$RKz2M8byaWP0/4yAGXg2hOb86Cy4ODNu6n2SxHB0JhCD9.N4uYsxe	2025-07-28 09:03:17.985368+00	\N		\N		\N			\N	2025-07-28 09:03:17.990386+00	{"provider": "email", "providers": ["email"]}	{"sub": "e78ba560-9542-4f67-8dc9-f2823b0f13d2", "email": "wewe@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-28 09:03:17.974204+00	2025-07-28 09:03:17.995199+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8c23da63-3d8b-4999-af4c-d28f8fa6f3de	authenticated	authenticated	xtineopwapo@gmail.com	$2a$10$zbIDb8IRiv5NtBLM7.kOzuAS.oDYLzYNkqVgtsu7iOk6n4ZH6.8Vm	2025-07-09 12:50:55.24297+00	\N		2025-07-09 12:49:11.374411+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "8c23da63-3d8b-4999-af4c-d28f8fa6f3de", "email": "xtineopwapo@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-09 12:49:11.311604+00	2025-07-09 12:50:55.246209+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	46052f9c-ba77-46fe-a5f2-6195c2f2ae0b	authenticated	authenticated	opwapochristine@gmail.com	$2a$10$pmzmSH8z43jAa0W9XwKXzeQ/iLlmTvXyDpi4pppNDTfN/x07DN8Im	2025-07-18 14:31:16.286293+00	\N		\N		\N			\N	2025-07-18 14:31:16.296613+00	{"provider": "email", "providers": ["email"]}	{"sub": "46052f9c-ba77-46fe-a5f2-6195c2f2ae0b", "email": "opwapochristine@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-18 14:31:16.263895+00	2025-07-18 14:31:16.299573+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	835c60e8-fc39-4b88-9cab-adb4e41abb2e	authenticated	authenticated	me@gmail.com	$2a$10$8z672HF4rH6On1z5Gsg/cOyouDovgTnDYzsc/LGufExjlVAYauwO6	2025-07-28 08:51:14.469459+00	\N		\N		\N			\N	2025-07-28 08:51:14.482255+00	{"provider": "email", "providers": ["email"]}	{"sub": "835c60e8-fc39-4b88-9cab-adb4e41abb2e", "email": "me@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-28 08:51:14.403608+00	2025-07-28 08:51:14.518369+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	67c4a209-c6b6-499f-900e-33d9c1c82012	authenticated	authenticated	try@gmail.com	$2a$10$VBw1H5ad/qwiTsZZvnM.NOzwXz0vRleBnBWuzvyAFdWG2TsFyEyzO	2025-07-19 00:29:13.061395+00	\N		\N		\N			\N	2025-07-19 00:29:13.069291+00	{"provider": "email", "providers": ["email"]}	{"sub": "67c4a209-c6b6-499f-900e-33d9c1c82012", "email": "try@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-19 00:29:13.031621+00	2025-07-19 07:40:08.619956+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ea361323-5bae-4576-b105-60431ab12a9f	authenticated	authenticated	opwapo.design@gmail.com	$2a$10$/HCC07McZwWtWCiQpEN6a.LOK2w1rHtfNobGw6/6lvgUt99EDS6Hq	2025-07-09 13:42:32.916562+00	\N		\N		\N			\N	2025-07-18 14:38:03.766597+00	{"provider": "email", "providers": ["email"]}	{"sub": "ea361323-5bae-4576-b105-60431ab12a9f", "email": "opwapo.design@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-09 13:42:32.900623+00	2025-07-19 08:13:04.526139+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6df1069c-e9d9-4525-bed8-0ce4243d1b5c	authenticated	authenticated	mimi@gmail.com	$2a$10$dqRbW0wavUxEamkAg1W6w.m76aniHGMhZ.V5BkJt5INK9THum5gQG	2025-07-28 09:22:56.183213+00	\N		\N		\N			\N	2025-07-28 09:22:56.19225+00	{"provider": "email", "providers": ["email"]}	{"sub": "6df1069c-e9d9-4525-bed8-0ce4243d1b5c", "email": "mimi@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-28 09:22:56.175419+00	2025-07-28 09:22:56.195411+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	authenticated	authenticated	test5@gmail.com	$2a$10$FN1FylWgA7OkVf7VK748M.gYCE6ddwi6dU8NGxYdrZwz3/Pwj7kUO	2025-07-28 09:26:46.582409+00	\N		\N		\N			\N	2025-07-28 09:26:46.588271+00	{"provider": "email", "providers": ["email"]}	{"sub": "2a48727b-7bea-49d2-bcae-f6c70ed8c74a", "email": "test5@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-28 09:26:46.57499+00	2025-08-03 09:32:27.911164+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ffbcebc8-ae9d-42db-a927-c1f1985d5877	authenticated	authenticated	hehe@gmail.com	$2a$10$QbHXK.PT5h2OZdoIx8MToOEeLSx/dxfMnRJaB5WW493ZpGYjaC1oe	2025-07-31 00:57:11.468158+00	\N		\N		\N			\N	2025-07-31 00:57:11.472743+00	{"provider": "email", "providers": ["email"]}	{"sub": "ffbcebc8-ae9d-42db-a927-c1f1985d5877", "email": "hehe@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-31 00:57:11.45221+00	2025-08-13 14:34:54.052062+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b46499fb-122c-4a98-a506-09254fa8451c	authenticated	authenticated	ha@ha.com	$2a$10$Zs1XdOwxRCtdn28iJWT/HuNXZM05GwvSgvHQiHuBSwgCoIUNrVfbq	2025-07-20 13:44:41.687524+00	\N		\N		\N			\N	2025-07-21 06:17:36.818348+00	{"provider": "email", "providers": ["email"]}	{"sub": "b46499fb-122c-4a98-a506-09254fa8451c", "email": "ha@ha.com", "email_verified": true, "phone_verified": false}	\N	2025-07-20 13:44:41.634029+00	2025-07-30 14:55:24.820189+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	722f50f8-20f7-4da4-8070-3c644ff1b096	authenticated	authenticated	test6@gmail.com	$2a$10$ghpjWBVsWrN4TUMgftFHQegrDzy4NRewlJWFUdtW6A21sKF11y6MO	2025-07-28 09:53:52.394947+00	\N		\N		\N			\N	2025-07-28 09:53:52.398895+00	{"provider": "email", "providers": ["email"]}	{"sub": "722f50f8-20f7-4da4-8070-3c644ff1b096", "email": "test6@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-28 09:53:52.384112+00	2025-07-30 23:30:40.686846+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2bd5f804-d025-4d99-8e8e-3cc978369df7	authenticated	authenticated	shemaiahngala8@gmail.com	$2a$10$ayHjAbE1avYbBMVx8XoKke5ZTfxbIkYZoqQ8DyI7y/TNt4ix6c7.2	2025-07-22 05:43:14.326202+00	\N		\N		\N			\N	2025-08-01 07:18:05.394996+00	{"provider": "email", "providers": ["email"]}	{"sub": "2bd5f804-d025-4d99-8e8e-3cc978369df7", "email": "shemaiahngala8@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-07-22 05:43:14.28975+00	2025-08-01 07:18:05.404676+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	11c89725-d719-4aa3-b1d6-d5808e415385	authenticated	authenticated	user@gmail.com	$2a$10$IHBLm3.MbNmfnP1EDe9uJ.e92DLtc2zQWZNOdy.UFjFHJVk823G..	2026-02-02 09:33:24.091072+00	\N		\N		\N			\N	2026-02-02 09:33:24.109917+00	{"provider": "email", "providers": ["email"]}	{"sub": "11c89725-d719-4aa3-b1d6-d5808e415385", "email": "user@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 09:33:24.031972+00	2026-02-02 09:33:24.138639+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a7386c56-a39f-4e2c-b25c-4f75f2daa891	authenticated	authenticated	ha@example.com	$2a$10$UqhkKqHPZifswVW3pdEgfOC7o5dEWaHi8spSx5CEsWGXNVKuyFpBi	2025-08-04 12:42:35.706678+00	\N		\N		\N			\N	2025-08-04 12:44:06.910233+00	{"provider": "email", "providers": ["email"]}	{"sub": "a7386c56-a39f-4e2c-b25c-4f75f2daa891", "email": "ha@example.com", "email_verified": true, "phone_verified": false}	\N	2025-08-04 12:42:35.616033+00	2025-08-04 12:44:06.913126+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	89f818c2-c79f-4eb1-b931-a2029983f13f	authenticated	authenticated	christine@gmail.com	$2a$10$HaP6JuEONfd5ufF9qOzo4Oxk05.3WbcndRFdvSVMRFCC8WYrKRcba	2025-08-04 13:33:39.470811+00	\N		\N		\N			\N	2025-08-04 16:57:09.386144+00	{"provider": "email", "providers": ["email"]}	{"sub": "89f818c2-c79f-4eb1-b931-a2029983f13f", "email": "christine@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-04 13:33:39.454728+00	2025-08-10 21:13:01.048237+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	authenticated	authenticated	s@gmail.com	$2a$10$WcqmAVYdBAMKNbzIlPQfyeB9O7avFqAe.yJNEgAVPD5WWVcZBSSVa	2025-11-09 16:33:46.509028+00	\N		\N		\N			\N	2025-11-09 16:33:46.515129+00	{"provider": "email", "providers": ["email"]}	{"sub": "a1d57ac1-f3e1-4c99-a01b-d494d6e76414", "email": "s@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-11-09 16:33:46.478913+00	2025-11-11 01:26:25.689665+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	authenticated	authenticated	stephenmushiyi803@gmail.com	$2a$10$n/P26jyxOozdOGQ1e6NdkOeOklSVMsrr//IzUJsjNxyq2TuJ183s2	2025-10-31 09:28:09.380554+00	\N		\N		\N			\N	2025-10-31 09:28:09.387279+00	{"provider": "email", "providers": ["email"]}	{"sub": "65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e", "email": "stephenmushiyi803@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-31 09:28:09.328603+00	2025-11-11 05:00:44.847052+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	45e66ac4-dc43-45c9-910a-e92646926526	authenticated	authenticated	yvvonjemymahmajala@gmail.com	$2a$10$Xv66V7izFIhMDsSKFhmieedYxwwm8sSLhTI.A8VV0cpJkS7NFnMsm	2025-08-19 13:36:16.407537+00	\N		\N		\N			\N	2025-08-19 13:36:16.417393+00	{"provider": "email", "providers": ["email"]}	{"sub": "45e66ac4-dc43-45c9-910a-e92646926526", "email": "yvvonjemymahmajala@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-19 13:36:16.3338+00	2025-08-19 13:36:16.46629+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	11bccca2-f952-4946-ac1c-00afcb665580	authenticated	authenticated	meme@gmail.com	$2a$10$B2ZEi19ASEdci1GsUgZXJ./Ka3b5WNWsacY1nxlhQB/xxXNkLqQc6	2025-09-01 12:28:24.224324+00	\N		\N		\N			\N	2025-09-01 12:28:24.237612+00	{"provider": "email", "providers": ["email"]}	{"sub": "11bccca2-f952-4946-ac1c-00afcb665580", "email": "meme@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-09-01 12:28:24.174724+00	2025-09-01 12:28:24.267617+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8b8056e7-e34f-474c-986c-ac698413736b	authenticated	authenticated	eugenenabiswa@gmail.com	$2a$10$UtWhUBV/zQ6JVqYeWfOg9uyNK0GwamFmEY.3IoPF0DsTguLPnwGyu	2025-08-25 13:10:05.135378+00	\N		\N		\N			\N	2025-08-25 13:10:05.143634+00	{"provider": "email", "providers": ["email"]}	{"sub": "8b8056e7-e34f-474c-986c-ac698413736b", "email": "eugenenabiswa@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-25 13:10:05.106654+00	2025-08-25 13:10:05.172644+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1225139c-666f-434a-aabc-48e9d40003af	authenticated	authenticated	her@gmail.com	$2a$10$xhA99EkyMZ3cdjGv2TWwk.f5kzAWZguQ6X8xQNldfUA89HsxscjWK	2025-09-22 10:28:55.263137+00	\N		\N		\N			\N	2025-09-22 10:28:55.278386+00	{"provider": "email", "providers": ["email"]}	{"sub": "1225139c-666f-434a-aabc-48e9d40003af", "email": "her@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-09-22 10:28:55.184575+00	2025-11-09 16:16:10.85745+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	authenticated	authenticated	clara.kahurani@gmail.com	$2a$10$ImeLuuRwNZxdNMAxT6ObeerFgB5yJszQ7G/.7NOoBQBqU6jqKvojC	2025-08-26 13:13:06.510566+00	\N		\N		\N			\N	2025-08-26 13:13:06.528161+00	{"provider": "email", "providers": ["email"]}	{"sub": "08fa5c97-9a7d-41cf-860c-0b61b0c3c14f", "email": "clara.kahurani@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-26 13:13:06.418488+00	2025-08-26 13:13:06.575429+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	43e35414-aa55-4234-a9c1-3e32246ceac0	authenticated	authenticated	opwapo.desig@gmail.com	$2a$10$wnNWR7Rj4iNSPe7zYmDwEu.a9RSHiqqtwrNfO4JWnq63Ze5zn1J3.	2025-08-25 13:22:49.946504+00	\N		\N		\N			\N	2025-08-25 14:12:13.0472+00	{"provider": "email", "providers": ["email"]}	{"sub": "43e35414-aa55-4234-a9c1-3e32246ceac0", "email": "opwapo.desig@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-25 13:22:49.927985+00	2025-08-26 20:43:24.260514+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a13fba99-ccb5-48ad-a2e5-eb379767a5e6	authenticated	authenticated	catekim612@gmail.com	$2a$10$VA3dACfPKXlGzCxmbQ6XI.xMJHRsg2MxZ/fKeNiB88nz9DQyxGzIu	2025-08-25 09:19:12.91794+00	\N		\N		\N			\N	2025-08-25 09:19:12.936297+00	{"provider": "email", "providers": ["email"]}	{"sub": "a13fba99-ccb5-48ad-a2e5-eb379767a5e6", "email": "catekim612@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-25 09:19:12.846083+00	2025-08-25 09:19:12.984307+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2ce65c9c-3a94-42c7-b603-52b7abfa1858	authenticated	authenticated	agwingidaisy@gmail.com	$2a$10$ih32QED/nuay5KTjlbTD1.9zdsEgTRIfwBWixNHIkiHlgh475wxNS	2025-08-05 00:38:58.967152+00	\N		\N		\N			\N	2025-08-05 00:38:58.976272+00	{"provider": "email", "providers": ["email"]}	{"sub": "2ce65c9c-3a94-42c7-b603-52b7abfa1858", "email": "agwingidaisy@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-08-05 00:38:58.926006+00	2025-10-02 11:54:17.285191+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0c0104ab-723d-45c1-9603-a9f12aeaab20	authenticated	authenticated	abc@gmail.com	$2a$10$Ggumt4dWjpLSmeVwM3xaueMZwEoGtzlvxKyy.fRePTg0QNf6xWLS.	2025-10-31 07:56:22.050496+00	\N		\N		\N			\N	2025-10-31 07:56:22.056874+00	{"provider": "email", "providers": ["email"]}	{"sub": "0c0104ab-723d-45c1-9603-a9f12aeaab20", "email": "abc@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-31 07:56:22.021529+00	2025-11-01 14:11:32.522267+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f05b7d85-385c-451b-915b-336bb7611aa3	authenticated	authenticated	user2@gmail.com	$2a$10$J26KYzPDkBpw9nl5PQGl8uQbeM9xJyM1tTqdYsRZnOPbvlsJWlwNe	2026-02-02 10:16:59.398215+00	\N		\N		\N			\N	2026-02-02 10:16:59.419871+00	{"provider": "email", "providers": ["email"]}	{"sub": "f05b7d85-385c-451b-915b-336bb7611aa3", "email": "user2@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 10:16:59.326495+00	2026-02-02 10:16:59.479811+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	749539bf-ce98-420c-8093-d3ea0de95610	authenticated	authenticated	christine2@gmail.com	$2a$10$p9fv1H5YaMpDlf1ggZN5teIISFQm3QZDzuD8LOW0rotHFRODh.TZq	2026-02-12 10:41:28.233989+00	\N		\N		\N			\N	2026-02-12 10:41:28.25169+00	{"provider": "email", "providers": ["email"]}	{"sub": "749539bf-ce98-420c-8093-d3ea0de95610", "email": "christine2@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-12 10:41:28.160585+00	2026-02-12 11:48:06.599433+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	d202bc66-2e79-4bd8-a630-bcb6df1e09ef	authenticated	authenticated	user4@gmail.com	$2a$10$yHGq6GCSv6xcvxPijJP/yethIUQU80aRzQLMVn8G9qFr3ziVn8pKi	2026-02-02 11:07:16.116874+00	\N		\N		\N			\N	2026-02-02 11:07:16.128018+00	{"provider": "email", "providers": ["email"]}	{"sub": "d202bc66-2e79-4bd8-a630-bcb6df1e09ef", "email": "user4@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 11:07:16.096451+00	2026-02-02 11:07:16.151918+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	593b4915-f840-4faf-b8ea-5639581e5ba6	authenticated	authenticated	testuser@gmail.com	$2a$10$m/PgB8VcZc2YSnl98KWkp.erZwHJoZfVvb6qVtxRB1ChCCQHAqQKS	2026-02-06 13:37:52.829243+00	\N		\N		\N			\N	2026-02-06 13:37:52.836247+00	{"provider": "email", "providers": ["email"]}	{"sub": "593b4915-f840-4faf-b8ea-5639581e5ba6", "email": "testuser@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-06 13:37:52.808041+00	2026-02-06 15:05:47.100843+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7307b2d1-0767-44b9-b1e8-a59e222ffa2a	authenticated	authenticated	user3@gmail.com	$2a$10$.yBxHRQP9bFkIfkII8QzSu9ahKB08y2fcYthCNykAduw1FAwsqXRe	2026-02-02 10:21:08.188326+00	\N		\N		\N			\N	2026-02-02 10:21:08.194409+00	{"provider": "email", "providers": ["email"]}	{"sub": "7307b2d1-0767-44b9-b1e8-a59e222ffa2a", "email": "user3@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 10:21:08.172406+00	2026-02-02 10:21:08.207388+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	authenticated	authenticated	kri@stin.com	$2a$10$K01larnZK2Ljv2N./iYbgeqgs2afuG0XRoukRMhm6.X1OErBKchj2	2026-02-05 10:14:16.86689+00	\N		\N		\N			\N	2026-02-05 10:14:16.892824+00	{"provider": "email", "providers": ["email"]}	{"sub": "bdf11f2a-687c-4e37-890a-8e7794e0e9ec", "email": "kri@stin.com", "email_verified": true, "phone_verified": false}	\N	2026-02-05 10:14:16.741127+00	2026-02-05 10:14:16.969907+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2c22e4af-e515-4f40-b2b2-f743f29eb7d5	authenticated	authenticated	user6@gmail.com	$2a$10$qy/UwxXX2xju1bGLD4LyfecX1egfL6Fq3yFeVMHPncjsUyhPyXIiq	2026-02-02 12:07:36.57625+00	\N		\N		\N			\N	2026-02-02 12:07:36.588252+00	{"provider": "email", "providers": ["email"]}	{"sub": "2c22e4af-e515-4f40-b2b2-f743f29eb7d5", "email": "user6@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 12:07:36.522871+00	2026-02-06 13:36:16.836977+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8f57cb78-e830-47f6-a492-e590a63f834d	authenticated	authenticated	user5@gmail.com	$2a$10$NQh/bvpm17ZTaEJ7ptKw2e9kFioTU5rnEyfsIZNYvKT6jpjST5md2	2026-02-02 11:13:33.014977+00	\N		\N		\N			\N	2026-02-02 11:13:33.025533+00	{"provider": "email", "providers": ["email"]}	{"sub": "8f57cb78-e830-47f6-a492-e590a63f834d", "email": "user5@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 11:13:32.96573+00	2026-02-02 11:13:33.048891+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	2c738a07-f482-4f35-99e3-0de3ef3798a9	authenticated	authenticated	oppo@gmail.com	$2a$10$uX1cg.E3l.NdcG7vCuz7b.JkFjxbDjXZnUm/edw/lY0LwA3NR7u4S	2026-02-02 10:58:06.752348+00	\N		\N		\N			\N	2026-02-02 10:58:06.766619+00	{"provider": "email", "providers": ["email"]}	{"sub": "2c738a07-f482-4f35-99e3-0de3ef3798a9", "email": "oppo@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-02 10:58:06.669209+00	2026-02-02 10:58:06.817839+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7720f8b9-5587-4fac-a275-3c59cf19f5d3	authenticated	authenticated	tester@gmail.com	$2a$10$UFNte60R6r3fvzsfrLiuieujRC6sI/RcNqJOdSu8hY6l5.7L/RAdu	2026-02-06 17:04:00.446536+00	\N		\N		\N			\N	2026-02-06 17:04:00.457153+00	{"provider": "email", "providers": ["email"]}	{"sub": "7720f8b9-5587-4fac-a275-3c59cf19f5d3", "email": "tester@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-06 17:04:00.401727+00	2026-02-09 08:39:54.99906+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fe953905-9ef8-4c6d-be09-442444285581	authenticated	authenticated	brandononyango9@gmail.com	$2a$10$zn2fCARjSIKFTlMmJDB0IeqwtgEbrq5VFr6bjsAmcytuyubO2uo1e	2026-02-06 21:16:41.126964+00	\N		\N		\N			\N	2026-02-06 21:16:41.144736+00	{"provider": "email", "providers": ["email"]}	{"sub": "fe953905-9ef8-4c6d-be09-442444285581", "email": "brandononyango9@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-06 21:16:41.058335+00	2026-02-06 21:16:41.188966+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	74e9227f-a16f-4af0-be98-176cf7727933	authenticated	authenticated	test3@gmail.com	$2a$10$.50Swr.EbVDTwJsnuZ0WyeiuBkbgwG45M4hcJGMwOVZhelFl25TsW	2026-02-06 16:37:18.544613+00	\N		\N		\N			\N	2026-02-06 16:37:18.553344+00	{"provider": "email", "providers": ["email"]}	{"sub": "74e9227f-a16f-4af0-be98-176cf7727933", "email": "test3@gmail.com", "email_verified": true, "phone_verified": false}	\N	2026-02-06 16:37:18.514761+00	2026-02-06 16:37:18.587269+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
8c23da63-3d8b-4999-af4c-d28f8fa6f3de	8c23da63-3d8b-4999-af4c-d28f8fa6f3de	{"sub": "8c23da63-3d8b-4999-af4c-d28f8fa6f3de", "email": "xtineopwapo@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-07-09 12:49:11.340893+00	2025-07-09 12:49:11.340955+00	2025-07-09 12:49:11.340955+00	822817e8-97e8-4ab0-a8bb-0f1f6b1f2bbb
ea361323-5bae-4576-b105-60431ab12a9f	ea361323-5bae-4576-b105-60431ab12a9f	{"sub": "ea361323-5bae-4576-b105-60431ab12a9f", "email": "opwapo.design@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-09 13:42:32.912601+00	2025-07-09 13:42:32.912665+00	2025-07-09 13:42:32.912665+00	dc86be9c-b48e-41e1-9957-dfb1b978249a
46052f9c-ba77-46fe-a5f2-6195c2f2ae0b	46052f9c-ba77-46fe-a5f2-6195c2f2ae0b	{"sub": "46052f9c-ba77-46fe-a5f2-6195c2f2ae0b", "email": "opwapochristine@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-18 14:31:16.279003+00	2025-07-18 14:31:16.27906+00	2025-07-18 14:31:16.27906+00	24984329-9ff1-458d-a980-900bdad06361
67c4a209-c6b6-499f-900e-33d9c1c82012	67c4a209-c6b6-499f-900e-33d9c1c82012	{"sub": "67c4a209-c6b6-499f-900e-33d9c1c82012", "email": "try@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-19 00:29:13.054033+00	2025-07-19 00:29:13.054093+00	2025-07-19 00:29:13.054093+00	884add33-2e6f-4571-ab53-9b9589b55181
57693c4b-8462-4c29-ad82-9103d5b3e33c	57693c4b-8462-4c29-ad82-9103d5b3e33c	{"sub": "57693c4b-8462-4c29-ad82-9103d5b3e33c", "email": "test@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-19 12:08:43.255122+00	2025-07-19 12:08:43.25518+00	2025-07-19 12:08:43.25518+00	c4b8e022-6a31-43d3-8fef-e1af1c66aa05
b46499fb-122c-4a98-a506-09254fa8451c	b46499fb-122c-4a98-a506-09254fa8451c	{"sub": "b46499fb-122c-4a98-a506-09254fa8451c", "email": "ha@ha.com", "email_verified": false, "phone_verified": false}	email	2025-07-20 13:44:41.668912+00	2025-07-20 13:44:41.668967+00	2025-07-20 13:44:41.668967+00	9ae2ab85-e25c-4a52-8ea8-293a292e5e48
2bd5f804-d025-4d99-8e8e-3cc978369df7	2bd5f804-d025-4d99-8e8e-3cc978369df7	{"sub": "2bd5f804-d025-4d99-8e8e-3cc978369df7", "email": "shemaiahngala8@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-22 05:43:14.315381+00	2025-07-22 05:43:14.315431+00	2025-07-22 05:43:14.315431+00	b9f8a7fc-6993-4249-a691-93cc8d511ffe
835c60e8-fc39-4b88-9cab-adb4e41abb2e	835c60e8-fc39-4b88-9cab-adb4e41abb2e	{"sub": "835c60e8-fc39-4b88-9cab-adb4e41abb2e", "email": "me@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-28 08:51:14.447245+00	2025-07-28 08:51:14.447297+00	2025-07-28 08:51:14.447297+00	d12a9f56-a1b9-4b74-915e-ea02003d201b
e78ba560-9542-4f67-8dc9-f2823b0f13d2	e78ba560-9542-4f67-8dc9-f2823b0f13d2	{"sub": "e78ba560-9542-4f67-8dc9-f2823b0f13d2", "email": "wewe@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-28 09:03:17.981831+00	2025-07-28 09:03:17.981881+00	2025-07-28 09:03:17.981881+00	fe3969b9-8330-4c83-9183-9d88d1ef1762
6df1069c-e9d9-4525-bed8-0ce4243d1b5c	6df1069c-e9d9-4525-bed8-0ce4243d1b5c	{"sub": "6df1069c-e9d9-4525-bed8-0ce4243d1b5c", "email": "mimi@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-28 09:22:56.179483+00	2025-07-28 09:22:56.179534+00	2025-07-28 09:22:56.179534+00	bd833f86-ee67-4ff3-bb64-c9fd99994b5f
2a48727b-7bea-49d2-bcae-f6c70ed8c74a	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	{"sub": "2a48727b-7bea-49d2-bcae-f6c70ed8c74a", "email": "test5@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-28 09:26:46.578143+00	2025-07-28 09:26:46.578188+00	2025-07-28 09:26:46.578188+00	0b86b079-389f-4caa-9251-b4fb60fe7678
722f50f8-20f7-4da4-8070-3c644ff1b096	722f50f8-20f7-4da4-8070-3c644ff1b096	{"sub": "722f50f8-20f7-4da4-8070-3c644ff1b096", "email": "test6@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-28 09:53:52.389023+00	2025-07-28 09:53:52.389069+00	2025-07-28 09:53:52.389069+00	1be4ac82-7530-4de9-8ba8-40bcc7a87d57
e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2	e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2	{"sub": "e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2", "email": "heee@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-31 00:14:46.478033+00	2025-07-31 00:14:46.478095+00	2025-07-31 00:14:46.478095+00	25b1aeb6-7cf0-49a0-b536-841108ce214f
ffbcebc8-ae9d-42db-a927-c1f1985d5877	ffbcebc8-ae9d-42db-a927-c1f1985d5877	{"sub": "ffbcebc8-ae9d-42db-a927-c1f1985d5877", "email": "hehe@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-07-31 00:57:11.46045+00	2025-07-31 00:57:11.460505+00	2025-07-31 00:57:11.460505+00	cfd96d87-b243-4e7a-aeac-d5956867c06a
a7386c56-a39f-4e2c-b25c-4f75f2daa891	a7386c56-a39f-4e2c-b25c-4f75f2daa891	{"sub": "a7386c56-a39f-4e2c-b25c-4f75f2daa891", "email": "ha@example.com", "email_verified": false, "phone_verified": false}	email	2025-08-04 12:42:35.669628+00	2025-08-04 12:42:35.671854+00	2025-08-04 12:42:35.671854+00	bbdbac2a-805a-4ce4-842b-2a49878b1159
89f818c2-c79f-4eb1-b931-a2029983f13f	89f818c2-c79f-4eb1-b931-a2029983f13f	{"sub": "89f818c2-c79f-4eb1-b931-a2029983f13f", "email": "christine@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-04 13:33:39.461458+00	2025-08-04 13:33:39.461504+00	2025-08-04 13:33:39.461504+00	60f56450-488e-4d47-8b88-4c3793b5aaf2
2ce65c9c-3a94-42c7-b603-52b7abfa1858	2ce65c9c-3a94-42c7-b603-52b7abfa1858	{"sub": "2ce65c9c-3a94-42c7-b603-52b7abfa1858", "email": "agwingidaisy@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-05 00:38:58.953455+00	2025-08-05 00:38:58.953504+00	2025-08-05 00:38:58.953504+00	3ee33015-164a-4655-a8b4-edfc5fd5a798
45e66ac4-dc43-45c9-910a-e92646926526	45e66ac4-dc43-45c9-910a-e92646926526	{"sub": "45e66ac4-dc43-45c9-910a-e92646926526", "email": "yvvonjemymahmajala@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-19 13:36:16.380007+00	2025-08-19 13:36:16.380059+00	2025-08-19 13:36:16.380059+00	b049afc1-3bcf-4e8e-beca-938a53926fb5
a13fba99-ccb5-48ad-a2e5-eb379767a5e6	a13fba99-ccb5-48ad-a2e5-eb379767a5e6	{"sub": "a13fba99-ccb5-48ad-a2e5-eb379767a5e6", "email": "catekim612@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-25 09:19:12.890946+00	2025-08-25 09:19:12.890998+00	2025-08-25 09:19:12.890998+00	1d0a1192-a386-4d04-84ee-41b5851d8966
8b8056e7-e34f-474c-986c-ac698413736b	8b8056e7-e34f-474c-986c-ac698413736b	{"sub": "8b8056e7-e34f-474c-986c-ac698413736b", "email": "eugenenabiswa@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-25 13:10:05.123207+00	2025-08-25 13:10:05.123263+00	2025-08-25 13:10:05.123263+00	536e9da6-cdb7-46e2-839b-21626c6c1b34
43e35414-aa55-4234-a9c1-3e32246ceac0	43e35414-aa55-4234-a9c1-3e32246ceac0	{"sub": "43e35414-aa55-4234-a9c1-3e32246ceac0", "email": "opwapo.desig@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-25 13:22:49.933448+00	2025-08-25 13:22:49.933496+00	2025-08-25 13:22:49.933496+00	5bb934fc-950b-4255-b6ba-b3695b3f2711
08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	{"sub": "08fa5c97-9a7d-41cf-860c-0b61b0c3c14f", "email": "clara.kahurani@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-08-26 13:13:06.467073+00	2025-08-26 13:13:06.467657+00	2025-08-26 13:13:06.467657+00	ab190e1f-2d19-4ac6-9155-8aab2a754f83
11bccca2-f952-4946-ac1c-00afcb665580	11bccca2-f952-4946-ac1c-00afcb665580	{"sub": "11bccca2-f952-4946-ac1c-00afcb665580", "email": "meme@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-09-01 12:28:24.205733+00	2025-09-01 12:28:24.205779+00	2025-09-01 12:28:24.205779+00	939cf347-ebdf-49b4-8076-74f1e239ce82
1225139c-666f-434a-aabc-48e9d40003af	1225139c-666f-434a-aabc-48e9d40003af	{"sub": "1225139c-666f-434a-aabc-48e9d40003af", "email": "her@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-09-22 10:28:55.231736+00	2025-09-22 10:28:55.231792+00	2025-09-22 10:28:55.231792+00	93a9a705-0ca7-4435-81c2-f1ada1bb78a9
0c0104ab-723d-45c1-9603-a9f12aeaab20	0c0104ab-723d-45c1-9603-a9f12aeaab20	{"sub": "0c0104ab-723d-45c1-9603-a9f12aeaab20", "email": "abc@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-10-31 07:56:22.041124+00	2025-10-31 07:56:22.041177+00	2025-10-31 07:56:22.041177+00	44faeec2-c2b9-44fd-a0a4-75c491bf510d
65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	{"sub": "65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e", "email": "stephenmushiyi803@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-10-31 09:28:09.365382+00	2025-10-31 09:28:09.366138+00	2025-10-31 09:28:09.366138+00	d9c53dc2-48b5-4650-a1d1-68dc43d844fa
a1d57ac1-f3e1-4c99-a01b-d494d6e76414	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	{"sub": "a1d57ac1-f3e1-4c99-a01b-d494d6e76414", "email": "s@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-11-09 16:33:46.50247+00	2025-11-09 16:33:46.502528+00	2025-11-09 16:33:46.502528+00	6b33a49c-5985-41a5-8334-d21e168f8685
11c89725-d719-4aa3-b1d6-d5808e415385	11c89725-d719-4aa3-b1d6-d5808e415385	{"sub": "11c89725-d719-4aa3-b1d6-d5808e415385", "email": "user@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 09:33:24.068814+00	2026-02-02 09:33:24.069922+00	2026-02-02 09:33:24.069922+00	13b23c46-1b46-44ab-b907-30306880c2b9
f05b7d85-385c-451b-915b-336bb7611aa3	f05b7d85-385c-451b-915b-336bb7611aa3	{"sub": "f05b7d85-385c-451b-915b-336bb7611aa3", "email": "user2@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 10:16:59.376387+00	2026-02-02 10:16:59.37644+00	2026-02-02 10:16:59.37644+00	d4f7e14f-72a7-41ef-82fc-50c67390aa74
7307b2d1-0767-44b9-b1e8-a59e222ffa2a	7307b2d1-0767-44b9-b1e8-a59e222ffa2a	{"sub": "7307b2d1-0767-44b9-b1e8-a59e222ffa2a", "email": "user3@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 10:21:08.180665+00	2026-02-02 10:21:08.180739+00	2026-02-02 10:21:08.180739+00	99bc92ea-eef3-4c57-ad9f-a123ecdc126e
2c738a07-f482-4f35-99e3-0de3ef3798a9	2c738a07-f482-4f35-99e3-0de3ef3798a9	{"sub": "2c738a07-f482-4f35-99e3-0de3ef3798a9", "email": "oppo@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 10:58:06.724405+00	2026-02-02 10:58:06.725577+00	2026-02-02 10:58:06.725577+00	1d447bce-513f-465b-8dd4-cac5313f77d4
d202bc66-2e79-4bd8-a630-bcb6df1e09ef	d202bc66-2e79-4bd8-a630-bcb6df1e09ef	{"sub": "d202bc66-2e79-4bd8-a630-bcb6df1e09ef", "email": "user4@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 11:07:16.10875+00	2026-02-02 11:07:16.108803+00	2026-02-02 11:07:16.108803+00	0d181aea-dfef-40b6-b422-e2f1e3da3298
8f57cb78-e830-47f6-a492-e590a63f834d	8f57cb78-e830-47f6-a492-e590a63f834d	{"sub": "8f57cb78-e830-47f6-a492-e590a63f834d", "email": "user5@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 11:13:32.991313+00	2026-02-02 11:13:32.991368+00	2026-02-02 11:13:32.991368+00	01ae1fed-294f-4845-bb4e-2b73e5e1fcff
2c22e4af-e515-4f40-b2b2-f743f29eb7d5	2c22e4af-e515-4f40-b2b2-f743f29eb7d5	{"sub": "2c22e4af-e515-4f40-b2b2-f743f29eb7d5", "email": "user6@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-02 12:07:36.559317+00	2026-02-02 12:07:36.560073+00	2026-02-02 12:07:36.560073+00	f6edb99f-015b-479e-bbc9-2493997081a0
bdf11f2a-687c-4e37-890a-8e7794e0e9ec	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	{"sub": "bdf11f2a-687c-4e37-890a-8e7794e0e9ec", "email": "kri@stin.com", "email_verified": false, "phone_verified": false}	email	2026-02-05 10:14:16.810334+00	2026-02-05 10:14:16.810389+00	2026-02-05 10:14:16.810389+00	90c834f4-c30a-4e15-9cca-82fef1abceb1
593b4915-f840-4faf-b8ea-5639581e5ba6	593b4915-f840-4faf-b8ea-5639581e5ba6	{"sub": "593b4915-f840-4faf-b8ea-5639581e5ba6", "email": "testuser@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-06 13:37:52.822563+00	2026-02-06 13:37:52.822626+00	2026-02-06 13:37:52.822626+00	b65f8ba6-84ef-469d-9d31-aa1c7ddbd65b
74e9227f-a16f-4af0-be98-176cf7727933	74e9227f-a16f-4af0-be98-176cf7727933	{"sub": "74e9227f-a16f-4af0-be98-176cf7727933", "email": "test3@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-06 16:37:18.534419+00	2026-02-06 16:37:18.534494+00	2026-02-06 16:37:18.534494+00	ac49ddbf-c366-4e78-a38d-e60d6fe00af3
7720f8b9-5587-4fac-a275-3c59cf19f5d3	7720f8b9-5587-4fac-a275-3c59cf19f5d3	{"sub": "7720f8b9-5587-4fac-a275-3c59cf19f5d3", "email": "tester@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-06 17:04:00.435045+00	2026-02-06 17:04:00.435095+00	2026-02-06 17:04:00.435095+00	97441ce5-0b1c-4b61-9810-456df81ca8c7
fe953905-9ef8-4c6d-be09-442444285581	fe953905-9ef8-4c6d-be09-442444285581	{"sub": "fe953905-9ef8-4c6d-be09-442444285581", "email": "brandononyango9@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-06 21:16:41.101032+00	2026-02-06 21:16:41.10108+00	2026-02-06 21:16:41.10108+00	ebbc90b7-2d6f-4b7e-b618-b4ae03976731
749539bf-ce98-420c-8093-d3ea0de95610	749539bf-ce98-420c-8093-d3ea0de95610	{"sub": "749539bf-ce98-420c-8093-d3ea0de95610", "email": "christine2@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-02-12 10:41:28.196474+00	2026-02-12 10:41:28.196544+00	2026-02-12 10:41:28.196544+00	25fbb5e9-f70f-48b5-8949-d3337465775d
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
066ebf8d-b598-4b0c-b21f-246c38959e5c	ea361323-5bae-4576-b105-60431ab12a9f	2025-07-09 13:42:32.921619+00	2025-07-09 13:42:32.921619+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.180.206	\N	\N	\N	\N	\N
ff1a16ed-101e-4836-bd83-d5b6ab563fe5	ea361323-5bae-4576-b105-60431ab12a9f	2025-07-09 13:43:54.357293+00	2025-07-09 13:43:54.357293+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.180.206	\N	\N	\N	\N	\N
8b5e2c2c-b127-4b09-850d-126b8dc7ffda	ea361323-5bae-4576-b105-60431ab12a9f	2025-07-09 13:44:20.35718+00	2025-07-09 13:44:20.35718+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.180.206	\N	\N	\N	\N	\N
da238deb-e120-4679-912a-7fdd4003a1ab	7720f8b9-5587-4fac-a275-3c59cf19f5d3	2026-02-06 17:04:00.457274+00	2026-02-09 08:39:55.013114+00	\N	aal1	\N	2026-02-09 08:39:55.010574	Dart/3.8 (dart:io)	196.96.165.20	\N	\N	\N	\N	\N
317fff41-f0e8-4ac3-b4a2-6368da2912d3	67c4a209-c6b6-499f-900e-33d9c1c82012	2025-07-19 00:29:13.069367+00	2025-07-19 07:40:08.623969+00	\N	aal1	\N	2025-07-19 07:40:08.623897	Dart/3.8 (dart:io)	41.139.143.209	\N	\N	\N	\N	\N
d33a433d-6615-4f60-904c-52e4c77cbfa4	ea361323-5bae-4576-b105-60431ab12a9f	2025-07-18 14:38:03.76667+00	2025-07-19 08:13:04.527388+00	\N	aal1	\N	2025-07-19 08:13:04.52732	Dart/3.8 (dart:io)	41.139.143.209	\N	\N	\N	\N	\N
6165a2f4-3f9e-4f27-9ac6-44e8acec44b8	57693c4b-8462-4c29-ad82-9103d5b3e33c	2025-07-19 12:08:43.26896+00	2025-07-19 12:08:43.26896+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.139.143.209	\N	\N	\N	\N	\N
20934d46-5b13-46b8-abf5-593ec47d5dea	57693c4b-8462-4c29-ad82-9103d5b3e33c	2025-07-19 12:40:54.664048+00	2025-07-19 12:40:54.664048+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.139.143.209	\N	\N	\N	\N	\N
d6bf989f-9bc5-4c17-9e5d-56e328ec7e13	89f818c2-c79f-4eb1-b931-a2029983f13f	2025-08-04 16:57:09.386234+00	2025-08-10 21:13:01.058687+00	\N	aal1	\N	2025-08-10 21:13:01.058604	Dart/3.8 (dart:io)	41.90.187.174	\N	\N	\N	\N	\N
41f8598e-1ba2-4db6-86b2-ae41bb9f3ecd	593b4915-f840-4faf-b8ea-5639581e5ba6	2026-02-06 13:37:52.837037+00	2026-02-06 15:05:47.110485+00	\N	aal1	\N	2026-02-06 15:05:47.110377	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
fdf8d946-dc94-4be1-8902-a478e1569463	2ce65c9c-3a94-42c7-b603-52b7abfa1858	2025-08-05 00:38:58.976345+00	2025-10-02 11:54:17.294794+00	\N	aal1	\N	2025-10-02 11:54:17.294709	Dart/3.8 (dart:io)	105.160.61.136	\N	\N	\N	\N	\N
5084d6b7-03b5-4fec-a3fe-8c3a161fb2f9	749539bf-ce98-420c-8093-d3ea0de95610	2026-02-12 10:41:28.251779+00	2026-02-12 11:48:06.613898+00	\N	aal1	\N	2026-02-12 11:48:06.611422	Dart/3.8 (dart:io)	105.161.177.195	\N	\N	\N	\N	\N
e974d003-a64c-4a0d-92ce-b52a3a5bb33b	fe953905-9ef8-4c6d-be09-442444285581	2026-02-06 21:16:41.146686+00	2026-02-06 21:16:41.146686+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
c2a0237d-f0e6-4d86-be6a-bd4b310127f5	2bd5f804-d025-4d99-8e8e-3cc978369df7	2025-08-01 07:18:05.395072+00	2025-08-01 07:18:05.395072+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.66.13	\N	\N	\N	\N	\N
badc0a37-03d5-4443-83f1-0314a3ba8dcd	0c0104ab-723d-45c1-9603-a9f12aeaab20	2025-10-31 07:56:22.058789+00	2025-11-01 14:11:32.524757+00	\N	aal1	\N	2025-11-01 14:11:32.524687	Dart/3.8 (dart:io)	196.96.75.74	\N	\N	\N	\N	\N
6dddf6da-bdb6-4ef3-a4f4-e9096a969320	ffbcebc8-ae9d-42db-a927-c1f1985d5877	2025-07-31 00:57:11.472824+00	2025-08-13 14:34:54.055393+00	\N	aal1	\N	2025-08-13 14:34:54.055321	Dart/3.8 (dart:io)	41.90.187.174	\N	\N	\N	\N	\N
9d97362c-9c4a-4e02-b5b9-daf94214a28d	45e66ac4-dc43-45c9-910a-e92646926526	2025-08-19 13:36:16.419445+00	2025-08-19 13:36:16.419445+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	105.163.158.67	\N	\N	\N	\N	\N
92754a86-9290-4d49-b846-deaffbe04515	a13fba99-ccb5-48ad-a2e5-eb379767a5e6	2025-08-25 09:19:12.936403+00	2025-08-25 09:19:12.936403+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	196.96.73.232	\N	\N	\N	\N	\N
c793022c-1ad6-45bc-8934-8bd68513b895	8b8056e7-e34f-474c-986c-ac698413736b	2025-08-25 13:10:05.144367+00	2025-08-25 13:10:05.144367+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	196.96.7.190	\N	\N	\N	\N	\N
84715ca3-f3ab-4cf5-870d-581fbac515b2	43e35414-aa55-4234-a9c1-3e32246ceac0	2025-08-25 13:22:49.951889+00	2025-08-25 13:22:49.951889+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	102.216.116.10	\N	\N	\N	\N	\N
5abc898c-1077-4a33-9487-f145c03791e2	b46499fb-122c-4a98-a506-09254fa8451c	2025-07-21 06:17:36.818441+00	2025-07-30 14:55:24.827271+00	\N	aal1	\N	2025-07-30 14:55:24.822709	Dart/3.8 (dart:io)	197.232.7.59	\N	\N	\N	\N	\N
711a5e41-bc8b-4c04-91d3-1eb5c5c8bbfe	08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	2025-08-26 13:13:06.52892+00	2025-08-26 13:13:06.52892+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.222.8.188	\N	\N	\N	\N	\N
cbaa2eb6-d3e9-4aa4-8a33-a53ab8ac4074	43e35414-aa55-4234-a9c1-3e32246ceac0	2025-08-25 14:12:13.047301+00	2025-08-26 20:43:24.265128+00	\N	aal1	\N	2025-08-26 20:43:24.265053	Dart/3.8 (dart:io)	41.90.190.96	\N	\N	\N	\N	\N
6a2aae76-7b87-4a3b-8640-14cb1f97942e	11bccca2-f952-4946-ac1c-00afcb665580	2025-09-01 12:28:24.237757+00	2025-09-01 12:28:24.237757+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.179.19	\N	\N	\N	\N	\N
6f7825dd-4e6d-40b2-84ee-d8c1061dc52d	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	2025-07-28 09:26:46.588345+00	2025-08-03 09:32:27.921065+00	\N	aal1	\N	2025-08-03 09:32:27.920987	Dart/3.8 (dart:io)	41.90.180.149	\N	\N	\N	\N	\N
0f5c6cec-6b60-4566-a9fc-29c0bad884ea	e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2	2025-07-31 00:14:46.495792+00	2025-07-31 00:14:46.495792+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	41.90.181.126	\N	\N	\N	\N	\N
d35b356a-c740-441d-af86-a946eaea0e6f	a7386c56-a39f-4e2c-b25c-4f75f2daa891	2025-08-04 12:44:06.910314+00	2025-08-04 12:44:06.910314+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	102.213.179.25	\N	\N	\N	\N	\N
9e58de9b-5a77-4011-ab03-80640d01547e	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	2025-11-09 16:33:46.515197+00	2025-11-11 01:26:25.700728+00	\N	aal1	\N	2025-11-11 01:26:25.700621	Dart/3.8 (dart:io)	105.161.115.133	\N	\N	\N	\N	\N
b8f11270-50a8-4dbd-aad5-4de646ea3d3f	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	2025-10-31 09:28:09.387421+00	2025-11-11 05:02:39.572417+00	\N	aal1	\N	2025-11-11 05:02:39.571118	Dart/3.8 (dart:io)	102.211.145.123	\N	\N	\N	\N	\N
5271b17d-8c72-4d12-948b-343efeb22c91	11c89725-d719-4aa3-b1d6-d5808e415385	2026-02-02 09:33:24.110753+00	2026-02-02 09:33:24.110753+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
50a4efee-4e36-49fb-adcd-7fb9060356c7	f05b7d85-385c-451b-915b-336bb7611aa3	2026-02-02 10:16:59.421999+00	2026-02-02 10:16:59.421999+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
68c1d80a-8b56-4269-be50-a191df4ed324	7307b2d1-0767-44b9-b1e8-a59e222ffa2a	2026-02-02 10:21:08.194537+00	2026-02-02 10:21:08.194537+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
803d14ef-a6dc-4c49-8a77-b14097959f3e	2c738a07-f482-4f35-99e3-0de3ef3798a9	2026-02-02 10:58:06.768486+00	2026-02-02 10:58:06.768486+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
e4d34a46-f4bd-4c71-9c98-414fb80e80a8	d202bc66-2e79-4bd8-a630-bcb6df1e09ef	2026-02-02 11:07:16.12812+00	2026-02-02 11:07:16.12812+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
0097fcee-892d-46f7-8d25-0a0433a9d658	8f57cb78-e830-47f6-a492-e590a63f834d	2026-02-02 11:13:33.026223+00	2026-02-02 11:13:33.026223+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	217.199.148.226	\N	\N	\N	\N	\N
d765e20b-c617-4674-8009-0cccfea2ec0b	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	2026-02-05 10:14:16.894186+00	2026-02-05 10:14:16.894186+00	\N	aal1	\N	\N	Dart/3.8 (dart:io)	102.213.179.81	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
066ebf8d-b598-4b0c-b21f-246c38959e5c	2025-07-09 13:42:32.938772+00	2025-07-09 13:42:32.938772+00	password	5bb44827-ee25-48e5-8dc5-705c8b24a6e0
ff1a16ed-101e-4836-bd83-d5b6ab563fe5	2025-07-09 13:43:54.361088+00	2025-07-09 13:43:54.361088+00	password	b9f88b26-0c01-4a8c-8b38-9dc6cf8fcaa0
8b5e2c2c-b127-4b09-850d-126b8dc7ffda	2025-07-09 13:44:20.358959+00	2025-07-09 13:44:20.358959+00	password	8dcc79ca-e31d-4ef5-a38d-1187daecdc3a
d33a433d-6615-4f60-904c-52e4c77cbfa4	2025-07-18 14:38:03.770283+00	2025-07-18 14:38:03.770283+00	password	d0bb9cfe-0f75-4289-ae52-622bbf003ecb
317fff41-f0e8-4ac3-b4a2-6368da2912d3	2025-07-19 00:29:13.083094+00	2025-07-19 00:29:13.083094+00	password	ec86e4ab-e9a9-4ee9-a7f5-70799a2cdaaf
6165a2f4-3f9e-4f27-9ac6-44e8acec44b8	2025-07-19 12:08:43.280312+00	2025-07-19 12:08:43.280312+00	password	72c27cb3-3858-49e9-81b2-10d05135019a
20934d46-5b13-46b8-abf5-593ec47d5dea	2025-07-19 12:40:54.670146+00	2025-07-19 12:40:54.670146+00	password	6c01268d-fe9e-4905-9e91-e68cb78cea45
5abc898c-1077-4a33-9487-f145c03791e2	2025-07-21 06:17:36.823733+00	2025-07-21 06:17:36.823733+00	password	4c4cd342-c171-4267-a9e0-01e770032796
6f7825dd-4e6d-40b2-84ee-d8c1061dc52d	2025-07-28 09:26:46.593957+00	2025-07-28 09:26:46.593957+00	password	2515944d-3006-44f3-9534-4b86afc747de
0f5c6cec-6b60-4566-a9fc-29c0bad884ea	2025-07-31 00:14:46.509773+00	2025-07-31 00:14:46.509773+00	password	12310633-0b4c-49e4-8dd1-755cd4597d63
6dddf6da-bdb6-4ef3-a4f4-e9096a969320	2025-07-31 00:57:11.477955+00	2025-07-31 00:57:11.477955+00	password	566f5445-8c58-4bf9-878f-b0da70f9fbdd
c2a0237d-f0e6-4d86-be6a-bd4b310127f5	2025-08-01 07:18:05.404988+00	2025-08-01 07:18:05.404988+00	password	d30703cc-f00f-416b-8b4d-371323e8b253
d35b356a-c740-441d-af86-a946eaea0e6f	2025-08-04 12:44:06.913708+00	2025-08-04 12:44:06.913708+00	password	2887c459-a480-4a13-bb83-e47aad7b8c09
d6bf989f-9bc5-4c17-9e5d-56e328ec7e13	2025-08-04 16:57:09.395797+00	2025-08-04 16:57:09.395797+00	password	a2765ff3-f307-4a19-adfe-d2e02399babd
fdf8d946-dc94-4be1-8902-a478e1569463	2025-08-05 00:38:58.996305+00	2025-08-05 00:38:58.996305+00	password	c7044e01-1efe-4d90-9e20-f202e6a51910
9d97362c-9c4a-4e02-b5b9-daf94214a28d	2025-08-19 13:36:16.466807+00	2025-08-19 13:36:16.466807+00	password	b7a60ddf-410a-4d15-9f13-e872c3db8075
92754a86-9290-4d49-b846-deaffbe04515	2025-08-25 09:19:12.984806+00	2025-08-25 09:19:12.984806+00	password	7b0db17b-03c9-4eb8-9114-cb2156095d51
c793022c-1ad6-45bc-8934-8bd68513b895	2025-08-25 13:10:05.173143+00	2025-08-25 13:10:05.173143+00	password	00cb1c40-f0ab-4259-8f9d-a5afe74a90bc
84715ca3-f3ab-4cf5-870d-581fbac515b2	2025-08-25 13:22:49.962632+00	2025-08-25 13:22:49.962632+00	password	e297261f-8e2b-48e5-8c4c-f679984bcf97
cbaa2eb6-d3e9-4aa4-8a33-a53ab8ac4074	2025-08-25 14:12:13.072783+00	2025-08-25 14:12:13.072783+00	password	05ba16e1-04a7-4efb-a007-594af8b65e4c
711a5e41-bc8b-4c04-91d3-1eb5c5c8bbfe	2025-08-26 13:13:06.575916+00	2025-08-26 13:13:06.575916+00	password	7ff31845-e762-4100-85a0-20ffe4a1e0c6
6a2aae76-7b87-4a3b-8640-14cb1f97942e	2025-09-01 12:28:24.268181+00	2025-09-01 12:28:24.268181+00	password	ff45e8e3-1465-44e8-b6c8-a82e290c5d80
badc0a37-03d5-4443-83f1-0314a3ba8dcd	2025-10-31 07:56:22.077997+00	2025-10-31 07:56:22.077997+00	password	1a69b673-da6d-42f8-a4c8-1d6194b49d7a
b8f11270-50a8-4dbd-aad5-4de646ea3d3f	2025-10-31 09:28:09.406553+00	2025-10-31 09:28:09.406553+00	password	f7ee2664-1831-4535-a456-884cfe32e8ea
9e58de9b-5a77-4011-ab03-80640d01547e	2025-11-09 16:33:46.52805+00	2025-11-09 16:33:46.52805+00	password	b2a4515b-efe5-4b7c-83f9-200ffdf50670
5271b17d-8c72-4d12-948b-343efeb22c91	2026-02-02 09:33:24.139193+00	2026-02-02 09:33:24.139193+00	password	266e6258-cd0f-4073-b908-e6c6da3edf38
50a4efee-4e36-49fb-adcd-7fb9060356c7	2026-02-02 10:16:59.481031+00	2026-02-02 10:16:59.481031+00	password	d47843cd-ec96-4089-bf95-323022b00acf
68c1d80a-8b56-4269-be50-a191df4ed324	2026-02-02 10:21:08.207968+00	2026-02-02 10:21:08.207968+00	password	94fed0dc-2ea0-4587-ae56-8333c6f10e86
803d14ef-a6dc-4c49-8a77-b14097959f3e	2026-02-02 10:58:06.819734+00	2026-02-02 10:58:06.819734+00	password	79ca5de1-6dff-4792-a406-5a751e78f4f9
e4d34a46-f4bd-4c71-9c98-414fb80e80a8	2026-02-02 11:07:16.153313+00	2026-02-02 11:07:16.153313+00	password	ebaca726-9d06-403a-b708-1799d7ccf940
0097fcee-892d-46f7-8d25-0a0433a9d658	2026-02-02 11:13:33.049424+00	2026-02-02 11:13:33.049424+00	password	b6a269e0-d342-45f3-ac12-d89d192caab0
d765e20b-c617-4674-8009-0cccfea2ec0b	2026-02-05 10:14:16.970582+00	2026-02-05 10:14:16.970582+00	password	63f22cdb-534b-4f16-97e7-585c8c885084
41f8598e-1ba2-4db6-86b2-ae41bb9f3ecd	2026-02-06 13:37:52.853055+00	2026-02-06 13:37:52.853055+00	password	a86dd0a7-280e-4dc1-bb90-0b0598f55ff4
da238deb-e120-4679-912a-7fdd4003a1ab	2026-02-06 17:04:00.475911+00	2026-02-06 17:04:00.475911+00	password	cf12c547-c48a-467c-986b-0e04ab6a4f3d
e974d003-a64c-4a0d-92ce-b52a3a5bb33b	2026-02-06 21:16:41.191409+00	2026-02-06 21:16:41.191409+00	password	49e42558-5f1e-43b9-8646-aaea5bfcdc5c
5084d6b7-03b5-4fec-a3fe-8c3a161fb2f9	2026-02-12 10:41:28.311803+00	2026-02-12 10:41:28.311803+00	password	388198f5-863d-47e2-b8e9-635d5f847c6a
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	1	62zcmksvosz4	ea361323-5bae-4576-b105-60431ab12a9f	f	2025-07-09 13:42:32.929286+00	2025-07-09 13:42:32.929286+00	\N	066ebf8d-b598-4b0c-b21f-246c38959e5c
00000000-0000-0000-0000-000000000000	2	gpidpwk7aiav	ea361323-5bae-4576-b105-60431ab12a9f	f	2025-07-09 13:43:54.358413+00	2025-07-09 13:43:54.358413+00	\N	ff1a16ed-101e-4836-bd83-d5b6ab563fe5
00000000-0000-0000-0000-000000000000	3	vxeuges6xx4y	ea361323-5bae-4576-b105-60431ab12a9f	f	2025-07-09 13:44:20.35787+00	2025-07-09 13:44:20.35787+00	\N	8b5e2c2c-b127-4b09-850d-126b8dc7ffda
00000000-0000-0000-0000-000000000000	107	cj2iq7zajs6d	e2c75f25-805f-4086-bd3e-9c1fc1f0c9c2	f	2025-07-31 00:14:46.506643+00	2025-07-31 00:14:46.506643+00	\N	0f5c6cec-6b60-4566-a9fc-29c0bad884ea
00000000-0000-0000-0000-000000000000	108	w7euoltksqn5	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 00:57:11.474414+00	2025-07-31 01:56:38.481194+00	\N	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	50	6dk24rvabk5k	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 14:38:03.768442+00	2025-07-18 15:37:27.844363+00	\N	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	51	iimbcfph7bm5	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 15:37:27.846358+00	2025-07-18 16:36:57.565873+00	6dk24rvabk5k	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	109	l3mugrygt6xr	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 01:56:38.483667+00	2025-07-31 02:56:02.25672+00	w7euoltksqn5	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	52	3b64gewc2lxr	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 16:36:57.568458+00	2025-07-18 17:36:28.308183+00	iimbcfph7bm5	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	53	qhecafibwz7w	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 17:36:28.310077+00	2025-07-18 18:35:58.946489+00	3b64gewc2lxr	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	110	byipnjb4gljm	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 02:56:02.258598+00	2025-07-31 04:00:47.265746+00	l3mugrygt6xr	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	54	brrjyogla72n	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 18:35:58.94771+00	2025-07-18 19:36:45.581907+00	qhecafibwz7w	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	55	2sxyg56lvi2s	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 19:36:45.58438+00	2025-07-18 20:36:15.780355+00	brrjyogla72n	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	111	s3frwkru36m5	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 04:00:47.266408+00	2025-07-31 05:07:37.696581+00	byipnjb4gljm	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	56	va7ruhrpuhyp	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 20:36:15.781664+00	2025-07-18 21:35:45.288846+00	2sxyg56lvi2s	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	112	rtq4hkph55ua	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 05:07:37.697264+00	2025-07-31 08:44:40.378907+00	s3frwkru36m5	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	58	ttmttpfdjtfv	67c4a209-c6b6-499f-900e-33d9c1c82012	t	2025-07-19 00:29:13.072798+00	2025-07-19 07:40:08.608753+00	\N	317fff41-f0e8-4ac3-b4a2-6368da2912d3
00000000-0000-0000-0000-000000000000	59	mxipczrlzenx	67c4a209-c6b6-499f-900e-33d9c1c82012	f	2025-07-19 07:40:08.616665+00	2025-07-19 07:40:08.616665+00	ttmttpfdjtfv	317fff41-f0e8-4ac3-b4a2-6368da2912d3
00000000-0000-0000-0000-000000000000	57	6njwilttjwt2	ea361323-5bae-4576-b105-60431ab12a9f	t	2025-07-18 21:35:45.290145+00	2025-07-19 08:13:04.52371+00	va7ruhrpuhyp	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	60	a5m2rxy6nnqm	ea361323-5bae-4576-b105-60431ab12a9f	f	2025-07-19 08:13:04.52511+00	2025-07-19 08:13:04.52511+00	6njwilttjwt2	d33a433d-6615-4f60-904c-52e4c77cbfa4
00000000-0000-0000-0000-000000000000	61	u3tryis42ubk	57693c4b-8462-4c29-ad82-9103d5b3e33c	f	2025-07-19 12:08:43.276751+00	2025-07-19 12:08:43.276751+00	\N	6165a2f4-3f9e-4f27-9ac6-44e8acec44b8
00000000-0000-0000-0000-000000000000	62	g2h5i5mgbbqk	57693c4b-8462-4c29-ad82-9103d5b3e33c	f	2025-07-19 12:40:54.666391+00	2025-07-19 12:40:54.666391+00	\N	20934d46-5b13-46b8-abf5-593ec47d5dea
00000000-0000-0000-0000-000000000000	113	wdajioeob34u	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 08:44:40.400357+00	2025-07-31 09:47:05.966164+00	rtq4hkph55ua	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	114	d5427kd7h5zz	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 09:47:05.968891+00	2025-07-31 10:46:35.574706+00	wdajioeob34u	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	115	5seq6zup7otx	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 10:46:35.575371+00	2025-07-31 11:46:05.478901+00	d5427kd7h5zz	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	116	glx2yaypuw7a	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 11:46:05.485378+00	2025-07-31 21:14:33.390739+00	5seq6zup7otx	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	117	2vbsz3r6uxpg	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 21:14:33.399949+00	2025-07-31 22:14:00.759788+00	glx2yaypuw7a	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	118	y3ukuwbr4rau	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 22:14:00.762375+00	2025-07-31 23:13:30.891214+00	2vbsz3r6uxpg	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	119	nwih2w7fl2tn	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-07-31 23:13:30.893067+00	2025-08-01 00:13:00.928759+00	y3ukuwbr4rau	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	120	3nszxnvtsyy4	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 00:13:00.933442+00	2025-08-01 01:12:30.805812+00	nwih2w7fl2tn	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	121	fq6rqyv76q6n	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 01:12:30.807143+00	2025-08-01 02:12:00.799751+00	3nszxnvtsyy4	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	122	awm7xs7d5z7l	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 02:12:00.802264+00	2025-08-01 03:11:31.329919+00	fq6rqyv76q6n	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	76	mmues666nghv	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-28 09:26:46.589848+00	2025-07-28 11:36:48.606974+00	\N	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	123	idf2ssjm2yv7	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 03:11:31.331824+00	2025-08-01 06:43:09.329904+00	awm7xs7d5z7l	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	79	l4btxo2hxl4x	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-28 11:36:48.608379+00	2025-07-28 12:53:08.404686+00	mmues666nghv	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	126	vdjjadmnloz5	2bd5f804-d025-4d99-8e8e-3cc978369df7	f	2025-08-01 07:18:05.403795+00	2025-08-01 07:18:05.403795+00	\N	c2a0237d-f0e6-4d86-be6a-bd4b310127f5
00000000-0000-0000-0000-000000000000	102	rppg57bsq5cp	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-30 14:56:37.277965+00	2025-08-01 07:48:00.1893+00	gx6rvgvkpwjj	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	127	tkh36nylwsf2	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-08-01 07:48:00.191146+00	2025-08-01 09:20:32.173834+00	rppg57bsq5cp	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	124	ex3zb3d3rach	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 06:43:09.333746+00	2025-08-01 11:24:05.318143+00	idf2ssjm2yv7	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	129	cudfljwvt6kj	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 11:24:05.321147+00	2025-08-01 12:23:52.300795+00	ex3zb3d3rach	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	81	4734ulw3oivu	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-28 12:53:08.407883+00	2025-07-28 19:49:35.076929+00	l4btxo2hxl4x	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	130	7d2vycgmgmdy	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 12:23:52.302212+00	2025-08-01 13:23:27.723406+00	cudfljwvt6kj	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	131	rodwetnlpo3n	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 13:23:27.726487+00	2025-08-01 14:23:12.959126+00	7d2vycgmgmdy	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	132	2xyvdjeaxaxv	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 14:23:12.960509+00	2025-08-01 15:22:49.476354+00	rodwetnlpo3n	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	128	rn4zzpntg7wi	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-08-01 09:20:32.175703+00	2025-08-03 09:32:27.882428+00	tkh36nylwsf2	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	87	qhdmsd22my55	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-28 19:49:35.078961+00	2025-07-29 16:47:17.77698+00	4734ulw3oivu	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	99	lj7vwlrs5a7r	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-29 16:47:17.780731+00	2025-07-30 11:21:45.930473+00	qhdmsd22my55	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	69	og7owlqc3zdk	b46499fb-122c-4a98-a506-09254fa8451c	t	2025-07-21 06:17:36.821996+00	2025-07-30 14:55:24.814147+00	\N	5abc898c-1077-4a33-9487-f145c03791e2
00000000-0000-0000-0000-000000000000	101	yi26nfwuteq2	b46499fb-122c-4a98-a506-09254fa8451c	f	2025-07-30 14:55:24.818157+00	2025-07-30 14:55:24.818157+00	og7owlqc3zdk	5abc898c-1077-4a33-9487-f145c03791e2
00000000-0000-0000-0000-000000000000	100	gx6rvgvkpwjj	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	t	2025-07-30 11:21:45.947456+00	2025-07-30 14:56:37.277317+00	lj7vwlrs5a7r	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	172	kjwtam7k4znl	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 19:16:41.394457+00	2025-08-12 20:16:30.894431+00	viwxczopavld	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	133	szkvvxutpbsv	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 15:22:49.477604+00	2025-08-01 16:22:21.095549+00	2xyvdjeaxaxv	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	173	q7suw2427jad	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 20:16:30.897307+00	2025-08-12 21:16:21.56295+00	kjwtam7k4znl	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	134	qebt44w27faw	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 16:22:21.099812+00	2025-08-01 17:21:53.153602+00	szkvvxutpbsv	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	231	fz2ywyiz4reh	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-09 16:33:46.524611+00	2025-11-09 20:59:24.001275+00	\N	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	135	neef2c6re72w	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 17:21:53.156503+00	2025-08-01 18:21:42.812093+00	qebt44w27faw	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	174	3d6dezixkzrk	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 21:16:21.567742+00	2025-08-13 10:31:17.447554+00	q7suw2427jad	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	136	xqtmtyomw2sc	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 18:21:42.814092+00	2025-08-01 19:21:16.916166+00	neef2c6re72w	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	175	gexbmktfphaq	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-13 10:31:17.466002+00	2025-08-13 11:31:05.513418+00	3d6dezixkzrk	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	137	yiow5hnbzfrx	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 19:21:16.918654+00	2025-08-01 20:20:51.668499+00	xqtmtyomw2sc	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	138	cewass6cmwj4	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 20:20:51.671344+00	2025-08-01 21:20:25.102939+00	yiow5hnbzfrx	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	176	qlh6ef24aosz	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-13 11:31:05.516371+00	2025-08-13 12:30:33.029358+00	gexbmktfphaq	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	139	yzgfnpksq6db	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 21:20:25.104779+00	2025-08-01 22:20:05.755472+00	cewass6cmwj4	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	140	sfywd35vnyxd	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 22:20:05.756782+00	2025-08-01 23:19:35.885222+00	yzgfnpksq6db	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	177	hp4tkhw7rje7	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-13 12:30:33.033125+00	2025-08-13 13:35:06.573486+00	qlh6ef24aosz	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	142	e3aexbcv3s3b	2a48727b-7bea-49d2-bcae-f6c70ed8c74a	f	2025-08-03 09:32:27.899873+00	2025-08-03 09:32:27.899873+00	rn4zzpntg7wi	6f7825dd-4e6d-40b2-84ee-d8c1061dc52d
00000000-0000-0000-0000-000000000000	144	jfqel2so4qg6	a7386c56-a39f-4e2c-b25c-4f75f2daa891	f	2025-08-04 12:44:06.911223+00	2025-08-04 12:44:06.911223+00	\N	d35b356a-c740-441d-af86-a946eaea0e6f
00000000-0000-0000-0000-000000000000	178	4fqwdw22inya	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-13 13:35:06.576686+00	2025-08-13 14:34:54.04755+00	hp4tkhw7rje7	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	141	k6nsiw5d6rht	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-01 23:19:35.888263+00	2025-08-04 13:54:13.997751+00	sfywd35vnyxd	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	146	6gjeacricpai	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-04 13:54:14.003531+00	2025-08-04 14:53:46.592788+00	k6nsiw5d6rht	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	180	d35pmx2bnv6e	45e66ac4-dc43-45c9-910a-e92646926526	f	2025-08-19 13:36:16.435508+00	2025-08-19 13:36:16.435508+00	\N	9d97362c-9c4a-4e02-b5b9-daf94214a28d
00000000-0000-0000-0000-000000000000	147	vm7hwq3p4cu3	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-04 14:53:46.596509+00	2025-08-04 15:53:16.267468+00	6gjeacricpai	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	181	tncymtvdscwt	a13fba99-ccb5-48ad-a2e5-eb379767a5e6	f	2025-08-25 09:19:12.956111+00	2025-08-25 09:19:12.956111+00	\N	92754a86-9290-4d49-b846-deaffbe04515
00000000-0000-0000-0000-000000000000	182	pezgidobyakd	8b8056e7-e34f-474c-986c-ac698413736b	f	2025-08-25 13:10:05.15825+00	2025-08-25 13:10:05.15825+00	\N	c793022c-1ad6-45bc-8934-8bd68513b895
00000000-0000-0000-0000-000000000000	183	24hzv3aggwxi	43e35414-aa55-4234-a9c1-3e32246ceac0	f	2025-08-25 13:22:49.954936+00	2025-08-25 13:22:49.954936+00	\N	84715ca3-f3ab-4cf5-870d-581fbac515b2
00000000-0000-0000-0000-000000000000	149	ijx56thxru4h	89f818c2-c79f-4eb1-b931-a2029983f13f	t	2025-08-04 16:57:09.389921+00	2025-08-05 06:05:20.376649+00	\N	d6bf989f-9bc5-4c17-9e5d-56e328ec7e13
00000000-0000-0000-0000-000000000000	150	t6upk2npwj5y	2ce65c9c-3a94-42c7-b603-52b7abfa1858	t	2025-08-05 00:38:58.983428+00	2025-08-06 06:15:03.155366+00	\N	fdf8d946-dc94-4be1-8902-a478e1569463
00000000-0000-0000-0000-000000000000	148	zig436ycwdnj	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-04 15:53:16.27265+00	2025-08-06 16:42:08.340354+00	vm7hwq3p4cu3	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	185	lhib7qbued2w	08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	f	2025-08-26 13:13:06.54982+00	2025-08-26 13:13:06.54982+00	\N	711a5e41-bc8b-4c04-91d3-1eb5c5c8bbfe
00000000-0000-0000-0000-000000000000	153	soxe3ob5tcyl	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-06 16:42:08.353752+00	2025-08-06 17:41:44.744589+00	zig436ycwdnj	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	184	zjzntfityavf	43e35414-aa55-4234-a9c1-3e32246ceac0	t	2025-08-25 14:12:13.057074+00	2025-08-26 20:43:24.245388+00	\N	cbaa2eb6-d3e9-4aa4-8a33-a53ab8ac4074
00000000-0000-0000-0000-000000000000	154	kmipz6jpgf5o	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-06 17:41:44.748788+00	2025-08-06 19:10:14.40516+00	soxe3ob5tcyl	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	179	fd4tnleqfpfq	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-13 14:34:54.050269+00	2025-09-01 08:23:23.39674+00	4fqwdw22inya	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	155	pimwcno4b5a4	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-06 19:10:14.409847+00	2025-08-06 20:09:41.50652+00	kmipz6jpgf5o	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	152	446pc2yqlm4y	2ce65c9c-3a94-42c7-b603-52b7abfa1858	t	2025-08-06 06:15:03.173816+00	2025-10-02 11:54:17.252891+00	t6upk2npwj5y	fdf8d946-dc94-4be1-8902-a478e1569463
00000000-0000-0000-0000-000000000000	151	qtdp52fikj5r	89f818c2-c79f-4eb1-b931-a2029983f13f	t	2025-08-05 06:05:20.379872+00	2025-08-10 21:13:01.009988+00	ijx56thxru4h	d6bf989f-9bc5-4c17-9e5d-56e328ec7e13
00000000-0000-0000-0000-000000000000	157	r3sovz2ax53h	89f818c2-c79f-4eb1-b931-a2029983f13f	f	2025-08-10 21:13:01.037279+00	2025-08-10 21:13:01.037279+00	qtdp52fikj5r	d6bf989f-9bc5-4c17-9e5d-56e328ec7e13
00000000-0000-0000-0000-000000000000	156	dkqmpnhnwpe3	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-06 20:09:41.51122+00	2025-08-11 07:20:54.330407+00	pimwcno4b5a4	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	158	ddl3ftxyd4lp	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 07:20:54.34453+00	2025-08-11 08:32:55.511575+00	dkqmpnhnwpe3	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	159	a7vytahixsq6	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 08:32:55.516172+00	2025-08-11 10:23:20.890102+00	ddl3ftxyd4lp	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	160	lky3fxnt5th6	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 10:23:20.894667+00	2025-08-11 11:22:57.281485+00	a7vytahixsq6	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	161	gdjq47vheafq	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 11:22:57.284093+00	2025-08-11 12:22:22.779596+00	lky3fxnt5th6	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	162	qh7h6ijnild4	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 12:22:22.783029+00	2025-08-11 14:23:52.35607+00	gdjq47vheafq	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	163	2b4tvmuhicap	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 14:23:52.360063+00	2025-08-11 15:24:00.44361+00	qh7h6ijnild4	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	164	anmydm4vdqwa	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 15:24:00.447719+00	2025-08-11 16:24:10.18005+00	2b4tvmuhicap	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	165	ak5przojamc6	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 16:24:10.184058+00	2025-08-11 17:24:30.984813+00	anmydm4vdqwa	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	166	bsa2omw2xmjl	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 17:24:30.987638+00	2025-08-11 18:24:44.136345+00	ak5przojamc6	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	167	oesdzp6panus	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 18:24:44.141879+00	2025-08-11 19:24:14.292526+00	bsa2omw2xmjl	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	168	6qmzsfqwghqa	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-11 19:24:14.297204+00	2025-08-12 16:17:16.515502+00	oesdzp6panus	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	169	iwwgww76dwo3	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 16:17:16.536868+00	2025-08-12 17:17:00.421996+00	6qmzsfqwghqa	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	170	scgotkqqtitz	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 17:17:00.427271+00	2025-08-12 18:16:50.848724+00	iwwgww76dwo3	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	171	viwxczopavld	ffbcebc8-ae9d-42db-a927-c1f1985d5877	t	2025-08-12 18:16:50.853565+00	2025-08-12 19:16:41.389884+00	scgotkqqtitz	6dddf6da-bdb6-4ef3-a4f4-e9096a969320
00000000-0000-0000-0000-000000000000	186	53i3noykj34a	43e35414-aa55-4234-a9c1-3e32246ceac0	f	2025-08-26 20:43:24.252649+00	2025-08-26 20:43:24.252649+00	zjzntfityavf	cbaa2eb6-d3e9-4aa4-8a33-a53ab8ac4074
00000000-0000-0000-0000-000000000000	187	cp4xs5t3vu3b	11bccca2-f952-4946-ac1c-00afcb665580	f	2025-09-01 12:28:24.249914+00	2025-09-01 12:28:24.249914+00	\N	6a2aae76-7b87-4a3b-8640-14cb1f97942e
00000000-0000-0000-0000-000000000000	232	cqmgex3s5nhp	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-09 20:59:24.006522+00	2025-11-09 22:01:01.432888+00	fz2ywyiz4reh	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	233	oocztd4s6dch	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-09 22:01:01.434552+00	2025-11-09 23:12:29.312281+00	cqmgex3s5nhp	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	234	lkm4vwxbdmn6	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-09 23:12:29.318834+00	2025-11-10 00:32:18.434982+00	oocztd4s6dch	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	235	t6wtvlxs7qwm	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 00:32:18.436903+00	2025-11-10 01:36:18.841922+00	lkm4vwxbdmn6	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	236	g755umxtkknu	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 01:36:18.847145+00	2025-11-10 02:48:11.72134+00	t6wtvlxs7qwm	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	237	kqakvp6vfmpz	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 02:48:11.725465+00	2025-11-10 04:44:54.192881+00	g755umxtkknu	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	238	647bh4zbw6yb	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 04:44:54.193513+00	2025-11-10 11:26:29.565218+00	kqakvp6vfmpz	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	239	7rkbsi57o5mk	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 11:26:29.572364+00	2025-11-10 12:25:52.20187+00	647bh4zbw6yb	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	240	tto26hmurmte	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 12:25:52.211531+00	2025-11-10 13:25:27.073464+00	7rkbsi57o5mk	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	241	7r3y6y37vzdx	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 13:25:27.083036+00	2025-11-10 15:02:17.423751+00	tto26hmurmte	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	242	aum6ennflx5b	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 15:02:17.444996+00	2025-11-10 16:02:41.75836+00	7r3y6y37vzdx	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	243	su6l4apndlxz	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 16:02:41.768795+00	2025-11-10 17:07:43.494457+00	aum6ennflx5b	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	244	fxqpfs47bqgx	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 17:07:43.511389+00	2025-11-10 18:07:13.864017+00	su6l4apndlxz	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	202	hxg6lyksclub	2ce65c9c-3a94-42c7-b603-52b7abfa1858	f	2025-10-02 11:54:17.270397+00	2025-10-02 11:54:17.270397+00	446pc2yqlm4y	fdf8d946-dc94-4be1-8902-a478e1569463
00000000-0000-0000-0000-000000000000	245	yydsjsbpj4sy	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 18:07:13.87086+00	2025-11-10 19:16:41.403353+00	fxqpfs47bqgx	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	246	jbwivdsjcp54	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 19:16:41.418592+00	2025-11-10 20:16:09.754968+00	yydsjsbpj4sy	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	247	2htm5uqe3fdl	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 20:16:09.76709+00	2025-11-10 21:15:38.952269+00	jbwivdsjcp54	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	248	ai5e6t7y3gmd	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 21:15:38.962764+00	2025-11-10 23:26:20.758147+00	2htm5uqe3fdl	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	249	p5mhvwx4lwg5	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-10 23:26:20.782344+00	2025-11-11 00:26:29.795534+00	ai5e6t7y3gmd	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	250	nehnreeswj4g	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	t	2025-11-11 00:26:29.810324+00	2025-11-11 01:26:25.672251+00	p5mhvwx4lwg5	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	251	b3c74qrth56r	a1d57ac1-f3e1-4c99-a01b-d494d6e76414	f	2025-11-11 01:26:25.680528+00	2025-11-11 01:26:25.680528+00	nehnreeswj4g	9e58de9b-5a77-4011-ab03-80640d01547e
00000000-0000-0000-0000-000000000000	217	o3ynlrkpopux	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	t	2025-11-03 17:20:42.815348+00	2025-11-11 05:00:44.811331+00	7itoscoxj7ua	b8f11270-50a8-4dbd-aad5-4de646ea3d3f
00000000-0000-0000-0000-000000000000	252	j2rsk6qnodsl	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	f	2025-11-11 05:00:44.833572+00	2025-11-11 05:00:44.833572+00	o3ynlrkpopux	b8f11270-50a8-4dbd-aad5-4de646ea3d3f
00000000-0000-0000-0000-000000000000	253	z4puzt3rg4ou	11c89725-d719-4aa3-b1d6-d5808e415385	f	2026-02-02 09:33:24.12606+00	2026-02-02 09:33:24.12606+00	\N	5271b17d-8c72-4d12-948b-343efeb22c91
00000000-0000-0000-0000-000000000000	254	gchjh7glts3z	f05b7d85-385c-451b-915b-336bb7611aa3	f	2026-02-02 10:16:59.455633+00	2026-02-02 10:16:59.455633+00	\N	50a4efee-4e36-49fb-adcd-7fb9060356c7
00000000-0000-0000-0000-000000000000	210	sidrumtacutp	0c0104ab-723d-45c1-9603-a9f12aeaab20	t	2025-10-31 07:56:22.067895+00	2025-10-31 13:33:28.459276+00	\N	badc0a37-03d5-4443-83f1-0314a3ba8dcd
00000000-0000-0000-0000-000000000000	255	irghf4pgj56y	7307b2d1-0767-44b9-b1e8-a59e222ffa2a	f	2026-02-02 10:21:08.199717+00	2026-02-02 10:21:08.199717+00	\N	68c1d80a-8b56-4269-be50-a191df4ed324
00000000-0000-0000-0000-000000000000	211	g735mpegc3mn	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	t	2025-10-31 09:28:09.395596+00	2025-10-31 16:33:15.821822+00	\N	b8f11270-50a8-4dbd-aad5-4de646ea3d3f
00000000-0000-0000-0000-000000000000	256	jba5ss5ly573	2c738a07-f482-4f35-99e3-0de3ef3798a9	f	2026-02-02 10:58:06.79741+00	2026-02-02 10:58:06.79741+00	\N	803d14ef-a6dc-4c49-8a77-b14097959f3e
00000000-0000-0000-0000-000000000000	212	4dpmgh3v35yv	0c0104ab-723d-45c1-9603-a9f12aeaab20	t	2025-10-31 13:33:28.462582+00	2025-11-01 09:59:41.29658+00	sidrumtacutp	badc0a37-03d5-4443-83f1-0314a3ba8dcd
00000000-0000-0000-0000-000000000000	257	2hviud53vrvw	d202bc66-2e79-4bd8-a630-bcb6df1e09ef	f	2026-02-02 11:07:16.139747+00	2026-02-02 11:07:16.139747+00	\N	e4d34a46-f4bd-4c71-9c98-414fb80e80a8
00000000-0000-0000-0000-000000000000	213	tk7ht7aaorrk	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	t	2025-10-31 16:33:15.82256+00	2025-11-01 13:59:48.007534+00	g735mpegc3mn	b8f11270-50a8-4dbd-aad5-4de646ea3d3f
00000000-0000-0000-0000-000000000000	258	7sd5uyeowyyh	8f57cb78-e830-47f6-a492-e590a63f834d	f	2026-02-02 11:13:33.037209+00	2026-02-02 11:13:33.037209+00	\N	0097fcee-892d-46f7-8d25-0a0433a9d658
00000000-0000-0000-0000-000000000000	214	xfooojdjmgz6	0c0104ab-723d-45c1-9603-a9f12aeaab20	t	2025-11-01 09:59:41.310842+00	2025-11-01 14:11:32.518298+00	4dpmgh3v35yv	badc0a37-03d5-4443-83f1-0314a3ba8dcd
00000000-0000-0000-0000-000000000000	216	gydr2gs6zpdz	0c0104ab-723d-45c1-9603-a9f12aeaab20	f	2025-11-01 14:11:32.518938+00	2025-11-01 14:11:32.518938+00	xfooojdjmgz6	badc0a37-03d5-4443-83f1-0314a3ba8dcd
00000000-0000-0000-0000-000000000000	215	7itoscoxj7ua	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	t	2025-11-01 13:59:48.013835+00	2025-11-03 17:20:42.802962+00	tk7ht7aaorrk	b8f11270-50a8-4dbd-aad5-4de646ea3d3f
00000000-0000-0000-0000-000000000000	264	37v6yllfjw5o	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	f	2026-02-05 10:14:16.935835+00	2026-02-05 10:14:16.935835+00	\N	d765e20b-c617-4674-8009-0cccfea2ec0b
00000000-0000-0000-0000-000000000000	266	d3zyf3dc5xtv	593b4915-f840-4faf-b8ea-5639581e5ba6	t	2026-02-06 13:37:52.850591+00	2026-02-06 15:05:47.069559+00	\N	41f8598e-1ba2-4db6-86b2-ae41bb9f3ecd
00000000-0000-0000-0000-000000000000	267	6wmsoz2qk4l2	593b4915-f840-4faf-b8ea-5639581e5ba6	f	2026-02-06 15:05:47.088894+00	2026-02-06 15:05:47.088894+00	d3zyf3dc5xtv	41f8598e-1ba2-4db6-86b2-ae41bb9f3ecd
00000000-0000-0000-0000-000000000000	269	rn7pkv7lzrnr	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 17:04:00.467595+00	2026-02-06 18:10:55.982478+00	\N	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	270	pwrtvjeejxxw	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 18:10:56.003811+00	2026-02-06 19:10:35.012176+00	rn7pkv7lzrnr	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	271	j4jt7iacwrwv	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 19:10:35.030808+00	2026-02-06 20:14:44.7965+00	pwrtvjeejxxw	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	273	35uu5ec64bvu	fe953905-9ef8-4c6d-be09-442444285581	f	2026-02-06 21:16:41.167178+00	2026-02-06 21:16:41.167178+00	\N	e974d003-a64c-4a0d-92ce-b52a3a5bb33b
00000000-0000-0000-0000-000000000000	272	5oarqmwjtxow	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 20:14:44.810307+00	2026-02-06 21:58:48.499354+00	j4jt7iacwrwv	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	274	3xymknzw57gk	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 21:58:48.509315+00	2026-02-06 22:58:14.033607+00	5oarqmwjtxow	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	275	dt6d6bcjukod	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-06 22:58:14.047186+00	2026-02-07 00:35:08.56425+00	3xymknzw57gk	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	276	exu7phkadr2t	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-07 00:35:08.583339+00	2026-02-07 12:11:45.044198+00	dt6d6bcjukod	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	277	d3uhmpp47saq	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-07 12:11:45.063554+00	2026-02-07 13:11:08.588966+00	exu7phkadr2t	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	278	pmsnic3krqaj	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-07 13:11:08.603283+00	2026-02-08 10:44:27.975833+00	d3uhmpp47saq	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	279	4ip6vbju3xpn	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 10:44:28.007277+00	2026-02-08 11:45:54.900072+00	pmsnic3krqaj	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	280	57tezivl5kne	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 11:45:54.91216+00	2026-02-08 12:45:25.80734+00	4ip6vbju3xpn	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	281	6buqoh2bz62t	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 12:45:25.82715+00	2026-02-08 13:45:03.67528+00	57tezivl5kne	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	282	lgxedbttiav2	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 13:45:03.686886+00	2026-02-08 14:44:29.821487+00	6buqoh2bz62t	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	283	sc4nep5m6dp3	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 14:44:29.840673+00	2026-02-08 15:43:58.866176+00	lgxedbttiav2	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	284	tadkpuksqqzz	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 15:43:58.888272+00	2026-02-08 16:43:48.201894+00	sc4nep5m6dp3	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	285	vdlazuilq6ii	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 16:43:48.215956+00	2026-02-08 17:43:23.855154+00	tadkpuksqqzz	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	286	pxuqpdqsmk7d	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 17:43:23.876953+00	2026-02-08 21:46:53.194828+00	vdlazuilq6ii	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	287	6ytgskvlz6er	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-08 21:46:53.214894+00	2026-02-09 04:26:36.747272+00	pxuqpdqsmk7d	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	288	hpyb3ph2hpyy	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-09 04:26:36.765247+00	2026-02-09 07:40:24.149888+00	6ytgskvlz6er	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	289	tkfirvh22d3m	7720f8b9-5587-4fac-a275-3c59cf19f5d3	t	2026-02-09 07:40:24.168825+00	2026-02-09 08:39:54.968944+00	hpyb3ph2hpyy	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	290	7ylnqj5rn5br	7720f8b9-5587-4fac-a275-3c59cf19f5d3	f	2026-02-09 08:39:54.988173+00	2026-02-09 08:39:54.988173+00	tkfirvh22d3m	da238deb-e120-4679-912a-7fdd4003a1ab
00000000-0000-0000-0000-000000000000	291	r5gwflijtdew	749539bf-ce98-420c-8093-d3ea0de95610	t	2026-02-12 10:41:28.283816+00	2026-02-12 11:48:06.564785+00	\N	5084d6b7-03b5-4fec-a3fe-8c3a161fb2f9
00000000-0000-0000-0000-000000000000	292	e3u3vwx2ysk2	749539bf-ce98-420c-8093-d3ea0de95610	f	2026-02-12 11:48:06.588818+00	2026-02-12 11:48:06.588818+00	r5gwflijtdew	5084d6b7-03b5-4fec-a3fe-8c3a161fb2f9
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."batches" ("id", "user_id", "name", "bird_type", "age_in_days", "total_chickens", "created_at", "price_per_bird") FROM stdin;
9a1d0f39-6466-40ea-bcce-4b467288b40d	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	brooko	broiler	2	230	2026-02-05 13:16:20.873649	150.00
9b1449ab-ca7b-49dc-ab44-a075005e2942	593b4915-f840-4faf-b8ea-5639581e5ba6	Jina	broiler	20	20	2026-02-06 16:39:20.016068	100.00
7b92d2bf-fed2-42f0-b58b-495f48868a04	ea361323-5bae-4576-b105-60431ab12a9f	Test Batch 	broiler	7	8	2025-07-09 17:31:58.812838	0.00
646cb6ae-320c-4ed6-aa11-dde333a705ee	ea361323-5bae-4576-b105-60431ab12a9f	Layer batch 1	broiler	6	50	2025-07-10 02:03:47.384759	0.00
bcbb4c1a-5566-4758-93fb-9762718e8aea	ea361323-5bae-4576-b105-60431ab12a9f	Big batch	kienyeji	3	10	2025-07-17 00:28:23.608639	0.00
522768f3-618e-43fe-912d-166b328abbc7	ea361323-5bae-4576-b105-60431ab12a9f	Mayai Batch	layer	24	50	2025-07-17 16:24:34.81847	0.00
98ff4379-44dc-4b75-abe7-235b027c56cb	ea361323-5bae-4576-b105-60431ab12a9f	Kienyaji test batch	kienyeji	3	20	2025-07-18 19:14:28.590565	0.00
d3b6c7c3-d5c0-4f54-8cc0-a919be2418ec	67c4a209-c6b6-499f-900e-33d9c1c82012	Batch 1 	broiler	3	20	2025-07-19 03:35:47.474689	0.00
17cd6388-be3c-4658-82e7-06e9fdc3cf78	2bd5f804-d025-4d99-8e8e-3cc978369df7	001	kienyeji	120	50	2025-07-22 08:47:07.599805	0.00
e3a453f0-bd7d-4258-b33b-c574e8df0a3f	7720f8b9-5587-4fac-a275-3c59cf19f5d3	tst	broiler	4	0	2026-02-07 00:59:44.105361	100.00
78d0a5f3-0b43-47f1-984d-b17afe1498b6	7720f8b9-5587-4fac-a275-3c59cf19f5d3	Test Layer	layer	1	92	2026-02-07 01:39:37.050166	100.00
a5be5acc-a800-4f31-952f-c9ef7694b767	2ce65c9c-3a94-42c7-b603-52b7abfa1858	brood A	broiler	5	150	2025-08-05 03:42:39.48963	0.00
e89a034a-acb9-4527-bcaa-76d1c48906bc	2ce65c9c-3a94-42c7-b603-52b7abfa1858	brood b	kienyeji	8	200	2025-08-05 03:45:45.463011	0.00
6fbdf340-4a8a-4869-bd80-886dff447093	2ce65c9c-3a94-42c7-b603-52b7abfa1858	Brood c	broiler	8	200	2025-08-06 09:15:42.757456	0.00
c2c0d549-92e8-42be-a59a-4c51fb306c37	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	ringo	layer	30	200	2025-10-31 12:36:01.83974	600.00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."users" ("id", "full_name", "phone_number", "created_at", "is_test_user", "updated_at", "recovery_question", "recovery_answer") FROM stdin;
7720f8b9-5587-4fac-a275-3c59cf19f5d3	Christine	0712345678	2026-02-06 17:04:01.591802+00	t	2026-02-06 17:04:01.591802+00	\N	\N
fe953905-9ef8-4c6d-be09-442444285581	Ronnie Coleman	0456741963	2026-02-06 21:16:41.459061+00	f	2026-02-06 21:16:41.459061+00	question_2	benin
2bd5f804-d025-4d99-8e8e-3cc978369df7	Shem	0715426401	2025-07-22 05:43:14.956388+00	f	2026-02-06 16:55:22.075033+00	\N	\N
749539bf-ce98-420c-8093-d3ea0de95610	Christine	0741934955	2026-02-12 10:41:28.765564+00	f	2026-02-12 10:41:28.765564+00	question_2	nairobi
2ce65c9c-3a94-42c7-b603-52b7abfa1858	Daisy	0703894096	2025-08-05 00:38:59.252709+00	f	2026-02-06 16:55:22.075033+00	\N	\N
45e66ac4-dc43-45c9-910a-e92646926526	Yvvon	+254791650774	2025-08-19 13:36:19.365046+00	f	2026-02-06 16:55:22.075033+00	\N	\N
08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	Clara	0757753427	2025-08-26 13:13:07.514345+00	f	2026-02-06 16:55:22.075033+00	\N	\N
65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	stephen	0706618560	2025-10-31 09:28:09.750313+00	f	2026-02-06 16:55:22.075033+00	\N	\N
593b4915-f840-4faf-b8ea-5639581e5ba6	Test User Christine	0741934955	2026-02-06 13:37:53.22225+00	t	2026-02-06 16:55:22.075033+00	\N	\N
bdf11f2a-687c-4e37-890a-8e7794e0e9ec	kris	077777777	2026-02-05 10:14:17.529438+00	t	2026-02-06 16:55:22.075033+00	\N	\N
74e9227f-a16f-4af0-be98-176cf7727933	christine	0741934955	2026-02-06 16:37:18.9206+00	t	2026-02-06 16:55:22.075033+00	\N	\N
0c0104ab-723d-45c1-9603-a9f12aeaab20	Christine	0741634655	2025-10-31 07:56:22.461857+00	t	2026-02-06 16:55:22.075033+00	\N	\N
\.


--
-- Data for Name: daily_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."daily_records" ("id", "user_id", "record_date", "created_at", "report_date") FROM stdin;
72486c86-3299-4c1f-b581-a4657dce5ae8	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	2026-02-05	2026-02-05 10:18:49.684342	2026-02-05
bd2afdd7-bc19-4bde-a14f-e54277d391e8	7720f8b9-5587-4fac-a275-3c59cf19f5d3	2026-02-07	2026-02-06 22:02:03.913069	2026-02-06
0598f23d-dc68-4fb0-92a9-8e08cb161b64	7720f8b9-5587-4fac-a275-3c59cf19f5d3	2026-02-07	2026-02-06 22:45:05.94095	2026-02-06
7afec175-249f-4f8f-9d15-1fb95581cb77	2ce65c9c-3a94-42c7-b603-52b7abfa1858	2025-08-05	2025-08-05 03:52:04.065337	2025-11-07
3786df28-fe94-4a7c-b0b1-5e7fc27925c8	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	2025-11-01	2025-11-01 14:10:53.746496	2025-11-07
\.


--
-- Data for Name: batch_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."batch_records" ("id", "daily_record_id", "batch_id", "chicken_reduction", "chickens_sold", "chickens_curled", "chickens_died", "chickens_stolen", "eggs_collected", "grade_eggs", "eggs_small", "eggs_deformed", "eggs_standard", "notes", "eggs_broken", "sawdust_in_store", "sawdust_remaining", "feeds_used", "vaccines_used", "other_materials_used", "sales_amount", "losses_amount", "losses_breakdown", "gains_amount") FROM stdin;
e1fe2876-c93b-4960-b7a0-ba74b0a230f3	72486c86-3299-4c1f-b581-a4657dce5ae8	9a1d0f39-6466-40ea-bcce-4b467288b40d	f	0	0	0	0	0	f	\N	0	0	\N	0	\N	\N	[{"name": "growers", "quantity": 2.0}]	[]	[]	0.00	0.0	{}	0.0
50da6db3-84b7-424f-a219-561f82a63c9b	0598f23d-dc68-4fb0-92a9-8e08cb161b64	78d0a5f3-0b43-47f1-984d-b17afe1498b6	t	0	4	0	0	10	f	\N	0	0	\N	0	\N	\N	[{"name": "Food", "quantity": 3.0}]	[]	[]	0.00	400.0	{"curled": 400.0}	0.0
490c0639-c1b1-4f3c-b9ad-ad87b33585f1	7afec175-249f-4f8f-9d15-1fb95581cb77	e89a034a-acb9-4527-bcaa-76d1c48906bc	f	0	0	0	0	100	t	\N	\N	\N	\N	\N	\N	\N	[{"name": "broilers mash ", "quantity": 50.0}]	[]	[]	0.00	0	{}	0
6f770cb7-a7e5-416f-922b-56c1dab21eb6	bd2afdd7-bc19-4bde-a14f-e54277d391e8	e3a453f0-bd7d-4258-b33b-c574e8df0a3f	t	0	0	0	3	0	f	\N	0	0	test for edits	0	\N	\N	[{"name": "Food", "quantity": 5.0}]	[]	[]	0.00	300.0	{"stolen": 300.0}	0.0
51e4c7bf-15c2-486e-a853-15f7045d234d	3786df28-fe94-4a7c-b0b1-5e7fc27925c8	c2c0d549-92e8-42be-a59a-4c51fb306c37	t	0	16	0	0	1011	f	\N	0	0	\N	0	\N	\N	[{"name": "kienyeji mash", "quantity": 1.0}]	[]	[]	0.00	0	{}	0
\.


--
-- Data for Name: dashboard_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."dashboard_summary" ("user_id", "total_feeds", "total_eggs", "total_chickens", "last_updated") FROM stdin;
\.


--
-- Data for Name: farm_summaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."farm_summaries" ("id", "batch_id", "user_id", "date", "total_eggs_collected", "total_feeds_used_items", "total_vaccines_used_items", "total_other_materials_used_items", "total_expenses", "created_at", "updated_at") FROM stdin;
92ec400b-e99a-4b6a-b1e8-660c65fcfb9e	e3a453f0-bd7d-4258-b33b-c574e8df0a3f	7720f8b9-5587-4fac-a275-3c59cf19f5d3	2026-02-06	0	0	0	0	1200.00	2026-02-06 22:02:03.305153+00	2026-02-06 22:19:33.635468+00
710c5623-4d16-4037-add5-2a8bac20fee3	78d0a5f3-0b43-47f1-984d-b17afe1498b6	7720f8b9-5587-4fac-a275-3c59cf19f5d3	2026-02-06	0	0	0	0	800.00	2026-02-06 22:46:13.542519+00	2026-02-06 22:55:45.804876+00
\.


--
-- Data for Name: farms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."farms" ("id", "user_id", "farm_name", "farm_location", "created_at") FROM stdin;
c182e44c-2996-4c69-a9c2-fc0a58d641f0	2bd5f804-d025-4d99-8e8e-3cc978369df7	ShemFarm	Tido	2025-07-22 05:44:22.935914+00
ae729358-bb04-460f-9ead-f1d5cfba5f2a	2ce65c9c-3a94-42c7-b603-52b7abfa1858	Daisy Farm limited	limuru	2025-08-05 00:40:34.675255+00
a696dcb7-bf10-4410-9916-b3e09af237b8	45e66ac4-dc43-45c9-910a-e92646926526	qwack qwack	monaco	2025-08-19 13:36:52.01138+00
efa175d0-b4b0-4499-a789-f1f6ad0a887c	08fa5c97-9a7d-41cf-860c-0b61b0c3c14f	Clara	Kiambu	2025-08-26 13:13:31.148278+00
5247fd8c-36af-4724-a7fd-b9f9a5996d01	0c0104ab-723d-45c1-9603-a9f12aeaab20	Farm	Nairobi	2025-10-31 07:56:54.768421+00
188dd1a6-fdee-4915-8a31-4828a5155cfa	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	Mushi poultry	Nairobi	2025-10-31 09:29:14.739091+00
946e85a7-4ef0-4c73-8972-ac769f1a3072	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	tina	kericho	2026-02-05 10:14:59.079929+00
ab9ec43b-303d-4397-9bb1-22510d777b9f	593b4915-f840-4faf-b8ea-5639581e5ba6	User Shamba	Nairobi	2026-02-06 13:38:53.031084+00
d3717f12-f9a8-4eef-81cd-451d40e65697	74e9227f-a16f-4af0-be98-176cf7727933	farm	Name	2026-02-06 16:39:29.215616+00
b962e3c5-0d4d-4e1c-ad8e-60d1d57d5446	7720f8b9-5587-4fac-a275-3c59cf19f5d3	Farm	Nairibi	2026-02-06 17:04:42.830744+00
7814d2e4-2e1a-4d18-9680-2ffd7614638f	fe953905-9ef8-4c6d-be09-442444285581	farm	Nairobi	2026-02-06 21:20:37.455858+00
6cc628a5-7af3-46d8-b642-fbab2fd1a243	749539bf-ce98-420c-8093-d3ea0de95610	Chris Chicken	Nairobi	2026-02-12 10:42:27.990244+00
\.


--
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."inventory_items" ("id", "user_id", "name", "category", "quantity", "unit", "added_on", "price") FROM stdin;
4ef0513b-8f5e-46a3-a7d8-73a912fc8ff2	bdf11f2a-687c-4e37-890a-8e7794e0e9ec	growers	feed	218	kg	2026-02-05	250.00
176c6cea-73a8-4a9e-b52d-b675f0fa389d	593b4915-f840-4faf-b8ea-5639581e5ba6	test	other	4	kg	2026-02-06	5.00
2d2d50e6-ad79-45ae-8522-6a95e86a5643	ea361323-5bae-4576-b105-60431ab12a9f	New Castle	vaccine	20	L	2025-07-12	0.00
ea3def1e-67fb-443b-a639-e3337ecad884	ea361323-5bae-4576-b105-60431ab12a9f	Broilers Mash	feed	180	kg	2025-07-09	0.00
8fb08684-78f9-44c0-8805-40a19e24b2d1	ea361323-5bae-4576-b105-60431ab12a9f	Briquettes	other	19	kg	2025-07-09	0.00
8fc8d1b4-4f2e-47b3-a0be-ae05cf80d64c	65ed8e3e-ecfe-4f15-9601-0e5b58a64e5e	kienyeji mash	feed	39	kg	2025-11-01	25.00
eedf8414-f772-4a7b-8fdc-dd9e1084c263	ea361323-5bae-4576-b105-60431ab12a9f	GUMBORO	vaccine	10	L	2025-07-09	0.00
f055818c-b50b-4792-bc53-73bac884a107	ea361323-5bae-4576-b105-60431ab12a9f	Sawdust	other	13	kg	2025-07-16	0.00
608649ae-724c-4ec3-9e03-02c433bd87b7	ea361323-5bae-4576-b105-60431ab12a9f	Layers Mash	feed	50	kg	2025-07-16	0.00
fe2d228e-3c2c-4692-af7f-ba0eea481557	ea361323-5bae-4576-b105-60431ab12a9f	Starter Mash	feed	20	kg	2025-07-18	0.00
d4ddac7a-34dc-44f6-94ad-54ee3e56bf9f	67c4a209-c6b6-499f-900e-33d9c1c82012	Broiler mash	feed	50	kg	2025-07-19	0.00
bea00cf5-f6c9-4619-977e-be25b8fa7b5e	67c4a209-c6b6-499f-900e-33d9c1c82012	Starter Mash 	feed	50	kg	2025-07-19	0.00
b1c7dacc-decb-487f-92d7-38e6c8cefe01	7720f8b9-5587-4fac-a275-3c59cf19f5d3	Food	feed	11	kg	2026-02-07	400.00
8157faff-47f3-45ab-bd0c-e545eec6d5f3	2ce65c9c-3a94-42c7-b603-52b7abfa1858	broilersash 	feed	500	kg	2025-08-05	0.00
c2b48cf8-dff3-4976-b026-a3a78609f51f	2ce65c9c-3a94-42c7-b603-52b7abfa1858	oedema 	vaccine	50	kg	2025-08-05	0.00
f9fa98af-46ff-40af-a1f4-dcce4ebe0488	2ce65c9c-3a94-42c7-b603-52b7abfa1858	broilers mash 	feed	550	kg	2025-08-05	0.00
\.


--
-- Data for Name: sales_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."sales_records" ("id", "batch_id", "daily_record_id", "record_date", "item_type", "quantity", "price_per_unit", "total_amount", "created_at", "user_id") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 292, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict 4PMl8bg3uqIqEgGkDARaIE45hVGsoSBR2w1btYBKQANA1vgBmlajzFwGDZDbDPS

RESET ALL;
