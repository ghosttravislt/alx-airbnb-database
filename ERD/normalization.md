# **Database Normalization Steps (Up to 3NF)**

## **Overview**
This document explains the normalization process applied to the given database schema to ensure it meets the **Third Normal Form (3NF)**.  
Normalization helps eliminate redundancy, ensure data integrity, and simplify database maintenance.

---

## **1. First Normal Form (1NF)**

### **Definition**
A table is in **1NF** if:
- Each column contains only atomic (indivisible) values.  
- Each record is unique (has a primary key).  
- There are no repeating groups or arrays.

### **Application**
In the provided schema:
- Every table has a unique primary key (`*_id`).
- Each field contains a single, indivisible value (e.g., `first_name`, `email`, `pricepernight`).
- No repeating groups or multi-valued attributes exist.

✅ **All tables meet the conditions for 1NF.**

---

## **2. Second Normal Form (2NF)**

### **Definition**
A table is in **2NF** if:
- It is already in 1NF.
- All non-key attributes are **fully functionally dependent** on the entire primary key (no partial dependency).

### **Application**
- Every table in this schema has a single-column primary key (`user_id`, `property_id`, `booking_id`, etc.).
- Therefore, no partial dependency can exist because there are no composite keys.
- All attributes depend solely on their respective primary keys.

✅ **All tables satisfy 2NF.**

---

## **3. Third Normal Form (3NF)**

### **Definition**
A table is in **3NF** if:
- It is in 2NF.
- There are **no transitive dependencies** (non-key attributes should not depend on other non-key attributes).

### **Evaluation and Adjustments**

#### **Users Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| first_name, last_name, email, password_hash, phone_number, role, created_at | user_id | All depend directly on the primary key. |
✅ No transitive dependency. **Users** is in 3NF.

---

#### **Property Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| name, description, loaction (location), pricepernight, host_id, created_at, updated_at | property_id | All depend on property_id. |
| host_id | References Users(user_id) to avoid redundancy. |

⚠️ Correction: `loaction` should be renamed to **`location`** for clarity.  
✅ After correction, **Property** is in 3NF.

---

#### **Booking Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| property_id, user_id, start_date, end_date, total_price, status, create_at | booking_id | All depend directly on booking_id. |
| total_price | Derived from property’s `pricepernight` × duration — could be calculated instead of stored. |

✅ After avoiding derived attributes, **Booking** is in 3NF.

---

#### **Payment Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| booking_id, amount, payment_date, payment_method | payment_id | All depend directly on payment_id. |
✅ **Payment** is in 3NF.

---

#### **Review Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| property_id, user_id, rating, created_at | review_id | All depend directly on review_id. |
✅ **Review** is in 3NF.

---

#### **Message Table**
| Attribute | Depends On | Comment |
|------------|-------------|---------|
| sender_id, recipeint_id (recipient_id), message_body, sent_at | message_id | All depend directly on message_id. |

⚠️ Correction: `recipeint_id` should be renamed to **`recipient_id`** for consistency.  
✅ After correction, **Message** is in 3NF.

---

## **4. Summary of Normalization**

| Table | 1NF | 2NF | 3NF | Notes |
|-------|------|------|------|-------|
| Users | ✅ | ✅ | ✅ | Fully normalized |
| Property | ✅ | ✅ | ✅ | Correct “loaction” to “location” |
| Booking | ✅ | ✅ | ✅ | Avoid storing derived `total_price` |
| Payment | ✅ | ✅ | ✅ | Fully normalized |
| Review | ✅ | ✅ | ✅ | Fully normalized |
| Message | ✅ | ✅ | ✅ | Correct “recipeint_id” to “recipient_id” |

---

## **Final Notes**
- The schema is now fully normalized to **Third Normal Form (3NF)**.  
- Only minor spelling and structural corrections were needed.  
- Redundant or derived data (e.g., `total_price`) should be calculated when needed rather than stored.

✅ **Result:** The database design now ensures data consistency, reduces redundancy, and adheres to best normalization practices.
