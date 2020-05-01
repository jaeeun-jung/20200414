�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==>
�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN (10, 30)
WHERE deptno = 10 OR deptno = 30


������ ������
�������� ��ȸ�ϴ� ���������� ��� = ������ ���Ұ� (WHERE deptno = (10, 30)
WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH - 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ���
==> ������������ ��밡���� ������ IN(���� ��, �߿�)*****, (ANY, ALL, �󵵰� ����)
IN : ���������� ����� �� ������ ���� ���� �� TRUE
    WHERE �÷�|ǥ���� IN (��������)
ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)
ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL (��������)
    
SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �� ���� ������ ����
1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
20, 30
SELECT *
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN (20, 30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���� ����
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));
                 
sub3]
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD');

ANY, ALL (���� ����)
SMITH(800)�� WARD(1250) �� ����� �޿� �� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

SMITH(800)�� WARD(1250) �� ����� �޿����� ���� �޿��� �޴� ���� ��ȸ
==> sal > 1250
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN (20, 30)

�ҼӺμ��� 20, Ȥ�� 30�ο� ������ �ʴ� ���
WHERE deptno NOT IN (20, 30)
NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�

�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�?? ---���� ����� NULL�� ������ ���������� �۵��� ����
NULL���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);
NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ                    
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);

���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT *
FROM emp
WHERE empno in ( 7499/*, 7782*/) WHERE empno = 7782);

7499m 7782����� ������ (���� �μ�, ���� �Ŵ���)�� ��� ���� ���� ��ȸ
�Ŵ����� 7698�̸鼭 �ҼӺμ��� 30�̰��
�Ŵ����� 7698�̸鼭 �ҼӺμ��� 21�̰��

(7689    30)
(7839   10)

mgr �÷��� deptno �÷��� �������� ����.
(mgr, deptno
(7698, 10)
(7698,10)
7839, 10)
(7839, 30);

SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
  AND deptno IN (10, 30);
  
PAIRWISE ���� (���� �������� ����� �� �� ����.)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7482));

�������� ���� - ��� ��ġ
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ���� ����

�������� ���� - ��ȯ�ϴ� ��, �÷��� �� ---������ü�� �߿��Ѱ� �ƴ�
���� ��
    ���� �÷�(��Į�� ���� ����) --- �길 ����
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�
    
��Į�� ��������
SELECT ���� ǥ���Ǵ� ��������
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷�ó�� �ν�

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ�ؾ� �Ѵ�.
���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ����. ==> ����
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

join���� ����
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�� ������ ��Į�� ���������� ���� ---��ȣ ���� ��������, ��Į�� ���������� �۵��ϸ� ������ ��
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) --, �μ��̸�
FROM emp;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ ���� ��������(corelated sub query) 
    .���� ������ ����Ǿ�� ���� ������ ������ �����ϴ�.
    
���ȣ ���� ��������(non corelated sub query)
    .main ������ ���̺��� ���� ��ȸ�� ���� �ְ�
     sub ������ ���̺��� ���� ��ȸ�� ���� �ִ�.
     ==> ����Ŭ�� �Ǵ� ���� �� ���ɻ� ������ �������� ���� ������ ����

��� ������ �޿� ��պ��� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ��ϼ���(���� ���� �̿�)
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?
 ���ȣ ���� ���� ������
 
������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;
 
SELECT *
FROM emp e
WHERE e.sal > (SELECT AVG(sal)
               FROM emp
               WHERE deptno = e.deptno);

-----OUTER JOIN ==> ������ ���еǴ��� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���� ���-----

INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

emp���̺� ��ϵ� �������� 10, 20, 30�� �μ����� �Ҽ��� �Ǿ����� ---1. �μ��� �����ִ� ���� ��ȸ 2. �Ҽӵ��� ���� ���� ��ȸ
���� �Ҽӵ��� ���� �μ� : 40, 99

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
���� ������ �־ ��� ����(����)

������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� �����Ϸ��� �׷� ������ �� ���(���� �´�)
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     GROUP BY deptno);
sub5] 1. 1�� ���� �����ϴ� ��ǰ / 2. 1�� ���� �������� �ʴ� ��ǰ
SELECT pid, pnm
FROM product
WHERE pid NOT IN(SELECT pid
                 FROM cycle
                 WHERE cid = 1);

sub6] 1. 1�� ���� �����ϴ� ��ǰ ������ ��ȸ�� �Ѵ�. 2�� ���� �����ϴ� ��ǰ�� ��ȸ�� �Ѵ�.
SELECT *
FROM cycle
WHERE cid = 1
  AND pid IN(SELECT pid
             FROM cycle
             WHERE cid = 2);

2�� ���� �Դ� ������ǰ����
SELECT pid
FROM cycle
WHERE cid = 2;

SELECT *
FROM cycle
WHERE cid = 1
  AND pid;

sub7] ���� ���� (������ �� ���� ���)
������ �̿��� ���
SELECT cycle.cid, cnm, product.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE cycle.cid = 1
  AND customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND cycle.pid IN(SELECT pid
             FROM cycle
             WHERE cid = 2);

��Į�� ������ �̿��� ��� (���������� �ʹ� ���� ����ȴ�)
SELECT cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
       pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm, day, cnt
FROM cycle
WHERE cid = 1
  AND pid IN(SELECT pid
             FROM cycle
             WHERE cid = 2);