REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION�� ����� ���ϸ�
���� ���� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����

==> �� �� ���ϰ� �ϴ°� REPORT GROUP FUNCTION

ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY jop, deptno
2. GROUP BY jop
3. GROUP BY ==> ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷� �� + 1;

GROUP_AD2]
CASE���
SELECT CASE
        WHEN GROUPING(job) = 1 THEN '�Ѱ�'
        ELSE job
       END job,
       deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

DECODE���
SELECT DECODE(GROUPING(job), 1, '�Ѱ�', job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


GROUP_AD2-1]
CASE ���
SELECT CASE
        WHEN GROUPING(job) = 1 THEN '��'
        ELSE job
       END job,
       CASE
        WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
        WHEN GROUPING(deptno) = 1 AND GROUPING(job) = 1 THEN '��'
        ELSE TO_CHAR(deptno)
       END deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

DECODE ���
SELECT DECODE(GROUPING(job), 1, '��', job) job,
       DECODE(GROUPING(job) + GROUPING(deptno), 2, '��', 1, '�Ұ�', TO_CHAR(deptno)) deptno,
       DECODE(GROUPING(job) || GROUPING(deptno), 11, '��', 01, '�Ұ�', TO_CHAR(deptno)) deptno,    ---���� �� ����
       SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);


GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

ROLLUP ���� ����Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��.
(***** ���� �׷��� ����� �÷��� �����ʺ��� ������ �����鼭 ����)

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
SELECT NVL(dname, '����') dname, job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);


2. GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�.
               ROLLUP���� ����� �÷��� �����ʿ������� ���������� ������
               ���� �߰������� �ִ� ����׷��� ���ʿ��� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ����.

���� : GROUP BY GROUPING SETS (col1, col2)
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


�׷������
1. job, deptno
2. mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr )

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr );


3. CUBE
���� : GROUP BY CUBE (col1, col2...)
����� �÷��� ������ ��� ���� (������ ��Ų��)

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
GROUP BY CUBE (job, deptno);    ---��ü ���� group by ���� �� ������ ��


���� ���� REPORT GROUP ����ϱ�

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
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


��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ�emp_test ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;


2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;


3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test���̺��� deptno ���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷� ���� ������ update

emp_test���̺��� dname �÷��� deptn ���̺��� �̿��ؼ� dname �� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��� ������ ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
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

UPDATE dept_test SET empcnt = (SELECT COUNT(*)                       ---��ȣ��������
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno);   --- null�� �ƴ϶� 0

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE dept_test.deptno = emp.deptno
                               GROUP BY deptno);    --- 0�� �ƴ϶� null �� / ���� �� �ʿ�� ������ Ʋ�� ���� �ƴϴ�.

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;