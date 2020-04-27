SELECT empno, ename, hiredate,
       DECODE(MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'yyyy'), 2), '�ǰ����� �����', '�ǰ����� ������') CONTACT_TO_DOCTOR
FROM emp;

SELECT empno, ename, hiredate,
       DECODE(MOD(TO_CHAR(SYSDATE+365, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'yyyy'), 2), '�ǰ����� �����', '�ǰ����� ������') CONTACT_TO_DOCTOR
FROM emp;

----------

NULLó���ϴ� ���(4���� �߿� ���� ���� �ɷ� �ϳ� �̻��� ���)
NVL, NVL2...

DESC emp; --��ũ��Ʈ ����ϸ� �̸�, ��, ������ �����µ� �� ���� ����ϴ��� ������ϴ��� �� �� �ִ�. empno�� NULL ���� ������� �ʴ´�.(NOT NULL)

SELECT empno, ename, sal, NVL(comm,0)
FROM emp;

condition : CASE, DECODE -- ���� ����ϱ� ������ �� �˾Ƶα�
 
�����ȹ : �����ȹ�� ���� / ���� ����
 
----------
 
 emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 -> 105)

�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                           �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����
                           
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����

�� �� �������� sal��ŭ�� ����

DECODE�� ��� (case �� ��� ����)

SELECT DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANAGER', sal * 1.30,
                   DECODE(deptno, 10, sal * 1.30, sal * 1.10), 1.30,
                   'PRESIDENT', sal * 1.20,
                   sal) bonus
FROM emp;

----------

���� A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
�Ҽ� : �ڽŰ� 1�� ����� �ϴ� ��
*Prime number* �Ҽ� : {23, 29, 37} : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
��Ҽ� : {10, 15, 18, 24, 25, 30, 35};

--�׷��Լ�(MULTI LOW FUNCTION) : �������� ������ ��� ���� �ϳ��� ����

SELECT *
FROM emp
ORDER BY deptno;

GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
     emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�.
     �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
     
GROUP BY ����� ���ǻ��� : SELECT ����� �� �ִ� �÷��� ���ѵȴ�. *****

SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY];


�μ����� ���� ���� �޿� ��
SELECT deptno,   ---deptno ���� sal�� ���� ���� ���� �����´�. �׷����� �������� ���� �÷��� ���� ����X(��, �׷� �Լ��� ����ϸ� ����)(3)
       MAX(sal), --�μ����� ���� ���� �޿� ��
       MIN(sal), --�μ����� ���� ���� �޿� ��
       ROUND(AVG(sal),2), --�μ��� �޿� ���
       SUM(sal), --�μ��� �޿� ��
       COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*),   --�μ��� ���� ��
       COUNT(mgr)
FROM emp ---emp ���̺���(1)
GROUP BY deptno; ---( )�� �׷����� ���(2)

* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
   ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����

emp ���̺��� �׷������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���
SELECT MAX(sal), --��ü ���� �� ���� ���� �޿� ��
       MIN(sal), --��ü ���� �� ���� ���� �޿� ��
       ROUND(AVG(sal),2), --��ü ������ �޿� ���
       SUM(sal), --��ü ������ �޿� ��
       COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*),   --��ü ���� ��
       COUNT(mgr)  --mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

2020.04.27 ��ǥ �� ���� Ȯ��
GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ???? �������.

GROUP BY  ���� ������� ���� �÷���
    SELECT ���� ������ ???? ��������.

�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�. (���� �ƴ�);
SELECT deptno,
       MAX(sal), --�μ����� ���� ���� �޿� ��
       MIN(sal), --�μ����� ���� ���� �޿� ��
       ROUND(AVG(sal),2), --�μ��� �޿� ���
       SUM(sal), --�μ��� �޿� ��
       COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*),   --�μ��� ���� ��
       COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ���� �� NULL ���� ���ܰ� �ȴ�.
30�� �μ�����  NULL ���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� ���� Ȯ���� �� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm), 0) : COMM �÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� COMM �÷��� NVL �Լ��� ���� ��(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����
SELECT deptno, NVL(SUM(comm), 0) -- SUM(NVL(comm, 0)) ����� ������ ȿ�������� �ʴ�.
FROM emp
GROUP BY deptno;

single row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��� ����
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';


�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
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

grp3] * ����
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
GROUP BY deptno --DECODE ���� ���� �� ����
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