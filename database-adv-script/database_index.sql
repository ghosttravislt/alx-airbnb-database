-- ==============================
-- DATABASE INDEX OPTIMIZATION
-- ==============================

-- === Users Table ===
-- Index on email for quick user lookups (used in login queries)
CREATE INDEX idx_users_email ON "Users" ("email");

-- Index on role for fast filtering (e.g., WHERE role = 'host')
CREATE INDEX idx_users_role ON "Users" ("role");

-- === Property Table ===
-- Index on host_id for fast JOINs (used when listing host properties)
CREATE INDEX idx_property_host_id ON "Property" ("host_id");

-- Index on name for quick searches by property name
CREATE INDEX idx_property_name ON "Property" ("name");

-- === Booking Table ===
-- Index on user_id for queries joining user bookings
CREATE INDEX idx_booking_user_id ON "Booking" ("user_id");

-- Index on property_id for queries joining property bookings
CREATE INDEX idx_booking_property_id ON "Booking" ("property_id");

-- Index on status for filtering active/confirmed bookings
CREATE INDEX idx_booking_status ON "Booking" ("status");

-- Optional: Composite index to optimize date range and property queries
CREATE INDEX idx_booking_property_date
ON "Booking" ("property_id", "start_date", "end_date");

EXPLAIN ANALYZE
SELECT * 
FROM "Booking" b
JOIN "Users" u ON b."user_id" = u."user_id"
WHERE u."email" = 'jane@example.com'
AND b."status" = 'confirmed';
