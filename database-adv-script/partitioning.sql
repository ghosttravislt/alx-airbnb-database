ALTER TABLE "Booking" RENAME TO "Booking_old";

-- 2️⃣ Step 2: Create the new partitioned parent table
CREATE TABLE "Booking" (
    "booking_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL REFERENCES "Users"("user_id"),
    "property_id" UUID NOT NULL REFERENCES "Property"("property_id"),
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "total_price" NUMERIC(10,2),
    "status" VARCHAR(50) DEFAULT 'pending',
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE ("start_date");

-- 3️⃣ Step 3: Create partitions by year (customize as needed)
-- Each partition stores data for a specific date range.
CREATE TABLE "Booking_2023" PARTITION OF "Booking"
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE "Booking_2024" PARTITION OF "Booking"
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE "Booking_2025" PARTITION OF "Booking"
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional: default partition for future or missing ranges
CREATE TABLE "Booking_default" PARTITION OF "Booking"
    DEFAULT;

-- 4️⃣ Step 4: Copy existing data into new partitions
INSERT INTO "Booking" (
    "booking_id", "user_id", "property_id", 
    "start_date", "end_date", "total_price", "status", "created_at"
)
SELECT 
    "booking_id", "user_id", "property_id",
    "start_date", "end_date", "total_price", "status", "created_at"
FROM "Booking_old";

-- 5️⃣ Step 5: Drop old table after verifying data
-- (Run only after checking that data copied successfully.)
-- DROP TABLE "Booking_old";

-- 6️⃣ Step 6: Index key columns inside each partition
CREATE INDEX idx_booking_2023_user_id ON "Booking_2023" ("user_id");
CREATE INDEX idx_booking_2024_user_id ON "Booking_2024" ("user_id");
CREATE INDEX idx_booking_2025_user_id ON "Booking_2025" ("user_id");

CREATE INDEX idx_booking_2023_property_id ON "Booking_2023" ("property_id");
CREATE INDEX idx_booking_2024_property_id ON "Booking_2024" ("property_id");
CREATE INDEX idx_booking_2025_property_id ON "Booking_2025" ("property_id");

-- 7️⃣ Step 7: Verify partitions
-- This command lists all partitions under the main Booking table.
SELECT 
    inhrelid::regclass AS partition_name
FROM pg_inherits
WHERE inhparent = 'Booking'::regclass;