SELECT e.manager_id mgr_id, m.first_name || m.last_name name, e.employee_id, e.job_id, jobs.job_title
FROM employees e, jobs, employees m
WHERE e.job_id = jobs.job_id
  AND e.manager_id = m.employee_id;
  
OUTER JOIN
테이블 연결 조건이 실패해도, 기준으로 삼은 테이블의 컬럼은 조회가 되도록 하는 조인 방식
<==>
INNER JOIN(우리가 지금까지 배운 방식)

LEFT OUTER JOIN     : 기준이 되는 테이블이 JOIN 키워드 왼쪽에 위치
RIGHT OUTER JOIN     : 기준이 되는 테이블이 JOIN 키워드 오른쪽에 위치
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (중복되는 데이터가 한 건만 남도록 처리)

emp테이블의 컬럼 중 mgr컬럼을 통해 해당 직원의 관리자 정보를 찾아갈 수 있다.
하지만 KING 직원의 경우 상급자가 없기 때문에 일반적인 inner 조인 처리시
조인에 실패하기 때문에 KING을 제외한 13건의 데이터만 조회가 됨.

INNER 조인 복습
상급자 사번, 상급자 이름, 직원 사번, 직원 이름

조인이 성공해야지만 데이터가 조회된다.
==> KING의 상급자 정보(mgr)는 NULL이기 때문에 조인에 실패하고 
    KING의 정보는 나오지 않는다 (emp 테이블 건수 14건 ==> 조인 결과 13건)
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

위의 쿼리를 OUTER 조인으로 변경
 (KING 직원이 조인에 실패해도 본인 정보에 대해서는 나오도록, 
  하지만 상급자 정보는 없기 때문에 나오지 않는다);

ANSI-SQL : OUTER
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1. FROM절에 조인할 테이블 기술(콤마로 구분)
2. WHERE절에 조인 조건을 기술
3. 조인 컬럼(연결고리)중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여 준다.
   ==> 마스터 테이블 반대편쪽 테이블의 컬럼 ---전부 다 붙여주기

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


OUTER 조인의 조건 기술 위치에 따른 결과 변화

직원의 상급자 이름, 아이디를 포함해서 조회
단, 직원의 소속부서가 10번에 속하는 직원들만 한정해서;

조건을 ON절에 기술했을 때 (14건)
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);    ---조인에 대한 조건을 on 뒤에 기재

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
  AND e.deptno = 10;

조건을 WHERE절에 기술했을 때 (3건) --- OUTER JOIN의 효과가 없음
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)   ---이너절....
WHERE e.deptno = 10;


OUTER 조인을 하고 싶은 것이라면 조건을 ON절에 기술하는게 맞다

outerjoin1]
SELECT buy_date, buyprod.buy_prod, prod.prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON (prod.prod_id = buyprod.buy_prod AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

outerjoin2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buyprod.buy_prod, prod.prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON (prod.prod_id = buyprod.buy_prod AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

outerjoin3]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buyprod.buy_prod, prod.prod_id, prod_name, NVL(buy_qty, 0)
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, NVL(buy_qty, 0)
FROM prod LEFT OUTER JOIN buyprod ON (prod.prod_id = buyprod.buy_prod AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

outerjoin4]
SELECT product.pid, pnm, NVL(cid, 1) cid /*1 cid*/, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product, cycle
WHERE product.pid = cycle.pid(+)
  AND cid(+) = 1;

SELECT product.pid, pnm, NVL(cid, 1) cid /*1 cid*/, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cid(+) = 1);

outerjoin5]
SELECT product.pid, pnm, NVL(cid, 1) cid /*1 cid*/, cnm, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product JOIN cycle ON (product.pid = cycle.pid)
             JOIN customer ON (cycle.pid = customer.cnm);

15 ==> 45
3배 ==> customer 테이블의 행의 개수
SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
조인 조건을 기술하지 않은 경우
모든 가능한 행의 조합으로 결과가 조회된다.

emp 14 * dept 4 = 56
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (조인 테이블만 기술하고 WHERE 절에 조건을 기술하지 않는다.)
SELECT *
FROM emp, dept;

crossjoin1]
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;


서브쿼리
WHERE : 조건을 만족하는 행만 조회되도록 제한 *****
SELECT *
FROM emp
WHERE 1 = 1
   OR 1 != 1;

서브 <==> 메인
서브쿼리는 다른 쿼리 안에서 작성된 쿼리
서브쿼리 가능한 위치
1. SELECT
    SCALAR SUB QUERY
    * 스칼라 서브쿼리는 조회되는 행이 1행이고, 컬럼이 한 개의 컬럼이어야 한다. ***
    EX) DUAL 테이블
2. FROM
    INLINE-VIEW
    SELECT 쿼리를 괄호로 묶은 것
3. WHERE
    SUB QUERY
    WHERE  절에 사용된 쿼리
    
SMITH가 속한 부서에 속한 직원들은 누가 있을까?

1. SMITH가 속한 부서가 몇번이지??
2. 1번에서 알아낸 부서번호에 속하는 직원을 조회

==> 독립적인 2개의 쿼리를 각각 실행
    두번째 쿼리는 첫번째 쿼리의 결과에 따라 값을 다르게 가져와야 한다.
    (SMITH(20) => WARD(30) ==> 두번째 쿼리 작성 시 10번에서 30번으로 조건을 변경
    ==> 유지보수 측면에서 좋지 않음
    
첫번째 쿼리
SELECT deptno   --20
FROM emp
WHERE ename = 'SMITH';

두번째 쿼리
SELECT *
FROM emp
WHERE deptno = 20; ---20이라는 하드코딩이 존재

서브쿼리를 통한 쿼리 통합
SELECT *
FROM emp
WHERE deptno = (SELECT deptno   --20
                FROM emp
                WHERE ename = 'SMITH'); ---smith는 바뀔 수 있음

sub1]
평균 급여보다 높은 급여를 받는 직원의 정보를 조회하세요
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

select *
from emp;

sub2]
평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);