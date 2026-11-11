# INFOMAN1 — Week 9 Lab Answers

Name: Kaizer David Palabay
Student ID: 2510997
GitHub repo: https://github.com/dabbedkai/infoman1
Date submitted: 11/11/2026

## Task 1 — INNER JOIN Basics

**Approach / explanation:**
Linked the `students` and `orders` tables on their common `student_id` key using an explicit `INNER JOIN` clause. This successfully isolates and returns only the student records that possess matching transaction entries in the `orders` table, sorting the final result set in ascending order by `order_id`.

**Code / query used (if applicable):**
```sql
SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
ORDER BY o.order_id ASC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt`

**Reflection question:**
Why does an INNER JOIN hide students who never ordered, and when is that exactly the behavior a sales report wants?
An `INNER JOIN` only returns rows where there is a matching key in both connected tables based on the join condition. Because students who never ordered have no corresponding entry in the `orders` table, they are excluded. This is precisely the desired behavior for a strict sales or revenue report where you only want to analyze active buyers and completed transactions without cluttering the summary with inactive records.

---

## Task 2 — Finding Missing Relationships

**Approach / explanation:**
Utilized a `LEFT JOIN` from the `students` table to the `orders` table to retain all registered students regardless of whether they made a purchase. For part (a), all students are listed with `NULL` populated for non-buyers; for part (b), a `WHERE o.order_id IS NULL` filter is added to isolate only the students who have never placed an order.

**Code / query used (if applicable):**
```sql
-- Query (a): All students with matched orders or NULLs
SELECT s.student_id, s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
ORDER BY s.student_id ASC;

-- Query (b): Students who never ordered
SELECT s.student_id, s.student_name, s.program
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_id IS NULL;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.txt`

**Reflection question:**
What does NULL mean in the unmatched columns of a LEFT JOIN, and why must you test it with IS NULL instead of equals?
In a `LEFT JOIN`, `NULL` represents the absence of a matching record in the right-side table for a given row from the left-side table. You must test it using `IS NULL` instead of `= NULL` because SQL treats `NULL` as an unknown value rather than a concrete data value; standard comparison operators (`=`, `!=`) evaluate to unknown when compared against `NULL`.

---

## Task 3 — Four-Table Canteen Report

**Approach / explanation:**
Joined four related tables (`students`, `orders`, `order_items`, and `menu_items`) in a sequential chain using three explicit `INNER JOIN` conditions and proper table aliasing. Calculated the itemized cost dynamically using `(oi.quantity * m.price) AS line_total` and ordered the report cleanly by order identifier and item name.

**Code / query used (if applicable):**
```sql
SELECT 
    s.student_name, 
    s.program, 
    o.order_id, 
    m.item_name, 
    oi.quantity, 
    m.price, 
    (oi.quantity * m.price) AS line_total
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN menu_items m ON oi.menu_id = m.menu_id
ORDER BY o.order_id ASC, m.item_name ASC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.txt`

**Reflection question:**
Why does each JOIN in a multi-table chain need its own ON condition, and what goes wrong when two joins share one?
Each `JOIN` represents a specific relational link between two distinct table entities; therefore, every join requires its own `ON` clause to define how those two tables map together. If joins share or omit conditions, it results in syntax errors or creates an unintended Cartesian product (cross-join), multiplying rows incorrectly and corrupting query results.

---

## Task 4 — Aliases, Filters, and the Silent Inner Join

**Approach / explanation:**
Compared standard inner join filtering against outer joins by evaluating August 2026 orders. Illustrated how placing a date filter on the right-side table inside the `WHERE` clause accidentally strips out `NULL` rows and converts a `LEFT JOIN` into a "silent inner join," and resolved this by moving the date condition into the `ON` clause.

**Code / query used (if applicable):**
```sql
-- Version A: Standard INNER JOIN with date filter
SELECT s.student_name, o.order_id, o.order_date, m.item_name, (oi.quantity * m.price) AS line_total
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN menu_items m ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC;

-- Version B (Flawed): LEFT JOIN broken by WHERE clause filter
SELECT s.student_name, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_date >= '2026-08-01';

-- Version B (Fixed): Correct OUTER JOIN preserving unmatched rows
SELECT s.student_name, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id AND o.order_date >= '2026-08-01';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task4_output.txt`

**Reflection question:**
Why does adding WHERE on the right-side table remove the NULL rows a LEFT JOIN just preserved, and where should that rule live instead?
A `WHERE` clause evaluates sequentially *after* the join operation has finished constructing the result set. When it checks a column from the right-side table where `NULL` was inserted, the condition evaluates to false (because `NULL >= '2026-08-01'` is unknown), causing the database to filter out those preserved outer rows. That filtering rule should instead live inside the `ON` clause of the `LEFT JOIN`.

---

## Task 5 — Reflection

**Approach / explanation:**
Wrote a comprehensive 150–200 word reflection essay comparing join types, analyzing real query errors (the silent inner join caused by `WHERE` filtering on outer joins), and explaining the diagnostic symptoms and fixes.

**Code / query used (if applicable):**
```sql
-- See Task 4 for the comparison between WHERE vs ON clause filtering on LEFT JOINs.
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task5_reflection.txt`

**Reflection question:**
Which join would you choose for an "all students including non-buyers" roster versus a "completed sales only" report, and what single symptom would tell you that you picked the wrong one?
For an "all students including non-buyers" roster, you must choose a `LEFT JOIN` rooted at the students table. For a "completed sales only" report, an `INNER JOIN` is appropriate. The single symptom indicating you picked the wrong join is the unexpected absence of student records with `NULL` values when you expected a complete roster, or conversely, seeing students with `NULL` order data when you only wanted active buyers.

---

### Task 5 Reflection Essay:
Choosing between `INNER JOIN` and `LEFT JOIN` depends entirely on whether unmatched records are required for complete reporting. `INNER JOIN` is ideal when strict intersection is needed—such as Task 1's list of active buyers—where entities lacking transaction records should be omitted. Conversely, `LEFT JOIN` is essential for audit reports or identifying inactive entities, as demonstrated in Task 2 where non-buying students needed to be highlighted.

A common mistake observed during multi-table joining is placing filtering conditions on optional table columns inside the `WHERE` clause during a `LEFT JOIN`. In Task 4, applying `WHERE o.order_date >= '2026-08-01'` broke the outer join logic. Because non-ordering students possessed `NULL` values for `order_date`, the `WHERE` clause evaluated `NULL >= '2026-08-01'` as unknown/false, silently eliminating non-buyer records (Ben and Cara) and reducing the output row count from 5 to 3. The symptom was the unexpected disappearance of non-ordering students from the report. The issue was resolved by relocating the date filtering rule directly into the join specification (`ON s.student_id = o.student_id AND o.order_date >= '2026-08-01'`), preserving unmatched student rows correctly.

---

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week9/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)