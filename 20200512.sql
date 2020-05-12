EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

ROWID : ���̺� ���� ����� �����ּ�
        (java - �ν��Ͻ� ����
            c - ������)

SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID = 'AAAE5uAAFAAAAETAAF';

SELECT *
FROM TABLE(dbms_xplan.display);

WHERE ���� ���� �����ϴµ� ����Ѵ�.


INDEX �ǽ�
emp ���̺� ���� ������ pk_emp PRIMARY KEY ���������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

2. emp ���̺� empno �÷����� PRIMARY KEY �������� ������ ���
   (empno�÷����� ������ unique �ε����� ����)
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

3. 2�� SQL�� ���� (SELECT �÷��� ����)

2��
SELECT *
FROM emp
WHERE empno = 7782;

3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

4. empno�÷��� non-unique �ε����� �����Ǿ� �ִ� ��� ---�� �� �� �д´�. / �ߺ�

ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_emp_01 ON emp (empno); ---INDEX �տ� UNIQUE ���̸� UNIQUE INDEX �Ⱥ��̸� NO-UNIQUE INDEX

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

5. emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ���� ��
�����ε���
idx_emp_01 : empno

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ�
SQL������ ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02 (job) ������ �� �� �����ȹ ��

CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FO
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


6. emp���̺��� job = 'MANAGER' �̸鼭 ename�� C�� �����ϴ� ����� ��ȸ (��ü�÷� ��ȸ)
�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'   ---job�̶�� �ε����� �ֱ� ������ ���� ����...?
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


7. emp���̺��� job = 'MANAGER' �̸鼭 ename�� C�� �����ϴ� ����� ��ȸ(��ü�÷� ��ȸ)
�� ���ο� �ε��� �߰� : idx_emp_03 : job, ename
CREATE INDEX idx_emp_03 ON emp (job, ename);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


8. emp���̺��� job = 'MANAGER' �̸鼭 ename�� C�� ������ ����� ��ȸ(��ü�÷� ��ȸ) 2�� OR 3��
�ε��� ��Ȳ
idx_emp_01 : ename
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *                        ---/*+ INDEX( emp IDX_EMP_03) */
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C';

SELECT *
FROM TABLE(dbms_xplan.display);

9. ���� �÷� �ε����� �÷� ������ �߿伺 2�� OR 4��
�ε��� ���� �÷� : (job, ename) VS (ename, job)
*** �����ؾ��ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�.

���� sql : job = manager, ename�� C�� �����ϴ� ��� ���� ��ȸ(��ü �÷�)
���� �ε��� ���� : idx_emp_03;
DROP INDEX idx_emp_03;

�ε��� �ű� ����
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp (ename, job);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);



���ο����� �ε���
idx_emp_01 ����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp ���̺� empno �÷��� PRIMARY KEY�� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

�ε��� ��Ȳ
pk_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;

3-2-5-4-1-0 
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |     1 |    58 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |         |     1 |    58 |     2   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP     |     1 |    38 |     1   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | PK_EMP  |     1 |       |     0   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=7788)


EXPLAIN PLAN FOR (��� �������� Ư�� �������� ���� ���� HASH)
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

���̺� �ε����� ������? (98-100)
- �˻��� �� ������ �Է��� �� ������
- ��������..

RULE BASED OPTIMIZER : ��Ģ��� ����ȭ�� (9i) ==> ���� ī�޶�
COST BASED OPTIMIZER : ����� ����ȭ�� (10g) ==> �ڵ� ī�޶�