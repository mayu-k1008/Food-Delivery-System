create database Food_delivery_system;
use Food_delivery_system;
create table customer(
cust_id int primary key,
cust_name varchar(200),
cust_address varchar(200),
cust_phone_no varchar(10),
cust_email varchar(200) unique
);
create table restaurant(
rest_id int primary key,
rest_name varchar(200),
rest_location varchar(200),
cuisine_type varchar(200),
contact_info varchar(200),
rest_rating float,
status varchar(100)
);
create table menu(
menu_id int primary key,
rest_id int ,
dish_name varchar(200),
price float,
description varchar(200),
foreign key(rest_id) references restaurant(rest_id) on delete cascade
);
create table orders(
order_id int primary key,
cust_id int,
foreign key(cust_id) references customer(cust_id) on delete cascade,
rest_id int ,
order_date datetime,
total_amount float,
status enum("pending", "inproces", "delivered","cancel")
);

create table Order_details(
order_detail_id int primary key,
order_id int,
menu_id int,
foreign key(order_id) references orders(order_id) on delete cascade,
foreign key(menu_id) references menu(menu_id) on delete cascade,
Quantity int,
price float
);

create table Delivery_person(
delivery_personId int primary key,
name varchar(200), 
contact int,
vehical_no varchar(200)
);
ALTER TABLE Delivery_person
MODIFY contact varchar(10);

create table Delivery(
del_id int primary key,
order_id int,
delivery_personId int,
foreign key(order_id) references orders(order_id) on delete cascade,
foreign key(delivery_personId) references Delivery_person(delivery_personId) on delete cascade,
deliver_address varchar(200),
deliver_status enum("pending", "inproces", "delivered","cancel"),
estimated_time time
);

create table Payment(
payment_id int primary key,
order_id int,
foreign key(order_id) references orders(order_id) on delete cascade,
payment_mode enum('online','cash on delivery'),
amount float,
payment_status enum( "paid", "unpaid")
);
create table review(
review_id int primary key,
cust_id int,
rest_id int,
foreign key(cust_id) references customer(cust_id) on delete cascade,
foreign key(rest_id) references restaurant(rest_id) on delete cascade,
ratings float,
comments varchar(500),
review_date date
);
INSERT INTO customer (cust_id, cust_name, cust_address, cust_phone_no, cust_email)
VALUES
(1, 'John Doe', '123 Main Street, Mumbai', '1234567890', 'john.doe@example.com'),
(2, 'Jane Smith', '456 Park Avenue, Pune', '0987654321', 'jane.smith@example.com'),
(3, 'Bob Johnson', '789 River Road, Nagpur', '1122334455', 'bob.johnson@example.com'),
(4, 'Alice Brown', '101 Hill Street, Nashik', '5566778899', 'alice.brown@example.com'),
(5, 'Charlie Davis', '202 Lake View, Aurangabad', '6677889900', 'charlie.davis@example.com');

INSERT INTO restaurant (rest_id, rest_name, rest_location, cuisine_type, contact_info, rest_rating, status)
VALUES
(1, 'Spice Garden', 'Mumbai', 'Indian', '022-12345678', 4.5, 'Open'),
(2, 'Pizza Haven', 'Pune', 'Italian', '020-87654321', 4.0, 'Open'),
(3, 'Sushi World', 'Nagpur', 'Japanese', '0712-6543210', 4.7, 'Open'),
(4, 'Burger Town', 'Nashik', 'American', '0253-1122334', 4.2, 'Open'),
(5, 'Taco Fiesta', 'Aurangabad', 'Mexican', '0240-2233445', 4.3, 'Open'),
(6, 'French Delight', 'Kolhapur', 'French', '0231-3344556', 4.6, 'Open'),
(7, 'Curry House', 'Thane', 'Indian', '022-5566778', 3.9, 'Closed'),
(8, 'Dragon Palace', 'Solapur', 'Chinese', '0217-4455667', 4.4, 'Open'),
(9, 'Mediterranean Bliss', 'Satara', 'Mediterranean', '02162-778899', 4.1, 'Open'),
(10, 'BBQ Central', 'Mumbai', 'American', '022-9988776', 4.8, 'Closed');
select * from restaurant;
INSERT INTO menu (menu_id, rest_id, dish_name, price, description)
VALUES
(1, 1, 'Paneer Butter Masala', 250.00, 'Delicious Indian cottage cheese curry'),
(2, 2, 'Margherita Pizza', 300.00, 'Classic Italian pizza with tomatoes and cheese'),
(3, 3, 'Sushi Roll', 500.00, 'Fresh sushi roll with salmon and avocado'),
(4, 4, 'Cheeseburger', 200.00, 'Juicy beef burger with cheddar cheese'),
(5, 5, 'Tacos', 150.00, 'Crispy Mexican tacos with beef and salsa'),
(6, 6, 'Quiche Lorraine', 350.00, 'French tart with bacon, cheese, and eggs'),
(7, 1, 'Chicken Curry', 220.00, 'Spicy Indian chicken curry'),
(8, 8, 'Kung Pao Chicken', 280.00, 'Spicy Chinese chicken with peanuts'),
(9, 9, 'Falafel', 180.00, 'Crispy Mediterranean chickpea balls'),
(10, 10, 'BBQ Ribs', 450.00, 'Slow-cooked American BBQ pork ribs');
INSERT INTO orders (order_id, cust_id, rest_id, order_date, total_amount, status)
VALUES
(1, 1, 1, '2025-02-19 12:30:00', 500.00, 'delivered'),
(2, 2, 2, '2025-02-19 13:00:00', 600.00, 'pending'),
(3, 3, 3, '2025-02-19 14:00:00', 1000.00, 'inproces'),
(4, 4, 4, '2025-02-19 15:30:00', 800.00, 'cancel'),
(5, 5, 5, '2025-02-19 16:00:00', 350.00, 'delivered');
INSERT INTO Order_details (order_detail_id, order_id, menu_id, Quantity, price)
VALUES
(1, 1, 1, 2, 500.00),
(2, 2, 2, 1, 300.00),
(3, 3, 3, 2, 1000.00),
(4, 4, 4, 4, 800.00),
(5, 5, 5, 3, 350.00);
INSERT INTO Delivery_person (delivery_personId, name, contact, vehical_no)
VALUES
(1, 'Rajesh Kumar', 9876543210, 'MH12AB1234'),
(2, 'Anita Sharma', 9876543211, 'MH14CD5678'),
(3, 'Sunil Patil', 9876543212, 'MH16EF9012'),
(4, 'Priya Desai', 9876543213, 'MH18GH3456'),
(5, 'Amit Joshi', 9876543214, 'MH20IJ7890');

INSERT INTO Delivery (del_id, order_id, delivery_personId, deliver_address, deliver_status, estimated_time)
VALUES
(1, 1, 1, '123, Main Street, Mumbai', 'delivered', '00:45:00'),
(2, 2, 2, '456, Park Avenue, Pune', 'pending', '00:30:00'),
(3, 3, 3, '789, River Road, Nagpur', 'inproces', '01:00:00'),
(4, 4, 4, '101, Hill Street, Nashik', 'cancel', '00:50:00'),
(5, 5, 5, '202, Lake View, Aurangabad', 'delivered', '00:40:00');
INSERT INTO Payment (payment_id, order_id, payment_mode, amount, payment_status)
VALUES
(1, 1, 'online', 500.00, 'paid'),
(2, 2, 'cash on delivery', 600.00, 'unpaid'),
(3, 3, 'online', 1000.00, 'paid'),
(4, 4, 'cash on delivery', 800.00, 'unpaid'),
(5, 5, 'online', 350.00, 'paid');
INSERT INTO review (review_id, cust_id, rest_id, ratings, comments, review_date)
VALUES
(1, 1, 1, 4.5, 'Excellent food!', '2025-02-19'),
(2, 2, 2, 4.0, 'Great taste', '2025-02-19'),
(3, 3, 3, 4.7, 'Loved the sushi', '2025-02-19'),
(4, 4, 4, 3.8, 'Burger was average', '2025-02-19'),
(5, 5, 5, 4.3, 'Tacos were delicious', '2025-02-19');
select *from customer;
select *from restaurant;
SELECT o.order_id, c.cust_name AS customer, r.rest_name AS restaurant, o.total_amount, o.status AS order_status, o.order_date AS order_time
FROM orders o
JOIN customer c ON o.cust_id = c.cust_id
JOIN restaurant r ON o.rest_id = r.rest_id;
SELECT od.order_detail_id, m.dish_name AS menu_item, od.Quantity, od.price
FROM Order_details od
JOIN menu m ON od.menu_id = m.menu_id
WHERE od.order_id = 1;

SELECT * FROM Payment WHERE payment_status = 'paid';
