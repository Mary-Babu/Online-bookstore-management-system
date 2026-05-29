Online Bookstore Management System

Project Overview

Designed and implemented a MySQL database system for an online bookstore that manages books, customers, orders, payments, inventory, and membership-based discounts.

The system automates order processing, inventory updates, and customer discount calculations while maintaining data integrity through normalization and role-based access control.

Tools & Technologies

* MySQL
* SQL
* Stored Procedures
* User Defined Functions
* Events
* Role-Based Access Control (RBAC)

Database Features

* 7 normalized tables (3NF)
* Entity Relationship Diagram (ERD)
* Foreign Key Constraints
* Stored Procedures
* User Defined Functions
* Scheduled Events
* User Roles and Permissions

Key Components

1. Stored Procedure: PlaceOrder

* Validates inventory availability
* Applies membership discounts
* Creates order records
* Updates stock automatically

2. Stored Procedure: UpdateInventory

* Adds new inventory
* Removes damaged stock
* Prevents negative inventory values

3.Membership Discount Function

* Regular Members: 0%
* Premium Members: 10%
* VIP Members: 20%

4. Automated Event

AutoRemoveUnpaidOrders automatically removes unpaid orders after 48 hours to maintain database performance.

Skills Demonstrated

* Database Design
* SQL Development
* Data Modeling
* Normalization (3NF)
* Stored Procedures
* Role-Based Security
* Business Logic Automation
