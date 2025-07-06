DELIMITER //
CREATE PROCEDURE PlaceOrderProcedure(
    IN p_user_id INT,
    IN p_restaurant_id INT
)

BEGIN
    DECLARE total_amount int;
    SELECT SUM(mi.price * ums.quantity) INTO total_amount
    FROM User_Menu_Selection as ums
    JOIN Menu_Items as mi ON ums.item_id = mi.item_id
    WHERE ums.user_id = p_user_id;
    INSERT INTO Orders (user_id, restaurant_id, order_date_time, total_amount)
    VALUES (p_user_id, p_restaurant_id, now(), total_amount);
END//
DELIMITER ;

delimiter //
CREATE PROCEDURE AddUserProcedure(
    IN p_name VARCHAR(100),
    IN p_contact_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_delivery_address VARCHAR(500)
)
BEGIN
    INSERT INTO Users (name, contact_phone, email, delivery_address)
    VALUES (p_name, p_contact_phone, p_email, p_delivery_address);
END //

delimiter //
CREATE PROCEDURE AddRestaurantProcedure(
    IN p_name VARCHAR(100),
    IN p_contact_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_address VARCHAR(500),
    IN p_cuisine_type VARCHAR(100)
)
BEGIN
    INSERT INTO Restaurants (name, contact_phone, email, address, cuisine_type)
    VALUES (p_name, p_contact_phone, p_email, p_address, p_cuisine_type);
END //

delimiter //
CREATE PROCEDURE AddMenuItemProcedure(
    IN p_name VARCHAR(100),
    IN p_description VARCHAR(500),
    IN p_price INT,
    IN p_dietary_information VARCHAR(100)
)
BEGIN
    INSERT INTO Menu_Items (name, description, price, dietary_information)
    VALUES (p_name, p_description, p_price, p_dietary_information);
END //

Delimiter //
CREATE PROCEDURE GetUserFavoriteRestaurantsProcedure
(IN p_user_id INT)
BEGIN
    SELECT DISTINCT r.*
    FROM Restaurants as r
    JOIN Orders as o 
    ON r.restaurant_id = o.restaurant_id
    WHERE o.user_id = p_user_id;
END //
Delimiter ;

 DELIMITER //
CREATE PROCEDURE AddUserMenuSelectionProcedure(
    IN p_user_id INT,
    IN p_selection_date DATETIME,
    IN p_item_ids_list VARCHAR(100) 
)
BEGIN
    INSERT INTO User_Menu_Selection (user_id, item_id, selection_date)
    SELECT p_user_id, item_id, p_selection_date
    FROM Menu_Items
    WHERE FIND_IN_SET(item_id, p_item_ids_list) ;
END//
DELIMITER ;
drop procedure if exists AddUserMenuSelectionProcedure;

Delimiter //
CREATE PROCEDURE GetOrderDetails(
    IN p_order_id INT
)
BEGIN
    SELECT o.order_id, u.name AS user_name, r.name AS restaurant_name,
           o.order_date_time, (mi.price * ums.quantity) as T,
		   mi.name AS item_name , ums.quantity
    FROM users as  u
    JOIN orders as o
    ON o.user_id = u.user_id
    JOIN  restaurants as r 
    ON o.restaurant_id = r.restaurant_id 
    join user_menu_selection as ums
    on ums.user_id = u.user_id
    join menu_items as mi
    on mi.item_id = ums.item_id 
    WHERE o.order_id = p_order_id;
END //
Delimiter ;
drop procedure if exists getorderdetails;

DELIMITER //
CREATE PROCEDURE AddReviewProcedure(
    IN p_user_id INT,
    IN p_restaurant_id INT,
    IN p_rating INT,
    IN p_review_comments VARCHAR(500)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE user_id = p_user_id) AND
       EXISTS (SELECT 1 FROM Restaurants WHERE restaurant_id = p_restaurant_id) THEN
        INSERT INTO Review (user_id, restaurant_id, rating, review_comments)
        VALUES (p_user_id, p_restaurant_id, p_rating, p_review_comments);

        SELECT 'Review added successfully.' AS message;
    ELSE
        SELECT 'User or restaurant not found. Review cannot be added.' AS message;
    END IF;
END;
//
DELIMITER ;
drop procedure if exists addReviewProcedure; 

Delimiter //
create procedure addPayment(
in p_order_id int,
In p_payment_method varchar(30)
)
begin
insert into payment (order_id,payment_date_time,payment_method)values(p_order_id,now(),p_payment_method);
End //
Delimiter ;


DElimiter //
create procedure paymentDone()
Begin
select u.name from users as u
join orders as o
on u.user_id = o.user_id
join payment as p
on o.order_id = p.order_id
where o.order_id in (select order_id from payment);
end //
Delimiter ;
drop procedure if exists paymentdone;

Delimiter //
create procedure RestaurantsByRating()
Begin
select Restaurants.name , round(avg(rating),1) as rating from Restaurants
join review 
on restaurants.restaurant_id = review.restaurant_id
group by Restaurants.name ;
End //
Delimiter ;
drop procedure if exists RestaurantsByRating;

Delimiter //
create procedure itemsSlectByUser 
(
p_user_id int
)
Begin
select users.name as customer_name , menu_items.name as Menu_items 
from users
join user_menu_selection
on users.user_id = user_menu_selection.user_id
join menu_items 
on user_menu_selection.item_id = menu_items.item_id
where users.user_id = p_user_id;
End //
Delimiter ;
Drop procedure if exists itemsSlectByUser;

DELIMITER //
CREATE PROCEDURE GetUsersByDeliveryStatus(
    IN p_delivery_status VARCHAR(50)
)
BEGIN
    SELECT users.name AS customer_name
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN delivery ON orders.order_id = delivery.order_id
    WHERE delivery.delivery_status = p_delivery_status;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertDeliveryProcedure(
    IN p_order_id INT,
    IN p_delivery_status VARCHAR(50)
)
BEGIN  

    DECLARE order_exists INT;
    SELECT COUNT(*) INTO order_exists
    FROM Orders
    WHERE order_id = p_order_id;
    IF order_exists > 0 THEN
        INSERT INTO Delivery (order_id, delivery_date_time, delivery_status)
        VALUES (p_order_id, now(), p_delivery_status);
        SELECT 'Delivery details inserted successfully.' AS message;
    ELSE
        SELECT 'Order not found. Delivery details cannot be inserted.' AS message;
    END IF;
END;
//
DELIMITER ;

drop procedure if exists InsertDeliveryProcedure;