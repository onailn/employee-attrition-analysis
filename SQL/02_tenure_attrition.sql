-- Business Question:
-- How does employee tenure affect attrition?

-- Purpose:
-- Identify which tenure groups have the highest employee turnover.

WITH tenure_groups AS (

    -- Assign each employee to a tenure category
    SELECT
        CASE
            WHEN years_at_company BETWEEN 0 AND 2 THEN '0-2 years'
            WHEN years_at_company BETWEEN 3 AND 5 THEN '3-5 years'
            WHEN years_at_company BETWEEN 6 AND 10 THEN '6-10 years'
            WHEN years_at_company BETWEEN 11 AND 15 THEN '11-15 years'
            ELSE '16+ years'
        END AS tenure_group,

        attrition

    FROM employee_attrition_raw
)

SELECT
    tenure_group,

    -- Count all employees in each tenure group
    COUNT(*) AS total_employees,

    -- Count employees who left in each tenure group
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_who_left,

    -- Calculate the attrition percentage for each tenure group
    ROUND(
        100.0 * SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM tenure_groups

-- Create one result row for each tenure group
GROUP BY tenure_group

-- Show the highest attrition rates first
ORDER BY attrition_rate DESC;