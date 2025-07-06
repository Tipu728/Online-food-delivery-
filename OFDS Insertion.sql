INSERT INTO Users (name, contact_phone, email, delivery_address)
VALUES
    ('Abdul Rehman', '0312-1234567', 'abdul.rehman@example.com', '123 Main Street, Gujranwala'),
    ('Ayesha Ahmed', '0321-9876543', 'ayesha.ahmed@example.com', '456 Park Avenue, Gujranwala'),
    ('Mohammad Ali', '0345-5678910', 'mohammad.ali@example.com', '789 Downtown Road, Gujranwala'),
    ('Sara Khan', '0300-4567890', 'sara.khan@example.com', '321 Industrial Area, Gujranwala'),
    ('Ahmed Raza', '0333-1122334', 'ahmed.raza@example.com', '456 Model Town, Gujranwala'),
    ('Ayesha Malik', '0311-9988776', 'ayesha.malik@example.com', '789 Cantonment, Gujranwala'),
    ('Bilal Butt', '0322-3344556', 'bilal.butt@example.com', '222 Satellite Town, Gujranwala'),
    ('Sana Khan', '0331-2233445', 'sana.khan@example.com', '777 Defense Housing Society, Gujranwala'),
    ('Usman Ali', '0300-1122334', 'usman.ali@example.com', '888 Wapda Town, Gujranwala'),
    ('Sadia Shah', '0313-9876543', 'sadia.shah@example.com', '666 Gulberg, Gujranwala');
    select *from users;
INSERT INTO Restaurants (name, contact_phone, email, address, cuisine_type)
VALUES
    ('Delicious Bites', '0312-1234567', 'info@deliciousbites.com', '123 Main Street, Gujranwala', 'Pakistani'),
    ('Taste of Lahore', '0321-9876543', 'info@tasteoflahore.com', '456 Park Avenue, Gujranwala', 'Pakistani'),
    ('Pizza Express', '0345-5678910', 'info@pizzaexpress.com', '789 Downtown Road, Gujranwala', 'Italian'),
    ('Kebab House', '0300-4567890', 'info@kebabhouse.com', '321 Industrial Area, Gujranwala', 'Pakistani'),
    ('Spicy Bites', '0333-1122334', 'info@spicybites.com', '456 Model Town, Gujranwala', 'Pakistani'),
    ('Chop Chop Chinese', '0311-9988776', 'info@chopchopchinese.com', '789 Cantonment, Gujranwala', 'Chinese'),
    ('Biryani Express', '0322-3344556', 'info@biryaniexpress.com', '222 Satellite Town, Gujranwala', 'Pakistani'),
    ('Sizzlers BBQ', '0331-2233445', 'info@sizzlersbbq.com', '777 Defense Housing Society, Gujranwala', 'Pakistani'),
    ('Fiesta Mexican', '0300-1122334', 'info@fiestamexican.com', '888 Wapda Town, Gujranwala', 'Mexican'),
    ('Juicy Burgers', '0313-9876543', 'info@juicyburgers.com', '666 Gulberg, Gujranwala', 'Fast Food');
select *from Restaurants;
AlTER table  orders
modify column total_amount int not null ;
INSERT INTO Menu_Items (name, description, price, dietary_information)
VALUES
    ('Biryani', 'Aromatic rice dish with spiced meat or vegetables.', 250, 'Non-vegetarian'),
    ('Nihari', 'Slow-cooked spicy stew made from beef or mutton.', 180, 'Non-vegetarian'),
    ('Haleem', 'Thick, spicy stew made from wheat, lentils, and meat.', 150, 'Non-vegetarian'),
    ('Seekh Kebab', 'Grilled minced meat skewers.', 120, 'Non-vegetarian'),
    ('Chapli Kebab', 'Flat, round-shaped kebabs made with minced meat.', 130, 'Non-vegetarian'),
    ('Samosa', 'Deep-fried pastry filled with spiced potatoes or minced meat.', 30, 'Vegetarian'),
    ('Pakora', 'Deep-fried fritters made with gram flour and various vegetables.', 100, 'Vegetarian'),
    ('Chana Chaat', 'Chickpea salad with spices and tangy tamarind sauce.', 120, 'Vegetarian'),
    ('Aloo Tikki', 'Fried potato patties served with chutney.', 110, 'Vegetarian'),
    ('Gajar Halwa', 'Carrot-based sweet dessert.', 140, 'Vegetarian');
    select *from menu_items;
   
insert into orders (user_id,restaurant_id,order_date_time,total_amount)
values(2,2,Now(),700);
insert into orders (user_id,restaurant_id,order_date_time,total_amount)
values(1,1,Now(),500);

call AddUserMenuSelectionProcedure (5,'2023-2-2 2:02:12','5' );
call AddUserMenuSelectionProcedure (2,'2023-2-2 2:02:12','1,4,3' );
call AddUserMenuSelectionProcedure (3,'2023-2-2 2:02:12','1,10,4,7' );
call AddUserMenuSelectionProcedure (4,'2023-2-2 2:02:12','1,2,3,4' );
call GetUserFavoriteRestaurantsProcedure(1);
select *from orders;
truncate table orders;
rollback;
alter table user_menu_selection
add column quanitiy int not null;
update user_menu_selection
set quantity = 1
where selection_id <=15 ;
update user_menu_selection
set quantity = 3
where user_id = 3;
alter table user_menu_selection
change quanitiy quantity int ;


DELIMITER //
CREATE TRIGGER AutoSetQuantityToOne
BEFORE INSERT ON User_Menu_Selection
FOR EACH ROW
BEGIN
    SET NEW.quantity = 1;
END;
//
DELIMITER ;

update user_menu_selection
set quantity = 1 
where selection_id = 9;