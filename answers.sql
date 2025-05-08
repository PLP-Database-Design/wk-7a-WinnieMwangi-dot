-- Question 1: Transform the ProductDetail table into 1NF by ensuring each row represents 
-- a single product for an order. The original table has multiple products in a single cell.

-- Step 1: Create the normalized table structure
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert the normalized data
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Verification query
SELECT * FROM OrderProducts_1NF;

-- Question 2: Transform the OrderDetails table into 2NF by removing partial dependencies.
-- The CustomerName depends only on OrderID, not the full composite key (OrderID + Product).

-- Step 1: Create the Orders table (removes partial dependency)
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create the OrderItems table (full dependency on composite key)
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Step 3: Populate the Orders table
INSERT INTO Orders_2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Step 4: Populate the OrderItems table
INSERT INTO OrderItems_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Verification queries
SELECT * FROM Orders_2NF;
SELECT * FROM OrderItems_2NF;
