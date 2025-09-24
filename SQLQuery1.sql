Create database StudentVle;

Create Database OULAD;

Select * from dbo.studentVle_processed;

Select * from dbo.studentAssessment ; 

SELECT *
FROM studentAssessment
WHERE score IS NULL;

SELECT id_assessment, id_student, COALESCE(score, 0) AS score
FROM studentAssessment
WHERE score IS NULL;

UPDATE studentAssessment
SET score = '0'
Where score IS NULL;


SELECT * FROM StudentInfo;
