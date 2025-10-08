-- Create Database
CREATE DATABASE OnlineBookstore;

use OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


select * from Books;
select * from Customers;
select * from Orders;


-- 1-Retrieve all books in the "Fiction" genre:
 select * from Books
 where Genre = "Fiction";
 
 
 
 -- 2-Find Books published after the year 1950:
 select * from books
 where Published_Year>1950;
 
 
 
-- 3-list all customers from canada:
select * from Customers
where Country = "Canada";



-- 4-show orders placed in november 2023:
select * from orders
where order_Date >= "2023-11-01"  and order_Date <  "2023-12-01";



-- 5-Retrieve the total stock of books available:
select sum(stock) as total_stock from Books;



-- 6-Find the detail of the most expensive book:
select * from Books
order by Price desc
limit 1;



-- 7-Show all customers who ordered more than 1 quantity of book:
select * from orders
where Quantity > 1;



-- 8-Retrive all orders where the total amount exceeds $20:
select * from orders
where Total_Amount> 20;



-- 9-list all genre available in the books table:
select distinct(Genre) from Books;



-- 10Find the books with lowest stock:
select * from books
order by stock 
limit 1;


-- 11-Calculate the total revenue generated from all orders:
select sum(Total_Amount) as total_revenue from orders;

-- Advanced Questions

-- 1- Retrive the total number of books sold for each genre:
select books.Genre , sum(orders.Quantity) as total_books
from books 
join orders on books.Book_ID = orders.Book_ID
group by books.Genre;




-- 2- Find the average price of books in the "Fantasy" Genre:
select avg(Price) as Fantasy_avg_price from books
where Genre = "Fantasy";



-- 3- List customers who have placed at least 2 orders:
select orders.Customer_Id , customers.name, count(orders.order_id) as order_count
from orders join customers on orders.Customer_ID = customers.Customer_ID
group by Customer_ID , name
having count(order_id) >=2;



-- 4- Find the most frequently ordered books:
select books.Title , orders.Book_ID , count(orders.order_ID) as order_count
from books join orders on books.Book_ID = orders.Book_ID
group by Book_ID , Title
order by order_count desc
limit 1;



-- 5- Show the top 3 most expensive books of "Fantasy" Genre:
select * from books
where Genre = "Fantasy"
order by Price desc
limit 3;



-- 6- Retrieve the total quantity of books sold by each author:
select books.Author ,sum(orders.Quantity) as total_quantity
from books join orders on 
books.Book_ID = orders.Book_Id 
group by Author;



-- 7- List the cities where customers who spent over $30 are located:
select distinct customers.city , (orders.Total_Amount)
from customers join orders on
customers.Customer_ID = orders.Customer_ID
where Total_Amount > 30;



-- 8- Find the customer who spent the most on orders:
select customers.Customer_ID , customers.Name ,  sum(orders.Total_Amount) as orders_total_amount
from customers join orders on
customers.Customer_ID = orders.Customer_ID
group by Customer_ID , Name
order by orders_total_amount desc 
limit 1;



-- 9- Calculate the stock remaining after fulfilling all orders:
select books.Book_ID , books.Title , books.stock , coalesce(sum(orders.Quantity),0) as order_qunatity,
books.stock-  coalesce(sum(orders.Quantity),0) as remaining_quantity
from books left join orders on 
books.Book_ID = orders.Book_ID
group by Book_ID;

