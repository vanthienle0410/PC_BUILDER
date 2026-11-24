CREATE TABLE [InstallmentSchedules] (
    [Id] int NOT NULL IDENTITY,
    [OrderId] int NOT NULL,
    [MonthNumber] int NOT NULL,
    [DueDate] datetime2 NOT NULL,
    [Amount] decimal(18,2) NOT NULL,
    [Status] nvarchar(20) NOT NULL DEFAULT N'Unpaid',
    [LastNotified] datetime2 NULL,
    CONSTRAINT [PK_InstallmentSchedules] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_InstallmentSchedule_Order] FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_InstallmentSchedules_OrderId] ON [InstallmentSchedules] ([OrderId]);
GO
