--------------------------------------------------------------------------------
grp7]
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�� ���� �����ϴ� ��� �μ�����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20, 30 ==> 3��

SELECT deptno  /*deptno �÷��� 1�� ����, row�� 3���� ���̺� */
FROM emp
GROUP BY deptno;
    
SELECT COUNT(*) cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);

SELECT COUNT(*) cnt
FROM
(SELECT COUNT(*) cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno));
--------------------------------------------------------------------------------
    
DBMS (.=.) RDBMS
DBMS : DataBase Management System
==> db 
RDBMS : Relational DataBase Management System
==> ������ �����ͺ��̽� ���� �ý���
     80�� �ʹݿ� �̷��� ����

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE, /*���ݾ� �ٸ�*/)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������(���� Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ��������)


NATURAL JOIN
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸��� ���� ���
    . emp, dept ���̺��� deptno��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
      ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.

.emp ���̺� : 14��
.dept ���̺� : 4��

SELECT *
FROM dept;

���� �Ϸ��� �ϴ� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept; --�� ���̺��� �̸��� ������ �÷����� �����Ѵ�. ==> deptno


ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE ���� ����ϸ� �ȴ�.(EX : WHERE emp.deptno = dept.deptno)
 
 SELECT *
FROM emp, dept
WHERE deptno = deptno; --> �ݷ��� ������ emp�� deptno���� dept�� deptno���� �𸣱� ������ ����
 
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 ��ȸ

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = 10; --(dept.deptno = 10)
 

ANSI-SQL : JOIN with USING
 . join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
 . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���

SELECT *
FROM emp JOIN dept USING (deptno);


ANSI-SQL : JOIN with ON *****
 . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
 . ON���� ����� ������ ���

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ORACLE �������� �� SQL�� �ۼ� *****
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;


JOIN�� ������ ���� --������ �ƴ�
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� �� --�Լ�����
EMP ���̺��� �� ���� ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �˰���� ��

ANSI-SQL�� SQL ���� :
�����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
            ����� �÷�: ����.MGR = ������.EMPNO
            ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                ==> NATURAL JOIN, JOIN with USING�� ����� �Ұ����� ����
                    ==> JOIN with ON


ANSI-SQL�� �ۼ�

SELECT *
FROM emp e JOIN emp m ON (e.mgr = m.empno);


NONEQUI JOIN : ����� ������ =�� �ƴ� ��

�׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=
                            AND, OR, NOT
                            LIKE %, _
                            OR - IN
                            BETWEEN AND ==>  >=, <=


SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT * --��ü
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND SALGRADE.HISAL);

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade --���� ���� �͸� ���� ���� �÷� ����
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND SALGRADE.HISAL);

==> ORACLE ���� �������� ����
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

join0]
-- ORACLE
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

-- ANSI-SQL
SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
ORDER BY deptno;

join0_1]
-- ORACLE
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno != 20 --emp.deptno IN(10, 30)
ORDER BY empno;

join0_2]
-- ORACLE
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
ORDER BY deptno;

join0_3]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
  AND empno > 7600
ORDER BY deptno;

join0_4]
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500
  AND emp.empno > 7600
  AND dept.dname = 'RESEARCH'
ORDER BY deptno;


�����غ���
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

join 1]
SELECT lprod.LPROD_GU, lprod.LPROD_NM, prod.PROD_ID, prod.PROD_NAME
FROM prod JOIN lprod ON (prod.PROD_LGU = lprod.LPROD_GU);

SELECT *
FROM prod;

SELECT *
FROM lprod;