USE PC_Builder;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductReviews]') AND type in (N'U'))
BEGIN
    CREATE TABLE ProductReviews (
        ReviewId INT PRIMARY KEY IDENTITY(1,1),
        ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
        UserId INT FOREIGN KEY REFERENCES AspNetUsers(Id),
        Rating INT CHECK (Rating >= 1 AND Rating <= 5),
        Content NVARCHAR(MAX),
        Sentiment NVARCHAR(20), -- 'Positive' or 'Negative'
        CreatedAt DATETIME DEFAULT GETDATE()
    );
END
GO
