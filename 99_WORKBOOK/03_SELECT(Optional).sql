--춘 대학교 워크북 과제
--SQL03_SELECT(Option)

-- 1번
-- 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT
ORDER BY 1;

-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME "학생이름", STUDENT_NO "학번", STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
	AND (STUDENT_ADDRESS LIKE '경기도%' OR STUDENT_ADDRESS LIKE '강원도%')
ORDER BY 1;

-- 4번
-- 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과 코드'는 학과 테이블을 조회해서 찾아 내도록 하자)
SELECT * FROM TB_PROFESSOR;  --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT; --> DEPARTMENT_NO

-- ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY 2;

-- ORACLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
    AND DEPARTMENT_NAME = '법학과'
ORDER BY 2;

-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고,
-- 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해 보시오.
-- 워크북 결과와 동일하게 소수점 아래 2자리까지 0으로 표현하기 위해서 TO_CHAR(NUMBER, 'FM9.00') 포맷 사용
SELECT * FROM TB_GRADE;

SELECT STUDENT_NO, TO_CHAR(POINT,'99.99') "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402'
  AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

-- ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2;


-- 7번
-- 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL문장을 작성하시오.
SELECT * FROM TB_CLASS;         --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2, 1;

-- 8번
-- 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT * FROM TB_CLASS_PROFESSOR; --> CLASS_NO, PROFESSOR_NO
SELECT * FROM TB_CLASS;           --> CLASS_NO
SELECT * FROM TB_PROFESSOR;       -->           PROFESSOR_NO

-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO
ORDER BY 2, 1;

-- 9번
-- 8번의 결과 중 '인문 사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT * FROM TB_DEPARTMENT;        --> DEPARTMENT_NO
-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO) --> DEPARTMENT를 조인해야 CATEGORY 컬럼을 사용할 수 있다.  
WHERE CATEGORY = '인문사회'
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO
  AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND CATEGORY = '인문사회'
ORDER BY 2, 1;
                        
-- 10번
-- '음악학과' 학생들의 평점을 구하려고 한다. 
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT * FROM TB_GRADE;      --> STUDENT_NO
SELECT * FROM TB_STUDENT;    --> STUDENT_NO  DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT; -->             DEPARTMENT_NO

-- ANSI
SELECT STUDENT_NO "학번", STUDENT_NAME "학생 이름", ROUND(AVG(POINT), 1) "전체 평점"
FROM TB_GRADE
JOIN TB_STUDENT S USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME='음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_GRADE G, TB_STUDENT S, TB_DEPARTMENT D
WHERE G.STUDENT_NO = S.STUDENT_NO
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 1;


-- 11번
-- 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
-- 이때 사용할 SQL문을 작성하시오.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO   COACH_PROFESSOR_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    -->                 PROFESSOR_NO

-- ANSI
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- ORACLE
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR
WHERE COACH_PROFESSOR_NO = PROFESSOR_NO
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND STUDENT_NO = 'A313047';


-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 
-- 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.

SELECT * FROM TB_STUDENT;   --> STUDENT_NO 
SELECT * FROM TB_GRADE;     --> STUDENT_NO     CLASS_NO
SELECT * FROM TB_CLASS;     -->                CLASS_NO

-- ANSI
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE CLASS_NAME = '인간관계론'
  AND TERM_NO LIKE '2007%';
  
-- ORACLE
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE S.STUDENT_NO = G.STUDENT_NO
  AND G.CLASS_NO = C.CLASS_NO
  AND CLASS_NAME = '인간관계론'
  AND TERM_NO LIKE '2007%';


-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- 결과 행의 수는 동일하나 정렬 기준이 없어 다른 순서를 보임
SELECT * FROM TB_CLASS;             --> CLASS_NO    DEPARTMENT_NO
SELECT * FROM TB_CLASS_PROFESSOR;   --> CLASS_NO   
SELECT * FROM TB_DEPARTMENT;        -->             DEPARTMENT_NO

SELECT CLASS_NO, CLASS_NAME, DEPARTMENT_NO, PROFESSOR_NO
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
WHERE PROFESSOR_NO IS NULL;

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
  AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = P.CLASS_NO(+)
  AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND CATEGORY = '예체능'
  AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;


-- 14번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- "지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오. 
-- 단 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO   COACH_PROFESSOR_NO
SELECT * FROM TB_PROFESSOR;     -->                 PROFESSOR_NO 
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;

-- ORACLE
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D 
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;

-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 
-- 그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는 SQL문을 작성하시오.
SELECT * FROM TB_STUDENT WHERE ABSENCE_YN = 'N';    --> STUDENT_NO   DEPARTMENT_NO
SELECT * FROM TB_GRADE;                             --> STUDENT_NO
SELECT * FROM TB_DEPARTMENT;                        -->              DEPARTMENT_NO

-- ANSI
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT 
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND S.STUDENT_NO = G.STUDENT_NO
  AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='환경조경학과'; --> DEPARTMENT_NO
SELECT * FROM TB_CLASS WHERE CLASS_TYPE LIKE '전공%';            --> DEPARTMENT_NO   CLASS_NO
SELECT * FROM TB_GRADE;                                         -->                 CLASS_NO

-- ANSI
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
  AND CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- ORACLE
SELECT C.CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS C, TB_GRADE G, TB_DEPARTMENT D
WHERE C.CLASS_NO = G.CLASS_NO
  AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '환경조경학과'
  AND CLASS_TYPE LIKE '%전공%'
GROUP BY C.CLASS_NO, CLASS_NAME
ORDER BY 1;


-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_STUDENT
                       WHERE STUDENT_NAME = '최경희');
                       
-- 18번
-- 국어국문학과에서 총점수가 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='국어국문학과'; --> DEPARTMENT_NO
SELECT * FROM TB_STUDENT;                                       --> DEPARTMENT_NO   STUDENT_NO
SELECT * FROM TB_GRADE;                                         -->                 STUDENT_NO

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과' --> 해당 조건이 없어도 결과는 잘 나오나 정확히 하자면 추가해줘야됨
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                     FROM TB_STUDENT
                     JOIN TB_GRADE USING(STUDENT_NO)
                     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                     WHERE DEPARTMENT_NAME = '국어국문학과'
                     GROUP BY STUDENT_NO);

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과' --> 해당 조건이 없어도 결과는 잘 나오나 정확히 하자면 추가해줘야됨
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT)) 
                     FROM TB_STUDENT
                     JOIN TB_GRADE USING(STUDENT_NO)
                     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                     WHERE DEPARTMENT_NAME = '국어국문학과'
                     GROUP BY STUDENT_NO);


-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 
-- 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 
-- 평점은 소수점 한자리까지만 반올림하여 표시되도록 한다.
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='환경조경학과'; --> DEPARTMENT_NO
SELECT * FROM TB_CLASS;                                         --> DEPARTMENT_NO   CLASS_NO
SELECT * FROM TB_GRADE;                                         -->                 CLASS_NO

-- ANSI
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT 
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = '환경조경학과')
    AND CLASS_TYPE LIKE '%전공%' --> 얘 추가해줘야 결과값 같다!!
GROUP BY DEPARTMENT_NAME
ORDER BY 1; 

-- ORACLE
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT D, TB_CLASS C, TB_GRADE G
WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
AND C.CLASS_NO = G.CLASS_NO
AND CATEGORY = (SELECT CATEGORY
                FROM TB_DEPARTMENT
                WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '%전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;