/*
    <SYNONYM>
        SYNONYM은 오라클에서 제공하는 객체로 데이터베이스 객체에 별칭을 생성한다.
*/
-- 관리자 계정으로 KH 계정에 SYNONYM 생성 권한을 준다.
GRANT CREATE SYNONYM TO KH;

-- 비공개 SYNONYM 생성
CREATE SYNONYM EMP FOR EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- 공개 SYNONYM 생성
CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;
GRANT SELECT ON KH.DEPARTMENT TO STUDY;

SELECT * FROM KH.DEPARTMENT;
SELECT * FROM DEPT;

-- SYNONYM 삭제
-- 비공개 SYNONYM 삭제 (사용자 계정)
DROP SYNONYM EMP;

-- 공개 SYNONYM 삭제 (관리자 계정)
DROP PUBLIC SYNONYM DEPT;






