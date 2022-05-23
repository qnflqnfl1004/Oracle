## PROCEDURE
### 1. PROCEDURE
* PROCEDURE는 오라클에서 제공하는 객체로 PL/SQL 문을 저장하여 필요할 때마다 복잡한 구문을 다시 입력할 필요 없이 간단하게 호출해서 실행 결과를 얻을 수 있다.
### 2. PROCEDURE 생성
* PROCEDURE는 CREATE 구문을 사용해서 생성한다.
  ```SQL
  CREATE [OR REPLACE] PROCEDURE 프로시저명
  (
      매개변수 1 [IN|OUT] 데이터 타입 [:= DEFAULT 값],
      매개변수 2 [IN|OUT] 데이터 타입 [:= DEFAULT 값],
      ...
  )
  IS [AS]
      선언부
  BEGIN
      실행부
  [EXCEPTION
      예외 처리부]
  END [프로시저명];
  /
  ```
* PROCEDURE는 매개변수를 받을 수 있는데 선언하는 방법에 따라 역할이 다르다.
  |구분|설명|
  |:--:|:--:|
  |IN|사용자로부터 값을 입력받아 PROCEDURE로 전달해 주는 역할을 한다. (기본값)|
  |OUT|PROCEDURE에서 호출 환경으로 값을 전달하는 역할을 한다.|
### 3. PROCEDURE 삭제
* PROCEDURE 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP PROCEDURE 프로시저명;
  ```
## FUNCTION
### 1. FUNCTION
* FUNCTION은 오라클에서 제공하는 객체로 PROCEDURE와 거의 유사한 용도로 사용하지만 실행 결과를 되돌려 받을 수 있다는 점이 다르다.
### 2. FUNCTION 생성
* FUNCTION은 CREATE 구문을 사용해서 생성한다.
* FUNCTION은 PROCEDURE와 다르게 RETURN 구문이 추가된다.
  ```SQL
  CREATE OR REPLACE FUNCTION 함수명
  ( 
      매개변수 1 타입,
      매개변수 2 타입,
      ... 
  )
  RETURN 데이터 타입
  IS [AS]
      선언부
  BEGIN
      실행부
      
      RETURN 반환값;
  [EXCEPTION
      예외 처리부]
  END [함수명];
  /
  ```
### 3. FUNCTION 삭제
* FUNCTION 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP FUNCTION 함수명;
  ```
## TRIGGER
### 1. TRIGGER
* TRIGGER는 오라클에서 제공하는 객체로 테이블이나 뷰가 DML(INSERT, UPDATE, DELETE)문에 의해 변경될 경우 자동으로 실행될 내용을 정의하여 저장한다.
### 2. TRIGGER 생성
* TRIGGER는 CREATE 구문을 사용해서 생성한다.
  ```SQL
  CREATE [OR REPLACE] TRIGGER 트리거명
  BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
  [FOR EACH ROW] --> 행 트리거
  [DECLARE
      선언부]
  BEGIN
      실행부 (해당 위에 지정된 이벤트 발생 시 자동으로 실행할 구문)
  [EXCEPTION
      예외처리부]
  END;
  /   
  ```
* 트리거 종류
  <table>
    <tr>
      <th>구분</th>
      <th>종류</th>
      <th>설명</th>
    </tr>
    <tr>
      <td rowspan='2'>SQL 문의 실행 시기에 따른 분류</td>
      <td>BEFORE TRIGGER</td>
      <td>해당 SQL 문장 실행 전 트리거를 실행한다.</td>
    </tr>
    <tr>
      <td>AFTER TRIGGER</td>
      <td>해당 SQL 문장 실행 후 트리거를 실행한다.</td>
    </tr>
    <tr>
      <td rowspan='2'>SQL 문에 의해 영향을 받는 각 행에 따른 분류</td>
      <td>STATEMENT TRIGGER</td>
      <td>해당 SQL 문에 대해 한 번만 트리거를 실행한다.</td>
    </tr>
      <td>ROW TRIGGER</td>
      <td>해당 SQL 문에 영향을 받는 행마다 트리거를 실행한다. (FOR EACH ROW 옵션을 기술)</td>
    </tr>
  </table>
### 3. TRIGGER 삭제
* TRIGGER 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP TRIGGER 트리거명;
  ```
