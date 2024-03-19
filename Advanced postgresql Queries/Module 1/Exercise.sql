select product_name, category_id, size, price
from inventory.products where price>20;

select * from inventory.products;
--group by clause
select size, count(*)
from inventory.products 
group by size 
having count(*) > 10
order by size desc;

--general purpose aggregate
select product_name,
  count(*) as "number of products",
  max(price) as "highest price",
  max(size) as "largest size",
  min(price) as "lowest price",
  avg(price) as "average price"
from inventory.products
group by product_name;

select * from sales.customers;

--boolean aggregates
select state,count(*), bool_and(newsletter), bool_or(newsletter)
from sales.customers
group by state;

--standard deviation and variance
select * from public.people_heights;

select gender, count(*), avg(height_inches), min(height_inches), max(height_inches),
stddev_samp(height_inches),
stddev_pop(height_inches),
var_samp(height_inches),
var_pop(height_inches)
from public.people_heights
group by gender;

--Using ROLLUP used with group by creates subtotal and grand total
select category_id, product_name,
  count(*) as "number of products",
  max(price) as "highest price",
  min(price) as "lowest price",
  avg(price) as "average price"
from inventory.products
group by rollup(category_id,product_name)
order by category_id,product_name;

--Using CUBE used with group by creates subtotal for each grouped column and grand total
select category_id, size,
  count(*) as "number of products",
  max(price) as "highest price",
  min(price) as "lowest price",
  avg(price) as "average price"
from inventory.products
group by cube(category_id,size)
order by category_id,size;

--segmenting groups with aggregate filters
select category_id,
  count(*) as "Count all",
  avg(price) as "average price",
  --small products
  count(*) filter(where size<=16) as "count small",
  avg(price) filter(where size<=16) as "average price small",
  --large products
  count(*) filter(where size > 16) as "count large",
  avg(price) filter(where size > 16) as "average price large"
from inventory.products
group by rollup (category_id)
order by category_id;



