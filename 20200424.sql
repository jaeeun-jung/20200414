SELECT empno, ename, hiredate,
       DECODE(MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'yyyy'), 2), '건강검진 대상자', '건강검진 비대상자') CONTACT_TO_DOCTOR
FROM emp;

SELECT empno, ename, hiredate,
       DECODE(MOD(TO_CHAR(SYSDATE+365, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'yyyy'), 2), '건강검진 대상자', '건강검진 비대상자') CONTACT_TO_DOCTOR
FROM emp;

----------

NULL처리하는 방법(4가지 중에 본인 편한 걸로 하나 이상은 기억)
NVL, NVL2...

DESC emp; --스크립트 출력하면 이름, 널, 유형이 나오는데 널 값을 허용하는지 비허용하는지 볼 수 있다. empno는 NULL 값을 허용하지 않는다.(NOT NULL)

SELECT empno, ename, sal, NVL(comm,0)
FROM emp;

condition : CASE, DECODE -- 많이 사용하기 때문에 잘 알아두기
 
실행계획 : 실행계획이 뭔지 / 보는 순서
 
----------
 
 emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL에서 5% 인상된 금액을 보너스로 지급 (ex: sal 100 -> 105)

해당 직원의 job이 MANAGER이면서 deptno가 10이면 SAL에서 30% 인상된 금액을 보너스로 지급
                           그 외의 부서에 속하는 사람은 10% 인상된 금액을 보너스로 지급
                           
해당 직원의 job이 PRESIDENT일 경우 SAL에서 20% 인상된 금액을 보너스로 지급

그 외 직원들은 sal만큼만 지급

DECODE만 사용 (case 절 사용 금지)

SELECT DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANAGER', sal * 1.30,
                   DECODE(deptno, 10, sal * 1.30, sal * 1.10), 1.30,
                   'PRESIDENT', sal * 1.20,
                   sal) bonus
FROM emp;

----------

집합 A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
소수 : 자신과 1을 약수로 하는 수
*Prime number* 소수 : {23, 29, 37} : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
비소수 : {10, 15, 18, 24, 25, 30, 35};

--그룹함수(MULTI LOW FUNCTION) : 여러가지 수에서 결과 값이 하나만 나옴

SELECT *
FROM emp
ORDER BY deptno;

GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다.
EX : 부서별 급여 평균
     emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30)에 속해 있다.
     부서별 급여 평균은 3개의 행으로 결과가 반환된다.
     
GROUP BY 적용시 주의사항 : SELECT 기술할 수 있는 컬럼이 제한된다. *****

SELECT 그룹핑 기준 컬럼, 그룹함수
FROM 테이블
GROUP BY 그룹핑 기준 컬럼
[ORDER BY];


부서별로 가장 높은 급여 값
SELECT deptno,   ---deptno 값과 sal의 가장 높은 값을 가져온다. 그룹으로 지정하지 않은 컬럼이 오면 실행X(단, 그룹 함수를 사용하면 가능)(3)
       MAX(sal), --부서별로 가장 높은 급여 값
       MIN(sal), --부서별로 가장 낮은 급여 값
       ROUND(AVG(sal),2), --부서별 급여 평균
       SUM(sal), --부서별 급여 합
       COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
       COUNT(*),   --부서별 행의 수
       COUNT(mgr)
FROM emp ---emp 테이블에서(1)
GROUP BY deptno; ---( )를 그룹으로 삼고(2)

* 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
  가장 높은 급여를 받는 사람의 이름을 알 수는 없다.
   ==> 추후 WINDOW/분석 FUNCTION을 통해 해결 가능

emp 테이블의 그룹기준을 부서번호가 아닌 전체 직원으로 설정하는 방법
SELECT MAX(sal), --전체 직원 중 가장 높은 급여 값
       MIN(sal), --전체 직원 중 가장 낮은 급여 값
       ROUND(AVG(sal),2), --전체 직원의 급여 평균
       SUM(sal), --전체 직원의 급여 합
       COUNT(sal), --전체 직원의 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
       COUNT(*),   --전체 행의 수
       COUNT(mgr)  --mgr 컬럼이 null이 아닌 건수
FROM emp;

2020.04.27 발표 때 정답 확인
GROUP BY 절에 기술된 컬럼이
    SELECT 절에 나오지 않으면 ???? 상관없다.

GROUP BY  절에 기술되지 않은 컬럼이
    SELECT 절에 나오면 ???? 에러난다.

그룹화와 관련 없는 문자열, 상수 등은 SELECT 절에 표현 될 수 있다. (에러 아님);
SELECT deptno,
       MAX(sal), --부서별로 가장 높은 급여 값
       MIN(sal), --부서별로 가장 낮은 급여 값
       ROUND(AVG(sal),2), --부서별 급여 평균
       SUM(sal), --부서별 급여 합
       COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
       COUNT(*),   --부서별 행의 수
       COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP 함수 연산 시 NULL 값은 제외가 된다.
30번 부서에는  NULL 값을 갖는 행이 있지만 SUM(COMM)의 값이 정상적으로 계산된 것을 확인할 수 있다.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20번 부서의 SUM(COMM) 컬럼이 NULL이 아니라 0이 나오도록 NULL처리
* 특별한 사유가 아니면 그룹함수 계산결과에 NULL 처리를 하는 것이 성능상 유리

NVL(SUM(comm), 0) : COMM 컬럼에 SUM 그룹함수를 적용하고 최종 결과에 NVL을 적용(1회 호출)
SUM(NVL(comm, 0)) : 모든 COMM 컬럼에 NVL 함수를 적용 후(해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용
SELECT deptno, NVL(SUM(comm), 0) -- SUM(NVL(comm, 0)) 결과는 같지만 효율적이지 않다.
FROM emp
GROUP BY deptno;

single row 함수는 where절에 기술할 수 있지만
multi row 함수(group 함수)는 where절에 기술할 수 없고
GROUP BY 절 이후 HAVING 절에 별도로 기술

single row 함수는 WHERE 절에서 사용 가능
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';


부서별 급여 합이 5000이 넘는 부서만 조회
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

grp1]
SELECT deptno, 
       MAX(sal) MAX_SAL,
       MIN(sal) MIN_SAL,
       ROUND(AVG(sal),2) AVG_SAL,
       SUM(sal)SUM_SAL,
       COUNT(sal) COUNT_SAL,
       COUNT(mgr) COUNT_MGR,
       COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

grp2]
SELECT deptno,
       Max(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       NVL(COUNT(sal), 0) count_sal,
       NVL(COUNT(mgr), 0) count_mgr,
       COUNT(*) count_all
FROM emp
GROUP BY deptno;

grp3] * 참고만
SELECT DECODE(deptno, '10', 'ACCOUNTING',
                      '20', 'RESEARCH',
                      '30', 'SALES',
                      '40', 'DDIT') DNAME,
       Max(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       NVL(COUNT(sal), 0) count_sal,
       NVL(COUNT(mgr), 0) count_mgr,
       COUNT(*) count_all
FROM emp
GROUP BY deptno --DECODE 값이 들어올 수 있음
ORDER BY deptno asc;

grp4]
SELECT  TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

grp5]
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

grp6]
SELECT count(deptno) cnt
FROM dept;


grp7]
SELECT count(count(deptno)) cnt
FROM emp
group by deptno;

SELECT *
FROM emp;