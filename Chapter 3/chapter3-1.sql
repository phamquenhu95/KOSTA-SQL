use madang;
select orderid '주문번호', orderdate '주문일',
		adddate(orderdate, interval 10 day) '확정'
from orders;

-- NULL 값이 있다면 sum, avg -> null, count -> 0
select sum(saleprice), avg(saleprice), count(saleprice) from orders where orderid = 12;

select name '이름', ifnull(phone, '연락처없음') '전화번호'
from customer;

update customer set phone= ifnull( phone, '연락처없음') 
where custid=5;
-- 4-12 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액을 출력).
select 
(select name from customer c where o.custid = c.custid) '고객이름' ,
 sum(saleprice) '판매액'
from orders o
group by o.custid;
-- 겂이 없는 것 -> NULL
select 
(select name from customer c where o.custid = 10) '고객이름' ,
 sum(saleprice) '판매액'
from orders o
group by o.custid;

alter table orders add column bname varchar(40);
select * from orders;
set sql_safe_updates = 0;
update orders o
set bname = (select bookname
				from book b
                where b.bookid = o.bookid);
                
-- 4-17 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하-- 
select sum(saleprice) 'total'
from orders 
where custid in (select custid
				from customer
                where address like '%대한민국%');
                
-- 4-18 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid = 3);

select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid is not null);

select sum(saleprice) from orders o
where exists (select c.custid from customer c
			where c.custid = o.custid and address like '대한민국%');
            
select sum(saleprice) from orders o
join customer c
on c.custid = o.custid
where c.address like '대한민국%';

select custid, count(*) from orders
group by custid
having count(*) > 1
order by custid desc;

select custid, count(*) from orders
where custid > 1
group by custid
having count(*) > 1
order by custid desc;

