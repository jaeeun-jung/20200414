'202005' ==> �Ϲ����� �޷��� row, col;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

JOIN ������ ��
CROSS JOIN : ������ ������ ��....

�μ���ȣ ��, ��ü �� �� SAL ���� ���ϴ� 3��° ���
SELECT DECODE(lv, 1, deptno, 2, null) deptno, SUM(sal) sal
FROM emp, (SELECT LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2)
GROUP BY DECODE(lv, 1, deptno, 2, null)
ORDER BY 1;


������ ���� �߿�**********
START WITH : ���� ������ ������ ���
CONNECT BY : ����(��)�� ������� ǥ��

zzȸ��κ��� (�ֻ��� ���)���� ���� ��������� ���������� Ž���ϴ� ����Ŭ ������ ���� �ۼ�
1. �������� ���� : xx ȸ��
2. ������(��� ��) ����� ǥ��
   PRIOR  ���� ���� �а� �ִ� ���� ǥ��
   �ƹ� �͵� ������ ���� : ���� ������ ���� ���� ǥ��
   
SELECT *
FROM emp, emp b
WHERE emp.mgr = b.empno;

SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;

SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

h_1]
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL - 1) * 3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

h_2]
SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd 
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

�����
������ : �������� - dept0_00_0

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_3]
SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_4]
SELECT LPAD(' ', (LEVEL - 1) * 3) || s_id s_id, value 
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

h_5]
SELECT LPAD(' ', (LEVEL - 1) * 3) || org_cd org_cd, no_emp 
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY ���Ŀ� �̾ PRIOR�� ���� �ʾƵ� ��� ����.
PRIOR�� ���� �а� �ִ� ���� ��Ī�ϴ� Ű����


Pruning branch : ����ġ��
WHERE���� ������ ������� �� : ������ ������ ���� �� ���� �������� ����
CONNECT BY ���� ������� ��
�� ���� ��
*�� ������ �������� FROM -> START WITH -> CONNECT BY -> WHERE�� ������ ó���ȴ�.

1. WHERE���� ������ ����� ���

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd 
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


2. CONNECT BY ���� ������ ����� ���

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';


������ �������� ����� �� �ִ� Ư�� �Լ�
CONNECT_BY_ROOT(column) : �ش� �÷��� �ֻ��� �����͸� ��ȸ
SYS_CONNECT_BY_PATH(column, ������) : �ش� ���� ������� ���Ŀ� ���� column���� ǥ���ϰ� �����ڸ� ���� ����
CONNECT_BY_ISLEAF ���ڰ� ���� : �ش� ���� ������ �� �̻� ���� ������ ������� (LEAF ���)
                              LEAF��� : 1, NO LEAF ��� : 0

������
  ==���
    ==���
������
  ==���
  ==���

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm)
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm),
       SYS_CONNECT_BY_PATH(deptnm, '-')
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm),
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-')
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
   
SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL - 1) * 3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm),
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-'),
       CONNECT_BY_ISLEAF
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

h_6]
SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title deptnm
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

h_7] ORDER BY�� ���� ���������� ������
ORDER SIBLINGS BY
SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title deptnm
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

h_8]
������ ������ ���Ľ� ���� ������ �����ϸ鼭 �����ϴ� ����� ����
SELECT seq, LPAD(' ', (LEVEL - 1) * 4) || title deptnm
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

h_9] �߰����� �÷�, �� �����Ͽ� ����

ALTER TABLE board_test ADD (gp_no NUMBER);

UPDATE board_test SET gp_no = 4
WHERE seq IN (4, 10, 11, 5, 8, 6, 7);

UPDATE board_test SET gp_no = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gp_no = 1
WHERE seq IN (1, 9);
COMMIT;

SELECT gp_no, CONNECT_BY_ROOT(seq), seq, LPAD(' ', (LEVEL - 1) * 4) || title deptnm
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY CONNECT_BY_ROOT(seq) DESC, seq ASC;


��ü ���� �߿� ���� ���� �޿��� �޴� ����� �޿� ����
�ٵ� �װ� ������???

���� ���� �޿��� �޴� ����� �̸�

emp���̺��� 2�� �о ������ �޼� ==> ���� �� ȿ������ ����� ������?? ==> WINDOW / ANALYSIS function
SELECT ename
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);


ana0]
SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal DESC;

SELECT f.ename, f.sal, f.deptno, lv sal_rank
FROM
(SELECT c.*, ROWNUM m
FROM
(SELECT a.*, b.lv
FROM 
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno)a, (SELECT LEVEL lv
                     FROM dual
                     CONNECT BY LEVEL <= 6) b
WHERE a.cnt >= lv
ORDER BY a.deptno, b.lv) c) d,

(SELECT ROWNUM w, e.*
FROM
(SELECT *
FROM emp
ORDER BY deptno, sal DESC) e) f
WHERE d.m = f.w;
