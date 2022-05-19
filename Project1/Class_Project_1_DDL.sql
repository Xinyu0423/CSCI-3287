/*
Class_Project_1: Insert data and run SQL queries
Smaple from Lecture 6 - Normalization_Exe.xlsx : Example 1
*/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- DB Schema Class_Project_1
-- -----------------------------------------------------
-- CREATE DATABASE IF NOT EXISTS Class_Project_1;

CREATE SCHEMA IF NOT EXISTS Class_Project_1;

USE Class_Project_1;

-- -----------------------------------------------------
-- Table Class_Project_1.Project
-- -----------------------------------------------------
DROP TABLE IF EXISTS Class_Project_1.Project;

CREATE TABLE IF NOT EXISTS Class_Project_1.Project
(
	project_id INT (10) NOT NULL PRIMARY KEY,
	project_title VARCHAR(45),
	project_manager VARCHAR(45),	
    project_budget DECIMAL (10,0)
)
;

DESC Class_Project_1.Project;

-- -----------------------------------------------------
-- Table Class_Project_1.Department
-- -----------------------------------------------------
DROP TABLE IF EXISTS Class_Project_1.Department;

CREATE TABLE IF NOT EXISTS Class_Project_1.Department
(
	dept_id INT (10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(45)
)
;

DESC Class_Project_1.Department;

-- -----------------------------------------------------
-- Table Class_Project_1.Employee
-- -----------------------------------------------------
DROP TABLE IF EXISTS Class_Project_1.Employee;

CREATE TABLE IF NOT EXISTS Class_Project_1.Employee
(
	employee_id INT (10) NOT NULL PRIMARY KEY,
	employee_name VARCHAR(45),
	dept_id INT (10),	
    CONSTRAINT fk_emp_dept_dept_id
		FOREIGN KEY (dept_id)
		REFERENCES Class_Project_1.Department (dept_id)
)
;

DESC Class_Project_1.Employee;

-- -----------------------------------------------------
-- Table Project.Proj_Emp
-- -----------------------------------------------------
DROP TABLE IF EXISTS Class_Project_1.Proj_Emp;

CREATE TABLE IF NOT EXISTS Class_Project_1.Proj_Emp 
(
	project_id INT (10),
	employee_id INT (10),
	Hourly_rate DECIMAL (4,2),
	PRIMARY KEY (project_id, employee_id),
	CONSTRAINT fk_proj_emp_project_id
		FOREIGN KEY (project_id)
		REFERENCES Class_Project_1.Project (project_id),
    CONSTRAINT fk_proj_emp_employee_id
		FOREIGN KEY (employee_id)
		REFERENCES Class_Project_1.Employee (employee_id)
)
;

DESC Class_Project_1.Proj_Emp;


