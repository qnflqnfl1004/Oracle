/*
    <DDL(Data Definition Language)>
        데이터 정의 언어로 오라클에서 제공하는 객체를 생성하고, 변경하고, 삭제하는 등 
        실제 데이터 값이 아닌 데이터의 구조 자체를 정의하는 언어이다. (DB 관리자, 설계자)

    <CREATE>
        데이터베이스 객체(테이블, 뷰, 사용자 등)를 생성하는 구문이다.
        
    <테이블 생성>
        CREATE TABLE 테이블명 (
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            ...
        );
*/
-- 회원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성
CREATE TABLE MEMBER (
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20),
    NAME VARCHAR2(15),
    ENROLL_DATE DATE DEFAULT SYSDATE
);

DROP TABLE MEMBER;

-- 테이블의 구조를 표시해 주는 구문이다.
DESC MEMBER;

/*
    데이터 딕셔너리
        자원을 효율적으로 관리하기 위해 다양한 객체들의 정보를 저장하는 시스템 테이블이다.
        데이터 딕셔너리는 사용자가 객체를 생성하거나 변경하는 등의 작업을 할 때 데이터베이스에 의해서 자동으로 갱신되는 테이블이다.
        데이터에 관한 데이터가 저장되어 있어서 메타 데이터라고도 한다.
        
    USER_TABLES : 사용자가 가지고 있는 테이블의 구조를 확인하는 뷰 테이블이다.
    USER_TAB_COLUMNS : 테이블, 뷰의 컬럼과 관련된 정보를 조회하는 뷰 테이블이다.
*/
SELECT *
FROM USER_TABLES;

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';

/*
    <컬럼 주석>
        테이블 컬럼에 대한 설명을 작성할 수 있는 구문이다.
        
        COMMENT ON COLUMN 테이블.컬럼명 IS '주석 내용';
*/

COMMENT ON COLUMN MEMBER.ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.PASSWORD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';

-- 테이블에 샘플 데이터 추가
-- DML(INSERT)을 사용해서 만들어진 테이블에 샘플 데이터를 추가할 수 있다.
-- INSERT INTO 테이블명[(컬럼명, ..., 컬럼명)] VALUES (값, ..., 값)
INSERT INTO MEMBER VALUES('USER1', '1234', '문인수', '2022-05-12');
INSERT INTO MEMBER VALUES('USER2', '1234', '홍길동', SYSDATE);
INSERT INTO MEMBER VALUES('USER3', '1234', '이몽룡', DEFAULT);
INSERT INTO MEMBER(ID, PASSWORD) VALUES('USER3', '1234');

SELECT * FROM MEMBER;

-- 위에서 추가한 데이터를 실제 데이터베이스에 반영한다.
-- (메모리 버퍼에 임시 저장된 데이터를 실제 테이블에 반영한다.)
COMMIT;

/*
    <제약조건>
        사용자가 원하는 조건의 데이터만 유지하기 위해서 테이블 작성 시 각 컬럼에 대해 제약조건을 설정할 수 있다.
        제약조건은 데이터 무결성 보장을 목적으로 한다. (데이터의 정확성과 일관성을 유지시키는 것)
        
    1. NOT NULL 제약조건
        해당 컬럼에 반드시 값이 있어야만 하는 경우에 사용한다.
        삽입 / 수정 시 NULL 값을 허용하지 않도록 제한한다.
*/
-- 기존 MEMBER 테이블은 값에 NULL이 있어도 행의 추가가 가능하다.
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- NOT NULL 제약조건에 위배되어 오류 발생
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건이 걸려있는 컬럼에는 반드시 값이 있어야 한다.
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', NULL);
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', SYSDATE);
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', DEFAULT);
INSERT INTO MEMBER(ID, PASSWORD, NAME) VALUES('USER1', '1234', '홍길동');

-- 테이블의 데이터를 수정하는 SQL 구문
UPDATE MEMBER
SET ID = NULL;

SELECT * FROM MEMBER;

-- 제약조건 확인
-- 사용자가 작성한 제약조건을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONSTRAINTS;

-- 사용자가 작성한 제약조건이 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONS_COLUMNS;

SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';

/*
    2. UNIQUE 제약조건
        컬럼에 입력 값이 중복 값을 가질 수 없도록 제한하는 제약조건이다.
*/

-- 아이디가 중복되어도 성공적으로 데이터가 삽입된다.
INSERT INTO MEMBER VALUES('USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES('USER1', '1234', '성춘향', DEFAULT);

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    ID VARCHAR2(20) NOT NULL UNIQUE,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES('USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES('USER1', '1234', '성춘향', DEFAULT);
-- UNIQUE 제약조건에 위배되어 INSERT 실패

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL,
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

INSERT INTO MEMBER VALUES('USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES('USER1', '1234', '성춘향', DEFAULT);
-- UNIQUE 제약조건에 위배되어 INSERT 실패

DROP TABLE MEMBER;

-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건으로 설정할 수 있다. (단, 반드시 테이블 레벨로만 설정이 가능하다.)
CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_ID_UQ UNIQUE(NO, ID)
);

-- 여러 컬럼을 묶어서 UNIQUE 제약조건이 설정되어 있으면 제약조건이 설정되어 있는 컬럼 값이 모두 중복되는 경우에만 오류가 발생한다.
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER1', '1234', '성춘향', DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '홍길동', DEFAULT);
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '이몽룡', DEFAULT);

/*
    3. CHECK 제약조건
        컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 기록할 수 있다.
        비교 값은 리터럴만 사용이 가능하다. 변하는 값이나 함수는 사용할 수 없다.
        
        CHECK (비교연산자)
            CHECK(컬럼 [NOT] IN(값, 값, ...))
            CHECK(컬럼 BETWEEN 값 AND 값)
            CHECK(컬럼 LIKE '_문자')
            ...
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

-- 성별, 나이에 유효한 값이 아닌 값들도 INSERT 된다.
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '강', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', -20, DEFAULT);

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남', '여')),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE > 0)
);

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '강', 30, DEFAULT);
-- GENDER 컬럼에 CHECK 제약조건으로 '남' 또는 '여'만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', -20, DEFAULT);
-- AGE 컬럼에 CHECK 제약조건으로 0보다 큰 값만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.

COMMIT;

UPDATE MEMBER
--SET AGE = -10
SET GENDER = '외'
WHERE ID = 'USER1';

ROLLBACK;

/*
    4. PRIMARY KEY(기본 키) 제약조건
        테이블에서 한 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건이다.
        기본 키 제약조건을 설정하게 되면 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 설정된다.
        한 테이블에 한 개만 설정할 수 있다. (단, 한 개 이상의 컬럼을 묶어서 기본 키 제약조건을 설정할 수 있다.)
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER,
--    NO NUMBER PRIMARY KEY,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남', '여')),
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE > 0)
);

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', 20, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT); -- 기본 키 중복으로 오류
INSERT INTO MEMBER VALUES(NULL, 'USER5', '1234', '심청이', '여', 16, DEFAULT); -- 기본 키가 NULL 이므로 오류

DROP TABLE MEMBER;

-- 컬럼을 묶어서 하나의 기본 키를 생성 (복합키라고 한다.)
CREATE TABLE MEMBER (
    NO NUMBER,
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_ID_PK PRIMARY KEY(NO, ID),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남', '여')),
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE > 0)
);

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', 20, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
-- 회원번호, 아이디가 세트로 동일한 값이 이미 존재하기 때문에 에러가 발생한다.
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
-- 기본 키로 설정된 컬럼에 NULL 값이 있으면 에러가 발생한다.
INSERT INTO MEMBER VALUES(NULL, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
INSERT INTO MEMBER VALUES(5, NULL, '1234', '심청이', '여', 16, DEFAULT);

SELECT * FROM MEMBER;

SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';

/*
    5. FOREIGN KEY(외래 키) 제약조건
        다른 테이블에 존재하는 값만을 가져야하는 컬럼에 부여하는 제약조건이다. (단, NULL 값도 가질 수 있다.)
        즉, 외래 키로 참조한 컬럼의 값만 기록할 수 있다.
        
        1) 컬럼 레벨
            컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(기본 키)] [삭제룰]
            
        2) 테이블 레벨
            [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(기본 키)] [삭제룰]
*/
-- 회원 등급에 대한 데이터를 보관하는 테이블 (부모 테이블)
CREATE TABLE MEMBER_GRADE (
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(20) NOT NULL,
    CONSTRAINT MEMBER_GRADE_PK PRIMARY KEY(GRADE_CODE)
);

INSERT INTO MEMBER_GRADE VALUES(10, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(20, '우수회원');
INSERT INTO MEMBER_GRADE VALUES(30, '특별회원');

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    GRADE_ID NUMBER CONSTRAINT MEMBER_GRADE_ID_FK REFERENCES MEMBER_GRADE (GRADE_CODE),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남', '여')),
--    CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY(GRADE_ID) REFERENCES MEMBER_GRADE /*(GRADE_CODE)*/, -- 생략가능
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE > 0)
);

SELECT * FROM MEMBER_GRADE;
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, 10, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, 50, DEFAULT);
-- 50이라는 값이 MEMBER_GRADE 테이블에 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 외래 키 제약조건에 위배되어 에러가 발생한다.
--   parent key not found 에러 발생
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, NULL, DEFAULT);
-- GRADE_ID 컬럼에 NULL 사용 가능

-- MEMBER 테이블과 MEMBER_GRADE 테이블을 조인하여 아이디, 이름, 회원 등급을 조회
SELECT M.ID, 
       M.NAME, 
       MG.GRADE_NAME
FROM MEMBER M
LEFT JOIN MEMBER_GRADE MG ON (M.GRADE_ID = MG.GRADE_CODE);


SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME LIKE 'MEMBER%';

DROP TABLE MEMBER;
DROP TABLE MEMBER_GRADE;





