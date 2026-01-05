create database SHOPPING_MALL_MANAGEMENT_SYSTEM;

use SHOPPING_MALL_MANAGEMENT_SYSTEM;

-- To design and analyze shopping mall database that manages:
-- Staff details 
-- Salaries
-- Clothes inventory
-- Daily sales
-- Monthly sales report
   
  -- staff table

create table staff (
	staff_id int primary key,
    staff_name varchar(50),
    role varchar(30),
    department varchar(30),
    join_date date);
    
insert into staff
(staff_id, staff_name, role, department, join_date)
values
   (1, "Rahul sharma", "Sales executive", "Clothing", '2021-03-15'),
   (2, "Anjali verma", "Cashier", "Billing", '2020-07-22'),
   (3, "Amit singh", "Store manager", "Management", '2020-01-10'),
   (4, "Neha gupta", "Sales executive", "Clothing", '2022-06-18'),
   (5, "Rohit meena", "Inventory manager", "Warehouse", '2021-11-05'),
   (6, "Pooja patel", "Customer support", "Help desk", '2023-02-12'),
   (7, "Vikas kumar", "Security guard", "Security", '2020-09-30'),
   (8, "Snesha iyer", "Visual merchandiser", "Marketing", '2022-04-25'),
   (9, "Arjun malhotra", "Senior cashier", "Billing", '2019-08-14'),
   (10, "Kiran joshi", "Sales supervisor", "Clothing", '2021-12-01');

select * from staff;
   
select staff_name, role
from staff
where department = "clothing";
   
select staff_name, join_date
from staff 
where join_date > '2021-01-01';

select department, count(*) as
totall_staff
from staff
group by department;

-- salary table
   
create table salary (
	salary_id int primary key,
    staff_id int,
    basic_salary int,
	bonus int,
    total_salary int,
foreign key (staff_id) 
references staff(staff_id));

insert into salary
(salary_id, staff_id, basic_salary, bonus, total_salary)
values
   (1001, 1, 18000, 2000, 20000),
   (1002, 2, 15000, 1500, 16500),
   (1003, 3, 35000, 5000, 40000),
   (1004, 4, 17000, 1800, 18800),
   (1005, 5, 28000, 3000, 31000), 
   (1006, 6, 16000, 1200, 17200),
   (1007, 7, 14000, 1000, 15000),
   (1008, 8, 22000, 2500, 24500),
   (1009, 9, 20000, 2200, 22200),
   (1010, 10, 25000, 2800, 27800);

select * from salary;

select * from salary 
where staff_id = 3;

select sum(total_salary) as
paid_total_salary
from salary
where basic_salary > 20000;

select avg(basic_salary) as
avg_basic_salary
from salary;

select max(basic_salary) as
max_basic_salary
from salary;

select min(basic_salary) as
min_basic_salary
from salary;

-- clothes table
   
create table clothes ( 
    cloth_id int primary key,
    cloth_name varchar (50),
    category varchar(30),
    price int,
    stock_quantity int);

insert into clothes 
(cloth_id, cloth_name, category, price, stock_quantity)
values
   (1, "Men cotton t-shirt", "Men", 799, 120),
   (2, "Women printed kurti", "Women", 1299, 90),
   (3, "Kids denim jeans", "Kids", 999, 70),
   (4, "Men formal shirt", "Men", 1499, 60),
   (5, "Womwn part dress", "Women", 2499, 40),
   (6, "Kids hoodie jacket", "Kids", 1799, 50),
   (7, "Men casual jeans", "Men", 1999, 85),
   (8, "Womwn silk saree", "Women", 4999, 30),
   (9, "Unisex sports jacket", "Unisex", 2999, 55),
   (10, "Kids summer shorts", "Kids", 599, 100);

select * from clothes;

select cloth_name, price
from clothes
where category = "Women";

select cloth_id, cloth_name, stock_quantity
from clothes
where stock_quantity < 60;

select category, avg(price) as
avg_price
from clothes
group by category;

-- daily_sales table

create table daily_sales (
    sale_id int primary key,
    sale_date date,
    cloth_id int,
    quantity_sold int,
    total_amount int,
	staff_id int,
foreign key (cloth_id) references
clothes(cloth_id),
foreign key (staff_id) references
staff(staff_id)
);

insert into daily_sales
(sale_id, sale_date, cloth_id, quantity_sold, total_amount, staff_id)
values
   (201, '2025-12-01', 1, 2, 2397, 1),
   (202, '2025-12-01', 2, 2, 2598, 2),
   (203, '2025-12-01', 4, 1, 1499, 4),
   (204, '2025-12-02', 3, 2, 1998, 1),
   (205, '2025-12-02', 7, 1, 1999, 10),
   (206, '2025-12-02', 5, 1, 2499, 7),
   (207, '2025-12-03', 6, 2, 3598, 4),
   (208, '2025-12-03', 8, 1, 4999, 9),
   (209, '2025-12-03', 10, 4, 2396, 6),
   (210, '2025-12-04', 9, 2, 5998, 8);

select * from daily_sales;

select sale_date, sum(total_amount) as
daily_total_amount
from daily_sales
group by sale_date;

select cloth_id, sum(quantity_sold) as
total_quantity
from daily_sales
group by cloth_id;

select * 
from daily_sales
where staff_id = 1;

-- monthly_sales table

create table monthly_sales (
    month varchar(20),
    total_sales int,
    total_item_sold int);

insert into monthly_sales
(month, total_sales, total_item_sold)
values
   ("January", 185000, 220),
   ("February", 172500, 205),
   ("March", 198300, 240),
   ("April", 165400, 210),
   ("May", 210750, 260),
   ("June", 225900, 280),
   ("August", 238400, 295),
   ("September", 205300, 250),
   ("October", 260800, 320),
   ("November", 290450, 360),
   ("December", 325900, 410);

select * from monthly_sales;

select * 
from monthly_sales
order by total_sales desc
limit 1;

select avg(total_sales) as
acg_monthly_sales
from monthly_sales;

-- join queries

select s.staff_name, d.sale_date, d.total_amount
from daily_sales as d
join staff as s 
on d.staff_id = s.staff_id
order by d.total_amount desc;

select cloth_name, quantity_sold
from daily_sales as d
join clothes as c
on c.cloth_id = d.cloth_id;

select s.staff_name, salary_id, total_salary
from salary as sa
join staff as s
on sa.staff_id = s.staff_id;

-- Best selling cloth

select c.cloth_name,
sum(d.quantity_sold) as total_sold
from daily_sales as d
join clothes as c 
on d.cloth_id = c.cloth_id
group by c.cloth_name
order by total_sold desc
limit 1;

-- Top performing staff

select s.staff_name,
sum(d.total_amount) as total_sales
from daily_sales as d
join staff as s
on s.staff_id = d.staff_id
group by s.staff_name
order by total_sales desc
limit 3;



































































































































































































