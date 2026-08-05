-- Business Question:
-- Which department and job-role combinations have the highest attrition rates?

-- Purpose:
-- Identify where employee turnover is most concentrated.

SELECT
    department,
    job_role,

    -- Count all employees in each department and job-role group
    COUNT(*) AS total_employees,

    -- Count employees who left the company
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_who_left,

    -- Calculate the attrition percentage for each group
    ROUND(
        100.0 * SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employee_attrition_raw

-- Create one group for each department and job-role combination
GROUP BY
    department,
    job_role

-- Keep only groups with at least 20 employees
HAVING COUNT(*) >= 20

-- Show the highest attrition rates first
ORDER BY attrition_rate DESC;