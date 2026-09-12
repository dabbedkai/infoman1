# INFOMAN1 — Week 5 Lab Reflection

**Name:** Kaizer David R. Palabay  
**Student ID:** 2510997  
**Section:** BSIT-II  

---

SELECT queries fall under Data Query Language (DQL), meaning they are strictly read-only operations. They are safe to run while exploring a database because they only fetch and display temporary result sets in memory. In contrast, DDL statements (like DROP or ALTER) permanently change table structures, while DML statements (like UPDATE or DELETE) modify or delete actual rows. Running an incorrect DDL or DML query can break a database, but a SELECT query will never alter or corrupt your stored data.

In Task 4, the mismatch I introduced was removing the single quotes around the string literal, writing WHERE species = Dog. Running this broke the query, throwing ERROR 1054 (42S22): Unknown column 'Dog' in 'where clause'. I diagnosed the error by comparing it directly to the working query (WHERE species = 'Dog'). I realized that without single quotes, MySQL's parser treats Dog as a column identifier instead of a string value. Adding the single quotes back resolved the error immediately and returned the expected records.