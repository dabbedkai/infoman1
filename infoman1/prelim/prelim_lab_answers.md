# INFOMAN1 — Prelim Lab Exam Answers

## Task 3: Data Type Justifications

1. **`return_date` (DATE, NULLable):** 
   While `borrow_date` is marked `NOT NULL` because every transaction must record when an item left the library, `return_date` allows `NULL` values. This accurately reflects active loans where an item has not yet been returned to the library.
2. **`location_code` (VARCHAR(20)):** 
   Storage locations use alphanumeric identifiers (e.g., "Shelf A3", "Pegboard B1") rather than numeric IDs. `VARCHAR(20)` accommodates non-numeric, structured strings while reserving minimal storage compared to a fixed-length `CHAR`.

---

## Task 5: Debugging a Cross-Week Mismatch

### Problem Analysis
The broken query fails:
```sql
SELECT borrow_date, return_date
FROM borrowing
WHERE member_name = 'Maria Santos';