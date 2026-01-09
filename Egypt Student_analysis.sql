-- Purpose: Create and select a dedicated database for student performance analysis

CREATE DATABASE student_performance_db;
USE student_performance_db;

-- Purpose: Create a table to store student performance metrics and classification tiers

CREATE TABLE `student_scores2` (
  `Student_ID` int DEFAULT NULL,
  `Name` text,
  `Score` double DEFAULT NULL,
  `Percentile` double DEFAULT NULL,
  `Zscore` double DEFAULT NULL,
  `Cluster` double DEFAULT NULL,
  `Performance_Tier` int DEFAULT NULL,
  `Tier_Label` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT student_scores2
SELECT *
FROM student_scores;

SELECT *
FROM student_scores2;

-- Purpose: Identify duplicate student IDs that could affect ranking and aggregation

SELECT `student_id`, COUNT(*) AS duplicate_count
FROM student_scores2
GROUP BY student_id
HAVING COUNT(*) > 1;

-- Purpose: Remove leading and trailing spaces from student names to ensure consistency

UPDATE student_scores2
SET `name` = TRIM(`name`);

-- Purpose: Replace missing or NULL tier labels with 'Unknown' for data completeness

UPDATE student_scores2
SET tier_label = 'Unknown'
WHERE tier_label IS NULL OR tier_label = '';

-- Purpose: Calculate overall average score and percentile of all students

SELECT 
    AVG(score) AS avg_score,
    AVG(percentile) AS avg_percentile
FROM student_scores2;

-- Purpose: Count number of students in each performance tier

SELECT Tier_Label,
COUNT(*) AS Total_student
FROM student_scores2
GROUP BY Tier_Label;

-- Purpose: Identify the top 10 students based on score

SELECT student_id, `name`, score
FROM student_scores2
ORDER BY score DESC
LIMIT 10;

-- Purpose: Determine the highest and lowest student scores

SELECT 
    MAX(score) AS highest_score,
    MIN(score) AS lowest_score
FROM student_scores2;

-- Purpose: Calculate average Z-score for each performance tier

SELECT tier_label, AVG(zscore) AS avg_zscore
FROM student_scores2
GROUP BY tier_label;

-- Purpose: Categorize students into performance ranges based on percentile

SELECT 
    student_id,
    `name`,
    percentile,
    CASE
        WHEN percentile >= 90 THEN 'Top Performer'
        WHEN percentile BETWEEN 70 AND 89 THEN 'Above Average'
        WHEN percentile BETWEEN 50 AND 69 THEN 'Average'
        ELSE 'Below Average'
    END AS performance_range
FROM student_scores2;

-- Purpose: Count number of students in each performance range category

SELECT 
CASE
	WHEN Percentile >= 90 THEN 'Top Performer'
    WHEN Percentile >= 70 THEN 'Above Performer'
    WHEN Percentile >= 50 THEN 'Average'
    ELSE 'Below Average'
END AS Performance_Range_Test,
COUNT(*) AS Total_People
FROM student_scores2
GROUP BY Performance_Range_Test;

-- Purpose: Rank students by score within each performance tier using a CTE

WITH Students_Rank AS
(
	SELECT  student_id, `name`, tier_label, score,
	DENSE_RANK () OVER (PARTITION by Performance_Tier ORDER BY score DESC) AS rank_students
	FROM student_scores2
) 
SELECT*
FROM Students_Rank
ORDER BY tier_label, Rank_Students;

-- Purpose: Identify the top-performing student in each performance tier

WITH Students_Rank AS
(
SELECT  student_id, `name`, tier_label, score,
row_number () OVER (PARTITION by Performance_Tier ORDER BY score DESC) AS rank_students
FROM student_scores2
) 
SELECT*
FROM Students_Rank
WHERE Rank_Students = 1
;

-- Purpose: Compare each student's score to the average score of their tier

SELECT 
    student_id,
    `name`,
    tier_label,
    score,
    AVG(score) OVER (PARTITION BY tier_label) AS tier_avg_score,
    score - AVG(score) OVER (PARTITION BY tier_label) AS score_diff_from_avg
FROM student_scores2
ORDER BY score DESC;

