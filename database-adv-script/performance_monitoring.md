# 🧠 Continuous Database Performance Monitoring and Optimization Report

## 🎯 Objective
To **continuously monitor and refine database performance** by analyzing query execution plans, identifying bottlenecks, and applying schema adjustments such as new indexes and optimized data structures.

We used `EXPLAIN ANALYZE` and `SHOW PROFILE` (where supported) to monitor key query performance across the **Users**, **Property**, and **Booking** tables.

---

## 🧩 1. Frequently Used Queries Monitored

| Query ID | Query Description | Purpose |
|-----------|-------------------|----------|
| Q1 | Retrieve all bookings with user and property details. | Main dashboard and reporting query. |
| Q2 | Fetch all properties for a given host. | Property management view. |
| Q3 | Get total number of confirmed bookings for each property. | Analytical query used in reporting. |

---

## 🧮 2. Query Execution Plans (Before Optimization)

### 🔹 Q1 – Booking with User + Property
```sql
EXPLAIN ANALYZE
SELECT 
  b."booking_id", b."start_date", b."end_date", b."status",
  u."first_name", u."last_name",
  p."name" AS property_name
FROM "Booking" b
JOIN "Users" u ON b."user_id" = u."user_id"
JOIN "Property" p ON b."property_id" = p."property_id"
WHERE b."status" = 'confirmed'
ORDER BY b."start_date" DESC;
