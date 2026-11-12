# INFOMAN1 - Week 10 Lab Answers

Name: Kaizer David Palabay
Student ID: 2510997
GitHub repo: https://github.com/dabbedkai/infoman1
Date submitted: 11/11/2026

## Task 1 - Safe INSERT

**Approach / explanation:**
Executed safe `INSERT INTO` statements by explicitly enumerating all target column names in the statement header rather than relying on implicit column positions. Inserted records for the Scientific Calculator and Compass, followed by verification using `SELECT` queries on their unique SKUs.

**Code / query used (if applicable):**

```sql
INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

SELECT * FROM products WHERE sku = 'CALC-SCI-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status) 
VALUES ('Compass', 'CMP-001', 120.00, 50, 'Active');

SELECT * FROM products WHERE sku = 'CMP-001';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt`

**Reflection question:**
Why does listing target columns explicitly make an INSERT safer, and what fills in for columns you omit?
Listing target columns explicitly makes `INSERT` statements immune to schema changes, such as column reordering or new column additions. When columns are omitted, MySQL automatically populates them with their defined `DEFAULT` values, auto-increment numbers, or `NULL` (if the column permits nulls).

## Task 2 - UPDATE & DELETE Without Collateral Damage

**Approach / explanation:**
Followed a strict preview-execute-verify workflow for all data modification statements. Evaluated rows using `SELECT` prior to execution, performed the updates and deletes targeted directly at primary keys (`product_id`), and verified the updated state afterward.

**Code / query used (if applicable):**

```sql
-- UPDATE Workflow
SELECT product_id, product_name, price FROM products WHERE sku = 'CALC-SCI-001';
UPDATE products SET price = 875.00 WHERE product_id = 6;
SELECT product_id, product_name, price FROM products WHERE product_id = 6;

-- DELETE Workflow
SELECT product_id, product_name, sku FROM products WHERE sku = 'ER-001';
DELETE FROM products WHERE product_id = 5;
SELECT product_id, product_name FROM products WHERE product_id = 5;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.txt`

**Reflection question:**
What would your UPDATE and DELETE have done without their WHERE clauses, and why is a stable identifier safer than a name?
Without a `WHERE` clause, `UPDATE` would overwrite every single price across the entire `products` table to 875.00, and `DELETE` would erase every single row in the table. Targeting stable primary key identifiers (`product_id`) is safer than names because names are subject to duplicates or typos, whereas primary keys uniquely identify one exact row.

## Task 3 - Self Join & Cross Join

**Approach / explanation:**
Formulated a self-join query linking the `employees` table to itself using `LEFT JOIN` to map employees to their respective managers without dropping top-level leadership. Created a `CROSS JOIN` between `colors` and `sizes` to generate all possible color-size product variant combinations.

**Code / query used (if applicable):**

```sql
-- Self Join (Employees & Managers)
SELECT e.employee_id, e.employee_name AS employee, m.employee_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- Cross Join (Variants)
SELECT c.color_name, s.size_name
FROM colors c
CROSS JOIN sizes s;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.txt`

**Reflection question:**
Why does the self join need two aliases and a LEFT JOIN, and when is a CROSS JOIN the deliberate choice rather than a missing ON?
A self-join requires two table aliases (e.g., `e` for employee, `m` for manager) so MySQL can treat one table instance as two separate logical entities. A `LEFT JOIN` is necessary so top-level managers whose `manager_id` is `NULL` (like Lea) are preserved in the output rather than filtered out. A `CROSS JOIN` is a deliberate choice when you explicitly need the full Cartesian product of two sets, such as pre-generating all size-color inventory matrix options.

## Task 4 - Constraints & Table Evolution

**Approach / explanation:**
Evolved the database structure using `ALTER TABLE` commands to add new columns and enforce data integrity constraints (`NOT NULL`, `UNIQUE`, and `CHECK`). Verified each constraint by executing one valid statement that succeeded and one invalid statement that MySQL actively rejected.

**Code / query used (if applicable):**

```sql
ALTER TABLE products ADD COLUMN contact_number VARCHAR(20);
ALTER TABLE products MODIFY product_name VARCHAR(100) NOT NULL;
ALTER TABLE products ADD CONSTRAINT unique_sku UNIQUE (sku);
ALTER TABLE products ADD CONSTRAINT check_positive_price CHECK (price > 0);
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task4_output.txt`

**Reflection question:**
Why do constraints block future bad writes without repairing old bad rows, and what must you do before adding NOT NULL?
Database constraints act as schema guards that validate incoming data modifications (`INSERT`/`UPDATE`), but they do not retroactively alter existing table data. Before enforcing a `NOT NULL` constraint on an existing column, you must first update or clean up all existing `NULL` entries in that column; otherwise, MySQL will reject the `ALTER TABLE` command.

## Task 5 - Reflection

**Approach / explanation:**
Authored a 150-200 word reflection analyzing the boundaries between application-level form validation and database-level constraints, discussing a common mistake (unintentional data updates due to broad selection criteria), its symptom, and the fix.

**Code / query used (if applicable):**

```sql
-- Reference Task 2 and Task 4 scripts for safe previewing and constraint validation.
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`answers.md` (Task 5 Reflection section below)

**Reflection question:**
When would you trust the application form versus the database constraint to enforce a rule, and what single symptom would tell you the wrong layer was trusted?
Application-level checks should be used for rich user feedback (e.g., password strength indicators), while database constraints must enforce critical domain integrity rules (e.g., uniqueness, non-negative pricing). The primary symptom that the wrong layer was trusted is corrupted or duplicate data bypassing client-side validation through direct API access, scripts, or external tools, leading to database-level integrity failures.

### Task 5 Reflection Essay:

In a campus bookstore system, relying on both application-level validation and database-level constraints is essential for maintaining data integrity. Application forms provide immediate feedback to users, such as checking formatted email inputs or displaying password strength, which improves user experience before sending requests to the server. However, critical rules like non-negative prices (`CHECK (price > 0)`), mandatory item descriptions (`NOT NULL`), and unique stock codes (`UNIQUE (sku)`) must ultimately be enforced at the database layer. Application logic can be bypassed by direct API requests, administrative scripts, or software bugs; database constraints act as the unyielding last line of defense.

During DML operations, a common mistake observed is updating or deleting records using non-unique text fields (such as product names) instead of stable primary key identifiers. When attempting to update a single item's price by name, duplicate product names can cause collateral damage by accidentally modifying multiple inventory items. The symptom of this mistake is an unexpectedly high row-affected count reported by MySQL (e.g., "Rows matched: 4" instead of 1). The permanent fix is adhering to a preview-then-execute workflow using primary key `product_id` values within the `WHERE` clause.

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week10/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)