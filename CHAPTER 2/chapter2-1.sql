SELECT * FROM madang.sales;

select avg(amount) from sales where brand = "MLB";
select brand, amount from sales s1
where s1.amount > (select avg(s2.amount) from sales s2
					where s2.brand = s1.brand);
                    
select name, address from customer cs 
where exists (select * from orders od where cs.custid = od.custid);

select b1.bookname from book b1
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

-- (5) 박지성이 구매한 도서의 출판사 수
select * from customer;
select bookname, publisher from book b1
where exists (select * from orders where custid = 1);

select count(distinct(publisher)) 출반사수
from book b 
join orders o 
join customer c
on b.bookid = o.bookid and c.custid = o.custid
where c.name="박지성";

select count(distinct(publisher)) 출반사수
from book where bookid in (select bookid
							from orders o
                            join customer c
                            on c.custid = o.custid
                            where name="박지성");
-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname, price, saleprice, price * saleprice as 차이
from book b
join orders o
join customer c
on b.bookid = o.bookid and c.custid = o.custid
                            where c.name="박지성";

-- (7) 박지성이 구매하지 않은 도서의 이름
select bookname from book where bookid not in (select bookid
												from orders
												where custid = (select custid
																from customer
                                                                where name="박지성"));

-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer
where custid not in (select custid from orders);

select name, o.custid from customer c
left join orders o
on c.custid = o.custid
where o.custid is null;

select name, o.custid from orders o 
right join customer c
on c.custid = o.custid
where o.custid is null;

select o.custid, c.custid, saleprice from orders o
left join customer c
on o.custid = c.custid;



-- (9) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as 총액, avg(saleprice) as 평균금액 from orders o;

-- (10) 고객의 이름과 고객별 구매액
select name, sum(saleprice) from customer c
join orders o
on o.custid = c.custid
group by name;

-- (11) 고객의 이름과 고객이 구매한 도서 목록
select name, bookname from customer c
join orders o
join book b
on o.custid = c.custid and o.bookid = b.bookid
order by name;

-- (12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select b.bookid, price, saleprice, price*saleprice 차이
from book b
join orders o
on b.bookid = o.bookid
order by 차이 desc
limit 1;


-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

select avg(saleprice) from orders o
join customer c on c.custid = o.custid;

select c.name, avg(saleprice) 구매액평균
from orders o
join customer c
on o.custid = c.custid
group by c.name
having 구매액평균 > (select avg(saleprice) from orders o join customer c on c.custid = o.custid);

-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름
select name from customer
where address like '대한민국%'
UNION
SELECT name FROM customer
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

 SELECT CUSTID, name from customer WHERE address like '대한민국%' AND
CUSTID NOT IN (SELECT DISTINCT(C.CUSTID) FROM CUSTOMER c
JOIN ORDERS O
ON o.custid = c.custid);

SELECT * FROM CUSTOMER WHERE address like '대한민국%';
SELECT DISTINCT(C.CUSTID) FROM CUSTOMER c
JOIN ORDERS O
ON o.custid = c.custid;

 SELECT * FROM CUSTOMER WHERE address like '대한민국%' AND
CUSTID NOT IN (SELECT DISTINCT(C.CUSTID) FROM CUSTOMER c
JOIN ORDERS O
ON o.custid = c.custid);       

/* 주문이 있는 고객과 이름과 주소를 보여주기 (EXISTS) */
SELECT NAME, ADDRESS FROM CUSTOMER C
WHERE EXISTS (SELECT O.CUSTID FROM ORDERS O
			WHERE O.CUSTID = C.CUSTID);
                