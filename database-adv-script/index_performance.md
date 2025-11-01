# 🧠 Database Index Optimization Report

## 📋 Objective
The goal of this analysis is to **identify high-usage columns** across the `Users`, `Booking`, and `Property` tables — focusing on columns frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses — and to recommend indexes that can **improve query performance**.

---

## 👤 Users Table

| Column | Usage Context | Reason for Index |
|---------|----------------|------------------|
| `user_id` | Used in `JOIN` conditions with `Booking`, `Property`, `Review`, and `Message` tables. | Frequently joined as a foreign key reference for user-related data. |
| `email` | Commonly used in `WHERE` clauses during login and user lookups. | Ensures fast lookups when identifying users by email. |
| `role` | Used to filter users by role (e.g., `WHERE role = 'host'`). | Helps quickly retrieve hosts vs. guests. |

### 🔍 Index Recommendations
```sql
CREATE INDEX idx_users_email ON "Users" ("email");
CREATE INDEX idx_users_role ON "Users" ("role");
