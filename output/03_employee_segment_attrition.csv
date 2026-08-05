-- Business Question:
-- Which employee segments have the highest attrition rates?
-- Purpose:
-- Compare turnover across employee groups based on overtime,
-- satisfaction, income, tenure, travel, and promotion history.
WITH
	EMPLOYEE_SEGMENTS AS (
		-- Assign each employee to one segment
		SELECT
			CASE
				WHEN OVERTIME = 'Yes'
				AND JOB_SATISFACTION <= 2 THEN 'Overtime + Low Satisfaction'
				WHEN OVERTIME = 'Yes'
				AND YEARS_SINCE_LAST_PROMOTION >= 4 THEN 'Overtime + Promotion Gap'
				WHEN MONTHLY_INCOME < 4000
				AND YEARS_AT_COMPANY <= 2 THEN 'Low Income + Short Tenure'
				WHEN BUSINESS_TRAVEL = 'Travel_Frequently'
				AND OVERTIME = 'Yes' THEN 'Frequent Travel + Overtime'
				WHEN JOB_SATISFACTION <= 2
				AND YEARS_SINCE_LAST_PROMOTION >= 4 THEN 'Low Satisfaction + Promotion Gap'
				ELSE 'Other Employees'
			END AS EMPLOYEE_SEGMENT,
			ATTRITION
		FROM
			EMPLOYEE_ATTRITION_RAW
	)
SELECT
	EMPLOYEE_SEGMENT,
	-- Count all employees in each segment
	COUNT(*) AS TOTAL_EMPLOYEES,
	-- Count employees who left in each segment
	SUM(
		CASE
			WHEN ATTRITION = 'Yes' THEN 1
			ELSE 0
		END
	) AS EMPLOYEES_WHO_LEFT,
	-- Calculate the attrition percentage for each segment
	ROUND(
		100.0 * SUM(
			CASE
				WHEN ATTRITION = 'Yes' THEN 1
				ELSE 0
			END
		) / COUNT(*),
		2
	) AS ATTRITION_RATE
FROM
	EMPLOYEE_SEGMENTS
	-- Create one result row for each employee segment
GROUP BY
	EMPLOYEE_SEGMENT
	-- Remove segments with fewer than 20 employees
HAVING
	COUNT(*) >= 20
	-- Show the highest attrition rates first
ORDER BY
	ATTRITION_RATE DESC;