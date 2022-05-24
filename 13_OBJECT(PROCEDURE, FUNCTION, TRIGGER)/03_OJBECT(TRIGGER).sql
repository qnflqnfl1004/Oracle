/*
    <TRIGGER>
        테이블이 DML(INSERT, UPDATE, DELETE) 구문에 의해 변경될 경우(테이블에 이벤트 발생 시)
        자동으로 실행될 내용을 정의해놓는 객체이다.
*/
-- STATEMENT TRIGGER
-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때 '신입사원이 입사했습니다.' 메시지를 자동으로 출력하는 트리거를 생성
CREATE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

-- EMPLOYEE 테이블에 새로운 사원을 INSERT 하기
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO) VALUES(SEQ_EMPID.NEXTVAL, '문인수', '030524-1122335');

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO) VALUES(SEQ_EMPID.NEXTVAL, '박노경', '050524-1234567');

/*
    ROW TRIGGER
        트리거 생성 구문에 FOR EACH ROW 옵션을 기술해야 한다.
        > :OLD  : 수정, 삭제 전 데이터에 접근 가능
        > :NEW  : 입력, 수정 후 데이터에 접근 가능
*/
-- EMPLOYEE 테이블에 UPDATE 수행 후 '업데이트 실행' 메시지를 자동으로 출력
CREATE OR REPLACE TRIGGER TRG_02
AFTER UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('업데이트 실행');
    DBMS_OUTPUT.PUT_LINE('변경 전 : ' || :OLD.DEPT_CODE || ' 변경 후 : ' || :NEW.DEPT_CODE);
END;
/

-- EMPLOYEE 테이블에 부서 코드가 D9인 직원들의 부서 코드를 D3로 변경
UPDATE EMPLOYEE
SET DEPT_CODE = 'D3'
WHERE DEPT_CODE = 'D9';

ROLLBACK;









