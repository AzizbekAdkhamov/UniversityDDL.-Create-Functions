-- 1. Create sales_revenue_by_category_qtr view

-- DROP VIEW IF EXISTS sales_revenue_by_category_qtr;

CREATE OR REPLACE VIEW sales_revenue_by_category_qtr AS
SELECT fc.category_id, c.name AS category_name, SUM(p.amount) AS total_sales_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE
    -- Current quarter
    EXTRACT(QUARTER FROM CURRENT_DATE) = EXTRACT(QUARTER FROM p.payment_date)
    AND EXTRACT(YEAR FROM CURRENT_DATE) = EXTRACT(YEAR FROM p.payment_date)
GROUP BY fc.category_id, c.name
HAVING SUM(p.amount) > 0
ORDER BY total_sales_revenue DESC;

-- SELECT * FROM sales_revenue_by_category_qtr;

-- 2. Create get_sales_revenue_by_category_qtr function

-- DROP FUNCTION get_sales_revenue_by_category_qtr(TIMESTAMP WITH TIME ZONE);

CREATE OR REPLACE FUNCTION get_sales_revenue_by_category_qtr(current_quarter_start TIMESTAMP WITH TIME ZONE)
RETURNS TABLE (
    category_id SMALLINT,
    category_name TEXT,
    total_sales_revenue NUMERIC
) AS $$
BEGIN
    RETURN QUERY
        SELECT fc.category_id, c.name AS category_name, SUM(p.amount) AS total_sales_revenue
        FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
        WHERE
            -- Specified quarter
            p.payment_date >= current_quarter_start::DATE
            AND p.payment_date < current_quarter_start::DATE + INTERVAL '3 months'
        GROUP BY fc.category_id, c.name
        HAVING SUM(p.amount) > 0
        ORDER BY total_sales_revenue DESC;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM get_sales_revenue_by_category_qtr(date_trunc('quarter', CURRENT_DATE));

--  3. Create new_movie procedure language function

-- DROP PROCEDURE IF EXISTS new_movie(VARCHAR);

CREATE OR REPLACE PROCEDURE new_movie(movie_title VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    klingon_language_id INTEGER;
    new_film_id INTEGER;
BEGIN
    -- Verify that the "Klingon" language exists in the "language" table
    SELECT language_id INTO klingon_language_id FROM language WHERE name = 'Klingon';

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Error: The language "Klingon" does not exist in the language table.';
    END IF;

    -- Generate a new unique film ID
    SELECT coalesce(MAX(film_id), 0) + 1 INTO new_film_id FROM film;

    -- Insert the new movie with the given title and specified attributes
    INSERT INTO film (film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
    VALUES (new_film_id, movie_title, NULL, EXTRACT(YEAR FROM CURRENT_DATE), klingon_language_id, 3, 4.99, NULL, 19.99, NULL, CURRENT_TIMESTAMP);
END;
$$;

-- CALL new_movie('Example Movie Title');