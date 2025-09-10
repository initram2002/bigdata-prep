-- Employee Data Analysis Queries
-- Sample SQL queries for analyzing employee dataset

-- Basic aggregations
SELECT 
    department,
    COUNT(*) as employee_count,
    AVG(salary) as avg_salary,
    MIN(salary) as min_salary,
    MAX(salary) as max_salary
FROM employees 
GROUP BY department
ORDER BY avg_salary DESC;

-- Performance analysis
SELECT 
    department,
    AVG(performance_score) as avg_performance,
    CASE 
        WHEN AVG(performance_score) >= 4.5 THEN 'Excellent'
        WHEN AVG(performance_score) >= 4.0 THEN 'Good'
        WHEN AVG(performance_score) >= 3.5 THEN 'Average'
        ELSE 'Below Average'
    END as performance_category
FROM employees
GROUP BY department;

-- Salary bands analysis
SELECT 
    CASE 
        WHEN salary >= 90000 THEN 'High (90K+)'
        WHEN salary >= 75000 THEN 'Medium-High (75K-90K)'
        WHEN salary >= 65000 THEN 'Medium (65K-75K)'
        ELSE 'Entry Level (<65K)'
    END as salary_band,
    COUNT(*) as employee_count,
    AVG(age) as avg_age,
    AVG(performance_score) as avg_performance
FROM employees
GROUP BY 
    CASE 
        WHEN salary >= 90000 THEN 'High (90K+)'
        WHEN salary >= 75000 THEN 'Medium-High (75K-90K)'
        WHEN salary >= 65000 THEN 'Medium (65K-75K)'
        ELSE 'Entry Level (<65K)'
    END
ORDER BY AVG(salary) DESC;

-- Hiring trends by year
SELECT 
    YEAR(hire_date) as hire_year,
    COUNT(*) as hires,
    AVG(salary) as avg_starting_salary
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;

-- Top performers by department
SELECT 
    department,
    name,
    salary,
    performance_score,
    RANK() OVER (PARTITION BY department ORDER BY performance_score DESC) as performance_rank
FROM employees
WHERE performance_score >= 4.0
ORDER BY department, performance_rank;