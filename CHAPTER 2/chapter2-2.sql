SELECT * FROM madang.importedbook;

update book set publisher = (select publisher from book where bookid = 10)
where bookid = 14;



update book set publisher = "TEST"
where bookid = (select bookid from book where publisher = '나무소');


select * from madang.orders;

/*1) 박지서ㅣ 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름*/
select name, b.bookname, publisher from orders o
join book b
join customer c
on o.custid = c.custid and b.bookid = o.bookid
where name != '박지성' and publisher in (select publisher from book b
join orders o
join customer c
on o.custid = c.custid and b.bookid = o.bookid
where name = '박지성');
/*2)두개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름 */
select name from customer;
select name, count(distinct(publisher)) 출판사수 from orders o
join book b
join customer c
on b.bookid = o.bookid and o.custid = c.custid
group by name
having 출판사수 >= 2;
select * from orders;
/*3)(생략) 전체 고객의 30% 이상이 구매한 도서 */
select o.bookid, count(distinct(o.custid)) 고객수 from orders o
join customer c
on c.custid = o.custid
group by o.bookid
having 고객수 > (select count(*) from customer)*0.3;
/*새로운 도서 ('스포츠 세계', '대한미디어', 10000원)이 마당서점에 입고되었다. 삽입이 안 될 경우 필요한 데이터가 ẹ 있는지 찾아보기*/

/*'삼성당'에서 출판한 도서를 삭제해야 함*/

/*'이상미디어'에서 출판한 도서를 삭제해야 함. 삭제가 안 될 경우 원인을 생각해보기*/

/*출판사 '대한미디어'가 '대한출판사'로 이름을 바꾸기*/
