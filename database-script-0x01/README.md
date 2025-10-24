# **Database Schema Documentation**

## **Overview**
This document provides an explanation of the entities, their relationships, and the normalization process applied to ensure the database schema is in **Third Normal Form (3NF)**.  
The database models a property rental system similar to Airbnb, including users, properties, bookings, payments, reviews, and messages.

---

# **Entity Descriptions**

## **1. Users**
**Purpose:**  
Stores information about all users in the system, including both guests and hosts.  
Each user is uniquely identified by a `user_id`.

**Key Attributes:**
- `user_id` – Unique identifier for each user.  
- `first_name`, `last_name` – User’s full name.  
- `email` – Unique email address used for login and communication.  
- `password_hash` – Securely stored hashed password.  
- `phone_number` – User’s contact number.  
- `role` – Defines the user type (e.g., *guest*, *host*, or *admin*).  
- `created_at` – Timestamp for when the user account was created.

---

## **2. Property**
**Purpose:**  
Represents the accommodations listed by hosts on the platform.  
Each property is owned by a user (host).

**Key Attributes:**
- `property_id` – Unique identifier for each property.  
- `host_id` – References `Users(user_id)`; identifies the host who owns the property.  
- `name` – Name or title of the property.  
- `description` – Detailed information about the property.  
- `location` – The physical or geographic address of the property.  
- `pricepernight` – Cost to rent the property per night.  
- `created_at`, `updated_at` – Track when the property was created and last updated.

---

## **3. Booking**
**Purpose:**  
Stores all booking transactions made by guests for properties.  
Each booking links a guest (`user_id`) to a property (`property_id`).

**Key Attributes:**
- `booking_id` – Unique identifier for each booking.  
- `property_id` – References the booked property.  
- `user_id` – References the guest who made the booking.  
- `start_date`, `end_date` – The check-in and check-out dates.  
- `total_price` – Total cost of the stay (may be computed from duration × nightly price).  
- `status` – Indicates booking state (e.g., *confirmed*, *pending*, *cancelled*).  
- `created_at` – Timestamp when the booking was created.

---

## **4. Payment**
**Purpose:**  
Tracks payments associated with bookings, including the method and amount paid.

**Key Attributes:**
- `payment_id` – Unique identifier for each payment record.  
- `booking_id` – References the booking that the payment corresponds to.  
- `amount` – The amount of money paid.  
- `payment_date` – Date and time of the payment.  
- `payment_method` – Method used (e.g., *credit card*, *PayPal*, *mobile money*).

---

## **5. Review**
**Purpose:**  
Stores user feedback and ratings for properties.  
Each review connects a guest to the property they reviewed.

**Key Attributes:**
- `review_id` – Unique identifier for each review.  
- `property_id` – References the reviewed property.  
- `user_id` – References the user who wrote the review.  
- `rating` – Numerical score (e.g., 1–5 stars).  
- `created_at` – Timestamp when the review was posted.

---

## **6. Message**
**Purpose:**  
Manages private messages exchanged between users (e.g., between guest and host).  

**Key Attributes:**
- `message_id` – Unique identifier for each message.  
- `sender_id` – References the user who sent the message.  
- `recipient_id` – References the user who received the message.  
- `message_body` – The content of the message.  
- `sent_at` – Timestamp when the message was sent.

---

# **Normalization Process (Up to 3NF)**

## **1. First Normal Form (1NF)**
A table is in **1NF** if:
- Each column contains only atomic (indivisible) values.  
- Each record is unique (has a primary key).  

✅ All tables meet the 1NF requirements.

---

## **2. Second Normal Form (2NF)**
A table is in **2NF** if:
- It is already in 1NF.  
- All non-key attributes depend on the entire primary key (no partial dependency).  

Since all tables have a single-column primary key, they automatically satisfy 2NF.  
✅ All tables meet 2NF.

---

## **3. Third Normal Form (3NF)**
A table is in **3NF** if:
- It is in 2NF.  
- There are no transitive dependencies (non-key attributes should not depend on other non-key attributes).  

### Adjustments Made:
- Renamed `loaction` → `location` in **Property** table.  
- Renamed `recipeint_id` → `recipient_id` in **Message** table.  
- Recommended that `total_price` in **Booking** should be computed, not stored, to avoid redundancy.

✅ After these changes, all tables are in **Third Normal Form (3NF)**.

---

# **Summary**
| Table | 1NF | 2NF | 3NF | Notes |
|-------|------|------|------|-------|
| Users | ✅ | ✅ | ✅ | Fully normalized |
| Property | ✅ | ✅ | ✅ | Corrected “loaction” to “location” |
| Booking | ✅ | ✅ | ✅ | Avoid storing derived `total_price` |
| Payment | ✅ | ✅ | ✅ | Fully normalized |
| Review | ✅ | ✅ | ✅ | Fully normalized |
| Message | ✅ | ✅ | ✅ | Corrected “recipeint_id” to “recipient_id” |

---

## **Conclusion**
The database schema successfully follows normalization principles up to **3NF**.  
It minimizes redundancy, maintains data integrity, and ensures clear relational mapping across entities.
