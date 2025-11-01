SELECT 
    b."booking_id",
    b."start_date",
    b."end_date",
    b."total_price",
    b."status" AS booking_status,

    -- User details
    u."user_id",
    u."first_name",
    u."last_name",
    u."email",
    u."role" AS user_role,

    -- Property details
    p."property_id",
    p."name" AS property_name,
    p."description" AS property_description,
    p."location",
    p."pricepernight",
    p."host_id",

    -- Payment details
    pay."payment_id",
    pay."amount",
    pay."payment_date",
    pay."payment_method",
    pay."status" AS payment_status

FROM "Booking" b
INNER JOIN "Users" u 
    ON b."user_id" = u."user_id"
INNER JOIN "Property" p 
    ON b."property_id" = p."property_id"
LEFT JOIN "Payment" pay 
    ON b."booking_id" = pay."booking_id"
ORDER BY b."start_date" DESC;

EXPLAIN ANALYZE
SELECT 
    b."booking_id",
    b."start_date",
    b."end_date",
    b."total_price",
    b."status" AS booking_status,
    u."user_id",
    u."first_name",
    u."last_name",
    u."email",
    p."property_id",
    p."name" AS property_name,
    pay."payment_id",
    pay."amount",
    pay."payment_date",
    pay."status" AS payment_status
FROM "Booking" b
INNER JOIN "Users" u 
    ON b."user_id" = u."user_id"
INNER JOIN "Property" p 
    ON b."property_id" = p."property_id"
LEFT JOIN "Payment" pay 
    ON b."booking_id" = pay."booking_id"
ORDER BY b."start_date" DESC;



CREATE INDEX IF NOT EXISTS idx_booking_user_id ON "Booking" ("user_id");
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON "Booking" ("property_id");
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON "Payment" ("booking_id");
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON "Booking" ("start_date");

-- ✅ Step 2: Refactored optimized query
EXPLAIN ANALYZE
SELECT 
    b."booking_id",
    b."start_date",
    b."end_date",
    b."total_price",
    b."status" AS booking_status,

    -- Only key user info
    u."first_name" || ' ' || u."last_name" AS guest_name,
    u."email" AS guest_email,

    -- Key property details
    p."name" AS property_name,
    p."location",
    p."pricepernight",

    -- Payment summary (optional left join)
    pay."amount" AS payment_amount,
    pay."status" AS payment_status

FROM "Booking" b
-- Use indexed joins
JOIN "Users" u 
  ON b."user_id" = u."user_id"
JOIN "Property" p 
  ON b."property_id" = p."property_id"
LEFT JOIN "Payment" pay 
  ON b."booking_id" = pay."booking_id"

-- Only retrieve active or recent bookings to limit scan scope
WHERE b."status" IN ('confirmed', 'pending')
  AND b."start_date" >= CURRENT_DATE - INTERVAL '1 year'

-- Sorting uses index on start_date
ORDER BY b."start_date" DESC