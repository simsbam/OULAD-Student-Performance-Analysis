# OULAD-Student-Performance-Analysis
Open University Learning Analysis to see factors that affect students performances with the learning plaform.

## Project Overview  
This project uses the **Open University Learning Analytics Dataset (OULAD)** to explore factors affecting student performance.  
The aim is to identify patterns in demographics, engagement, and assessments that contribute to student success or failure, and to demonstrate the use of **SQL** and **Power BI** for cleaning, analysis, and visualization.  

---

## Tools & Technologies  
- **SQL (MySQL & SSMS)** → data cleaning, joins, and preparation  
- **Power BI** → data modeling, DAX calculations, and visualization  
- **Excel** → initial exploration and checks  

---

## Process & Steps  

### **1. Data Cleaning (SQL)**  
- Imported OULAD dataset into SQL.  
- Handled:  
  - Null values, blanks, and missing records.  
  - Standardized text fields (e.g., gender, region).  
  - Converted data types where necessary.  
  - Dropped irrelevant/duplicate columns.  

**Example SQL queries:**  
```sql
-- Checking for null/blank values
SELECT *
FROM studentInfo
WHERE highest_education IS NULL OR TRIM(highest_education) = '';

-- Removing duplicates
SELECT id_student, COUNT(*)
FROM studentAssessment
GROUP BY id_student
HAVING COUNT(*) > 1;
```
To view the entire SQL file

---

### **2. Data Modeling (Power BI)**  
- Imported cleaned SQL tables into Power BI.  
- Built relationships:  
  - `studentInfo` ↔ `studentAssessment`  
  - `studentAssessment` ↔ `assessments`  
  - `studentVle` ↔ `vle`  
  - `courses` linked via `code_module` & `code_presentation`.  
- Removed unnecessary relationships to avoid circular references.  

---

### **3. DAX Calculations**  
Created calculated columns and measures for analysis:  

```DAX
-- Pass Rate %
Pass Rate % =
VAR TotalStudents = COUNTROWS(studentInfo)
VAR PassStudents =
    CALCULATE(
        COUNTROWS(studentInfo),
        studentInfo[final_result] = "Pass"
    )
RETURN DIVIDE(PassStudents, TotalStudents, 0) * 100

-- Total Clicks
Total Clicks = SUM(studentVle[sum_click])

-- Average Assessment Score
Average Assessment Score = AVERAGE(studentAssessment[score])

-- Engagement Level
Engagement Level =
SWITCH(
    TRUE(),
    [Total Clicks] < 100, "Low",
    [Total Clicks] >= 100 && [Total Clicks] < 500, "Medium",
    [Total Clicks] >= 500, "High",
    "Unknown"
)
```

---

### **4. Visualizations (Power BI)**  
Created visuals to answer key questions:  

1. **Impact of Disability on Performance** → Clustered Column Chart  
2. **Assessment Score vs Final Result** → Scatter Plot / Box Plot  
3. **Gender vs Final Result** → Clustered Column Chart  
4. **Highest Education vs Performance** → Column Chart  
5. **Attempts vs Average Score** → Line Chart  
6. **Overall KPIs** → Card visuals for Pass Rate, Dropout Rate, Average Score, Total Clicks  

Added slicers for `gender`, `disability`, `age_band`, `highest_education`, `module`, and `semester`.  
Click here to view the visualization report.

---

## Insights  

- **Disability Status:** Students without disabilities had higher pass rates, suggesting barriers exist for disabled students.  
- **Assessment Scores:** Strong correlation with final results — low scores were a clear indicator of failure.  
- **Gender:** Little difference in overall outcomes, but module-level differences exist.  
- **Education Level:** Higher prior education correlated with better outcomes.  
- **Previous Attempts:** Students with repeated attempts often struggled, though some showed improvement after one retry.  

---

## Discussion  
The analysis highlights how **engagement (clicks, assessments)** and **background (education, disability)** impact academic success.  
This supports the case for:  
- **Early intervention** for disengaged or struggling students to reduce dropout rate.  
- **Tailored support** for students with disabilities and with poor educational background. 
- **Encouraging strong assessment performance** as a predictor of success.

---

## Conclusion  
By analyzing the OULAD dataset, we can:  
- Predict student outcomes using engagement and assessment metrics.  
- Provide targeted academic support.  
- Reduce dropout rates and improve learning outcomes.  

This project demonstrates the power of combining **SQL for data preparation** and **Power BI for analytics & visualization** to extract actionable insights from educational datasets.  

---
