-- ===========================
-- SAMPLE DATA POPULATION
-- ===========================

-- Insert Users
INSERT INTO "Users" ("user_id", "first_name", "last_name", "email", "password_hash", "phone_number", "role")
VALUES
('11111111-1111-1111-1111-111111111111', 'Kwame', 'Mensah', 'kwame.mensah@example.com', 'hash_kwame', '+233501234567', 'host'),
('22222222-2222-2222-2222-222222222222', 'Ama', 'Owusu', 'ama.owusu@example.com', 'hash_ama', '+233541112233', 'guest'),
('33333333-3333-3333-3333-333333333333', 'Kojo', 'Asante', 'kojo.asante@example.com', 'hash_kojo', '+233509876543', 'guest'),
('44444444-4444-4444-4444-444444444444', 'Efua', 'Addo', 'efua.addo@example.com', 'hash_efua', '+233559998877', 'host');

-- Insert Properties
INSERT INTO "Property" ("property_id", "host_id", "name", "description", "loaction", "pricepernight")
VALUES
('aaaa1111-aaaa-1111-aaaa-1111aaaa1111', '11111111-1111-1111-1111-111111111111', 'Accra City Apartment', 'A modern 2-bedroom apartment in the heart of Accra.', 'Accra, Ghana', 300.00),
('bbbb2222-bbbb-2222-bbbb-2222bbbb2222', '44444444-4444-4444-4444-444444444444', 'Kumasi Villa', 'Spacious villa with a private garden and pool.', 'Kumasi, Ghana', 450.00);

-- Insert Bookings
    INSERT INTO "Booking" ("booking_id", "property_id", "user_id", "start_date", "end_date", "total_price", "status")
    VALUES
    ('bkg11111-aaaa-bbbb-cccc-111111111111', 'aaaa1111-aaaa-1111-aaaa-1111aaaa1111', '22222222-2222-2222-2222-222222222222', '2025-10-01', '2025-10-05', 1200.00, 'confirmed'),
    ('bkg22222-bbbb-cccc-dddd-222222222222', 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222', '33333333-3333-3333-3333-333333333333', '2025-11-10', '2025-11-13', 1350.00, 'pending');

-- Insert Payments
INSERT INTO "Payment" ("Payment_id", "booking_id", "amount", "payment_method")
VALUES
('pay11111-aaaa-bbbb-cccc-111111111111', 'bkg11111-aaaa-bbbb-cccc-111111111111', 1200.00, 'Mobile Money'),
('pay22222-bbbb-cccc-dddd-222222222222', 'bkg22222-bbbb-cccc-dddd-222222222222', 1350.00, 'Credit Card');

-- Insert Reviews
INSERT INTO "Review" ("review_id", "property_id", "user_id", "rating")
VALUES
('rev11111-aaaa-bbbb-cccc-111111111111', 'aaaa1111-aaaa-1111-aaaa-1111aaaa1111', '22222222-2222-2222-2222-222222222222', 5),
('rev22222-bbbb-cccc-dddd-222222222222', 'bbbb2222-bbbb-2222-bbbb-2222bbbb2222', '33333333-3333-3333-3333-333333333333', 4);

-- Insert Messages
INSERT INTO "Message" ("message_id", "sender_id", "recipeint_id", "message_body")
VALUES
('msg11111-aaaa-bbbb-cccc-111111111111', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hello, is your Accra apartment available next weekend?'),
('msg22222-bbbb-cccc-dddd-222222222222', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Yes, it is available from Friday to Sunday.'),
('msg33333-cccc-dddd-eeee-333333333333', '33333333-3333-3333-3333-333333333333', '44444444-4444-4444-4444-444444444444', 'Hi! Can I get a discount for the Kumasi Villa?');
