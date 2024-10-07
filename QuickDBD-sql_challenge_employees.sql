-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Uq4Pon
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE IF EXISTS departments;
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
	)
);
INSERT INTO "departments" ("dept_no", "dept_name") 
VALUES 
    ('d001', 'Marketing'),
    ('d002', 'Finance'), 
    ('d003', 'Human Resources'),
    ('d004', 'Production'),
    ('d005', 'Development'),
    ('d006', 'Quality Management'),
    ('d007', 'Sales'),
    ('d008', 'Research'),
    ('d009', 'Customer Service');


DROP TABLE IF EXISTS dept_emp;	
CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR  NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY ("emp_no", "dept_no"
     ) 
);


CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "dept_manager" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_manager" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
FROM employees e

LEFT JOIN
	salaries s 
ON
	e.emp_no=s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
	first_name, 
	last_name,
	hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31'; 


-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
	t.title,
	m.dept_no,
	d.dept_name,
	m.emp_no,
	e.last_name,
	e.first_name
	
FROM employees e

INNER JOIN  titles t 
	ON e.emp_title_id =t.title_id

INNER JOIN 
    dept_emp de
    ON e.emp_no = de.emp_no
	
INNER JOIN
 	dept_manager m
	ON e.emp_no=m.emp_no
	
INNER JOIN
	departments d 
	ON m.dept_no=d.dept_no;
	

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT 
	de.dept_no,
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
	
FROM dept_emp de

INNER JOIN 
    employees e
    ON e.emp_no = de.emp_no 

INNER JOIN
	departments d
	ON de.dept_no = d.dept_no;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT 
	first_name,
	last_name,
	sex
FROM employees

WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';
	
-- List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
	d.dept_name,
	de.emp_no,
	e.last_name,
	e.first_name
	
FROM departments d

INNER JOIN 
	dept_emp de
	ON d.dept_no=de.dept_no

INNER JOIN
		employees e
	ON e.emp_no=de.emp_no

WHERE d.dept_name = 'Sales';

	
-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM 
	employees e

INNER JOIN
	dept_emp de
	ON e.emp_no=de.emp_no

INNER JOIN
	departments d
	ON de.dept_no=d.dept_no

WHERE d.dept_name IN ('Sales','Development');

-- check total amount employees in sales and development departments separately

SELECT d.dept_name, COUNT(e.emp_no) AS total_employees
FROM employees e
INNER JOIN dept_emp de 
	ON e.emp_no=de.emp_no
INNER JOIN departments d
	ON de.dept_no=d.dept_no
WHERE d.dept_name IN ('Sales','Development')
GROUP BY d.dept_name;

--List the frequency counts, in desocending order, of all the employees last nmes (that is, how many employees share each last name).

-- had to use INITCAP to make the first letter Uppercase and the rest lowercase, because the list was starting with the name dAstous, instead of letter Z, due to the lowercase d and upper case A.INITCAP avoids this.
SELECT INITCAP (last_name),COUNT(*) AS frequency_count
FROM employees
GROUP BY last_name 
ORDER BY LOWER (last_name) DESC;
