-- 한 줄짜리 주석
/*
    여러 줄 주석
*/

-- 사용자 계정 생성하는 구문
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;

-- 생성한 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
GRANT RESOURCE, CONNECT TO KH;