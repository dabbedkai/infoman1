# INFOMAN1 — Week 8 Lab Answers

Name: 
Student ID: 
GitHub repo: https://github.com/<STUDENT_GITHUB_USERNAME>/infoman1
Date submitted: 

**Dataset check:** `SELECT COUNT(*) FROM employee;` returned: `500`

## Task 1 — Pattern Matching Basics

**Approach / explanation:**
Applied `LIKE` pattern matching operators combined with `%` wildcards to locate text patterns of arbitrary length (such as suffixes and prefixes), and used `_` underscores as exact single-character placeholders to inspect structured codes of fixed lengths.

**Code / query used (if applicable):**
```sql
-- 1.1 Last name ends in 'ez'
SELECT emp_id, first_name, last_name 
FROM employee 
WHERE last_name LIKE '%ez';

-- 1.2 First name starts with 'Ma'
SELECT emp_id, first_name, department 
FROM employee 
WHERE first_name LIKE 'Ma%';

-- 1.3 5-character emp_code starting with E
SELECT emp_code, first_name, last_name 
FROM employee 
WHERE emp_code LIKE 'E____';

-- 1.3b emp_code with 0 as the third character
SELECT emp_code, first_name, last_name 
FROM employee 
WHERE emp_code LIKE 'E_0__';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.png`

**Reflection question:**
Why do we use the `%` wildcard instead of the `_` wildcard when searching for fields containing a specific keyword?
The `%` wildcard matches zero or more arbitrary characters, making it flexible for locating substrings, prefixes, or suffixes regardless of their length. In contrast, the `_` wildcard strictly matches one single character per underscore, which makes it rigid and unsuited for variable-length keyword searches.

## Task 2 — Basic Aggregation

**Approach / explanation:**
Computed foundational dataset metrics using standard aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) across the entire `employee` table. Used `COALESCE` to substitute `NULL` commission values with zero so that total compensation calculations would not evaluate to `NULL`.

**Code / query used (if applicable):**
```sql
-- 2.1 Total employees vs employees earning commission
SELECT COUNT(*) AS total_employees, COUNT(commission) AS employees_with_commission 
FROM employee;

-- 2.2 Total monthly payroll and average salary
SELECT SUM(salary) AS total_payroll, AVG(salary) AS average_salary 
FROM employee;

-- 2.3 Earliest and latest hire dates
SELECT MIN(hire_date) AS earliest_hire_date, MAX(hire_date) AS latest_hire_date 
FROM employee;

-- 2.4 Total compensation treating NULL commission as 0
SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation 
FROM employee;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.png`

**Reflection question:**
What is the difference between `COUNT(*)` and `COUNT(column_name)`?
`COUNT(*)` counts every row in the dataset or group regardless of `NULL` values. On the other hand, `COUNT(column_name)` evaluates only the rows where that specific column contains a non-`NULL` value, ignoring any rows with `NULL` entries in that column (which explains why commission counts differ from total employee counts).

## Task 3 — Grouping Data

**Approach / explanation:**
Employed single-column and multi-column `GROUP BY` clauses coupled with aggregate functions (`COUNT`, `AVG`, `COUNT(DISTINCT)`) to summarize headcount, average earnings, and job diversity across departments and job titles.

**Code / query used (if applicable):**
```sql
-- 3.1 Per department aggregates
SELECT department, COUNT(*) AS headcount, AVG(salary) AS avg_salary, COUNT(DISTINCT job_title) AS distinct_titles 
FROM employee 
GROUP BY department;

-- 3.2 Grouping by both department and job title
SELECT department, job_title, COUNT(*) AS headcount 
FROM employee 
GROUP BY department, job_title;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.png`

**Reflection question:**
Why is it generally invalid to include columns in the `SELECT` list that are not in the `GROUP BY` clause, unless they are inside an aggregate function?
Because grouping collapses multiple rows into a single summary row, SQL would have ambiguity regarding which individual row's value to display for an unaggregated column. Requiring all non-aggregated select columns to be part of the `GROUP BY` ensures every returned value is deterministically tied to the grouping key.

## Task 4 — Advanced Filtering with HAVING

**Approach / explanation:**
Filtered summary groups by incorporating the `HAVING` clause to evaluate conditions on aggregate calculations (such as average salary thresholds and active headcount counts). Distinguished row-level filtering (`WHERE`) from group-level filtering (`HAVING`).

**Code / query used (if applicable):**
```sql
-- 4.1 Departments with average salary exceeding threshold (e.g., 60,000)
SELECT department, AVG(salary) AS avg_salary 
FROM employee 
GROUP BY department 
HAVING AVG(salary) > 60000;

-- 4.2 Active employees in departments with > 50 active headcount
SELECT department, COUNT(*) AS active_headcount 
FROM employee 
WHERE status = 'Active' 
GROUP BY department 
HAVING COUNT(*) > 50;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task4_output.png`

**Reflection question:**
Why must we use the `HAVING` clause here instead of the `WHERE` clause to filter by the average value?
`WHERE` filters individual rows *before* grouping and aggregation occur, meaning aggregate functions like `AVG()` or `COUNT()` do not yet exist during the `WHERE` evaluation phase. `HAVING` is specifically designed to filter summary groups *after* the aggregation has already been computed.

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week08/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)