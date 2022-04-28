/* 
    <SELECT>
      SELECT 컬럼 [, 컬럼, ...]
        FROM 테이블명;
        
      - 테이블에서 데이터를 조회할 때 사용하는 SQL 문이다.
      - SELECT를 통해서 조회된 결과를 RESULT SET이라고 한다.
      - 조회하고자 하는 컬럼은 반드시 FROM 절에 기술한 테이블에 존재하는 컬럼이어야 한다.
      - 모든 컬럼을 조회할 경우 컬럼명 대신 * 기호 사용할 수 있다.
*/
-- 현재 계정이 소유한 테이블 목록 조회
SELECT TABLE_NAME 
  FROM TABS;
  
-- 테이블의 컬럼 정보 확인
DESC EMPLOYEE;
  
-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼의 정보를 조회
SELECT *
  FROM EMPLOYEE;
  
-- EMPLOYEE 테이블에서 전체 사원들의 사번, 이름, 급여만 조회
SELECT EMP_ID, EMP_NAME, SALARY
  FROM EMPLOYEE;

-- 아래와 같이 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.  
select emp_id, emp_name, salary
  from employee;
  
----------------- 실습 문제 -----------------
-- 1. JOB 테이블의 모든 컬럼 정보 조회
SELECT * FROM JOB; 

-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일(HIRE_DATE) 정보 조회
SELECT EMP_NAME, 
       EMAIL, 
       PHONE, 
       HIRE_DATE 
FROM EMPLOYEE;
--------------------------------------------
/*
    <컬럼의 산술 연산>
      SELECT 절에 컬럼명 입력 부분에서 산술 연산자를 사용하여 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블에서 직원명, 직원의 연봉 (연봉 = 급여 * 12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉, 보너스가 포함된 연봉((급여 + (보너스 * 급여)) * 12) 조회
-- 산술 연산 중 NULL 값이 존재할 경우 산술 연산한 결과값은 무조건 NULL이다.
SELECT EMP_NAME, 
       SALARY * 12, 
       BONUS,
       (SALARY + (BONUS * SALARY)) * 12
--       (SALARY + (NVL(BONUS, 0) * SALARY)) * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수

-- SYSDATE는 현재 날짜를 출력한다.
SELECT SYSDATE 
FROM DUAL;

-- DATE 타입도 연산이 가능하다.
SELECT EMP_NAME,
       HIRE_DATE,
       SYSDATE - HIRE_DATE
FROM EMPLOYEE;

SELECT EMP_NAME,
       HIRE_DATE,
       CEIL(SYSDATE - HIRE_DATE) -- 매개값으로 전달되는 수를 올림하는 함수
FROM EMPLOYEE;

/*
    <컬럼 별칭>
      [표현법]
        컬럼 AS 별칭 / 컬럼 AS "별칭" / 컬럼 별칭 / 컬럼 "별칭"
        
        - 산술연산을 하게 되면 컬럼명이 지저분해진다. 이때 컬럼명에 별칭을 부여해서 깔끔하게 보여줄 수 있다.
        - 별칭을 지정할 때 띄어쓰기 혹은 특수문자가 별칭에 포함될 경우에는 반드시 큰따옴표("")로 감싸준다.
*/
-- EMPLOYEE 테이블에서 직원명, 급여, 연봉, 보너스가 포함된 연봉((급여 + (보너스 * 급여)) * 12) 조회
SELECT EMP_NAME AS 직원명, 
       SALARY * 12 AS "연봉",
       (SALARY + (BONUS * SALARY)) * 12 "총 소득(원)"
FROM EMPLOYEE;

/*
    <리터럴>
      SELECT 절에 리터럴을 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
      즉, 리터럴은 RESULT SET의 모든 행에 반복적으로 출력된다.
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 단위(원) 조회
SELECT EMP_ID, 
       EMP_NAME, 
       SALARY, 
       '원' AS "단위(원)"
FROM EMPLOYEE;

/*
    <DISTINCT>
        컬럼에 포함된 중복 값을 한 번씩만 표시하고자 할 때 사용한다.
        SELECT 절에 한 번만 기술할 수 있다.
        컬럼이 여러 개이면 컬럼 값들이 모두 동일해야 중복 값으로 판단되어 중복이 제거된다.
*/
-- EMPLOYEE 테이블에서 직급 코드(중복제거) 조회
SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE
ORDER BY JOB_CODE; -- 오름차순

-- EMPLOYEE 테이블에서 부서 코드(중복제거) 조회
SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC; -- 내림차순

-- DISTINCT는 SELECT 절에 한 번만 기술할 수 있다.
SELECT DISTINCT JOB_CODE, DEPT_CODE
--SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE
ORDER BY JOB_CODE;

/*
    <WHERE>
        SELECT 컬럼 [, 컬럼, ...]
        FROM 테이블명
        WHERE 조건식;
        
    <비교 연산자>
        >, <, >=, <= : 대소 비교
        =            : 같다
        !=, ^=, <>   : 같지 않다
*/

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하는 사원들의 모든 컬럼 조회
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하는 사원들의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME,
       DEPT_CODE,
       SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하지 않는 사원들의 사번, 직원명, 부서 코드 조회
SELECT EMP_ID, 
       EMP_NAME, 
       DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

----------------- 실습 문제 -----------------

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원들의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME AS "직원명", 
       DEPT_CODE AS "부서 코드", 
       SALARY AS "급여"
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 재직 중인 직원들의 사번, 직원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';
--WHERE ENT_DATE IS NULL;

-- EMPLOYEE 테이블에서 연봉이 5000만원 이상인 직원들의 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME AS "직원명", 
       SALARY AS "급여", 
       SALARY * 12 AS "연봉" , 
       HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;
---------------------------------------------------------------

/*
    <ORDER BY>
        SELECT 컬럼 [, 컬럼, ...]
        FROM 테이블명
        WHERE 조건식
        ORDER BY 컬럼|별칭|컬럼 순번 [ASC|DESC] [NULLS FIRST|NULLS LAST];
        
        - ASC : 오름차순 정렬 (ASC, DESC 생략 시 기본값)
        - DESC : 내림차순 정렬
        - NULLS FIRST : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 앞으로 정렬한다. 
        - NULLS LAST : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 뒤로 정렬한다.
        
    <SELECT 문이 실행(해석) 되는 순서>
        1. FROM 절
        2. WHERE 절
        3. SELECT 절
        4. ORDER BY 절
*/

-- EMPLOYEE 테이블에서 BONUS로 오름차순 정렬
SELECT * 
FROM EMPLOYEE
--ORDER BY BONUS;
--ORDER BY BONUS ASC;  -- 오름차순 정렬은 기본적으로 NULLS LAST
--ORDER BY BONUS NULLS FIRST;
ORDER BY BONUS ASC NULLS FIRST;

-- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬 (단, BONUS 값이 일치할 경우에는 SALARY 가지고 오름차순 정렬)
SELECT * 
FROM EMPLOYEE
--ORDER BY BONUS DESC; -- 내림차순의 정렬은 기본적으로 NULLS FIRST
--ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC NULLS LAST, SALARY; -- 정렬 기준 여러 개를 제시할 수 있다.

-- EMPLOYEE 테이블에서 연봉별 내림차순으로 정렬된 직원들의 직원명, 연봉 조회
SELECT EMP_NAME AS "직원명", 
       SALARY * 12 AS "연봉"
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY "연봉" DESC;
ORDER BY 2 DESC;

/*
    <연결 연산자>
        여러 컬럼 값들을 하나의 컬럼인 것처럼 연결하거나, 컬럼과 리터럴을 연결할 수 있는 연산자이다.
*/

-- EMPLOYEE 테이블에서 사번, 직원명, 급여를 연결해서 조회
SELECT EMP_ID || EMP_NAME || SALARY AS "사번 직원명 급여"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여를 리터럴과 연결해서 조회
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여 정보"
FROM EMPLOYEE;

/*
    <논리 연산자>
        AND (~이면서, 그리고)
        OR  (~이거나, 또는)
*/

-- EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

-- EMPLOYEE 테이블에서 부서 코드가 D5이거나 급여가 500만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 50000020;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000
ORDER BY SALARY;

/*
    <BETWEEN AND>
        WHERE 컬럼 BETWEEN 하한값 AND 상한값
        
        WHERE 절에서 사용되는 연산자로 범위에 대한 조건을 제시할 때 사용한다.
        컬럼의 값이 하한값 이상이고, 상한값 이하인 경우 검색 대상이 된다.
*/

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하가 아닌 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000
WHERE SALARY NOT BETWEEN 3500000 AND 6000000 -- NOT 연산자는 컬럼명 앞 또는 BETWEEN 앞에 사용 가능
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'인 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE DESC;

-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'이 아닌 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE DESC;
  
/*
    <IN>
        WHERE 컬럼 IN (값, 값, ..., 값)
        
        컬럼의 값이 값 목록 중에 일치하는 값이 있을 때 검색 대상이 된다.
*/
-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D8'인 부서원들의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D8'
WHERE DEPT_CODE IN ('D5', 'D6', 'D8')
ORDER BY DEPT_CODE;
  
  
  
  
  
  
  