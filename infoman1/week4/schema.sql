-- Task 1: Create and select database
CREATE DATABASE IF NOT EXISTS infoman1_vetclinic;
USE infoman1_vetclinic;

-- Task 2: Core Tables
CREATE TABLE owners (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT NOT NULL
);

CREATE TABLE veterinarians (
    vet_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL
);

CREATE TABLE pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    owner_id INT NOT NULL,
    CONSTRAINT fk_pets_owners 
        FOREIGN KEY (owner_id) REFERENCES owners(owner_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Task 3: Relationship Tables
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    reason_for_visit VARCHAR(255) NOT NULL,
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    CONSTRAINT fk_appointments_pets 
        FOREIGN KEY (pet_id) REFERENCES pets(pet_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_appointments_veterinarians 
        FOREIGN KEY (vet_id) REFERENCES veterinarians(vet_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE vaccination_records (
    pet_id INT NOT NULL,
    vaccine_name VARCHAR(100) NOT NULL,
    vaccination_date DATE NOT NULL,
    PRIMARY KEY (pet_id, vaccine_name, vaccination_date),
    CONSTRAINT fk_vaccination_pets 
        FOREIGN KEY (pet_id) REFERENCES pets(pet_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Task 5: Deliberate Mistake Fix
ALTER TABLE owners 
MODIFY COLUMN phone_number VARCHAR(20) NOT NULL;