USE infoman1_canteen;

-- ==========================================
-- TASK 1: INNER JOIN Basics
-- ==========================================
SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
ORDER BY o.order_id ASC;

-- ==========================================
-- TASK 2: Finding Missing Relationships
-- ==========================================
-- (a) All students with matched orders (NULL for non-buyers)
SELECT s.student_id, s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
ORDER BY s.student_id ASC;

-- (b) Only students who NEVER ordered
SELECT s.student_id, s.student_name, s.program
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_id IS NULL;

-- ==========================================
-- TASK 3: Four-Table Canteen Report
-- ==========================================
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

-- ==========================================
-- TASK 4: Filters and Silent Inner Join
-- ==========================================
-- Version A: Standard INNER JOIN with date filter
SELECT 
    s.student_name, 
    o.order_id, 
    o.order_date, 
    m.item_name, 
    (oi.quantity * m.price) AS line_total
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN menu_items m ON oi.menu_id = m.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC;

-- Version B: Flawed LEFT JOIN (WHERE converts it to INNER JOIN)
SELECT 
    s.student_name, 
    o.order_id, 
    o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_date >= '2026-08-01';

-- Version B (Fixed): Correct OUTER JOIN preserving students without orders
SELECT 
    s.student_name, 
    o.order_id, 
    o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id AND o.order_date >= '2026-08-01';