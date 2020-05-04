������

��Ģ ������ : +, -, *, / : ���׿�����
���� ������ : ? 1==1 ? true�� �� ���� : false�� �� ����

SQL ������
= : �÷�|ǥ���� = �� ==> ���� ������
  = 1
IN : �÷�|ǥ���� IN (����)
  deptno IN (10, 30) ==> IN (10, 30), deptno (10, 30)

EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �� ���̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� �����ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�.

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� �� �̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);

ex)
�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14 - KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);

IS NOT NULL�� ���ؼ��� ������ ����� ����� �� �� �ִ�.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

sub9]
SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT *
              FROM cycle
              WHERE cycle.cid = 1
                AND cycle.pid = product.pid);

1�� ���� �Դ� ��ǰ ����
SELECT *
FROM cycle
WHERE cid = 1;

sub10]
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT *
                  FROM cycle
                  WHERE cycle.cid = 1
                    AND cycle.pid = product.pid);

���տ���
������
{1, 5, 3} U {2. 3} = {1, 2, 3, 5}

SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�)
{1, 5, 3} U {2. 3} = {1, 5, 3, 2, 3}

������
{1, 5, 3} ������ {2. 3} = {3}

������
{1, 5, 3} - {2. 3} = {1, 5}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ�� (��, �Ʒ��� ���յȴ�.)


UNION ������ : �ߺ�����(������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


UNION ALL ������ : �ߺ� ���

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


INTERSECT ������ : �� ���� �� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


SQL ���� �������� Ư¡

���� �̸� : ù��° SQL�� �÷��� ���󰣴�.

ù��° ������ �÷��� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. ������ �ϰ���� ��� �������� ���� ����
   ���� SQL���� ORDER BY �Ұ�(�ζ��� �並 ����Ͽ� ������������ ORDER BY�� ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���� �Ұ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�.(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ⹿�� ������ ������ �����ϴ� �۾����ʿ�
   ==> ����ڿ��� ����� �����ִ� �������� ������
    ==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ�.
4. �˰���(���� - ��������, ��������, ......
          �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                    heap
                    stack, queue
                    list
���տ��꿡�� �߿��� ���� : �ߺ�����


���ù�������
����ŷ�� ���� + �Ƶ������� ���� + KFC�� ���� / �Ե������� ����

SELECT ROWNUM || '��' ���ù�������, r.*
FROM
(SELECT m.sido, m.sigungu, m.a, n.b, ROUND(a/b, 2) c
FROM 
(SELECT sido, sigungu, COUNT(gb) a
FROM fastfood
WHERE gb IN ('����ŷ', '�Ƶ�����', 'KFC')
GROUP BY sido, sigungu) m,

(SELECT sido, sigungu, COUNT(gb) b
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY sido, sigungu) n

WHERE m.sido = n.sido AND m.sigungu = n.sigungu
ORDER BY c desc) r;


���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT),
                �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�, ���̺�), ROUND, JOIN

SELECT ROWNUM || '��' ���ù�������, a.sido, a.sigungu, a.city_idx
FROM
(SELECT bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, loc.cnt, ROUND((bk.cnt + kfc.cnt + mac.cnt) / loc.cnt, 2) city_idx
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu) kfc,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu) loc

WHERE bk.sido = kfc.sido
  AND bk.sigungu = kfc.sigungu
  AND bk.sido = mac.sido
  AND bk.sigungu = mac.sigungu
  AND bk.sido = loc.sido
  AND bk.sigungu = loc.sigungu 
ORDER BY city_idx desc) a;


����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�        �ʼ�****************
 1. �õ� �ñ����� ���ù��������� ���ϰ� (������ ���� ���ð� ������ ����)
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� !!������ ���� �����ͳ���!! �����Ͽ� �Ʒ��� ���� �÷��� ��ȸȸ���� SQL �ۼ�
 
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ� 1�δ� �Ű��

����2]
�ܹ��� ���ù��������� ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
CASE, DECODE ���..

����3]
�ܹ������� SQL�� �ٸ� ���·� �����ϱ�