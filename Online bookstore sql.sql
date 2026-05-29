CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;


-- Tables: Books, Authors, Categories, Customers, Orders, OrderDetails, Payments

-- Table 1: Authors (basic info about book authors)
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Categories (book genres / categories)

CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 3: Books (each row is a book in the store)
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    description TEXT,
    published_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Table 4: Customers (people who buy books)
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    membership_type ENUM('Regular', 'Premium', 'VIP') DEFAULT 'Regular',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 5: Orders (one row per order)
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Pending', 'Paid', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    payment_status ENUM('Unpaid', 'Paid', 'Refunded') DEFAULT 'Unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Table 6: OrderDetails (line items inside an order)
CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Table 7: Payments (payments for orders)
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Cash on Delivery') NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100),
    status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);


INSERT INTO Authors (first_name, last_name, email, bio) VALUES
('J.K.', 'Rowling', 'jk.rowling@email.com', 'British author, best known for the Harry Potter series'),
('George', 'Orwell', 'george.orwell@email.com', 'English novelist and essayist, known for dystopian fiction'),
('Jane', 'Austen', 'jane.austen@email.com', 'English novelist known for social commentary and romance'),
('Stephen', 'King', 'stephen.king@email.com', 'American author of horror and suspense novels'),
('Agatha', 'Christie', 'agatha.christie@email.com', 'English writer known for detective novels'),
('Ernest', 'Hemingway', 'ernest.hemingway@email.com', 'American novelist and short story writer'),
('Mark', 'Twain', 'mark.twain@email.com', 'American writer, humorist, and lecturer'),
('Charles', 'Dickens', 'charles.dickens@email.com', 'English writer and social critic'),
('Emily', 'Bronte', 'emily.bronte@email.com', 'English novelist and poet'),
('F. Scott', 'Fitzgerald', 'fitzgerald@email.com', 'American novelist known for The Great Gatsby');


INSERT INTO Categories (category_name, description) VALUES
('Fiction', 'Works of imaginative narration and storytelling'),
('Non-Fiction', 'Factual and informative works based on real events'),
('Mystery', 'Detective and crime stories with puzzles to solve'),
('Horror', 'Scary and suspenseful stories designed to frighten'),
('Romance', 'Love and relationship stories'),
('Classic', 'Timeless literary works of historical significance'),
('Science Fiction', 'Futuristic and speculative fiction'),
('Fantasy', 'Magical and supernatural elements in fictional worlds');

INSERT INTO Books (title, isbn, author_id, category_id, price, stock_quantity, description, published_date) VALUES
('Harry Potter and the Philosopher\'s Stone', '978-0747532699', 1, 8, 12.99, 50, 'The first book in the Harry Potter series', '1997-06-26'),
('1984', '978-0451524935', 2, 1, 9.99, 30, 'A dystopian social science fiction novel', '1949-06-08'),
('Pride and Prejudice', '978-0141439518', 3, 5, 8.99, 25, 'A romantic novel of manners', '1813-01-28'),
('The Shining', '978-0307743657', 4, 4, 14.99, 40, 'A horror novel about a haunted hotel', '1977-01-28'),
('Murder on the Orient Express', '978-0062693662', 5, 3, 11.99, 35, 'A detective novel featuring Hercule Poirot', '1934-01-01'),
('The Old Man and the Sea', '978-0684801223', 6, 6, 10.99, 20, 'A short novel about an aging fisherman', '1952-09-01'),
('The Adventures of Tom Sawyer', '978-0486400778', 7, 6, 9.99, 28, 'A classic American novel about a young boy', '1876-12-01'),
('Harry Potter and the Chamber of Secrets', '978-0747538493', 1, 8, 12.99, 45, 'The second book in the Harry Potter series', '1998-07-02'),
('Animal Farm', '978-0451526342', 2, 1, 8.99, 32, 'An allegorical novella about farm animals', '1945-08-17'),
('It', '978-1501142970', 4, 4, 16.99, 38, 'A horror novel about a shape-shifting monster', '1986-09-15'),
('Wuthering Heights', '978-0141439556', 9, 5, 9.99, 22, 'A tale of passion and revenge', '1847-12-01'),
('The Great Gatsby', '978-0743273565', 10, 1, 10.99, 27, 'A classic American novel about the Jazz Age', '1925-04-10'),
('A Tale of Two Cities', '978-0486406510', 8, 6, 9.99, 30, 'A historical novel set during the French Revolution', '1859-11-26');

INSERT INTO Customers (first_name, last_name, email, phone, address, membership_type) VALUES
('John', 'Doe', 'john.doe@email.com', '555-0101', '123 Main St, City, State 12345', 'Regular'),
('Jane', 'Smith', 'jane.smith@email.com', '555-0102', '456 Oak Ave, City, State 12345', 'Premium'),
('Bob', 'Johnson', 'bob.johnson@email.com', '555-0103', '789 Pine Rd, City, State 12345', 'VIP'),
('Alice', 'Williams', 'alice.williams@email.com', '555-0104', '321 Elm St, City, State 12345', 'Regular'),
('Charlie', 'Brown', 'charlie.brown@email.com', '555-0105', '654 Maple Dr, City, State 12345', 'Premium'),
('Diana', 'Prince', 'diana.prince@email.com', '555-0106', '987 Cedar Ln, City, State 12345', 'VIP'),
('Michael', 'Jordan', 'michael.jordan@email.com', '555-0107', '111 Sports Ave, City, State 12345', 'Regular'),
('Sarah', 'Connor', 'sarah.connor@email.com', '555-0108', '222 Future St, City, State 12345', 'Premium');


-- View - "Available books by category"
CREATE OR REPLACE VIEW AvailableBooksByCategory AS
SELECT 
c.category_name,
b.book_id,
b.title,
CONCAT(a.first_name, ' ', a.last_name) AS author_name,
b.price,
b.stock_quantity,
b.description,
b.isbn
FROM 
    
Books b
INNER JOIN Categories c ON b.category_id = c.category_id
INNER JOIN Authors a ON b.author_id = a.author_id
WHERE 
b.stock_quantity > 0
ORDER BY 
c.category_name, b.title;

--  UDF - "Calculate discount based on membership"
-- This function calculates discount percentage based on customer membership type
-- Returns: 0.00 for Regular, 10.00 for Premium, 20.00 for VIP
DELIMITER $$

CREATE FUNCTION CalculateMembershipDiscount(membership VARCHAR(20))
RETURNS DECIMAL(5, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
DECLARE discount DECIMAL(5, 2);
    
CASE membership
WHEN 'Regular' THEN SET discount = 0.00;
WHEN 'Premium' THEN SET discount = 10.00;
WHEN 'VIP' THEN SET discount = 20.00;
ELSE SET discount = 0.00;
END CASE;
    
RETURN discount;
END$$

DELIMITER ;

-- SP - "Place order, update inventory"
-- Two stored procedures: PlaceOrder (places order and updates inventory), UpdateInventory (updates book stock)

DELIMITER $$

CREATE PROCEDURE PlaceOrder(
IN p_customer_id INT,
IN p_book_id INT,
IN p_quantity INT,
OUT p_order_id INT,
OUT p_message VARCHAR(255)
)
BEGIN
DECLARE v_stock INT;
DECLARE v_price DECIMAL(10, 2);
DECLARE v_membership VARCHAR(20);
DECLARE v_discount DECIMAL(5, 2);
DECLARE v_subtotal DECIMAL(10, 2);
DECLARE v_total DECIMAL(10, 2);
DECLARE v_new_order_id INT;
    
    SELECT stock_quantity, price INTO v_stock, v_price
    FROM Books 
    WHERE book_id = p_book_id;
    
    IF v_stock IS NULL THEN
        SET p_message = 'Book not found';
        SET p_order_id = 0;
    ELSEIF v_stock < p_quantity THEN
        SET p_message = CONCAT('Insufficient stock. Available: ', v_stock);
        SET p_order_id = 0;
    ELSE
        SELECT membership_type INTO v_membership
        FROM Customers 
        WHERE customer_id = p_customer_id;
        
        SET v_discount = CalculateMembershipDiscount(v_membership);
        
        SET v_subtotal = v_price * p_quantity;
        SET v_total = v_subtotal * (1 - v_discount / 100);
        
        INSERT INTO Orders (customer_id, total_amount, status, payment_status)
        VALUES (p_customer_id, v_total, 'Pending', 'Unpaid');
        
        SET v_new_order_id = LAST_INSERT_ID();
        
        INSERT INTO OrderDetails (order_id, book_id, quantity, unit_price, subtotal)
        VALUES (v_new_order_id, p_book_id, p_quantity, v_price, v_subtotal);
        
        UPDATE Books 
        SET stock_quantity = stock_quantity - p_quantity
        WHERE book_id = p_book_id;
        
        SET p_order_id = v_new_order_id;
        SET p_message = CONCAT('Order placed successfully. Order ID: ', v_new_order_id, 
                              ', Total: $', v_total, 
                              ', Discount: ', v_discount, '%');
END IF;
END$$

DELIMITER ;

-- STORED PROCEDURE 2: UpdateInventory
-- This procedure updates the stock quantity for a book
-- Can add stock (positive quantity) or remove stock (negative quantity)
DELIMITER $$

CREATE PROCEDURE UpdateInventory(
    IN p_book_id INT,
    IN p_quantity_change INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_current_stock INT;
    DECLARE v_new_stock INT;
    
    -- Get current stock quantity
    SELECT stock_quantity INTO v_current_stock
    FROM Books 
    WHERE book_id = p_book_id;
    
    -- Validate book exists
    IF v_current_stock IS NULL THEN
        SET p_message = 'Book not found';
    ELSE
        -- Calculate new stock quantity
        SET v_new_stock = v_current_stock + p_quantity_change;
        
        -- Validate new stock won't be negative
        IF v_new_stock < 0 THEN
            SET p_message = CONCAT('Insufficient stock. Current: ', v_current_stock, 
                                  ', Requested change: ', p_quantity_change);
        ELSE
            -- Update stock quantity
            UPDATE Books 
            SET stock_quantity = v_new_stock
            WHERE book_id = p_book_id;
            
 SET p_message = CONCAT('Inventory updated. New stock: ', v_new_stock);
 END IF;
 END IF;
END$$

DELIMITER ;

--  EVENT - Auto-remove Unpaid Orders After 48 Hours
-- This event automatically removes unpaid orders after 48 hours
-- Runs every hour to check for and delete old unpaid orders

-- Enable event scheduler (
SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT IF NOT EXISTS AutoRemoveUnpaidOrders
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    DECLARE deleted_count INT;
    
    -- Delete unpaid orders older than 48 hours
    -- CASCADE will automatically delete related OrderDetails
    DELETE FROM Orders 
    WHERE payment_status = 'Unpaid'
    AND status = 'Pending'
    AND created_at < DATE_SUB(NOW(), INTERVAL 48 HOUR);
    
    -- Get count of deleted rows 
    SET deleted_count = ROW_COUNT();
END$$

DELIMITER ;

-- User Roles - Admin, Seller, Customer
-- Create three user roles with appropriate privileges


-- ROLE 1: Admin
-- Full access to all tables and operations
CREATE USER IF NOT EXISTS 'bookstore_admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'bookstore_admin'@'localhost';

-- ROLE 2: Seller
-- Can manage books, authors, categories, and view orders
-- Can execute UpdateInventory procedure
CREATE USER IF NOT EXISTS 'bookstore_seller'@'localhost' IDENTIFIED BY 'seller123';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.Books TO 'bookstore_seller'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.Authors TO 'bookstore_seller'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.Categories TO 'bookstore_seller'@'localhost';
GRANT SELECT ON bookstore_db.Orders TO 'bookstore_seller'@'localhost';
GRANT SELECT ON bookstore_db.OrderDetails TO 'bookstore_seller'@'localhost';
GRANT EXECUTE ON PROCEDURE bookstore_db.UpdateInventory TO 'bookstore_seller'@'localhost';

-- ROLE 3: Customer
-- Can view books and place orders
-- Can execute PlaceOrder procedure
CREATE USER IF NOT EXISTS 'bookstore_customer'@'localhost' IDENTIFIED BY 'customer123';
GRANT SELECT ON bookstore_db.Books TO 'bookstore_customer'@'localhost';
GRANT SELECT ON bookstore_db.Authors TO 'bookstore_customer'@'localhost';
GRANT SELECT ON bookstore_db.Categories TO 'bookstore_customer'@'localhost';
GRANT SELECT ON bookstore_db.AvailableBooksByCategory TO 'bookstore_customer'@'localhost';
GRANT SELECT, INSERT ON bookstore_db.Orders TO 'bookstore_customer'@'localhost';
GRANT SELECT, INSERT ON bookstore_db.OrderDetails TO 'bookstore_customer'@'localhost';
GRANT EXECUTE ON PROCEDURE bookstore_db.PlaceOrder TO 'bookstore_customer'@'localhost';

-- Apply privileges
FLUSH PRIVILEGES;

-- VERIFICATION AND SUMMARY
-- Display summary of all created components

SELECT 'ONLINE BOOKSTORE MANAGEMENT SYSTEM - SETUP COMPLETE ' AS Status;

SELECT 
    'Tables Created' AS Component,
    COUNT(*) AS Count
FROM information_schema.tables 
WHERE table_schema = 'bookstore_db' 
AND table_type = 'BASE TABLE'

UNION ALL

SELECT 
    'Views Created',
    COUNT(*)
FROM information_schema.views 
WHERE table_schema = 'bookstore_db'

UNION ALL

SELECT 
    'Stored Procedures Created',
    COUNT(*)
FROM information_schema.routines 
WHERE routine_schema = 'bookstore_db' 
AND routine_type = 'PROCEDURE'

UNION ALL

SELECT 
    'Functions Created',
    COUNT(*)
FROM information_schema.routines 
WHERE routine_schema = 'bookstore_db' 
AND routine_type = 'FUNCTION'

UNION ALL

SELECT 
    'Events Created',
    COUNT(*)
FROM information_schema.events 
WHERE event_schema = 'bookstore_db'

UNION ALL

SELECT 
    'Users Created',
    COUNT(*)
FROM mysql.user 
WHERE user LIKE 'bookstore_%';

-- Display sample data counts
SELECT 
    (SELECT COUNT(*) FROM Authors) AS Authors_Count,
    (SELECT COUNT(*) FROM Categories) AS Categories_Count,
    (SELECT COUNT(*) FROM Books) AS Books_Count,
    (SELECT COUNT(*) FROM Customers) AS Customers_Count,
    'Sample data loaded successfully!' AS Status;

-- Display user credentials
SELECT 
    '=== USER CREDENTIALS ===' AS Info;

SELECT 
    'bookstore_admin' AS Username,
    'admin123' AS Password,
    'Admin - Full access' AS Role
UNION ALL
SELECT 
    'bookstore_seller',
    'seller123',
    'Seller - Manage books'
UNION ALL
SELECT 
    'bookstore_customer',
    'customer123',
    'Customer - Browse and order';

-- REQUIREMENTS CHECKLIST
-- 7 Tables: Books, Authors, Categories, Customers, Orders, OrderDetails, Payments
-- View: AvailableBooksByCategory (Available books by category)
-- Stored Procedure: PlaceOrder (Place order, update inventory)
-- Stored Procedure: UpdateInventory (Update inventory)
-- Event: AutoRemoveUnpaidOrders (Auto-remove unpaid orders after 48 hours)
-- User-Defined Function: CalculateMembershipDiscount (Calculate discount based on membership)
-- User Roles: Admin, Seller, Customer

SELECT 'All requirements have been successfully implemented!' AS Final_Status;