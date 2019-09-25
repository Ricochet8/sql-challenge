SELECT * FROM employees; 
SELECT * FROM salaries;

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

--2. List employees who were hired in 1987.
CREATE VIEW employeehire AS
SELECT emp_no, last_name, first_name, hire_date, 
Extract(YEAR FROM hire_date) AS hireyear FROM employees;

SELECT emp_no, last_name, first_name, hireyear
FROM employeehire
WHERE hireyear = 1987;

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date,
	employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_manager ON (dept_manager.emp_no=employees.emp_no)
JOIN departments ON (dept_manager.dept_no=departments.dept_no);

--4. List the department of each employee with the following information:
--employee number, last name, first name, and department name.
SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM employees
JOIN dept_emp ON (dept_emp.emp_no=employees.emp_no)
JOIN departments ON (dept_emp.dept_no=departments.dept_no);

--5. List all employees whose first name is "Duangkaew" and last names begin with "P."
SELECT last_name, first_name 
FROM employees
WHERE first_name = 'Duangkaew' AND last_name LIKE 'P%';




--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW salesdepartment AS
SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM employees
JOIN dept_emp ON (dept_emp.emp_no=employees.emp_no)
JOIN departments ON (dept_emp.dept_no=departments.dept_no);

SELECT dept_name, first_name, last_name, emp_no
FROM salesdepartment
WHERE dept_name = 'Sales';
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW developmentdepartment AS
SELECT departments.dept_name, employees.first_name, employees.last_name, employees.emp_no
FROM employees
JOIN dept_emp ON (dept_emp.emp_no=employees.emp_no)
JOIN departments ON (dept_emp.dept_no=departments.dept_no);

SELECT dept_name, first_name, last_name, emp_no
FROM developmentdepartment
WHERE dept_name = 'Sales' OR dept_name = 'Development';
--8. In ascending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "name count"
FROM employees
GROUP BY last_name
ORDER BY "name count" DESC;