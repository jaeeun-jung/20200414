SELECT e.manager_id mgr_id, m.first_name || m.last_name name, e.employee_id, e.job_id, jobs.job_title
FROM employees e, jobs, employees m
WHERE e.job_id = jobs.job_id
  AND e.manager_id = m.employee_id;
  
OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<==>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �� �Ǹ� ������ ó��)

emp���̺��� �÷� �� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�.
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ� 
    KING�� ������ ������ �ʴ´� (emp ���̺� �Ǽ� 14�� ==> ���� ��� 13��)
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

���� ������ OUTER �������� ����
 (KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, 
  ������ ����� ������ ���� ������ ������ �ʴ´�);

ANSI-SQL : OUTER
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE���� ���� ������ ���
3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�.
   ==> ������ ���̺� �ݴ����� ���̺��� �÷� ---���� �� �ٿ��ֱ�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� �� (14��)
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);    ---���ο� ���� ������ on �ڿ� ����

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
  AND e.deptno = 10;

������ WHERE���� ������� �� (3��) --- OUTER JOIN�� ȿ���� ����
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)   ---�̳���....
WHERE e.deptno = 10;


OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�

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
3�� ==> customer ���̺��� ���� ����
SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

emp 14 * dept 4 = 56
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp, dept;

crossjoin1]
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;


��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ���� *****
SELECT *
FROM emp
WHERE 1 = 1
   OR 1 != 1;

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �� ���� �÷��̾�� �Ѵ�. ***
    EX) DUAL ���̺�
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
3. WHERE
    SUB QUERY
    WHERE  ���� ���� ����
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��° ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ� �� 10������ 30������ ������ ����
    ==> �������� ���鿡�� ���� ����
    
ù��° ����
SELECT deptno   --20
FROM emp
WHERE ename = 'SMITH';

�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20; ---20�̶�� �ϵ��ڵ��� ����

���������� ���� ���� ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno   --20
                FROM emp
                WHERE ename = 'SMITH'); ---smith�� �ٲ� �� ����

sub1]
��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ�ϼ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

select *
from emp;

sub2]
��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);