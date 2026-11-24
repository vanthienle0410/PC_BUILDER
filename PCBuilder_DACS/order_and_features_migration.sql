USE PC_Builder;
GO

-- 1. Thêm cột IsHiddenFromRecommendation vào bảng Products
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Products' AND COLUMN_NAME = 'IsHiddenFromRecommendation')
BEGIN
    ALTER TABLE Products ADD IsHiddenFromRecommendation BIT NOT NULL DEFAULT 0;
END
GO

-- 2. Tạo bảng Orders
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
BEGIN
    CREATE TABLE Orders (
        OrderId INT IDENTITY(1,1) PRIMARY KEY,
        UserId INT NOT NULL,
        OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
        TotalAmount DECIMAL(18, 2) NOT NULL,
        Status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
        CONSTRAINT FK_Order_User FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
    );
END
GO

-- 3. Tạo bảng OrderDetails
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderDetails')
BEGIN
    CREATE TABLE OrderDetails (
        OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
        OrderId INT NOT NULL,
        ProductId INT NOT NULL,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(18, 2) NOT NULL,
        CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
        CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE NO ACTION
    );
END
GO
