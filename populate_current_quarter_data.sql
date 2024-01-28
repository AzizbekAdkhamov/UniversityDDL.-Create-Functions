-- Create partitions for current quarter for payment

-- Table: public.payment_p2023_10

-- DROP TABLE IF EXISTS public.payment_p2023_10;

CREATE TABLE public.payment_p2023_10 PARTITION OF public.payment
(
    CONSTRAINT payment_p2023_10_customer_id_fkey FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,-- Create partitions for current quarter for payment

                            -- Table: public.payment_p2023_10

                            -- DROP TABLE IF EXISTS public.payment_p2023_10;

                            CREATE TABLE public.payment_p2023_10 PARTITION OF public.payment
                            (
                                CONSTRAINT payment_p2023_10_customer_id_fkey FOREIGN KEY (customer_id)
                                    REFERENCES public.customer (customer_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_10_rental_id_fkey FOREIGN KEY (rental_id)
                                    REFERENCES public.rental (rental_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_10_staff_id_fkey FOREIGN KEY (staff_id)
                                    REFERENCES public.staff (staff_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION
                            )
                                FOR VALUES FROM ('2023-10-01 02:00:00+05') TO ('2023-11-01 02:00:00+05')
                            TABLESPACE pg_default;

                            ALTER TABLE IF EXISTS public.payment_p2023_10
                                OWNER to postgres;
                            -- Index: idx_fk_payment_p2023_10_customer_id

                            -- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_10_customer_id;

                            CREATE INDEX idx_fk_payment_p2023_10_customer_id
                                ON public.payment_p2023_10 USING btree
                                (customer_id ASC NULLS LAST)
                                TABLESPACE pg_default;



                            -- Table: public.payment_p2023_11

                            -- DROP TABLE IF EXISTS public.payment_p2023_11;

                            CREATE TABLE public.payment_p2023_11 PARTITION OF public.payment
                            (
                                CONSTRAINT payment_p2023_11_customer_id_fkey FOREIGN KEY (customer_id)
                                    REFERENCES public.customer (customer_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_11_rental_id_fkey FOREIGN KEY (rental_id)
                                    REFERENCES public.rental (rental_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_11_staff_id_fkey FOREIGN KEY (staff_id)
                                    REFERENCES public.staff (staff_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION
                            )
                                FOR VALUES FROM ('2023-11-01 02:00:00+05') TO ('2023-12-01 02:00:00+05')
                            TABLESPACE pg_default;

                            ALTER TABLE IF EXISTS public.payment_p2023_11
                                OWNER to postgres;
                            -- Index: idx_fk_payment_p2023_11_customer_id

                            -- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_11_customer_id;

                            CREATE INDEX idx_fk_payment_p2023_11_customer_id
                                ON public.payment_p2023_11 USING btree
                                (customer_id ASC NULLS LAST)
                                TABLESPACE pg_default;


                            -- Table: public.payment_p2023_12

                            -- DROP TABLE IF EXISTS public.payment_p2023_12;

                            CREATE TABLE public.payment_p2023_12 PARTITION OF public.payment
                            (
                                CONSTRAINT payment_p2023_12_customer_id_fkey FOREIGN KEY (customer_id)
                                    REFERENCES public.customer (customer_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_12_rental_id_fkey FOREIGN KEY (rental_id)
                                    REFERENCES public.rental (rental_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION,
                                CONSTRAINT payment_p2023_12_staff_id_fkey FOREIGN KEY (staff_id)
                                    REFERENCES public.staff (staff_id) MATCH SIMPLE
                                    ON UPDATE NO ACTION
                                    ON DELETE NO ACTION
                            )
                                FOR VALUES FROM ('2023-12-01 02:00:00+05') TO ('2024-01-01 02:00:00+05')
                            TABLESPACE pg_default;

                            ALTER TABLE IF EXISTS public.payment_p2023_12
                                OWNER to postgres;
                            -- Index: idx_fk_payment_p2023_12_customer_id

                            -- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_12_customer_id;

                            CREATE INDEX idx_fk_payment_p2023_12_customer_id
                                ON public.payment_p2023_12 USING btree
                                (customer_id ASC NULLS LAST)
                                TABLESPACE pg_default;



                            -- populate payment data to this quarter 2023 q4
                            INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
                            SELECT customer_id, staff_id, rental_id, amount,
                                   date_trunc('quarter', CURRENT_DATE) + INTERVAL '1 second' * round(random() * EXTRACT(EPOCH FROM date_trunc('quarter', CURRENT_DATE + INTERVAL '3 months') - date_trunc('quarter', CURRENT_DATE)))
                            FROM (
                                 SELECT *
                                 FROM payment
                                 ORDER BY payment_date DESC
                                 LIMIT 5
                            ) sub;

    CONSTRAINT payment_p2023_10_rental_id_fkey FOREIGN KEY (rental_id)
        REFERENCES public.rental (rental_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT payment_p2023_10_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    FOR VALUES FROM ('2023-10-01 02:00:00+05') TO ('2023-11-01 02:00:00+05')
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payment_p2023_10
    OWNER to postgres;
-- Index: idx_fk_payment_p2023_10_customer_id

-- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_10_customer_id;

CREATE INDEX idx_fk_payment_p2023_10_customer_id
    ON public.payment_p2023_10 USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;



-- Table: public.payment_p2023_11

-- DROP TABLE IF EXISTS public.payment_p2023_11;

CREATE TABLE public.payment_p2023_11 PARTITION OF public.payment
(
    CONSTRAINT payment_p2023_11_customer_id_fkey FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT payment_p2023_11_rental_id_fkey FOREIGN KEY (rental_id)
        REFERENCES public.rental (rental_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT payment_p2023_11_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    FOR VALUES FROM ('2023-11-01 02:00:00+05') TO ('2023-12-01 02:00:00+05')
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payment_p2023_11
    OWNER to postgres;
-- Index: idx_fk_payment_p2023_11_customer_id

-- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_11_customer_id;

CREATE INDEX idx_fk_payment_p2023_11_customer_id
    ON public.payment_p2023_11 USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.payment_p2023_12

-- DROP TABLE IF EXISTS public.payment_p2023_12;

CREATE TABLE public.payment_p2023_12 PARTITION OF public.payment
(
    CONSTRAINT payment_p2023_12_customer_id_fkey FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT payment_p2023_12_rental_id_fkey FOREIGN KEY (rental_id)
        REFERENCES public.rental (rental_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT payment_p2023_12_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    FOR VALUES FROM ('2023-12-01 02:00:00+05') TO ('2024-01-01 02:00:00+05')
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payment_p2023_12
    OWNER to postgres;
-- Index: idx_fk_payment_p2023_12_customer_id

-- DROP INDEX IF EXISTS public.idx_fk_payment_p2023_12_customer_id;

CREATE INDEX idx_fk_payment_p2023_12_customer_id
    ON public.payment_p2023_12 USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;



-- populate payment data to this quarter 2023 q4
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
SELECT customer_id, staff_id, rental_id, amount,
       date_trunc('quarter', CURRENT_DATE) + INTERVAL '1 second' * round(random() * EXTRACT(EPOCH FROM date_trunc('quarter', CURRENT_DATE + INTERVAL '3 months') - date_trunc('quarter', CURRENT_DATE)))
FROM (
     SELECT *
     FROM payment
     ORDER BY payment_date DESC
     LIMIT 5
) sub;
