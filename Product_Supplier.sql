SELECT
    *
FROM sale;
SELECT
    *
FROM product;
SELECT
    *
FROM category;
SELECT
    *
FROM supplier;
SELECT
    *
FROM purchase;


--1 sual: Hazırda neçə məhsul olduğunu təyin edən sorğunu yazın. 

select  sum(pr.quantityinstock-(select sa.quantitysold 
                               from sale sa 
                               where sa.productid=pr.productid)) as stok
from product pr;


--Sual 2:Son bir ayda konkret təchizatçıdan alınmış bütün məhsulların ümumi alış qiyməti nə qədər olduğunu təyin edən sorğunu yazın. 

select sum(pur.purchaseprice) 
from product pr
inner join purchase pur
on pr.productid=pur.productid
inner join supplier sup
on sup.supplierid=pur.supplierid
where pur.purchasedate between add_months(sysdate,-1) and sysdate;


-- 3.  Hansı təchizatçı son rübdə ən çox məhsul təqdim etdiyini göstərən sorğunu yazın. 

select sup.suppliername,
       count(pur.productid) counts 
from product pr
inner join purchase pur 
on pur.productid=pr.productid
inner join supplier sup 
on sup.supplierid=pur.supplierid
where pur.purchasedate>='01-oct-2023' and pur.purchasedate<='31-dec-2023'
group by sup.suppliername
order by counts desc fetch next 1 rows only


-- 4.  Ötən həftə nə qədər satış həyata keçirildiyini təyin edən sorğunu yazın.

select sum(sa.quantitysold)
from sale sa
where sa.saledate between sysdate-7 and sysdate;

-- 5.  Hansı məhsulun qiymətinin ən yüksək olduğunu təyin edən sorğunu yazın.

 select 
      * 
 from product pr
 where pr.price=(select  
                      max(price)
                 from product);
 
-- 6.  Nə qədər məhsul alınıb, lakin hələ də satılmadığını təyin edən sorğunu yazın. 

select 
     sum(distinct pur.quantitypurchased) 
from product pr 
inner join purchase pur
on pur.productid=pr.productid
where pur.productid not in (select s.productid from sale s);

-- 7.  Hansı kateqoriyada ən çox məhsul olduğunu təyin edən sorğunu yazın. 
select X,
       sum(pr.quantityinstock-(select 
                                  sa.quantitysold 
                              from sale sa 
                              where sa.productid=pr.productid)) as stok,
from product pr
group by X;
--category və productla elaqe qurmaq mumkun deyil


-- 8.  Hər bir məhsulun orta satış qiyməti nə qədər olduğunu göstərən sorğunu yazın. 

select pr.productname,
       avg(sa.saleprice)
from product pr 
inner join sale sa
on sa.productid=pr.productid
group by pr.productname;

-- 9.  Son bir ayda neçə təchizatçı məhsul tədarük etdiyini bildirən sorğunu yazın. 

select 
   count(distinct supplierid) as techizatçi_say
from purchase
where purchasedate between add_months(sysdate,-1) and sysdate;


-- 10.  Son bir ayda hansı məhsullar satılmadığını bildirən sorğunu yazın.

select pr.productname
from product pr
left join Sale sa on pr.productid = sa.productid  
WHERE sa.saledate between add_months(sysdate,-1) and sysdate  and sa.saledate is null;


