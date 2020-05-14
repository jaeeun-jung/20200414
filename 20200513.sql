CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1 = 1;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

idx3]
CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE INDEX idx_emp_02 ON emp (deptno, mgr, hiredate, sal);
CREATE INDEX idx_emp_03 ON emp (ename);

idx4]����
CREATE UNIQUE INDEX idx_u_emp_01 ON emp (empno);
CREATE UNIQUE INDEX idx_u_emp_02 ON emp (deptno, sal);
CREATE INDEX idx_u_dept_01 ON dept (deptno, loc);

�����ȹ

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱���, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ� ���� ������ ��� ����� ���� ���εǴ� ���� ���
self join : ���� ���̺��� �����ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û�ϸ� DBMS�� SQL�� �м��ؼ� ��� �� ���̺��� ������ ���� ����,
3���� ����� ���ι��(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join --- �ҷ��� ������ ����
2. Sort Merge Join --- ���� ���x, ������ ������ ������ ����, ������ ����, �幮 ���, �ε���x
3. Hash Join --- �ε���x, ��ټ��� ��� ��� ����, �Է� ���� �Ϻθ� ����ǵ� ��� ���� �ٸ�, Hash ���̺��� �ϼ��ϸ�(Hash �Լ�) �ٸ� ���̺�� ������� ����

--- �����͸� ��ȸ�� �� �ε����� �ҷ��� �����͸� ���� �� ������ - sigle block(����)
--- �����͸� ��ȸ�� �� ���̺��� �뷮�� �����͸� ���� �� ������ - (��ũ����)

OLTP (OnLine Trascation Processing) : �ǽð� ó�� ==> ������ ����� �ϴ� �ý��� (�Ϲ����� �� ����)
OLAP (OnLine Analysis Processing) : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���(���� ���� ���, ���� �ѹ��� ���)

�ε��� ��� ���ϴ� ���
1. �÷� ����(�º� ����)
2. ������ ���� : !
3. NULL �� (NULL ���� �ε����� �ȵ� �� �ε����� Ȯ���ϴ� ���� �ǹ̰� ����) - NOT NULL ���� �߿�
4. LIKE ����� ���� ���ϵ� ī�� : LIKE '%T';

INDEX UNIQUE SCAN : ���� ã���� ��ȸ�� ����
INDEX RANGE SCAN[DESCENDING] : �Ϻ� ������ ��ȸ
INDEX FULL SCAN[DESCENDING] : ��� ���� ��ȸ
INDEX FAST FULL SCAN : ��ü ��ȸ
INDEX SKIP SCAN : �ε����� �����÷��� �� ���� �÷��� ���� ���� -> ���� �÷��� ��...?????