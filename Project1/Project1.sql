SELECT * FROM Class_Project_1.Department;
use Class_Project_1;

#Section 1:
#1
INSERT INTO
	Project (project_id,project_title,project_manager,project_budget)
    VALUES(1,"Pension System","M Phillips",25500);
INSERT INTO
	Project (project_id,project_title,project_manager,project_budget)
    VALUES(2,"Salary System","H Martin",15500);
INSERT INTO
	Project (project_id,project_title,project_manager,project_budget)
    VALUES(3,"HR System","K Lewis",10500);
SELECT * from Project;
#2

INSERT INTO
	Department(dept_id,dept_name)
    VALUES(100,"IT");
INSERT INTO
	Department(dept_id,dept_name)
    VALUES(101,"HR");
INSERT INTO
	Department(dept_id,dept_name)
    VALUES(102,"DB");
SELECT * from Department;
#3
INSERT INTO
	employee(employee_id,employee_name,dept_id)
    VALUES(200,"A Smith",100);
INSERT INTO
	employee(employee_id,employee_name,dept_id)
    VALUES(201,"B Lewis",100);
INSERT INTO
	employee(employee_id,employee_name,dept_id)
    VALUES(202,"D Rich",101);
INSERT INTO
	employee(employee_id,employee_name,dept_id)
    VALUES(203,"E Ford",101);
INSERT INTO
	employee(employee_id,employee_name,dept_id)
    VALUES(204,"F James",102);
SELECT * from employee;
#4
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(1,200,25);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(1,201,18.5);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(1,202,21);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(2,203,20);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(2,204,17);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(3,201,17.5);
INSERT INTO
	Proj_Emp(project_id,employee_id,hourly_rate)
    VALUES(3,202,16.25);
SELECT * from Proj_Emp;

#Section 2
#a
SELECT project_title, project_manager, project_budget, 
	Employee.employee_name,
    Department.dept_name,
    Proj_Emp.hourly_rate
	from Project
    INNER JOIN Proj_Emp
    ON Project.project_id=Proj_Emp.project_id
    INNER JOIN Employee
    ON Proj_Emp.employee_id=Employee.employee_id
    INNER JOIN Department
    ON Employee.dept_id=Department.dept_id
    ORDER BY 1,2,3,4;
    
    
#b
SELECT employee_name,
	MAX(Proj_Emp.Hourly_rate) as 'max_hourly_rate'
	from Employee
    INNER JOIN Proj_Emp
    on Employee.employee_id=Proj_Emp.employee_id
    GROUP BY Employee.employee_name;
#c
SELECT project_title,
	Employee.employee_name,project_budget
	from Project
    INNER JOIN Proj_Emp
    ON Project.project_id=Proj_Emp.project_id
    INNER JOIN Employee
    ON Proj_Emp.employee_id=Employee.employee_id
    where Project.project_budget=
    (SELECT MIN(Project.project_budget)
    From Project);
#d
SELECT employee_name,
	d.dept_name,
    pe.Hourly_rate
	From Employee e
    INNER JOIN Proj_Emp pe
    ON e.employee_id=pe.employee_id
    INNER JOIN Department d
    ON e.dept_id=d.dept_id
    WHERE pe.Hourly_rate=
    (SELECT MAX(pe2.Hourly_rate)
    FROM Proj_Emp pe2
    INNER JOIN Employee e2
    ON pe2.employee_id=e2.employee_id
    INNER JOIN Department d2
    ON e2.dept_id=d2.dept_id
	WHERE d.dept_id=d2.dept_id);
#e
SELECT employee_name,
	Department.dept_name,
    Proj_Emp.Hourly_rate,
    RANK() OVER(PARTITION BY Department.dept_name
    ORDER BY Proj_Emp.Hourly_rate DESC)
    as 'Rank'
	FROM Employee
    INNER JOIN Proj_Emp
    ON Employee.employee_id=Proj_Emp.employee_id
    INNER JOIN Department
    ON Employee.dept_id=Department.dept_id;