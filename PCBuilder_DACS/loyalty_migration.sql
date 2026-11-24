BEGIN TRANSACTION;
GO

ALTER TABLE [Orders] ADD [DiscountAmount] decimal(18,2) NOT NULL DEFAULT 0.0;
GO

ALTER TABLE [Orders] ADD [IsPointsAwarded] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

ALTER TABLE [AspNetUsers] ADD [CurrentPoints] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [AspNetUsers] ADD [Tier] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [AspNetUsers] ADD [TotalPoints] int NOT NULL DEFAULT 0;
GO


INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260515165730_AddLoyaltySystem', N'8.0.0');
GO

COMMIT;
GO

