ALTER TABLE [Orders]
ADD [PaymentMethod] nvarchar(max) NOT NULL DEFAULT N'Tiền mặt',
    [InstallmentMonths] int NOT NULL DEFAULT 0,
    [PrepaymentAmount] decimal(18,2) NOT NULL DEFAULT 0.0,
    [MonthlyInstallment] decimal(18,2) NOT NULL DEFAULT 0.0;
GO
