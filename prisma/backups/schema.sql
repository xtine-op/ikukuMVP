


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


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."get_batch_profits"() RETURNS TABLE("batch_id" "uuid", "batch_name" "text", "total_sales" numeric, "total_expenses" numeric, "profit" numeric)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        b.id as batch_id,
        b.name as batch_name,
        COALESCE(SUM(s.total_amount), 0) as total_sales,
        COALESCE(SUM(
            CASE 
                WHEN br.feeds_used IS NOT NULL THEN 
                    (SELECT SUM((f->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.feeds_used) as f
                     JOIN inventory_items i ON i.name = f->>'name')
                ELSE 0
            END +
            CASE 
                WHEN br.vaccines_used IS NOT NULL THEN
                    (SELECT SUM((v->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.vaccines_used) as v
                     JOIN inventory_items i ON i.name = v->>'name')
                ELSE 0
            END +
            CASE 
                WHEN br.other_materials_used IS NOT NULL THEN
                    (SELECT SUM((m->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.other_materials_used) as m
                     JOIN inventory_items i ON i.name = m->>'name')
                ELSE 0
            END
        ), 0) as total_expenses,
        COALESCE(SUM(s.total_amount), 0) - COALESCE(SUM(
            CASE 
                WHEN br.feeds_used IS NOT NULL THEN 
                    (SELECT SUM((f->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.feeds_used) as f
                     JOIN inventory_items i ON i.name = f->>'name')
                ELSE 0
            END +
            CASE 
                WHEN br.vaccines_used IS NOT NULL THEN
                    (SELECT SUM((v->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.vaccines_used) as v
                     JOIN inventory_items i ON i.name = v->>'name')
                ELSE 0
            END +
            CASE 
                WHEN br.other_materials_used IS NOT NULL THEN
                    (SELECT SUM((m->>'quantity')::decimal * i.price)
                     FROM jsonb_array_elements(br.other_materials_used) as m
                     JOIN inventory_items i ON i.name = m->>'name')
                ELSE 0
            END
        ), 0) as profit
    FROM batches b
    LEFT JOIN daily_records dr ON dr.user_id = b.user_id
    LEFT JOIN batch_records br ON br.batch_id = b.id AND br.daily_record_id = dr.id
    LEFT JOIN sales_records s ON s.batch_id = b.id
    WHERE b.user_id = auth.uid()
    GROUP BY b.id, b.name;
END;
$$;


ALTER FUNCTION "public"."get_batch_profits"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_farm_data"() RETURNS TABLE("daily_record_id" "uuid", "batch_id" "uuid", "batch_name" "text", "user_id" "uuid", "bird_type" "text", "total_chickens" integer, "price_per_bird" numeric, "chickens_died" integer, "chickens_sold" integer, "eggs_collected" integer, "feeds_used" "jsonb", "vaccines_used" "jsonb", "other_materials_used" "jsonb", "notes" "text", "record_date" "date", "inventory_price" numeric)
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    IF auth.uid() IS NULL THEN
        RAISE EXCEPTION 'Not authenticated';
    END IF;

    RETURN QUERY
    SELECT 
        dr.id,
        b.id,
        b.name,
        b.user_id,
        b.bird_type,
        b.total_chickens,
        b.price_per_bird,
        br.chickens_died,
        br.chickens_sold,
        br.eggs_collected,
        br.feeds_used,
        br.vaccines_used,
        br.other_materials_used,
        br.notes,
        dr.record_date,
        i.price
    FROM public.batches b
    LEFT JOIN public.daily_records dr ON dr.user_id = b.user_id
    LEFT JOIN public.batch_records br ON br.batch_id = b.id AND br.daily_record_id = dr.id
    LEFT JOIN public.inventory_items i ON i.user_id = b.user_id
    WHERE b.user_id = auth.uid();
END;
$$;


ALTER FUNCTION "public"."get_farm_data"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_monthly_farm_summary"("p_user_id" "uuid") RETURNS TABLE("user_id" "uuid", "date" "date", "batch_id" "text", "total_eggs_collected" bigint, "total_feeds_used_items" bigint, "total_vaccines_used_items" bigint, "total_other_materials_used_items" bigint, "total_expenses" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        fs.user_id,
        fs.date,
        fs.batch_id,
        fs.total_eggs_collected,
        fs.total_feeds_used_items,
        fs.total_vaccines_used_items,
        fs.total_other_materials_used_items,
        fs.total_expenses
    FROM
        farm_summaries fs
    WHERE
        fs.user_id = p_user_id
    ORDER BY
        fs.date DESC, fs.batch_id;
END;
$$;


ALTER FUNCTION "public"."get_monthly_farm_summary"("p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."insert_into_farm_base_tables"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    v_daily_record_id UUID;
BEGIN
    -- Insert into daily_records
    INSERT INTO daily_records (user_id, record_date)
    VALUES (NEW.user_id, NEW.date)
    RETURNING id INTO v_daily_record_id;

    -- Insert into batch_records
    INSERT INTO batch_records (daily_record_id, batch_id, eggs_collected, feeds_used, vaccines_used, other_materials_used)
    VALUES (
        v_daily_record_id,
        NEW.batch_id,
        NEW.total_eggs_collected,
        '[]'::jsonb, -- Assuming empty for now, as original data is not available from view insert
        '[]'::jsonb, -- Assuming empty for now
        '[]'::jsonb  -- Assuming empty for now
    );

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."insert_into_farm_base_tables"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_dashboard_summary"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Update the dashboard summary for the user
    UPDATE dashboard_summary
    SET 
        total_feeds = (
            SELECT SUM(quantity)
            FROM inventory_items
            WHERE user_id = NEW.user_id
            AND category = 'feeds'
        ),
        total_eggs = (
            SELECT SUM(eggs_collected)
            FROM batch_records br
            JOIN daily_records dr ON br.daily_record_id = dr.id
            WHERE dr.user_id = NEW.user_id
            AND dr.report_date >= CURRENT_DATE - INTERVAL '7 days'
        ),
        total_chickens = (
            SELECT SUM(total_chickens)
            FROM batches
            WHERE user_id = NEW.user_id
        )
    WHERE user_id = NEW.user_id;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_dashboard_summary"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_expenses_on_bird_death"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- Calculate the cost of dead birds
    DECLARE
        dead_birds_cost DECIMAL(10, 2);
    BEGIN
        -- Get the number of birds that died (difference between old and new count)
        dead_birds_cost := (OLD.total_chickens - NEW.total_chickens) * 
                          COALESCE(NEW.price_per_bird, 0);
        
        -- Only update if birds actually died
        IF dead_birds_cost > 0 THEN
            -- Insert or update the farm summary for the date
            INSERT INTO farm_summaries (
                batch_id,
                user_id,
                date,
                total_expenses
            ) VALUES (
                NEW.id,
                NEW.user_id,
                CURRENT_DATE,
                dead_birds_cost
            )
            ON CONFLICT (batch_id, date) DO UPDATE 
            SET total_expenses = farm_summaries.total_expenses + dead_birds_cost,
                updated_at = timezone('utc'::text, now());
        END IF;
    END;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_expenses_on_bird_death"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."batch_records" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "daily_record_id" "uuid",
    "batch_id" "uuid",
    "chicken_reduction" boolean DEFAULT false,
    "chickens_sold" integer DEFAULT 0,
    "chickens_curled" integer DEFAULT 0,
    "chickens_died" integer DEFAULT 0,
    "chickens_stolen" integer DEFAULT 0,
    "eggs_collected" integer,
    "grade_eggs" boolean DEFAULT false,
    "eggs_small" integer,
    "eggs_deformed" integer,
    "eggs_standard" integer,
    "notes" "text",
    "eggs_broken" integer,
    "sawdust_in_store" integer,
    "sawdust_remaining" integer,
    "feeds_used" "jsonb",
    "vaccines_used" "jsonb",
    "other_materials_used" "jsonb",
    "sales_amount" numeric(10,2) DEFAULT 0.00,
    "losses_amount" numeric DEFAULT 0,
    "losses_breakdown" "jsonb" DEFAULT '{}'::"jsonb",
    "gains_amount" numeric DEFAULT 0
);


ALTER TABLE "public"."batch_records" OWNER TO "postgres";


COMMENT ON COLUMN "public"."batch_records"."losses_amount" IS 'Total monetary loss from dead, stolen, or curled chickens';



COMMENT ON COLUMN "public"."batch_records"."losses_breakdown" IS 'JSON breakdown of losses by type: {"died": amount, "stolen": amount, "curled": amount}';



COMMENT ON COLUMN "public"."batch_records"."gains_amount" IS 'Total monetary gain from sold chickens (should match sales_amount)';



CREATE TABLE IF NOT EXISTS "public"."batches" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid",
    "name" "text" NOT NULL,
    "bird_type" "text" NOT NULL,
    "age_in_days" integer DEFAULT 0,
    "total_chickens" integer NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"(),
    "price_per_bird" numeric(10,2) DEFAULT 0.0,
    CONSTRAINT "batches_bird_type_check" CHECK (("bird_type" = ANY (ARRAY['broiler'::"text", 'kienyeji'::"text", 'layer'::"text"])))
);


ALTER TABLE "public"."batches" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."daily_records" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid",
    "record_date" "date" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"(),
    "report_date" "date" DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE "public"."daily_records" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dashboard_summary" (
    "user_id" "uuid" NOT NULL,
    "total_feeds" integer DEFAULT 0,
    "total_eggs" integer DEFAULT 0,
    "total_chickens" integer DEFAULT 0,
    "last_updated" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE ONLY "public"."dashboard_summary" FORCE ROW LEVEL SECURITY;


ALTER TABLE "public"."dashboard_summary" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."farm_summaries" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "batch_id" "uuid",
    "user_id" "uuid",
    "date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "total_eggs_collected" integer DEFAULT 0,
    "total_feeds_used_items" integer DEFAULT 0,
    "total_vaccines_used_items" integer DEFAULT 0,
    "total_other_materials_used_items" integer DEFAULT 0,
    "total_expenses" numeric(10,2) DEFAULT 0.00,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"())
);


ALTER TABLE "public"."farm_summaries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."farms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "farm_name" "text" NOT NULL,
    "farm_location" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"())
);


ALTER TABLE "public"."farms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."inventory_items" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid",
    "name" "text" NOT NULL,
    "category" "text" NOT NULL,
    "quantity" integer,
    "unit" "text",
    "added_on" "date" DEFAULT CURRENT_DATE,
    "price" numeric(12,2) DEFAULT 0 NOT NULL
);


ALTER TABLE "public"."inventory_items" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."financial_summary" WITH ("security_invoker"='on') AS
 SELECT "batch_id",
    "sum"(COALESCE("sales_amount", (0)::numeric)) AS "total_gains",
    "sum"(((COALESCE(( SELECT "sum"(("f"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."feeds_used") "f"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "f"."name")))), (0)::numeric) + COALESCE(( SELECT "sum"(("v"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."vaccines_used") "v"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "v"."name")))), (0)::numeric)) + COALESCE(( SELECT "sum"(("o"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."other_materials_used") "o"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "o"."name")))), (0)::numeric))) AS "total_expenses",
    ("sum"(COALESCE("sales_amount", (0)::numeric)) - "sum"(((COALESCE(( SELECT "sum"(("f"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."feeds_used") "f"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "f"."name")))), (0)::numeric) + COALESCE(( SELECT "sum"(("v"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."vaccines_used") "v"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "v"."name")))), (0)::numeric)) + COALESCE(( SELECT "sum"(("o"."quantity" * "i"."price")) AS "sum"
           FROM ("jsonb_to_recordset"("b"."other_materials_used") "o"("quantity" numeric, "name" "text")
             JOIN "public"."inventory_items" "i" ON (("i"."name" = "o"."name")))), (0)::numeric)))) AS "profit"
   FROM "public"."batch_records" "b"
  GROUP BY "batch_id";


ALTER VIEW "public"."financial_summary" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sales_records" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "batch_id" "uuid",
    "daily_record_id" "uuid",
    "record_date" "date" NOT NULL,
    "item_type" "text" NOT NULL,
    "quantity" integer NOT NULL,
    "price_per_unit" numeric(10,2) NOT NULL,
    "total_amount" numeric(10,2) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "user_id" "uuid"
);


ALTER TABLE "public"."sales_records" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" NOT NULL,
    "full_name" "text",
    "phone_number" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "is_test_user" boolean DEFAULT false,
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "recovery_question" "text",
    "recovery_answer" "text"
);


ALTER TABLE "public"."users" OWNER TO "postgres";


ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "batch_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."batches"
    ADD CONSTRAINT "batches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."daily_records"
    ADD CONSTRAINT "daily_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."dashboard_summary"
    ADD CONSTRAINT "dashboard_summary_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."farm_summaries"
    ADD CONSTRAINT "farm_summaries_batch_id_date_key" UNIQUE ("batch_id", "date");



ALTER TABLE ONLY "public"."farm_summaries"
    ADD CONSTRAINT "farm_summaries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."farms"
    ADD CONSTRAINT "farms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."inventory_items"
    ADD CONSTRAINT "inventory_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sales_records"
    ADD CONSTRAINT "sales_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "unique_batch_per_day" UNIQUE ("batch_id", "daily_record_id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_farm_summaries_batch_id" ON "public"."farm_summaries" USING "btree" ("batch_id");



CREATE INDEX "idx_farm_summaries_date" ON "public"."farm_summaries" USING "btree" ("date");



CREATE INDEX "idx_farm_summaries_user_id" ON "public"."farm_summaries" USING "btree" ("user_id");



CREATE OR REPLACE TRIGGER "update_dashboard_after_batch_change" AFTER INSERT OR DELETE OR UPDATE ON "public"."batches" FOR EACH ROW EXECUTE FUNCTION "public"."update_dashboard_summary"();



CREATE OR REPLACE TRIGGER "update_dashboard_after_inventory_change" AFTER INSERT OR DELETE OR UPDATE ON "public"."inventory_items" FOR EACH ROW EXECUTE FUNCTION "public"."update_dashboard_summary"();



CREATE OR REPLACE TRIGGER "update_dashboard_after_record_change" AFTER INSERT OR DELETE OR UPDATE ON "public"."batch_records" FOR EACH ROW EXECUTE FUNCTION "public"."update_dashboard_summary"();

ALTER TABLE "public"."batch_records" DISABLE TRIGGER "update_dashboard_after_record_change";



CREATE OR REPLACE TRIGGER "update_expenses_on_bird_death_trigger" AFTER UPDATE ON "public"."batches" FOR EACH ROW WHEN (("old"."total_chickens" IS DISTINCT FROM "new"."total_chickens")) EXECUTE FUNCTION "public"."update_expenses_on_bird_death"();



CREATE OR REPLACE TRIGGER "update_farm_summaries_updated_at" BEFORE UPDATE ON "public"."farm_summaries" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "batch_records_batch_id_fkey" FOREIGN KEY ("batch_id") REFERENCES "public"."batches"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "batch_records_daily_record_id_fkey" FOREIGN KEY ("daily_record_id") REFERENCES "public"."daily_records"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."batches"
    ADD CONSTRAINT "batches_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."daily_records"
    ADD CONSTRAINT "daily_records_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dashboard_summary"
    ADD CONSTRAINT "dashboard_summary_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."farm_summaries"
    ADD CONSTRAINT "farm_summaries_batch_id_fkey" FOREIGN KEY ("batch_id") REFERENCES "public"."batches"("id");



ALTER TABLE ONLY "public"."farm_summaries"
    ADD CONSTRAINT "farm_summaries_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."farms"
    ADD CONSTRAINT "farms_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "fk_batch" FOREIGN KEY ("batch_id") REFERENCES "public"."batches"("id");



ALTER TABLE ONLY "public"."batch_records"
    ADD CONSTRAINT "fk_daily_record" FOREIGN KEY ("daily_record_id") REFERENCES "public"."daily_records"("id");



ALTER TABLE ONLY "public"."daily_records"
    ADD CONSTRAINT "fk_user" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."inventory_items"
    ADD CONSTRAINT "inventory_items_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."sales_records"
    ADD CONSTRAINT "sales_records_batch_id_fkey" FOREIGN KEY ("batch_id") REFERENCES "public"."batches"("id");



ALTER TABLE ONLY "public"."sales_records"
    ADD CONSTRAINT "sales_records_daily_record_id_fkey" FOREIGN KEY ("daily_record_id") REFERENCES "public"."daily_records"("id");



ALTER TABLE ONLY "public"."sales_records"
    ADD CONSTRAINT "sales_records_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "User can access own batch records" ON "public"."batch_records" USING (("batch_id" IN ( SELECT "batches"."id"
   FROM "public"."batches"
  WHERE ("batches"."user_id" = "auth"."uid"()))));



CREATE POLICY "User can access own batches" ON "public"."batches" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "User can access own daily records" ON "public"."daily_records" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "User can access own inventory" ON "public"."inventory_items" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own farm summaries" ON "public"."farm_summaries" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own sales records" ON "public"."sales_records" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can edit their own dashboard summaries" ON "public"."dashboard_summary" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can insert their own farm summaries" ON "public"."farm_summaries" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own farms" ON "public"."farms" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can insert their own profile" ON "public"."users" FOR INSERT WITH CHECK (("id" = "auth"."uid"()));



CREATE POLICY "Users can insert their own sales records" ON "public"."sales_records" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can select their own farms" ON "public"."farms" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can select their own profile" ON "public"."users" FOR SELECT USING (("id" = "auth"."uid"()));



CREATE POLICY "Users can update their own farm summaries" ON "public"."farm_summaries" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own farms" ON "public"."farms" FOR UPDATE USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can update their own profile" ON "public"."users" FOR UPDATE USING (("id" = "auth"."uid"()));



CREATE POLICY "Users can update their own sales records" ON "public"."sales_records" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own dashboard summaries" ON "public"."dashboard_summary" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can view their own farm summaries" ON "public"."farm_summaries" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own sales records" ON "public"."sales_records" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."batch_records" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "batch_records_delete_policy" ON "public"."batch_records" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."batches"
  WHERE (("batches"."id" = "batch_records"."batch_id") AND ("batches"."user_id" = "auth"."uid"())))));



CREATE POLICY "batch_records_insert_policy" ON "public"."batch_records" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."batches"
  WHERE (("batches"."id" = "batch_records"."batch_id") AND ("batches"."user_id" = "auth"."uid"())))));



CREATE POLICY "batch_records_select_policy" ON "public"."batch_records" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."batches"
  WHERE (("batches"."id" = "batch_records"."batch_id") AND ("batches"."user_id" = "auth"."uid"())))));



CREATE POLICY "batch_records_update_policy" ON "public"."batch_records" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."batches"
  WHERE (("batches"."id" = "batch_records"."batch_id") AND ("batches"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."batches" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."daily_records" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "daily_records_delete_policy" ON "public"."daily_records" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "daily_records_insert_policy" ON "public"."daily_records" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "daily_records_select_policy" ON "public"."daily_records" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "daily_records_update_policy" ON "public"."daily_records" FOR UPDATE USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."dashboard_summary" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."farm_summaries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."farms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."inventory_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sales_records" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "users_policy" ON "public"."users" USING (("auth"."uid"() = "id"));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































REVOKE ALL ON FUNCTION "public"."get_batch_profits"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."get_batch_profits"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_batch_profits"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_batch_profits"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."get_farm_data"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."get_farm_data"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_farm_data"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_farm_data"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_monthly_farm_summary"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_monthly_farm_summary"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_monthly_farm_summary"("p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."insert_into_farm_base_tables"() TO "anon";
GRANT ALL ON FUNCTION "public"."insert_into_farm_base_tables"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."insert_into_farm_base_tables"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_dashboard_summary"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_dashboard_summary"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_dashboard_summary"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_expenses_on_bird_death"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_expenses_on_bird_death"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_expenses_on_bird_death"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


















GRANT ALL ON TABLE "public"."batch_records" TO "anon";
GRANT ALL ON TABLE "public"."batch_records" TO "authenticated";
GRANT ALL ON TABLE "public"."batch_records" TO "service_role";



GRANT ALL ON TABLE "public"."batches" TO "anon";
GRANT ALL ON TABLE "public"."batches" TO "authenticated";
GRANT ALL ON TABLE "public"."batches" TO "service_role";



GRANT ALL ON TABLE "public"."daily_records" TO "anon";
GRANT ALL ON TABLE "public"."daily_records" TO "authenticated";
GRANT ALL ON TABLE "public"."daily_records" TO "service_role";



GRANT ALL ON TABLE "public"."dashboard_summary" TO "anon";
GRANT ALL ON TABLE "public"."dashboard_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."dashboard_summary" TO "service_role";



GRANT ALL ON TABLE "public"."farm_summaries" TO "anon";
GRANT ALL ON TABLE "public"."farm_summaries" TO "authenticated";
GRANT ALL ON TABLE "public"."farm_summaries" TO "service_role";



GRANT ALL ON TABLE "public"."farms" TO "anon";
GRANT ALL ON TABLE "public"."farms" TO "authenticated";
GRANT ALL ON TABLE "public"."farms" TO "service_role";



GRANT ALL ON TABLE "public"."inventory_items" TO "anon";
GRANT ALL ON TABLE "public"."inventory_items" TO "authenticated";
GRANT ALL ON TABLE "public"."inventory_items" TO "service_role";



GRANT ALL ON TABLE "public"."financial_summary" TO "anon";
GRANT ALL ON TABLE "public"."financial_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."financial_summary" TO "service_role";



GRANT ALL ON TABLE "public"."sales_records" TO "anon";
GRANT ALL ON TABLE "public"."sales_records" TO "authenticated";
GRANT ALL ON TABLE "public"."sales_records" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































