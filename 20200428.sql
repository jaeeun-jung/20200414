join2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON (prod.prod_buyer = buyer.buyer_id)
GROUP BY buyer_id, buyer_name, prod_id, prod_name;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE prod.prod_buyer = buyer.buyer_id;
     
join2_1]
SELECT COUNT(*)
FROM (SELECT buyer_id, buyer_name, prod_id, prod_name
      FROM buyer JOIN prod ON (prod.prod_buyer = buyer.buyer_id)
      GROUP BY buyer_id, buyer_name, prod_id, prod_name);

SELECT COUNT(*)
FROM(SELECT buyer_id, buyer_name, prod_id, prod_name
     FROM buyer, prod
     WHERE prod.prod_buyer = buyer.buyer_id);
     
SELECT COUNT(*)
FROM buyer JOIN prod ON (prod.prod_buyer = buyer.buyer_id);

SELECT COUNT(*)
FROM buyer, prod
WHERE prod.prod_buyer = buyer.buyer_id;

join2_2]BUYER_NAME �� �Ǽ� ��ȸ ���� �ۼ�
SELECT buyer.buyer_name, COUNT(*)
FROM buyer, prod
WHERE prod.prod_buyer = buyer.buyer_id
GROUP BY buyer.buyer_name;

join3] 207��
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  AND cart.cart_prod = prod.prod_id;
  
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON (mem_id = cart.cart_member)
            JOIN prod ON (cart.cart_prod = prod.prod_id);
            
�������
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT *
FROM
    (SELECT deptno, COUNT(*)
    FROM emp
    GROUP BY deptno)
WHERE deptno = 30;

SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30
GROUP BY deptno;


cid : customer id
cnm : customer name

SELECT *
FROM customer;

pid : product id
pnm : product name

SELECT *
FROM product;

cycle : �����ֱ�
cid : �� id
pid : ��ǰ id
day : ��������(�Ͽ��� - 1, ������ - 2, ȭ����...)
cnt : ����

SELECT *
FROM cycle;

join4]
SELECT cycle.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND customer.cnm IN('brown', 'sally');

SELECT cid, cnm, pid, day, cnt --natural join�� cid �տ� ���� �ʴ´�.
FROM customer NATURAL JOIN cycle
WHERE customer.cnm IN ('brown', 'sally');

join5]
SELECT cycle.cid, cnm, cycle.pid, pnm day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN('brown', 'sally');

join6] ���� ��ǰ�� ������ ��
SELECT cycle.cid, cnm, cycle.pid, pnm, SUM(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  And cycle.pid = product.pid
GROUP BY cycle.cid, cnm, cycle.pid, pnm
ORDER BY cycle.cid, cycle.pid;

join7]
SELECT product.pid, pnm, SUM(cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY product.pid, pnm;