REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION을 사용을 안하면
여러 개의 SQL작성, UNION ALL을 통해서 하나의 결과로 합치는 과정

==> 좀 더 편하게 하는게 REPORT GROUP FUNCTION

ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY를 실행

아래 쿼리의 서브그룹
1. GROUP BY jop, deptno
2. GROUP BY jop
3. GROUP BY ==> 전체

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP에 기술한 컬럼 수 + 1;

GROUP_AD2]
CASE사용
SELECT CASE
        WHEN GROUPING(job) = 1 THEN '총계'
        ELSE job
       END job,
       deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

DECODE사용
SELECT DECODE(GROUPING(job), 1, '총계', job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


GROUP_AD2-1]
CASE 사용
SELECT CASE
        WHEN GROUPING(job) = 1 THEN '총'
        ELSE job
       END job,
       CASE
        WHEN GROUPING(deptno) = 1 THEN '소계'
        WHEN GROUPING(deptno) = 1 AND GROUPING(job) = 1 THEN '계'
        ELSE TO_CHAR(deptno)
       END deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

DECODE 사용
SELECT DECODE(GROUPING(job), 1, '총', job) job,
       DECODE(GROUPING(job) + GROUPING(deptno), 2, '계', 1, '소계', TO_CHAR(deptno)) deptno,
       DECODE(GROUPING(job) || GROUPING(deptno), 11, '계', 01, '소계', TO_CHAR(deptno)) deptno,    ---같은 값 도출
       SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);


GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

ROLLUP 절에 기술되는 컬럼의 순서는 조회 결과에 영향을 미친다.
(***** 서브 그룹을 기술된 컬럼의 오른쪽부터 제거해 나가면서 생성)

GROUP_AD4]
SELECT dname, job, SUM(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);

OUTER JOIN
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job))a, dept
WHERE a.deptno = dept.deptno(+);

GROUP_AD5]
SELECT NVL(dname, '총합') dname, job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);


2. GROUPING SETS
ROLLUP의 단점 : 관심없는 서브그룹도 생성 해야한다.
               ROLLUP절에 기술한 컬럼을 오른쪽에서부터 지워나가기 때문에
               만약 중간과정에 있는 서브그룹이 불필요할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과는 다르게 방향성이 없다.

사용법 : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col2, col1)
GROUP BY col2
UNION ALL
GROUP BY col1


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY job
UNION ALL
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY deptno;


그룹기준을
1. job, deptno
2. mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr )

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr );


3. CUBE
사용법 : GROUP BY CUBE (col1, col2...)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다)

GROUP BY CUBE (job, deptno);
 1        2
job,    deptno
job,      X
 X,     deptno
 X,       X

GROUP BY CUBE (job, deptno, mgr);
 1        2         3
job     deptno     mgr
job     deptno      X
job       X        mgr
job       X         X
 X      deptno     mgr
 X      deptno      X
 X        X        mgr
 X        X         X
 
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);    ---전체 행을 group by 했을 때 나오는 값


여러 개의 REPORT GROUP 사용하기

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1       2       3
job   deptno   mgr  ==> GROUP BY job, deptno, mgr
job     X      mgr  ==> GROUP BY job, mgr
job   deptno    X   ==> GROUP BY job, deptno
job     X       X   ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);
1           2           3
job    job, deptno      mgr     ==> GROUP BY job, job, deptno, mgr ==> GROUP BY job, deptno, mgr
job    job              mgr     ==> GROUP BY job, job, mgr ==> GROUP BY job, mgr
job    X                mgr     ==> GROUP BY job, X,mgr ==> GROUP BY job, mgr
job    job, deptno      X       ==> GROUP BY job, deptno, X ==> GROUP BY job, deptno
job    job              X       ==> GROUP BY job, job, X ==> GROUP BY job
job    X                X       ==> GROUP BY job, X, X ==> GROUP BY job


상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여emp_test 테이블 생성
    ==> 기존에 생성된 emp_test 테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;


2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;


3. subquery를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
emp_test의 dname 컬럼의 값을 dept 테이블의 dname 컬럼으로 update
emp_test테이블의 deptno 값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname 컬럼 값을 가져와 update

emp_test테이블의 dname 컬럼을 deptn 테이블을 이용해서 dname 값 조회하여 업데이트
update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든 직원을 대상으로 dname 컬럼을 dept 테이블에서 조회하여 업데이트
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

sub_a1]
DROP TABLE dept_test;

CREATE Table dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);
DESC dept_test;

UPDATE dept_test SET empcnt = (SELECT COUNT(*)                       ---상호연관쿼리
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno);   --- null이 아니라 0

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno
                               GROUP BY deptno);    --- 0이 아니라 null 값 / 굳이 할 필요는 없지만 틀린 것은 아니다.

SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다

SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;