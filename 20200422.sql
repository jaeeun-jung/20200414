date 종합 실습 fn3]

문자열         =>              날짜      ==>     마지막 날짜로 변경      ==>         일자
    TO_DATE('201912', 'YYYYMM')

SELECT TO_DATE(:YYYYMM, 'YYYYMM'),
       LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),
       TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';
      (empno = 7369)

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


Plan hash value: 3956160932
 
 실행계획을 보는 순서(id) ***sql d 시험 중에 자주 출제 --조인(?) 배울 때 자세히 배움
 * 들여쓰기 되어 있으면 자식 오퍼레이션
 1. 위에서 아래로
   *단 자식 오퍼레이션이 있으면 자식부터 읽는다.
   
   1 ==> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 | -- 컬럼 8개의 값을 그냥 가져옴
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 | --1은 0의 자식 오퍼레이션 / 먼저 읽기
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
    1 - filter("EMPNO"=7369) -- 14개 데이터 중에 필터 조건을 충족하는 데이터만 남기고 나머지는 필터링을 함
    

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - filter(TO_CHAR("EMPNO")='7369')
    
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - filter("EMPNO"=7369)
   
-- emp 테이블에는 부서명이 없다.
-- 테이블을 여러가지 열 때, 어떤 것을 먼저 여는 지는 실행계획을 확인해야 한다.

SELECT ename, sal, TO_CHAR(sal, 'L0009,999.00') fm_sal --L : 원단위
FROM emp;

NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE;

왜 null 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다.

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(exprl, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt
FROM users;

SELECT userid, usernm, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;