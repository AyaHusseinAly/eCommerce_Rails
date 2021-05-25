# eCommerce Ruby on Rails Project Preview

## Database Structure (ERD)
![](preview/WhatsApp%20Image%202021-05-13%20at%204.06.55%20AM.jpeg)

## Steps to run project in development mode 
#### </ins>First:</ins> install npm in your machine
#### <ins> Second:</ins>install ruby on your machine
#### <ins>Third:</ins>install rails on your machine
#### <ins> Fourth:</ins> install sqlite3 or postgres in your machine 
#### Then run these commands:
##### >>    bundle install
##### >>    rails db:create
##### >>    rails db:migrate
##### >>   rails db:seed
##### >>    rails  s 
To login as a buyer or seller  visit url: http://localhost:3000 <br/>
To login as an admin or seller visit url: http://localhost:3000/admin

##### Username and password for Admin:
Email: admin@example.com                      Password: password
##### Username and password for seller
Email: seller@example.com                     Password: password

to test user model : rails t test/models/user_test.rb

## Home Page
![](preview/1-homePage.png)

## Product Page
![](preview/2-productShow.png)

### only buyer who purchased the product can review it
![](preview/no_purchase_no_review.PNG)

### buyer can review only once
![](preview/already_reviewed.PNG)

## Cart Items
![](preview/cart.png)

### in case of no cart items
![](preview/noCartItems.png)

## Order status notification
### Notifying buyer when his order confirmed
![](preview/orderconfirmed.PNG)

### Notifying buyer when his order delivered
![](preview/orderDelivered.PNG)

## My Orders
![](preview/my_orders.png)

### in case of no orders yet
![](preview/no_orders_yet.png)

## Wishing List Items
![](preview/wishingList.png)

### in case of no wishing list items items
![](preview/noWishItems.png)

## profile
![](preview/profile.png)



### Design patterns  
#### Query Objects
Query Object a type of design patterns in rails that lets us fetch query logic from Controllers and Models into reusable classes.
#### Form Objects
The form object is a design pattern that is used to encapsulate the code related to validation and persisting data into a single unit.

