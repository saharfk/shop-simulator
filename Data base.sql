drop database sell1
go
create database sell1
go
use sell1
create table customers(
id int not null primary key identity,
name varchar(200) not null,
family varchar(200) not null,
address1 varchar(200) ,
city varchar(200) ,
postalcode nchar(10),
sex bit default(0),
date1 datetime default (getdate())
);
go
create table phoneC (
id int not null primary key identity,
phoneid int not null references customers(id),
phoneNum varchar(10) not null,
unique(phoneNum),
ismobile bit default(0)
);
go
create table EmailC (
id int not null primary key identity,
EmailId int not null references customers(id),
Email varchar(10) not null,
unique(Email)
);
go
create table Categories (
id int not null primary key identity,
parentCid int not null references Categories(id),
title varchar(200) not null,
unique(title , parentCid)
);
go
create table unit(
id int not null primary key identity,
unitName varchar(100) not null,
);
go
create table products(
id int not null primary key identity,
Categoryid int not null references Categories(id),
unit int not null references unit(id),
code nchar(20) not null,
title varchar(200),
description1 varchar(200) ,
adddate datetime default(getdate())
);
go
create table price(
id int not null primary key identity,
productid int not null references products(id),
price decimal not null,
datePrice datetime default(getdate())
);
go
create table productIns(
id int not null primary key identity,
productid int not null references products(id),
dateIns datetime default (getdate()),
amount decimal not null,
constraint chk_productIns check(amount>0)
);
go
create table staff(
id int not null primary key identity,
name varchar(200) not null,
phone varchar(200) not null,
email varchar(200) not null,
addressS varchar(200) not null,
unique(phone,email,addressS)
);
go
create table factor(
id int not null primary key identity,
customerid int not null references customers(id),
staffId int not null references staff(id),
totalprice int not null,
factorDate datetime default (getdate())
);
go
create table factorItems(
id int not null primary key identity,
factorid int not null references factor(id),
priceid int not null references price(id)
);
go
create table sellinfo(
id int not null primary key identity,
whichC int not null references customers(id),
howManyP int not null  
);
go
go
create table seller(
id int not null primary key identity,
name varchar(200) not null,
phone varchar(200) not null,
email varchar(200) not null,
addressS varchar(200) not null,
unique(phone,email,addressS)
);
go

create table whichSeller(
id int not null primary key identity,
productid int not null references products(id),
sellerid int not null references seller(id)
);
go


INSERT INTO customers(name,family,address1,city,postalcode,sex)
VALUES ('n1','f1','a1','tehran','456854691','false' ),
('n2','f2','a2','c2','542657835','true'),
('n4','f3','a3','tehran','456834691','false'),
('n3','f2','a2','c3','55555555','false'),
('n2','f4','a2','c4','5426754','true'),
('n4','f3','a3','tehran','456544691','false'),
('n3','f2','a2','c3','558455','false'),
('n2','f4','a2','tehran','54555835','true'),
('n1','f1','a5','c5','6871346','true');

INSERT INTO phoneC(phoneid,phoneNum,ismobile)
VALUES (1,'4886453','true'),(2,'8465614','false'),(3,'85612355','true'),
(4,'99999999','true'),(5,'68764313','false'),(6,'87331598','false');

INSERT INTO EmailC(EmailId,Email)
VALUES (1,'n1@f1'),(2,'n2@f2'),(3,'n4@f3'),(4,'n3@f2'),(5,'n2@f4'),(6,'n1@f11');

INSERT INTO Categories(parentCid,title)
VALUES (1,'a'),(2,'b'),(3,'c');

INSERT INTO unit(unitName)
VALUES ('un1'),('un2'),('un3'),('un4'),('un5'),('un6');

INSERT INTO products(Categoryid,unit,code,title,description1)
VALUES (1,1,'c1','t1','d1'),(2,2,'c2','t2','d2'),(3,3,'c3','t3','d3'),
(2,1,'c4','t4','d4'),(3,4,'c5','t5','d5');

INSERT INTO price(productid,price)
VALUES (1,500),(2,200),(3,25000),(4,30000),(5,8000);

INSERT INTO productIns(productid,amount)
VALUES (1,10),(2,15),(3,20),(4,14),(5,30);

INSERT INTO staff(name,phone,email,addressS)
VALUES ('sn1','17541','sn1@gmail','sa1'),('sn2','5287','sn2@gmail','sa2'),('sn3','6764','sn3@gmail','sa3'),
('sn4','6878','sn4@gmail','sa4');

INSERT INTO factor(customerid,staffId,totalprice,factorDate)
VALUES (1,1,1000,'20101005'),(2,4,700,'20200506'),(3,3,55000,'20050505');

INSERT INTO factorItems(factorid,priceid)
VALUES (1,1),(1,1),(2,1),(2,2),(3,4),(3,3);

INSERT INTO sellinfo(whichC,howManyP)
VALUES (1,2),(2,2),(3,2);

INSERT INTO seller(name,phone,email,addressS)
VALUES ('selln1','17541','selln1@gmail','sella1'),('selln2','5287','selln2@gmail','ssella2'),('selln3','6764','selln3@gmail','ssella3'),
('selln4','6878','selln4@gmail','ssella4');

INSERT INTO whichSeller(productid,sellerid)
VALUES (1,1),(2,2),(3,2),(4,3),(5,4);

go

--1 : list bishtarin moshtariane yek guruhe entekhabi mahsulat
select Categories.id ,Categories.title , factor.customerid
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on price.id=factorItems.priceid
inner join products
on price.productid=products.id
inner join Categories
on Categories.id=products.Categoryid


select customers.id as customer_id, COUNT(customers.id) as howmany_times
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on price.id=factorItems.priceid
inner join products
on price.productid=products.id
inner join Categories
on Categories.id=products.Categoryid
where Categories.title='a' 
group by customers.id
order by COUNT(customers.id) desc




--2 : moshtariane khanom k kharide an ha dar mahe mey bishtr az 2000 tuman ast
INSERT INTO factor(customerid,staffId,totalprice,factorDate)
VALUES (5,1,1000,'20100505'),(5,4,8000,'20200506'),(6,1,1000,'20100505'),(6,4,8000,'20200506');


declare @tbl table(TotalPrice int,customerid int)
declare @id int =1
declare @m int
set @m = (select COUNT(id) from customers)
while(@id <= @m)
begin
insert into @tbl
select Sum(factor.totalprice),customers.id
from customers
inner join factor
on factor.customerid=customers.id
where customers.sex='false' and month(factor.factorDate)=05 and customers.id = @id 
group by customers.id
having Sum(factor.totalprice)>2000
set @id = @id+1
end
select * from @tbl


select customers.id,customers.name,customers.family,customers.sex,factor.factorDate,factor.id,factor.totalprice
from customers
inner join factor
on factor.customerid=customers.id
where customers.sex='false' and month(factor.factorDate)=05 and factor.totalprice>2000
go



--3 : gerantarin mahsulati k tavasote moshtariane boomi kharidari shode
select customers.id as C_id,customers.name,customers.family,customers.city,price.price,products.title,products.id as product_id
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on factorItems.priceid=price.id
inner join products
on products.id=price.productid
where customers.city='tehran' 
order by price.price desc


--4 gruh bandi shode : guruhae mahsulati k hichaght kharidari nashodand
select COUNT(products.id)as product_count,Categories.title
from products
inner join price
on products.id=price.productid
inner join Categories
on products.Categoryid = Categories.id
WHERE NOT EXISTS ( SELECT 1 FROM factorItems WHERE factorItems.priceid = price.id )
group by Categories.title


--shomare 4 bedune guruh(esme mahsulat)
select products.id as product_id, products.title,price.id as price_id
from products
inner join price
on products.id=price.productid
WHERE NOT EXISTS ( SELECT 1 FROM factorItems WHERE factorItems.priceid = price.id )

--5 : mojudi anbar mahsulati k tedadeshan bishtr az 5 va hich vaght kharidari nashodeand
select products.id as product_id,products.title , productIns.amount
from products
inner join productIns
on products.id=productIns.productid
inner join price
on products.id=price.productid
WHERE NOT EXISTS ( SELECT 1 FROM factorItems WHERE factorItems.priceid = price.id ) and productIns.amount>5



INSERT INTO factor(customerid,staffId,totalprice,factorDate)
VALUES (4,2,63700,'20200804');
select * from factor

INSERT INTO factorItems(factorid,priceid)
VALUES (8,1),(8,2),(8,3),(8,4),(8,5);

INSERT INTO sellinfo(whichC,howManyP)
VALUES (4,5);



--6 : list moshtariani k hadaghal yekbar az kol guruhhae mahsulat anbar kharid krde bashand
declare @tbl table(cid int)
declare @tbl1 table (categoryId int , CustomerId int)
declare @id int =1
declare @m int
set @m = (select COUNT(id) from customers)
while(@id <= @m)
begin
insert into @tbl
select distinct Categories.id
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on price.id=factorItems.priceid
inner join products
on price.productid=products.id
inner join Categories
on Categories.id=products.Categoryid
WHERE customers.id = @id 
if ((select COUNT(cid) from @tbl)=3)
begin
insert into @tbl1
select Categories.id ,customers.id
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on price.id=factorItems.priceid
inner join products
on price.productid=products.id
inner join Categories
on Categories.id=products.Categoryid
where customers.id=@id
end
delete @tbl
set @id=@id+1
end

select * from @tbl1

select  Categories.id , customers.id
from customers
inner join factor
on factor.customerid=customers.id
inner join factorItems
on factorItems.factorid=factor.id
inner join price
on price.id=factorItems.priceid
inner join products
on price.productid=products.id
inner join Categories
on Categories.id=products.Categoryid


