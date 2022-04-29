/*
    <문자 관련 함수>
    
    1) LENGTH / LENGTHB
        LENGTH('문자값') : 글자 수 반환
        LENGTHB('문자값') : 글자의 바이트 수 반환
        
        한글 한 글자 -> 3BYTE
        영문자, 숫자, 특수문자 한 글자 -> 1BYTE
*/

SELECT LENGTH('오라클'), 
       LENGTHB('오라클')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), 
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

/*
    2) INSTR
        INSTR('문자값', '문자값' [, POSITION, OCCURRENCE])
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;  -- 3
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 10
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 9
SELECT INSTR('AABAACAABBAA', 'B', 1, -1) FROM DUAL; -- 음수 사용 불가
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; -- 3

SELECT EMAIL AS "이메일", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

/*
    3) LPAD / RPAD
        LPAD/RPAD('문자값', 최종적으로 반환할 문자의 길이(바이트)[, 덧붙이고자 하는 문자])
*/
SELECT LPAD('Hello', 10, 'A')
FROM DUAL;

SELECT RPAD('Hello', 10, 'AB')
FROM DUAL;

-- 20만큼의 길이 중 EMAIL 값은 오른쪽으로 정렬하고 공백을 왼쪽으로 채운다.
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 10)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 3)
FROM EMPLOYEE;

-- 20만큼의 길이 중 EMAIL 값은 왼쪽으로 정렬하고 #을 오른쪽으로 채운다.
SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 220429-3******를 출력
SELECT RPAD('220429-3', 14, '*')
FROM DUAL;

/*
    4) LTRIM / RTRIM
        LTRIM/RTRIM('문자값'[, 제거하고자 하는 문자값])
*/
SELECT LTRIM('   KH') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('KH   ', ' ') FROM DUAL;
SELECT RTRIM('000123000456000', '0') FROM DUAL;

SELECT LTRIM(RTRIM('000123000456000', '0'), '0') FROM DUAL;

/*
    5) TRIM
        TRIM([[LEADING | TRAILING | BOTH] '제거하고자 하는 문자값' FROM] '문자값')
    
        문자값 앞/뒤/양쪽에 있는 지정한 문자를 제거한 나머지를 반환한다.
*/

-- 기본적으로 양쪽에 있는 공백 문자를 제거한다.
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM(' ' FROM '   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

/*
    6) SUBSTR
        SUBSTR('문자값', POSITION[, LENGTH])
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7, 3) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- EMPLOYEE 테이블에서 주민등록번호에 성별을 나타내는 부분만 잘라서 조회하기 (직원명, 성별 코드)
SELECT EMP_NAME AS "직원명", 
       SUBSTR(EMP_NO, 8, 1) AS "성별 코드"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 여자 사원의 직원명, 성별 코드 조회
SELECT EMP_NAME AS "직원명", 
       SUBSTR(EMP_NO, 8, 1) AS "성별 코드"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- EMPLOYEE 테이블에서 남자 사원의 직원명, 성별 조회
SELECT EMP_NAME AS "직원명", 
       '남자' AS "성별"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- EMPLOYEE 테이블에서 주민등록번호 첫 번째 자리부터 성별까지 추출한 결과값에 오른쪽에 * 문자를 채워서 14 글자 출력
-- ex) 991212-1******
SELECT SUBSTR('991212-1222222', 1, 8)
FROM DUAL;

SELECT RPAD(SUBSTR('991212-1222222', 1, 8), 14, '*')
FROM DUAL;

SELECT EMP_NAME AS "직원명", 
       RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS "주민등록번호"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 이메일, 아이디(이메일에서 '@' 앞의 문자 값만 출력)를 조회
SELECT INSTR('sun_di@kh.or.kr', '@')
FROM DUAL;

SELECT SUBSTR('sun_di@kh.or.kr', 1, INSTR('sun_di@kh.or.kr', '@') - 1)
FROM DUAL;

SELECT EMP_NAME AS "이름", 
       EMAIL AS "이메일",
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "아이디"
--       SUBSTR(EMAIL, 1, LENGTH(EMAIL) - 9) AS "아이디" -- 지선님 아이디어
--       LPAD(EMAIL, INSTR(EMAIL, '@') - 1) AS "아이디"  -- 정아님 아이디어
FROM EMPLOYEE;

/*
    7) LOWER / UPPER / INITCAP
        LOWER/UPPER/INITCAP('문자값')
*/

SELECT 'welcome to my world' FROM DUAL;
SELECT LOWER('WELCOME TO MY WORLD') FROM DUAL; -- 소문자로 변경
SELECT UPPER('welcome to my world') FROM DUAL; -- 대문자로 변경
SELECT INITCAP('welcome to my world') FROM DUAL; -- 단어 앞 글자마다 대문자로 변경

/*
    8) CONCAT
        CONCAT('문자값', '문자값')
*/

SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라'||'ABCD' FROM DUAL; -- 연결 연산자와 동일한 결과를 출력한다.

SELECT CONCAT('가나다라', 'ABCD', 'EFG') FROM DUAL; -- 에러 발생 (CONCAT은 두 개의 문자값만 전달받을 수 있다.)
SELECT '가나다라' || 'ABCD' || 'EFG' FROM DUAL;

SELECT CONCAT(EMP_ID, EMP_NAME)
FROM EMPLOYEE;

SELECT EMP_ID || EMP_NAME || EMP_NO
FROM EMPLOYEE;

/*
    9) REPLACE
        REPLACE('문자값', '변경하려고 하는 문자값', '변경할 문자값')
*/
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- EMPLOYEE 테이블에서 이메일의 kh.or.kr을 gmail.com 변경해서 조회
SELECT REPLACE('sun_di@kh.or.kr', 'kh.or.kr', 'gmail.com') FROM DUAL;

SELECT EMP_NAME, 
       EMAIL,
       REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;















