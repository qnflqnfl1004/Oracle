/*
    <INDEX>
*/
SELECT ROWID, 
       EMP_ID, 
       EMP_NAME
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 202;

SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '황효종';
--WHERE STUDENT_NO = 'A511332';

-- 비고유 인덱스 생성
CREATE INDEX IDX_STUDENT_NAME
ON TB_STUDENT(STUDENT_NAME);

-- 결합 인덱스 생성
--A617031	C2272800
SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A617031' AND CLASS_NO = 'C2272800';

CREATE INDEX IDX_STUDENT_CLASS_NO
ON TB_GRADE(STUDENT_NO, CLASS_NO);

-- INDEX 삭제
DROP INDEX IDX_STUDENT_NAME;






