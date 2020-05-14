CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1 = 1;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

idx3]
CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE INDEX idx_emp_02 ON emp (deptno, mgr, hiredate, sal);
CREATE INDEX idx_emp_03 ON emp (ename);

idx4]과제
CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE UNIQUE INDEX idx_u_emp_02 ON emp (deptno, sal);
CREATE INDEX idx_u_dept_01 ON dept (deptno, loc);

실행계획

수업시간에 배운 조인
==> 논리적 조인 형태를 이야기함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이 되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인(카티션 프러덕트), 조인 조건을 기술하지 않아서 연결 가능한 모든 경우의 수로 조인되는 조인 기법
self join : 같은 테이블끼리 조인하는 형태

개발자가 DBMS에 SQL을 실행 요청하면 DBMS는 SQL을 분석해서 어떻게 두 테이블을 연결할 지를 결정,
3가지 방식의 조인방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop Join --- 소량의 데이터 조인
2. Sort Merge Join --- 많이 사용x, 정렬이 끝나야 연결이 가능, 응답이 느림, 드문 방법, 인덱스x
3. Hash Join --- 인덱스x, 대다수의 경우 사용 가능, 입력 값의 일부만 변경되도 결과 값이 다름, Hash 테이블을 완성하면(Hash 함수) 다른 테이블과 연결고리로 조인

--- 데이터를 조회할 때 인덱스는 소량의 데이터를 읽을 때 유리함 - sigle block(삽질)
--- 데이터를 조회할 때 테이블은 대량의 데이터를 읽을 때 유리함 - (포크레인)

OLTP (OnLine Trascation Processing) : 실시간 처리 ==> 응답이 빨라야 하는 시스템 (일반적인 웹 서비스)
OLAP (OnLine Analysis Processing) : 일괄처리 ==> 전체 처리속도가 중요한 경우(은행 이자 계산, 새벽 한번에 계산)

인덱스 사용 못하는 경우
1. 컬럼 가공(좌변 가공)
2. 부정형 연산 : !
3. NULL 비교 (NULL 값은 인덱스에 안들어감 즉 인덱스를 확인하는 것은 의미가 없음) - NOT NULL 제약 중요
4. LIKE 연산시 선행 와일드 카드 : LIKE '%T';

INDEX UNIQUE SCAN : 값을 찾으면 조회를 멈춤
INDEX RANGE SCAN[DESCENDING] : 일부 구간을 조회
INDEX FULL SCAN[DESCENDING] : 모든 값을 조회
INDEX FAST FULL SCAN : 전체 조회
INDEX SKIP SCAN : 인덱스가 복합컬럼일 때 후행 컬럼만 조건 제시 -> 선행 컬럼의 값...?????