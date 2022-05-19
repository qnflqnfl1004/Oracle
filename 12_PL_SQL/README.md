## PL/SQL(Procedural Language extension to SQL)
### 1. PL/SQL
* PL/SQL은 오라클에서 제공하는 절차적인 프로그래밍 언어이다.
* SQL 문의 반복적인 실행이나 조건에 따른 분기 등 다양한 기능을 제공한다.
* PL/SQL은 선언부(DECLARE SECTION), 실행부(EXECUTABLE SECTION), 예외 처리부(EXCEPTION SECTION)로 구성된다.
  ```SQL
  DECLARE
    -- 선언부
    ...
  BEGIN
    -- 실행부
    ...
  EXCEPTION
    -- 예외 처리부
    ...
  END;
  /
  ```
* 선언부(DECLARE SECTION)는 DECLARE로 시작, 변수나 상수를 선언하는 영역이다.
* 실행부(EXECUTABLE SECTION)는 BEGIN으로 시작, 제어문, 반복문, 함수 정의 등 로직을 기술하는 영역이다.
* 예외 처리부(EXCEPTION SECTION)는 EXCEPTION으로 시작, 예외사항 발생 시 해결하기 위한 문장을 기술하는 영역이다.
### 2. PL/SQL 선언부
#### 2.1. 변수 선언 및 초기화
* 변수 및 상수는 일반 타입 변수, 레퍼런스 타입 변수, ROW 타입 변수로 선언해서 사용할 수 있다.
  ```SQL
    DECLARE
      -- 선언부
      변수명 [CONSTANT] 자료형(크기) [:= 값];
    BEGIN
      -- 실행부
      ...
    END;
    /
  ```
* 레퍼런스 타입 변수는 테이블의 컬럼에 데이터 타입을 참조한다.
  ```SQL
    DECLARE
      -- 선언부
      변수명 테이블명.컬럼명%TYPE [:= 값];
    BEGIN
      -- 실행부
      ...
    END;
    /
  ```
* 하나의 테이블의 여러 컴럼의 값을 한꺼번에 저장할 수 있는 변수를 선언할 수 있다.
  ```SQL
    DECLARE
      -- 선언부
      변수명 변수명 테이블명%ROWTYPE;
    BEGIN
      -- 실행부
      ...
    END;
    /
  ```
### 3. PL/SQL 실행부
#### 3.1. 선택문
* 단일 IF
  ```SQL
  IF 조건식 THEN
    실행 문장
  END IF;
  ```
* IF ~ ELSE
  ```SQL
  IF 조건식 THEN
    실행 문장
  ELSE 
    실행 문장
  END IF;
  ```
* IF ~ ELSIF ~ ELSE
  ```SQL
  IF 조건식 THEN
    실행 문장
  ELSIF 조건식 THEN
    실행 문장
    ...
  ELSE
    실행 문장
  END IF;
  ```
* CASE
  ```SQL
  CASE 비교 대상
    WHEN 비교값 1 THEN 결과값 1
    WHEN 비교값 2 THEN 결과값 2
    ...
    [ELSE 결과값]
  END;
  ```
#### 3.2. 반복문
* BASIC LOOP
  ```SQL
  LOOP
    반복적으로 실행시킬 구문

    [반복문을 빠져나갈 조건문 작성]
    1) IF 조건식 THEN EXIT; END IF; 
    2) EIXT WHEN 조건식;
  END LOOP;
  ```
* WHILE LOOP 
  ```SQL
  WHILE 조건식
  LOOP
    반복적으로 실행할 구문;
  END LOOP;  
  ```
* FOR LOOP
  ```SQL
  FOR 변수 IN [REVERSE] 초기값..최종값
  LOOP
    반복적으로 실행할 구문;
  END LOOP;
  ```
### 4. PL/SQL 예외 처리부
* PL/SQL 문에서 발생한 예외를 예외 처리부에서 처리가 가능하다.
  ```SQL
  DECLARE
      ...
  BEGIN
      ...
  EXCEPTION
    WHEN 예외명 1 THEN 예외 처리 구문 1;
    WHEN 예외명 2 THEN 예외 처리 구문 2;
    ...
    WHEN OTHERS THEN 예외 처리 구문;
  END
  ```