use assignment;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(50),
    address VARCHAR(100)
);

desc Customers;

CREATE TABLE Policies (
    policy_id INT PRIMARY KEY,
    policy_name VARCHAR(50),
    policy_type VARCHAR(20),
    coverage_details VARCHAR(255),
    premium DECIMAL(10, 2),
    start_date DATE,
    end_date DATE
);

desc  Policies;

CREATE TABLE Claims (
    claim_id INT PRIMARY KEY,
    claim_date DATE,
    claim_amount DECIMAL(10, 2),
    approved_amount DECIMAL(10, 2),
    claim_status VARCHAR(20),
    policy_id INT,
    customer_id INT,
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

desc Claims;

CREATE TABLE Agents (
    agent_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_number VARCHAR(15),
    email VARCHAR(50),
    hire_date DATE
);

desc Agents;

CREATE TABLE Policy_Assignments (
    assignment_id INT PRIMARY KEY,
    customer_id INT,
    policy_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id)
);

desc Policy_Assignments;


CREATE TABLE Claim_Processing (
    processing_id INT PRIMARY KEY,
    claim_id INT,
    processing_date DATE,
    payment_amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (claim_id) REFERENCES Claims(claim_id)
);

desc Claim_Processing;

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, gender, contact_number, email, address) VALUES
(1, 'Amit', 'Kumar', '1985-01-15', 'Male', '9876543210', 'amit@example.com', 'Delhi, India'),
(2, 'Neha', 'Sharma', '1990-05-10', 'Female', '9123456789', 'neha@example.com', 'Mumbai, India'),
(3, 'Rohit', 'Singh', '1988-08-20', 'Male', '9988776655', 'rohit@example.com', 'Bangalore, India');

INSERT INTO Policies (policy_id, policy_name, policy_type, coverage_details, premium, start_date, end_date) VALUES
(1, 'Health Shield', 'Health', 'Covers hospitalization and medical expenses', 12000.00, '2023-01-01', '2024-01-01'),
(2, 'Auto Protect', 'Auto', 'Covers vehicle damage and accidents', 8000.00, '2023-06-01', '2024-06-01'),
(3, 'Life Care', 'Life', 'Life insurance policy with death benefits', 15000.00, '2022-05-01', '2032-05-01');


INSERT INTO Claims (claim_id, claim_date, claim_amount, approved_amount, claim_status, policy_id, customer_id) VALUES
(1, '2023-02-15', 5000.00, 4800.00, 'Approved', 1, 1),
(2, '2023-07-10', 10000.00, 0.00, 'Denied', 2, 2),
(3, '2023-09-05', 15000.00, 14000.00, 'Approved', 3, 3);

INSERT INTO Agents (agent_id, first_name, last_name, contact_number, email, hire_date) VALUES
(1, 'Ravi', 'Verma', '9812345678', 'ravi@insurance.com', '2022-02-15'),
(2, 'Sonal', 'Gupta', '9923456781', 'sonal@insurance.com', '2021-11-20'),
(3, 'Vikram', 'Rao', '9876543211', 'vikram@insurance.com', '2020-05-10');

INSERT INTO Policy_Assignments (assignment_id, customer_id, policy_id, start_date, end_date) VALUES
(1, 1, 1, '2023-01-01', '2024-01-01'),
(2, 2, 2, '2023-06-01', '2024-06-01'),
(3, 3, 3, '2022-05-01', '2032-05-01');

INSERT INTO Claim_Processing (processing_id, claim_id, processing_date, payment_amount, payment_date) VALUES
(1, 1, '2023-02-16', 4800.00, '2023-02-20'),
(2, 3, '2023-09-10', 14000.00, '2023-09-15');

SELECT * FROM Customers;
SELECT * FROM Policies;
SELECT * FROM Claims;
SELECT * FROM Agents;
SELECT * FROM Policy_Assignments;
SELECT * FROM Claim_Processing;


-- 1. Customers and Policies
SELECT 
    c.customer_id, c.first_name, c.last_name, 
    p.policy_name, p.policy_type, pa.start_date, pa.end_date
FROM 
    Customers c
JOIN 
    Policy_Assignments pa ON c.customer_id = pa.customer_id
JOIN 
    Policies p ON pa.policy_id = p.policy_id;

-- 2. Policies and Claims
SELECT 
    p.policy_id, p.policy_name, p.policy_type, 
    cl.claim_id, cl.claim_date, cl.claim_amount, cl.claim_status
FROM 
    Policies p
JOIN 
    Claims cl ON p.policy_id = cl.policy_id;

-- 3. Customers and Claims
SELECT 
    c.customer_id, c.first_name, c.last_name, 
    cl.claim_id, cl.claim_date, cl.claim_amount, cl.claim_status
FROM 
    Customers c
JOIN 
    Claims cl ON c.customer_id = cl.customer_id;

-- 4. Claims and Claim Processing
SELECT 
    cl.claim_id, cl.claim_date, cl.claim_amount, cl.claim_status, 
    cp.processing_id, cp.processing_date, cp.payment_amount, cp.payment_date
FROM 
    Claims cl
JOIN 
    Claim_Processing cp ON cl.claim_id = cp.claim_id;

-- 5. Agents and Policies
SELECT 
    c.customer_id, c.first_name AS customer_first_name, 
    p.policy_id, p.policy_name, pa.start_date, pa.end_date
FROM 
    Policy_Assignments pa
JOIN 
    Customers c ON pa.customer_id = c.customer_id
JOIN 
    Policies p ON pa.policy_id = p.policy_id;

-- DDL Queries
-- 1. Add a new column to the agents table:
ALTER TABLE Agents ADD region VARCHAR(50);
DESC Agents;

-- 2. Rename the policy_name column in the policies table to policy_title:
alter table policies rename column policy_name to  policy_title;

-- 3. Drop the address column from the customers table:
alter table  customers drop address;

-- DML Queries
-- 1. Update a policy's premium amount:
update  Policies set premium =10000 where policy_id=1;

-- 2. Delete a specific claim:
desc Claims ;
DELETE FROM Claims WHERE claim_id = 3;
DELETE FROM Claim_Processing 
WHERE claim_id = 3;

-- 3. Insert a new policy assignment:
desc Policy_Assignments;
INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, gender, contact_number, email) 
VALUES 
(5, 'Raj', 'Sharma', '1990-02-15', 'Male', 9876543210, 'raj.sharma@example.com');
INSERT INTO Policies (policy_id, policy_title, policy_type, coverage_details, premium, start_date, end_date) 
VALUES 
(4, 'Health Protect Plan', 'Health', 'Covers hospitalization and surgeries', 15000, '2023-01-01', '2024-12-31');
INSERT INTO Policy_Assignments (assignment_id, customer_id, policy_id, start_date, end_date) VALUES
(4, 4, 4, '2023-01-01', '2024-01-01');

-- Join Queries
-- 1. Retrieve all customers with their assigned policies and agents:
SELECT 
    c.customer_id, 
    c.first_name AS customer_first_name, 
    c.last_name AS customer_last_name, 
    p.policy_id, 
    p.policy_title, 
    p.policy_type, 
    pa.start_date, 
    pa.end_date
FROM 
    Policy_Assignments pa
JOIN 
    Customers c ON pa.customer_id = c.customer_id
JOIN 
    Policies p ON pa.policy_id = p.policy_id;
    
    -- 2. Find all claims and the associated policy details:
    SELECT 
    cl.claim_id, 
    cl.claim_date, 
    cl.claim_amount, 
    cl.approved_amount, 
    cl.claim_status, 
    p.policy_id, 
    p.policy_title, 
    p.policy_type, 
    p.start_date, 
    p.end_date
FROM 
    Claims cl
JOIN 
    Policies p ON cl.policy_id = p.policy_id;
-- 3. List all claims along with the customer details:
SELECT 
    cl.claim_id, 
    cl.claim_date, 
    cl.claim_amount, 
    cl.approved_amount, 
    cl.claim_status, 
    c.customer_id, 
    c.first_name AS customer_first_name, 
    c.last_name AS customer_last_name, 
    c.contact_number, 
    c.email
FROM 
    Claims cl
JOIN 
    Customers c ON cl.customer_id = c.customer_id;
--- 4. Get the total claim amount and number of claims per policy type:
SELECT 
    p.policy_type, 
    COUNT(cl.claim_id) AS total_claims, 
    SUM(cl.claim_amount) AS total_claim_amount
FROM 
    Claims cl
JOIN 
    Policies p ON cl.policy_id = p.policy_id
GROUP BY 
    p.policy_type;

-- 5. Find the most recent claim for each customer:
SELECT 
    c.customer_id, 
    c.first_name AS customer_first_name, 
    c.last_name AS customer_last_name, 
    cl.claim_id, 
    cl.claim_date, 
    cl.claim_amount, 
    cl.approved_amount, 
    cl.claim_status
FROM 
    Customers c
JOIN 
    Claims cl ON c.customer_id = cl.customer_id
WHERE 
    cl.claim_date = (
        SELECT MAX(cl2.claim_date)
        FROM Claims cl2
        WHERE cl2.customer_id = c.customer_id
    );






