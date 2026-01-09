**Overview**



* This project analyzes student performance data using MySQL.
* The objective is to clean and validate the dataset, categorize student performance levels, and identify top-performing students within each performance tier using SQL analytical techniques.
* The project emphasizes data cleaning, logical categorization, and advanced SQL analysis using window functions and Common Table Expressions (CTEs).



**Dataset**



**Data Source**: Public YouTube statistics dataset sourced from Kaggle.



The dataset contains student-level academic performance data, including:

* Student ID
* Student name
* Score
* Percentile
* Z-score
* Performance tier label



**Data Cleaning \& Preparation**



**Duplicate Detection**



Student IDs were checked for duplicates to prevent inaccurate ranking and aggregation results.



**Text Standardization**



Student names were standardized by removing leading and trailing spaces to ensure consistency.



**Missing Value Handling**



Missing or empty performance tier labels were replaced with "Unknown" to maintain data completeness.



**Performance Categorization**



Students were categorized into performance ranges based on percentile values:

* Top Performer: Percentile ≥ 90
* Above Average: Percentile between 70 and 89
* Average: Percentile between 50 and 69
* Below Average: Percentile < 50

This categorization enables clearer interpretation of student performance levels beyond raw scores.



**Analysis \& Key Findings**



**Overall Performance**

* The dataset shows variation in student scores and percentiles, indicating diverse performance levels across the population.



**Tier-Based Insights**

* Average Z-scores differ across performance tiers, suggesting meaningful separation between groups.
* Ranking students within tiers highlights top performers without unfair comparison across different performance levels.



**Top Performers**

* The top student in each performance tier was identified using window functions.
* Comparing individual scores to tier averages provides additional context on relative performance.



**Tools Used**

* MySQL
* MySQL Workbench



**Screenshots**

1.Analysis Result 1

(screenshots/analysis\_result\_score\_difference\_vs\_tier\_average.png)

2.Analysis Result 2

(screenshots/analysis\_result\_top\_student\_each\_tier.png)

3.Analysis Result 3

(screenshots/analysis\_avg\_score\_and\_percentile.png)



