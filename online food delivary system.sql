/* 
ProjectName : Online Food Delivary System
Represnt by : AliHaiderTipu
              Zaeem Asghar
RollNumber : 21011519-035
			 21011519-028
*/
drop database online_food_delivary_system;
create database online_food_delivary_system;
use online_food_delivary_system;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) ,
    contact_phone VARCHAR(20) ,
    email VARCHAR(100) ,
    delivery_address VARCHAR(500) 
);
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) ,
    contact_phone VARCHAR(20) ,
    email VARCHAR(100) ,
    address VARCHAR(500) ,
    cuisine_type VARCHAR(100)
);
CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) ,
    description VARCHAR(500),
    price DECIMAL(10, 2) ,
    dietary_information VARCHAR(100)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT ,
    restaurant_id INT ,
    order_date_time DATETIME,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT ,
    payment_date_time DATETIME ,
    payment_method VARCHAR(100) ,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    delivery_date_time DATETIME  ,
    delivery_status VARCHAR(100) ,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT ,
    restaurant_id INT ,
    rating INT ,
    review_comments VARCHAR(500),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);
CREATE TABLE User_Menu_Selection (
    selection_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    item_id INT,
    selection_date DATETIME NOT NULL,
    quantity INT,
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (item_id)
        REFERENCES Menu_Items (item_id)
);
