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
