USE toolshare_prelim;

-- Query 1: List the names and categories of all tools in the "Power Tools" category.
SELECT name, category 
FROM tool 
WHERE category = 'Power Tools';

-- Query 2: Find all members who joined after January 1, 2025.
SELECT member_id, name, membership_start_date 
FROM member 
WHERE membership_start_date > '2025-01-01';

-- Query 3: Show all borrowing records currently on loan (return_date IS NULL).
SELECT borrow_id, member_id, tool_id, borrow_date, return_date 
FROM borrowing 
WHERE return_date IS NULL;

-- Query 4: List all borrowing records for one specific member ID (member_id = 1).
SELECT borrow_id, tool_id, borrow_date, return_date 
FROM borrowing 
WHERE member_id = 1;

-- Query 5: List all tools purchased before January 1, 2024.
SELECT tool_id, name, category, purchase_date 
FROM tool 
WHERE purchase_date < '2024-01-01';