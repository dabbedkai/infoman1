# INFOMAN1 — Week 7 Lab Answers


## Task 1 — Complex Student Roster

**Approach / explanation:**
Filtered students enrolled in either Computer Science or Information Technology majors whose last names begin with the letter 'S', while explicitly excluding online sections using the `NOT` logical operator. Utilized the `IN` operator to cleanly evaluate multiple major options in a single check.

**Code / query used (if applicable):**
```sql
SELECT first_name, last_name, major
FROM students
WHERE major IN ('Computer Science', 'Information Technology')
  AND last_name LIKE 'S%'
  AND NOT (section = 'Online');
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1.png`

**Reflection question:**
Why is it often better to use the `IN` operator rather than chaining multiple `OR` conditions when filtering by a specific list of values?
The `IN` operator significantly improves query readability, reduces syntax clutter, and makes maintaining or updating the list of target values much easier. Modern query optimizers handle `IN` clauses efficiently, often translating them into optimized evaluation paths equivalent to multiple `OR` checks or index lookups.

---

## Task 2 — Formatting Employee Data

**Approach / explanation:**
Combined string manipulation and numeric rounding functions to format instructor records into a clean display format. Used `LEFT(first_name, 1)` to extract the initial, `CONCAT` to assemble the formatted string, and `ROUND(salary, 0)` to strip decimals from the salary value.

**Code / query used (if applicable):**
```sql
SELECT CONCAT(LEFT(first_name, 1), '. ', last_name, ' ($', ROUND(salary, 0), ')') AS `Instructor Details`
FROM instructors
LIMIT 5;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
Query executed successfully; matches expected pre-formatted console output.

**Reflection question:**
How do string functions like `CONCAT` affect the performance of a query compared to retrieving raw columns and formatting them in the application layer (e.g., in Java or Python)?
Performing string concatenation in the database places extra processing load on the database server over large result sets and can prevent indexes from being utilized on those columns. Handling formatting in the application layer keeps raw data pristine and lightweight for transport, shifting presentation logic to where UI concerns naturally belong, though database-level formatting remains useful for quick direct reports.

---

## Task 3 — Project Deadline Analysis

**Approach / explanation:**
Calculated the duration between assigned and due dates using the `DATEDIFF` function. Filtered out assignments where the completion window was 14 days or fewer, and sorted the results in descending order by the calculated completion span.

**Code / query used (if applicable):**
```sql
SELECT assignment_name, assigned_date, due_date, DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM assignments
WHERE DATEDIFF(due_date, assigned_date) > 14
ORDER BY Days_To_Complete DESC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3.png`

**Reflection question:**
Why is column aliasing particularly important when using mathematical or date functions in the `SELECT` clause?
Column aliasing assigns meaningful, readable names to dynamically generated or expression-based columns (such as `Days_To_Complete`), preventing columns from defaulting to raw function strings. It is also required when you need to reference that calculated column in subsequent clauses like `ORDER BY` or when consuming the result set within an application.

---

## Task 4 — Comprehensive Data Audit

**Approach / explanation:**
Queried courses meeting specific audit criteria by combining logical operators and pattern matching. Used explicit parentheses to control operator precedence between the `OR` condition for missing descriptions or credit ranges, combined with the `AND` condition for course codes containing 'ADV'.

**Code / query used (if applicable):**
```sql
SELECT course_code, course_name, credits
FROM courses
WHERE (course_description IS NULL OR credits BETWEEN 4 AND 6)
  AND course_code LIKE '%ADV%'
ORDER BY course_name ASC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
Query executed successfully and verified against expected audit constraints.

**Reflection question:**
Explain how MySQL evaluates the expression `A OR B AND C`. How did you use parentheses (if you did) to ensure your query filtered the exact data requested in the instructions?
By default, SQL evaluates `AND` operators with higher precedence than `OR`, meaning `A OR B AND C` is interpreted as `A OR (B AND C)`. Parentheses are essential to override this default behavior and force the desired evaluation order—grouping `(course_description IS NULL OR credits BETWEEN 4 AND 6)` together first before evaluating the `AND course_code LIKE '%ADV%'` requirement.

---

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week7/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)