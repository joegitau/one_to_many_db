-- SIMPLE ONE TO MANY RELATIONSHIP 
  --- includes table altering,  left join and simple math functions

-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS project_management DEFAULT CHARACTER SET utf8;

-- CREATE TABLES
  -- employees table
CREATE TABLE IF NOT EXISTS employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL DEFAULT 'employee',
  address VARCHAR(100),
  email VARCHAR(50),
  salary DECIMAL(6,2),
  phone_number NUMERIC
);

  -- projects table
CREATE TABLE IF NOT EXISTS projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  start_date DATE,
  end_date DATE,
  name VARCHAR(100) NOT NULL DEFAULT 'new project',
  description VARCHAR(255),
  employee_id INT,
  FOREIGN KEY(employee_id) REFERENCES employees(id)
  ON DELETE CASCADE
);

-- employee table data
INSERT INTO employees (name, address, email, salary, phone_number)
VALUES 
  ('Joseph Gitau', 'helsinki', 'kajoe@live.com', 4500, 0409311996),
  ('Andrea Kanoma', 'vantaa', 'andrea@live.com', 3500, 0408318966),
  ('Kevo Gitz', 'espoo', 'kevo@gitz.com', 5600, 0404516596),
  ('Abigs Glam', 'espoo', 'glam@hotmail.com', 4875, 0508991996),
  ('Mason Trevor', 'helsinki', 'trevor@live.com', 4500, 0449319896),
  ('Joseph Mane', 'vantaa', 'mane@live.com', 3450, 0409342696);

-- project table data
INSERT INTO projects (start_date, end_date, name, description, employee_id)
VALUES 
  ('2019.08.24', '2019.09.20', 'Visitor App', 'A nodejs API for visitor checkin', 1),
  ('2019.10.01', '2019.10.20', 'Guest Messaging', 'API to send notifications to guests', 1),
  ('2019.08.24', '2019.09.20', 'eCommerce API', 'E-commerce wesbstore', 3),
  ('2019.08.01', '2019.09.01', 'Tasks App', 'Simple tasks manager', 5),
  ('2018.12.01', '2019.01.31', 'Evovy Clone', 'Delivery management app for smes', 4),
  ('2019.08.24', '2019.09.20', 'Instagram Clone', 'Social platform for sharing images', 2),
  ('2019.02.02', '2019.04.20', 'Facebook Clone', 'Social networking platform', 2),
  ('2019.06.03', '2019.03.31', 'Chat Bot', 'Chat Bot for executives', 1);

---------------------
-- BASIC QUERIES

--- ALTER COLUMN NAME - in PROJECTS TABLE
ALTER TABLE projects
  CHANGE COLUMN name title VARCHAR(100);


-- SELECT * EMPLOYEES & RESPECTIVE PROJECTS + include project duration
SELECT 
  name, 
  title, 
  IFNULL(start_date, 'N/A') AS started, 
  IFNULL(end_date, 'N/A') AS completed,
  IFNULL( FROM_DAYS( DATEDIFF(end_date, start_date) ), 'N/A') AS duration
FROM employees e
LEFT JOIN projects p
  ON e.id = p.employee_id
ORDER BY duration DESC;