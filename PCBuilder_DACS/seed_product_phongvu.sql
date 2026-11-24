-- ==========================================================
-- SEED: Thêm sản phẩm mẫu đầy đủ thông số kiểu Phong Vũ
-- Gồm: 1 CPU, 1 GPU, 1 Mainboard, 1 RAM, 1 sản phẩm không spec
-- ==========================================================

-- 1. Đảm bảo có đủ Category
-- Kiểm tra và thêm category nếu chưa có
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'CPU')
    INSERT INTO Categories (CategoryName) VALUES ('CPU');

IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'GPU')
    INSERT INTO Categories (CategoryName) VALUES ('GPU');

IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'Mainboard')
    INSERT INTO Categories (CategoryName) VALUES ('Mainboard');

IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'RAM')
    INSERT INTO Categories (CategoryName) VALUES ('RAM');

GO

-- 2. Lấy CategoryId
DECLARE @CpuCatId   INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'CPU');
DECLARE @GpuCatId   INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'GPU');
DECLARE @MainCatId  INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'Mainboard');
DECLARE @RamCatId   INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'RAM');

-- ============================================================
-- SẢN PHẨM 1: CPU Intel Core i9-14900K
-- ============================================================
INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation)
VALUES (
    N'CPU Intel Core i9-14900K (3.2GHz turbo up to 6.0GHz, 24 nhân 32 luồng, 36MB Cache, 125W, Socket LGA1700)',
    N'Intel',
    13990000,
    'cpu-i9-14900k.jpg',
    @CpuCatId,
    GETDATE(),
    1, 0
);

DECLARE @CpuProductId INT = SCOPE_IDENTITY();

INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics)
VALUES (
    @CpuProductId,
    'LGA1700',
    24,
    32,
    3.2,
    125,
    1
);

-- ============================================================
-- SẢN PHẨM 2: GPU NVIDIA GeForce RTX 4090 ASUS ROG STRIX OC 24GB
-- ============================================================
INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation)
VALUES (
    N'VGA ASUS ROG Strix GeForce RTX 4090 OC 24GB GDDR6X (ROG-STRIX-RTX4090-O24G-GAMING)',
    N'ASUS',
    55990000,
    'gpu-rtx4090-rog.jpg',
    @GpuCatId,
    GETDATE(),
    1, 0
);

DECLARE @GpuProductId INT = SCOPE_IDENTITY();

INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length)
VALUES (
    @GpuProductId,
    24,
    450,
    357
);

-- ============================================================
-- SẢN PHẨM 3: Mainboard ASUS ROG MAXIMUS Z790 APEX
-- ============================================================
INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation)
VALUES (
    N'Mainboard ASUS ROG Maximus Z790 Apex (Intel Z790, Socket LGA1700, ATX, 2 khe DDR5)',
    N'ASUS',
    18990000,
    'mainboard-rog-z790-apex.jpg',
    @MainCatId,
    GETDATE(),
    1, 0
);

DECLARE @MainProductId INT = SCOPE_IDENTITY();

INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported)
VALUES (
    @MainProductId,
    'LGA1700',
    'Z790',
    'ATX',
    2,
    96,
    'DDR5'
);

-- ============================================================
-- SẢN PHẨM 4: RAM Kingston Fury Beast DDR5
-- ============================================================
INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation)
VALUES (
    N'RAM Kingston Fury Beast DDR5 32GB (2x16GB) 6000MHz CL36 (KF560C36BBEK2-32)',
    N'Kingston',
    3290000,
    'ram-kingston-fury-ddr5.jpg',
    @RamCatId,
    GETDATE(),
    1, 0
);

DECLARE @RamProductId INT = SCOPE_IDENTITY();

INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency)
VALUES (
    @RamProductId,
    'DDR5',
    32,
    6000,
    'CL36'
);

GO

PRINT N'✅ Đã chèn 4 sản phẩm mẫu thành công!';
PRINT N'   1. CPU Intel Core i9-14900K';
PRINT N'   2. GPU ASUS ROG Strix RTX 4090 OC 24GB';
PRINT N'   3. Mainboard ASUS ROG Maximus Z790 Apex';
PRINT N'   4. RAM Kingston Fury Beast DDR5 32GB 6000MHz';
