BEGIN TRANSACTION;
GO

ALTER TABLE [Orders] ADD [AppliedVoucherCode] nvarchar(max) NULL;
GO

CREATE TABLE [Vouchers] (
    [Id] int NOT NULL IDENTITY,
    [Code] nvarchar(50) NOT NULL,
    [Description] nvarchar(255) NULL,
    [DiscountType] int NOT NULL,
    [DiscountValue] decimal(18,2) NOT NULL,
    [MinSpend] decimal(18,2) NOT NULL,
    [MaxDiscount] decimal(18,2) NULL,
    [StartDate] datetime2 NOT NULL,
    [EndDate] datetime2 NOT NULL,
    [UsageLimit] int NOT NULL,
    [UsageCount] int NOT NULL,
    [UsageLimitPerUser] int NOT NULL,
    [IsStackableWithMembership] bit NOT NULL,
    [IsActive] bit NOT NULL,
    CONSTRAINT [PK_Vouchers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [VoucherUsages] (
    [Id] int NOT NULL IDENTITY,
    [VoucherId] int NOT NULL,
    [UserId] int NOT NULL,
    [OrderId] int NULL,
    [UsedAt] datetime2 NOT NULL,
    CONSTRAINT [PK_VoucherUsages] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_VoucherUsages_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_VoucherUsages_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId]),
    CONSTRAINT [FK_VoucherUsages_Vouchers_VoucherId] FOREIGN KEY ([VoucherId]) REFERENCES [Vouchers] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_VoucherUsages_OrderId] ON [VoucherUsages] ([OrderId]);
GO

CREATE INDEX [IX_VoucherUsages_UserId] ON [VoucherUsages] ([UserId]);
GO

CREATE INDEX [IX_VoucherUsages_VoucherId] ON [VoucherUsages] ([VoucherId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260516134958_AddVoucherSystem', N'8.0.0');
GO

COMMIT;
GO

