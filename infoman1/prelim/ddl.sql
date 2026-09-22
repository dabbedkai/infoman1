CREATE DATABASE IF NOT EXISTS toolshare_prelim;
USE toolshare_prelim;

-- 1. Storage Location Table
CREATE TABLE storage_location (
    location_code VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    PRIMARY KEY (location_code)
);

-- 2. Member Table
CREATE TABLE member (
    member_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    membership_start_date DATE NOT NULL,
    PRIMARY KEY (member_id)
);

-- 3. Certification Table
CREATE TABLE certification (
    cert_id INT AUTO_INCREMENT NOT NULL,
    cert_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (cert_id)
);

-- 4. Tool Table
CREATE TABLE tool (
    tool_id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    purchase_date DATE NOT NULL,
    location_code VARCHAR(20) NOT NULL,
    PRIMARY KEY (tool_id),
    FOREIGN KEY (location_code) REFERENCES storage_location(location_code)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5. Borrowing Table (Junction: Member - Tool)
CREATE TABLE borrowing (
    borrow_id INT AUTO_INCREMENT NOT NULL,
    member_id INT NOT NULL,
    tool_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    PRIMARY KEY (borrow_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (tool_id) REFERENCES tool(tool_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. Member Certification Table (Junction: Member - Certification)
CREATE TABLE member_certification (
    member_id INT NOT NULL,
    cert_id INT NOT NULL,
    completion_date DATE NOT NULL,
    PRIMARY KEY (member_id, cert_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cert_id) REFERENCES certification(cert_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Tool Certification Table (Junction: Tool - Certification)
CREATE TABLE tool_certification (
    tool_id INT NOT NULL,
    cert_id INT NOT NULL,
    PRIMARY KEY (tool_id, cert_id),
    FOREIGN KEY (tool_id) REFERENCES tool(tool_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cert_id) REFERENCES certification(cert_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);