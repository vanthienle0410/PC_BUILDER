IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] int NOT NULL IDENTITY,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Categories] (
    [CategoryId] int NOT NULL IDENTITY,
    [CategoryName] nvarchar(100) NOT NULL,
    CONSTRAINT [PK__Categori__19093A0B664CDDEA] PRIMARY KEY ([CategoryId])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] int NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] int NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] int NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] int NOT NULL,
    [RoleId] int NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] int NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Products] (
    [ProductId] int NOT NULL IDENTITY,
    [ProductName] nvarchar(255) NOT NULL,
    [Brand] nvarchar(100) NULL,
    [Price] decimal(18,2) NULL,
    [ImagePath] nvarchar(max) NULL,
    [CategoryId] int NULL,
    [CreatedAt] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__Products__B40CC6CD4D42EFD7] PRIMARY KEY ([ProductId]),
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([CategoryId])
);
GO

CREATE TABLE [Cpu_Specs] (
    [CpuId] int NOT NULL,
    [SocketType] nvarchar(50) NOT NULL,
    [Cores] int NULL,
    [Threads] int NULL,
    [BaseClock] float NULL,
    [TDP] int NULL,
    [HasIntegratedGraphics] bit NULL,
    CONSTRAINT [PK__Cpu_Spec__CAD9B6B30B70E715] PRIMARY KEY ([CpuId]),
    CONSTRAINT [FK_Cpu_Product] FOREIGN KEY ([CpuId]) REFERENCES [Products] ([ProductId])
);
GO

CREATE TABLE [Gpu_Specs] (
    [GpuId] int NOT NULL,
    [VramSize] int NULL,
    [PowerRequirement] int NULL,
    [Length] int NULL,
    CONSTRAINT [PK__Gpu_Spec__E542DFA4A513F42A] PRIMARY KEY ([GpuId]),
    CONSTRAINT [FK_Gpu_Product] FOREIGN KEY ([GpuId]) REFERENCES [Products] ([ProductId])
);
GO

CREATE TABLE [Mainboard_Specs] (
    [MainId] int NOT NULL,
    [SocketType] nvarchar(50) NOT NULL,
    [Chipset] nvarchar(50) NULL,
    [FormFactor] nvarchar(20) NULL,
    [RamSlotCount] int NULL,
    [MaxRamCapacity] int NULL,
    [RamTypeSupported] nvarchar(20) NULL,
    CONSTRAINT [PK__Mainboar__71F8F5CC4A85A9AB] PRIMARY KEY ([MainId]),
    CONSTRAINT [FK_Main_Product] FOREIGN KEY ([MainId]) REFERENCES [Products] ([ProductId])
);
GO

CREATE TABLE [Ram_Specs] (
    [RamId] int NOT NULL,
    [RamType] nvarchar(20) NOT NULL,
    [Capacity] int NULL,
    [BusSpeed] int NULL,
    [Latency] nvarchar(20) NULL,
    CONSTRAINT [PK__Ram_Spec__8840B2776FC6CF22] PRIMARY KEY ([RamId]),
    CONSTRAINT [FK_Ram_Product] FOREIGN KEY ([RamId]) REFERENCES [Products] ([ProductId])
);
GO

CREATE TABLE [UserInteractions] (
    [InteractionId] int NOT NULL IDENTITY,
    [UserId] int NULL,
    [ProductId] int NULL,
    [InteractionType] nvarchar(20) NULL,
    [InteractionDate] datetime NULL DEFAULT ((getdate())),
    [Rating] real NULL,
    CONSTRAINT [PK__UserInte__922C04963AE65C79] PRIMARY KEY ([InteractionId]),
    CONSTRAINT [FK_Interact_ApplicationUser] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]),
    CONSTRAINT [FK_Interact_Product] FOREIGN KEY ([ProductId]) REFERENCES [Products] ([ProductId])
);
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_Products_CategoryId] ON [Products] ([CategoryId]);
GO

CREATE INDEX [IX_UserInteractions_ProductId] ON [UserInteractions] ([ProductId]);
GO

CREATE INDEX [IX_UserInteractions_UserId] ON [UserInteractions] ([UserId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260510152309_AddIdentitySetup', N'8.0.0');
GO

COMMIT;
GO

