USE infoman1_vetclinic;

INSERT INTO owners (first_name, last_name, phone_number) VALUES
('Juan', 'Dela Cruz', '09171234567'),
('Maria', 'Santos', '09189876543'),
('Carlos', 'Reyes', '09195551234');

INSERT INTO veterinarians (first_name, last_name, specialization) VALUES
('Ana', 'Lim', 'General Practice'),
('Ramon', 'Garcia', 'Surgery');

INSERT INTO pets (name, species, age, owner_id) VALUES
('Buddy', 'Dog', 5, 1),
('Luna', 'Cat', 2, 1),
('Max', 'Dog', 1, 2),
('Bella', 'Cat', 4, 3);

INSERT INTO appointments (appointment_date, reason_for_visit, pet_id, vet_id) VALUES
('2026-04-10 09:00:00', 'Annual Vaccination', 1, 1),
('2026-04-12 14:30:00', 'Routine Checkup', 2, 2),
('2026-04-15 11:00:00', 'Dental Cleaning', 3, 1);

-- Task 1: Basic SELECT Statements
-- Query 1A:
SELECT * FROM pets;

-- Query 1B:
SELECT name, species FROM pets;

-- Task 2: Filtering with Equality
-- Query 2:
SELECT name, species FROM pets WHERE species = 'Dog';

-- Task 3: Filtering with Relational Operators
-- Query 3A:
SELECT name, species, age FROM pets WHERE age > 2;

-- Query 3B:
SELECT appointment_id, appointment_date, reason_for_visit 
FROM appointments 
WHERE appointment_date >= '2026-04-12 00:00:00';

-- Task 4: Combine and Debug
-- Query 4A (Working):
SELECT name, species, age FROM pets WHERE species = 'Dog';

-- Query 4B (Deliberately Broken)
SELECT name, species, age FROM pets WHERE species = Dog;