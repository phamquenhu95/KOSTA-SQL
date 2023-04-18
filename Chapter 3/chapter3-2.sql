create view view_orders
as select orderid, o.custid, c.name, o.bookid, b.bookname, saleprice, orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid = b.bookid;

select * from madang.view_orders where name = '박지성';

create view www_customer
as select * from customer
where address like '%대한민국%';
select * from www_customer;

drop view www_customer;
select * from www_customer;

desc view_orders;
use madang;
create view view_customer as select * from customer;
select * from view_customer;
update view_customer set phone = '000-0000-0001' where custid = 5;

use information_schema;
show tables;
desc views;
select * from infomation_schema;

select * from views where table_name = 'view_customer';
select * from views where table_name = 'view_oders';
