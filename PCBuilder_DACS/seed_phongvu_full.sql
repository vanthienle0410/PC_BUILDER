USE [PC_Builder];
GO
BEGIN TRANSACTION;
BEGIN TRY
    -- Ensure categories exist
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'CPU') INSERT INTO Categories (CategoryName) VALUES ('CPU');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'GPU') INSERT INTO Categories (CategoryName) VALUES ('GPU');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'Mainboard') INSERT INTO Categories (CategoryName) VALUES ('Mainboard');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'RAM') INSERT INTO Categories (CategoryName) VALUES ('RAM');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'Storage') INSERT INTO Categories (CategoryName) VALUES ('Storage');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'Case') INSERT INTO Categories (CategoryName) VALUES ('Case');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'PSU') INSERT INTO Categories (CategoryName) VALUES ('PSU');
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = 'Cooler') INSERT INTO Categories (CategoryName) VALUES ('Cooler');

    DECLARE @CpuId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'CPU');
    DECLARE @GpuId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'GPU');
    DECLARE @MainboardId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'Mainboard');
    DECLARE @RamId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'RAM');
    DECLARE @StorageId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'Storage');
    DECLARE @CaseId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'Case');
    DECLARE @PsuId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'PSU');
    DECLARE @CoolerId INT = (SELECT CategoryId FROM Categories WHERE CategoryName = 'Cooler');
    DECLARE @CurrentPId INT;

    -- RAM: RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB/16)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB/16)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/unYg4X0Q6t8sFDhqL8m881seifrfgBCB9R91qASYt-nd_PMv_qCG_ExGjGZd-vqVu0lgZ7yjqlptJflW2Kex8njIbuPy6t1dww=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Storage: Ổ cứng SSD Kingston NV3 M.2 2280 PCIe Gen 4.0 NVMe 500G (SNV3S/500G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD Kingston NV3 M.2 2280 PCIe Gen 4.0 NVMe 500G (SNV3S/500G)', N'Kingston', 2500000, N'https://lh3.googleusercontent.com/tb1tOKxtaNm6_lI4Igkqo3Gt7UOtrsXJ_6nvK-fZ4kPwaeGwZXNURNpadXo1K9-9q_9MZKxJ_8d3nBMNf-TKMU2qySbnJjjz=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Gigabyte GeForce RTX™ 3060 WINDFORCE OC 12G (GV-N3060WF2OC-12GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte GeForce RTX™ 3060 WINDFORCE OC 12G (GV-N3060WF2OC-12GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/2LNovZ7R7EMuTFNaXkMUji7MYL6yzjRUShyQJzcrO2YU1nz5zUk8WzAh47yX4UAhqJBaaeDTJiQYegyGDp9FS8NRrMQgUkMk=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Mainboard: Mainboard MSI PRO H610M-E DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI PRO H610M-E DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/4hH0wL0dbi0qBhWejIXnWLoSctWJD89WXYCPv7VpK6yesqgvebPplpJGzqqes0nTQCAxC_9OK96Ymf_f9KPXNpI70e6x0hKc=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình ASUS PRIME GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MH2-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS PRIME GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MH2-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/3T14fiX_TZdv8b5UGBzOuBQGBiisPPbZaJw_l_VEi9gHHYvtvE2IA-KTcj-k29HkKbj6kQZvxfX7AqAoByOH9Yq0dbXuryUF=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Gainward GeForce RTX 5080 Phoenix 16GB GDDR7 (NE75080019T2-GB2031X)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gainward GeForce RTX 5080 Phoenix 16GB GDDR7 (NE75080019T2-GB2031X)', N'Gainward', 15000000, N'https://lh3.googleusercontent.com/YFGOCCTFoa3aBW_LkEgXb-1-3QLN5sX4i7Csb_pTUTXL204cWvo_i1DK2X0KYJ2DlMW-_paA4K8IEQZYHeGEXNpdOSZ51Gg1tQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- Case: Vỏ máy tính/ Case Xigmatek Moon ML DGT - Đen (EN49699)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ Case Xigmatek Moon ML DGT - Đen (EN49699)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/SxjYoeUyHBTvA052A_Dz37ZGa1E4nllidMk70IkpfaxlASmtxpOv5kuym-IPPvy5o3C8qVTKJ8ojixlgQIj8PQf_Os3gBhc3WQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Gainward Gainward GeForce RTX 5060 GHOST 8GB GDDR7 (NE75060019P1-GB2063B)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gainward Gainward GeForce RTX 5060 GHOST 8GB GDDR7 (NE75060019P1-GB2063B)', N'Gainward', 15000000, N'https://lh3.googleusercontent.com/u7jjZ7T1VcDnPY4YDemhHLObgxBXJIa0Kbqb4K6PaFBblBl99-XsbDO2IunmCbPS4jxOlK8CUgetbXyzNf24lSHLvMSuigpG0w=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Gainward Gainward GeForce RTX 5060Ti GHOST 8GB GDDR7 (NE7506T019P1-GB2062B)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gainward Gainward GeForce RTX 5060Ti GHOST 8GB GDDR7 (NE7506T019P1-GB2062B)', N'Gainward', 15000000, N'https://lh3.googleusercontent.com/0XLgrTR0OkoBCu0xTxwfivN-g7JpYjN9CFL0_denFgb4MDHWxGVA769SN2ew2BtpRHnMSi_-hSKDkvx5YvSjyd5wVOla31E=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Gainward GeForce RTX 5060Ti PYTHON III 16GB GDDR7 (NE7506T019T1-GB2061T)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gainward GeForce RTX 5060Ti PYTHON III 16GB GDDR7 (NE7506T019T1-GB2061T)', N'Gainward', 15000000, N'https://lh3.googleusercontent.com/Y9Dy6G9sNS6SLBCProC7Ng7_54b31-IUKPZskI-leB2sdpof4ANHyC8DgzNsXGEDjtQ8cfDAkHZTgmBKKXYc8V3rPc02A6d3=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Gainward GeForce RTX 5070 PYTHON III 12GB GDDR7 (NE75070019K9-GB2050T)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gainward GeForce RTX 5070 PYTHON III 12GB GDDR7 (NE75070019K9-GB2050T)', N'Gainward', 15000000, N'https://lh3.googleusercontent.com/KzTrC0daWoj8_HD96-EAr5tgzAAWf8DFDxVRdJvbVpkgEbk3cm6OtbbB1-wwl6S19pW0GYy4pMPJy4BEUyhUWmgweh7BI9w=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- Mainboard: Mainboard Msi PRO Z890-S WIFI 6E
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO Z890-S WIFI 6E', N'MSI', 4000000, N'https://lh3.googleusercontent.com/lVjLF1g7LPaofLDap35kbW8nti6DtQFZroBUtKLCMQUp9NkSkjVHOP_PEAn08khRj4nzhwx2Z_rdD0kM3MbdNE5QuXJMgZvp9g=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Cooler: Tản nhiệt nước AIO DARKFLASH UV360 - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước AIO DARKFLASH UV360 - Đen', N'Other', 1000000, N'https://lh3.googleusercontent.com/04edNRRRG4fudOgXi0tsOpkTSpxDTmR3sS8jCSerb8jRwjzh9V7bJsUcPsFA2cn0BXDA0nenD7LTKPD3YCHU5nQ8OpYAkwTo=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 5 5500GT MPK (3.6GHz up to 4.4GHz/19MB/6 cores 12 threads/Socket AM4) kèm quạt làm mát
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 5 5500GT MPK (3.6GHz up to 4.4GHz/19MB/6 cores 12 threads/Socket AM4) kèm quạt làm mát', N'AMD', 8500000, N'https://lh3.googleusercontent.com/mQlsLy1bXfHlRbrcI-KK62HgDl7lY6tnXzs6xYYdZFEzEZsLI2X-kOZvbzRlZO5r5D6sJDR2Ly2o3-cbZAP4ozpZ4P9Z1fWt=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Mainboard: Mainboard Asus PRIME B550M-A WIFI II-CSM
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus PRIME B550M-A WIFI II-CSM', N'Asus', 4000000, N'https://lh3.googleusercontent.com/4lYTWxiiKWxA-ED3UJNYzgvBDlU9dnziW98tUSu1g2MTd00vuTA1gENgILH8v94FXKvhC2fFx88gPuad-XQ7tBLHkMIbqYle=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 3 3200G MPK (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 3 3200G MPK (Không box)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/lifVBk8gZvWh0SFau69poBwXJtaOCbMqVQU0SveDSzaiVax4xyCZJU9srkDhNlnBvxkXqDDnmPQIKBwJ6jcwj6Kro3SKIPZy=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 5 7500F Tray (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 5 7500F Tray (Không box)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/apKlItnk5zVLHxNJDNLClzYGeMIUj4E5cxmfvallbnoQwf4vC0kKvMRU4llIqZFLpPGvggd7Q-N9LSGaNRxbFE70VMP-yR9T=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- GPU: Bộ dựng card màn hình Cooler Master - Vertical VGA Card Holder Kit Gen5 Black
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ dựng card màn hình Cooler Master - Vertical VGA Card Holder Kit Gen5 Black', N'Cooler Master', 15000000, N'https://lh3.googleusercontent.com/4islbdMwSbbkbwZ-wrVMjENfKFFcNeNnnISqBCvkXpXRx9CLCcCuHmrxZ4XsYzUFZ_dHlFcdLRkYKTpbZPRFrp4oOjl2wGig=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Case: Vỏ máy tính/ CASE Cooler Master COSMOS Alpha Gold
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ CASE Cooler Master COSMOS Alpha Gold', N'Cooler Master', 1500000, N'https://lh3.googleusercontent.com/t3ElOWgPQ0kFW3V-s5sL_MzRb2Ln-eOEoecgRznCWFiRMeuTf-kQ3JTC5CM6JDBC6rb2qLHaqmktRQbY83schd1ARW5lAKhMaA=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 9 9950X3D2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 9 9950X3D2', N'AMD', 8500000, N'https://lh3.googleusercontent.com/DJfSLmkPPD2IXOk7Gs-SubDeVanh2lzizMv9QARsUKhBO11VqYm37TG_bjdk5gEn8a9dmrrfc2Z-dzvOZtIJpKptaqP5Aj8=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- GPU: Card màn hình Msi GeForce RTX 5060 Ti 8G SHADOW 2X OC PLUS 8GB GDDR7 (G506T-8S2CP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi GeForce RTX 5060 Ti 8G SHADOW 2X OC PLUS 8GB GDDR7 (G506T-8S2CP)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/nqKyt9JpILKDTlrixNLQob-8lL4SpDM5wUZPq_xHqdumRTMySOPhrWJXlbzW2vns8904dcLXLpg2TxPznlBLezwNilkuXBI=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Case: Vỏ máy tính/ Case Xigmatek Cloud M DGT - Đen (EN49859)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ Case Xigmatek Cloud M DGT - Đen (EN49859)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/ET2TJjZkTNOZfP3XyDKX3MfW7qpTjiDzhw3v5ti7ok9kG_EYIzv-trKAqOhO1FRwtpzxtj0ghwLR3PRhXf7qnJ4GAS6ShAKP2A=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair HX1500i - 1500W - Cybenetics Platinum - Full Modular (CP-9020269-NA)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair HX1500i - 1500W - Cybenetics Platinum - Full Modular (CP-9020269-NA)', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/N0sWIECTlCsk4NtafHJxHWOp5NWIXMP6dzNMiYTrP50l-4ZEKcVsZcXxdvJWGcXp20hEHWKc__j0WYkggmkoMzwnQxwOH1je=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo D400 (ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo D400 (ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/TlkOyIdZ-xjx8OsMF6QfVEarIBDDXNwMVXypkUTpnJ66V6YaQ1hvnqa7XzDsnbmJrAmpK9f8scS314Jg_09tWNxE_-ZFJno=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo D300 (M-ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo D300 (M-ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/1aRyqr1uCT97ERV9LmjpjSz_y967plP-hOGoLGLZRaoeBl1UyoW_ADWskzg9Hski24MMqaqJh6mmKbXsZfS-LFcOoFmIboZUpg=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo D32 STD (M-ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo D32 STD (M-ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/dYVDsT4mrC1KWjYoVBLcT1CeugAOPA2DXlC4YtA6n7lqH8tyQiMqIXxCiwvFfcMW_yR8-N2R_Ks4qPdXwmhNaKCNeQxeMZd7=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair RM1000x - 1000W - Cybenetics Gold - Full Modular (CP-9020275-NA)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair RM1000x - 1000W - Cybenetics Gold - Full Modular (CP-9020275-NA)', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/l0So5wrLTp0KR6G8agfRM5vlHfA4XZM_Gxq54JgtPBeFquQYjaPZmZcf2VR_1iY3Ecr5kFhYyBUcl9tenb6U7qgtDVykLkpFEA=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo C6 Max (M-ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo C6 Max (M-ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/tMNFK-Gcv3hSLp9P4_YlRe8zHBJJOOmiSrHocvB5b26-0kKhqv0exyXeAFlIwXnQMiEGH-edvsZXEFaNuDDDCw2eOjrRThs=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair RM850e - 850W - Cybenetics Gold - Full Modular (CP-9020293-NA)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair RM850e - 850W - Cybenetics Gold - Full Modular (CP-9020293-NA)', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/4sP7gkiLY39pnjBPKIQsBAOY7G2aYStlg8zcAusyrCCCXu3P-s1hDrKhCzWAe31huKEAeoBDzeFcHjK4k-n3gpPyyrcgWHcD=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Vỏ máy tính/ Case Jonsbo BO400 (ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ Case Jonsbo BO400 (ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/ph-IOL388JwhrYMzl04qlSBV7IN-hgF7pqQRvvEGp1kIqIBZ-lqNbd753sz6WZP4h2FsVgeQkaCRbSzBK37S5FycTUF4OHY=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo TK-3 (ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo TK-3 (ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/y8E19mVCAWHciz7zpaKaIdNHX_03ItADGafrLZZ6fusRbmDqFXt1s7y-fpnSjcS7216m0lOgGEO-wnaKRbXiHofishzr1V6t=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM laptop Kingston (1 x 8GB) DDR4 3200MHz (KVR32S22S8/8WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston (1 x 8GB) DDR4 3200MHz (KVR32S22S8/8WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/LlSPUu2Pd8O-b2KlBIHY5m46Q_CQV9DANGr0b0uw5NEKOpTZIT5j7NliNEEm-FzLlfKlJJb8HRsvMIWu4GcBvQn5nI-0GWQM=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- RAM: RAM desktop Kingston FURY Beast RGB EXPO 32GB (1 x 32GB) DDR5 6000MHz (KF560C36BBE2A-32)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast RGB EXPO 32GB (1 x 32GB) DDR5 6000MHz (KF560C36BBE2A-32)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/2nlNfaIqPYsBsnnXOoJqJ_Jyr1sndo7X_pMSN72RdtJ7V46cBpvjvWBBVBx1qrLS72yY87KhaZd-J4wUsQroBV4PHEpWmvfW=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 6000, 'CL16');

    -- Cooler: Tản nhiệt khí JONSBO HP-600 - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khí JONSBO HP-600 - Đen', N'HP', 1000000, N'https://lh3.googleusercontent.com/p5VgrKDjt1yZcPknWJCDiDL5TQkybFUFMzSxKqaDy0ujqtoiMHWV8sgtf_UvZ6X3W2SFi6lYAU6_e4GCM0pT02AECAKP2mzC=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt thùng máy/ Fan case DARKFLASH DM18 Reverse - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt thùng máy/ Fan case DARKFLASH DM18 Reverse - Đen', N'Other', 1500000, N'https://lh3.googleusercontent.com/9za9PR92Clw2coKworhLFL4x1LWRTYAJkkPYyjkCKGuBxnuqudl7m4xtOBnia_qyHxp42cThm7tH7Qt_UFMJRnKTiz7IJQIy=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt thùng máy/ Fan case DARKFLASH DM18 - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt thùng máy/ Fan case DARKFLASH DM18 - Đen', N'Other', 1500000, N'https://lh3.googleusercontent.com/NLFT2CuXLHBovFhjqNKR_HQre-Rv_Jc7LpA0Xz2xYMVqIPlLV0fgUUrgN80VHjOx1wWkbB_JZ96HfGNHXzytQiuIPoWHQUJ_rQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt thùng máy/ Fan case DARKFLASH DM8 SE Reverse - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt thùng máy/ Fan case DARKFLASH DM8 SE Reverse - Đen', N'Other', 1500000, N'https://lh3.googleusercontent.com/C7cvMedb18S0FsoThM3eEeROuGkAZuAisT6r8sh47R0-2P3NPPTLwbHCDzA0MhilucpNvPCtT-1-Bdq1d4e60JaaX1q6lSNQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt thùng máy/ Fan case DARKFLASH DM8 SE - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt thùng máy/ Fan case DARKFLASH DM8 SE - Đen', N'Other', 1500000, N'https://lh3.googleusercontent.com/-WQTfRE4rhGX2IapH72b6DF-1VuiAnKwHHqxpeSkW-w7FQlM-tZnXgkD7EV0qqgRMZFrx3LGFwa6AMnUnXUfhd97IQ08MnsAyA=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 5 3400G MPK (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 5 3400G MPK (Không box)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/N1I3Y8l_hMZbs9mrMRqth7MXQmZ2ZH1CE9-mhpjhAxAmbRsgq7Ml7UuXynltrwQBsMqI4CVq99AzDsprVUsjaa9pyY6Ntvqh=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- CPU: Bộ vi xử lý/ CPU Intel Core i3-13100 TRAY (không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i3-13100 TRAY (không box)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/gXmnEQczfRnPUrkBgZYN4QIZc1TBlyBUNNDh3P_zyPPcTal3BiNLBrrgF9EVyuO8kg6Uw9mVgGqyTWyewu0eca-hpyrJYzny=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- GPU: Card màn hình Inno3d GeForce RTX 3050 6GB Twin X2 V2 6GB GDDR6
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Inno3d GeForce RTX 3050 6GB Twin X2 V2 6GB GDDR6', N'Inno3d', 15000000, N'https://lh3.googleusercontent.com/Silgf9qRDl2PmIp61UZsV0xcNGM-2vuaV80ZFVxKHk_vu47eZkhk5de3q6hPDu3TXmW8SBpk0pRVKpcKDqoHiRX_2HKClvo=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- Case: Vỏ máy tính/ CASE MAGIC ES GASMING Aircraft 007 BLACK Ultra-Cool Display ARGB 3 FAN
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ CASE MAGIC ES GASMING Aircraft 007 BLACK Ultra-Cool Display ARGB 3 FAN', N'Other', 1500000, N'https://lh3.googleusercontent.com/Zc9qCBNS2DjzNF0Tg_UN3Li7X92ObIie5tZe-lHT5_j5kqnPr7mSW1FB8pvuqd-BKtUeLLBPbjOh98DRgu_m2pWpu8UYH74=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Palit RTX 5060 Ti INFINITY 3 16GB GDDR6
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Palit RTX 5060 Ti INFINITY 3 16GB GDDR6', N'Palit', 15000000, N'https://lh3.googleusercontent.com/egwl1sYhwoaEJE41Szp1llkhIbGWS5nW4CBbBGoLcVjhYfJt1vtJSQMiQLZ9SzyiLtlEMv7Wwz61_sXrXhWbTnCH36LmvHWi=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- Cooler: Tản nhiệt khí JONSBO CB40 BLACK ARGB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khí JONSBO CB40 BLACK ARGB', N'Jonsbo', 1000000, N'https://lh3.googleusercontent.com/B8fP1zelBYAk2LVErKsuECyAks9JFU3y60kxVwNt4szjqDLDDgi4eegHtcYCT4AZikpzpIZk3PPqtRr2VccPawen4OliDh29=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ HDD WD Ultrastar DC HA340 8TB 3.5″ SATA WUS721208BLE6L4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ HDD WD Ultrastar DC HA340 8TB 3.5″ SATA WUS721208BLE6L4', N'WD', 2500000, N'https://lh3.googleusercontent.com/ZSTVuzF__aoWNOWKmVVUCZk-frEzHc6dvw1QhTBmxdEGCx6fZa07gSZBowughILpeyFAgS2LVf85qKPSW4am9Kcj0xU3QjgC7w=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi A520M-A PRO DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi A520M-A PRO DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/atZbeL3UYAugolsvz2cMHCjoM5p7xMbWMpqbwWY-6ZjDv_gBWab-ovRz4tKEpBRxWZZ4LJsSm6H2wnRSNsWPXZEw9co6Gho=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Cooler: Tản nhiệt nước Cooler Master MasterLiquid 360 Core II ARGB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Cooler Master MasterLiquid 360 Core II ARGB', N'Cooler Master', 1000000, N'https://lh3.googleusercontent.com/wHrro0f5rdWnoTrN5EtwUM32O14bnnp-Y10iIURqhLZrKP77UKPRvkrIMu7FMbRQCeBPfUj60MtIjyYhW1O7ZirDfF27pFQ=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình PNY GeForce RTX 4060 Ti VERTO Dual Fan 16GB GDDR6 (VCG4060T16DFXPB1)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình PNY GeForce RTX 4060 Ti VERTO Dual Fan 16GB GDDR6 (VCG4060T16DFXPB1)', N'PNY', 15000000, N'https://lh3.googleusercontent.com/91U6aeCoyy3i1fvEO5PGXArT1TjGBIR47PoFXIOEKDph0f-gjDjy0SsMZ1J3jEOCgk0l1lNu_LXowycVHkIkoo7bfXHtPxZG=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- Storage: Ổ cứng gắn trong/ SSD KIOXIA EXCERIA BASIC 1TB Gen4x4 R7200 W6500 NVMe LSF10Z001TG8
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD KIOXIA EXCERIA BASIC 1TB Gen4x4 R7200 W6500 NVMe LSF10Z001TG8', N'Other', 2500000, N'https://lh3.googleusercontent.com/jdKbp9rL74sArcohaFIiOJ2FBWblwSUN07BdPr83erK8cqE1FkKS0JRhtMge4sVaoMhSu9heARGhXHohKHX7ShIeDho0FEk=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình PNY GeForce RTX 4070 SUPER VERTO Overclocked Dual Fan 12GB GDDR6X (VCG4070S12DFXPB1-O)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình PNY GeForce RTX 4070 SUPER VERTO Overclocked Dual Fan 12GB GDDR6X (VCG4070S12DFXPB1-O)', N'PNY', 15000000, N'https://lh3.googleusercontent.com/u3gI7oMf8VU70dLKyN9zo7fXEkIjaJtljD9tzlClt966AM9TuA7Wv4zQeGvvHmfsN3jb0VqVbnmmmaEKTP_FmF1HpJdYF8cC=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- Storage: Ổ cứng gắn trong/ SSD PATRIOT P320 512GB NVMe M.2 PCIe P320P512GM28
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD PATRIOT P320 512GB NVMe M.2 PCIe P320P512GM28', N'Patriot', 2500000, N'https://lh3.googleusercontent.com/fVrHGMYO9O7MO0A7WsAzAem5S_33QSzAG5oFapXTbXzOG1S9M9iQwIxkxVB4tuFihu_QgkgqeRAhgvGM9WAsVXpFTMTk_9Q=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Inno3d GEFORCE RTX 5060 TWIN X2 8GB 8GB GDDR7 (N50602-08D7-195071N)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Inno3d GEFORCE RTX 5060 TWIN X2 8GB 8GB GDDR7 (N50602-08D7-195071N)', N'Inno3d', 15000000, N'https://lh3.googleusercontent.com/ENR1fi6DrYG4BymA3enRtQa6zHivqzjfySE4lJnnNyh_futrWHUZtnVeKOfqA1GAHlIZhgQU8y6mvnKrQWKr-Y4Ue2pEgILquQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- CPU: Bộ vi xử lý/ CPU Intel Core i7-14700 TRAY (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i7-14700 TRAY (Không box)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/AVBpWeJBZTLUkvDzdIPcCX202M_Y6rQCUuxpqV4Cvf8mnOx-lkMqDjaiUDihQ2h1J9IOcHVAKLBsyPp633QXoTbY0A3i8Va7=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Case: Thùng máy/ CASE Xigmatek MYX Air 3F (3 Fan) (EN49125)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE Xigmatek MYX Air 3F (3 Fan) (EN49125)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/EJ6I-bCw6UbZQ2BuDe_BQAF2tqAvz9zvZECCKYrOp7kA-fNoBNOth_xTa60df7Oznd1RNDgbiH1L_jIEiCz4cqEzTsQXp_M=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ CASE Xigmatek MYX 3F (3 Fan) (EN49118)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE Xigmatek MYX 3F (3 Fan) (EN49118)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/0G3PnfrNQM8KyXlsd4USkGOClCHxhgnQtVc0k9BCp4WR-s7lApyQwLgVDKnGuKzABx2JNX7Et0HwXtVg-tF5YXkGitBCfuc=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi PRO X870E-P WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO X870E-P WIFI DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/CZwK4UDy8dNYkGJWl9qL4N8PJA94jmDRu6sBU9WAt-B4jvENqKrS48rHbpKETVnTTZk7mwjpASyGDvU0Wp4C-AHMawog95M=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM5', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: Bộ vi xử lý/ CPU Intel Core i5-12400F TRAY (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i5-12400F TRAY (Không box)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/NuqyPqXyDLOsJMMi1QCuJbrxLJk7fn3CHEKkY5O-UBCC4S5NQygj7MiCKniMhoZeSp06LvVzaw_GhyEe9Z_M3q7B_TiZktiK=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: Bộ vi xử lý/ CPU Intel Core i3-14100 TRAY (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i3-14100 TRAY (Không box)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/iv-C8IgnMM3Ud3lo1EC6qagAJT_zMg5apf9tuQw1lUY8OGSPiRyM1AkTI_YtrLz-igwAIGeZ_0pjyMePdBeXJk8PmewsnnVdJw=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: Bộ vi xử lý/ CPU Intel Core i7-12700 TRAY (Không box)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i7-12700 TRAY (Không box)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/QbDDT4FkqwTxy9A7ApiLVfVzx9LMZvyu4ribrw-RzRIehCknocjbKbyjpkMt6hU9wfEgfrYxf21HftDBEqYpO6VhPRxyzqNB=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Cooler: Tản nhiệt khi/ COOLER AIGO ICE200 PRO RGB - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khi/ COOLER AIGO ICE200 PRO RGB - Đen', N'Other', 1000000, N'https://lh3.googleusercontent.com/4yhXCTD-0i2wAT1codHQf-7LDqjfWqGdFVHxreFKWnKn5NIVRAp47m2QXWO1nVoq5mvM3Vf4BJ39wz1xSKURKrg-YTfdQiH3=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM laptop Transcend (1 x 16GB) DDR5 4800MHz (JM4800ASE-16G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Transcend (1 x 16GB) DDR5 4800MHz (JM4800ASE-16G)', N'Transcend', 1800000, N'https://lh3.googleusercontent.com/SW-e580tdJ44C3EiynS0LZSwMt-HpUmlaD_RZPw2xbmxJ_LN_MKloWaKhbfBATKV-8XUAygaO5WhgkXZkbr4qb7hZYb1WwKV=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 4800, 'CL16');

    -- Cooler: Tản nhiệt nước/ COOLER MSI MAG CORELIQUID A13 240 Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước/ COOLER MSI MAG CORELIQUID A13 240 Đen', N'MSI', 1000000, N'https://lh3.googleusercontent.com/AE08tCbQmulL4R2ex4KJcXoGoOuKfmqXZeLAB2kJk0sXbTjWqgLSrnk3xC31-kZIGsX8EmeDdgO_pqqS56dGMp0eKG2l1cySyA=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt tản nhiệt/ Fan Case MAGIC FC-04 ARGB BLACK (Ngược)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ Fan Case MAGIC FC-04 ARGB BLACK (Ngược)', N'Other', 1500000, N'https://lh3.googleusercontent.com/0_V30d-9C-KmAZ22VjxMdTvKlAQAB2IKHeNiDcOO89g7EnP1zPSNwlrvPFlLXobS0kWwyp6L3G9HbbKsKJW-_Rtyh6LJ6svx=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Kingston (1 x 16GB) DDR4 3200MHz (KVR32N22D8/16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston (1 x 16GB) DDR4 3200MHz (KVR32N22D8/16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/EmEU31ggJxKpOtA1pGpGIAD1Ie5VT-1SfEpOU7XStDXHafGRLcRcZTF31QpcB2mkMSpBU3J5bEoGIagrk_HRgaG9HEIEBlvR=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Case: Quạt tản nhiệt/ Fan Case MAGIC FC-04 ARGB BLACK
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ Fan Case MAGIC FC-04 ARGB BLACK', N'Other', 1500000, N'https://lh3.googleusercontent.com/j0Fqa3a_wzMhXTRzMDbrWN_uk_DpFxiSmdBtF6HJdE5XC6nNjPvMwNCUbve_bdLW8V75fwHFCpggdaRktsjdqfqLxvaHE9E=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Kingston (1 x 8GB) DDR4 3200MHz (KVR32N22S8/8WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston (1 x 8GB) DDR4 3200MHz (KVR32N22S8/8WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/l59JiSrURPTokcP-wAUE6pqhjfJj9veZkSfLTnP4-VoUmuMZFFpxmp2FY2jFk-PwGc1KdNgaZpk9BpiaPAVtDxAHaTDfHbeU=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- GPU: Card màn hình Colorful GeForce RTX 5060 Gaming DUO 8GB-V (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Colorful GeForce RTX 5060 Gaming DUO 8GB-V (8GB GDDR7)', N'Colorful', 15000000, N'https://lh3.googleusercontent.com/e0X_86bwJxa9-qy2157W2ARmpXHHE0tKcfyfIM7R6YQfDux0OGxogwop5DucRWl76e2APu8OFAlbK5nvHiZXyJ_XEZ7CjwBm2A=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- PSU: Nguồn máy tính Msi MAG A750BN PCIE5 III - 750W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Msi MAG A750BN PCIE5 III - 750W - 80 Plus Bronze', N'MSI', 2200000, N'https://lh3.googleusercontent.com/eBNLhbjiIRhnErC_tZ48zN_GeZw995IbvCWbD4esVDZq-2dX8H9Sqk1y8KSbiW8KAQdEXnvIn0cRPvfNljvGNA6O6_Akv0rO=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ PATRIOT SSD P400 1TB V4 M.2 2280 PCIe Gen4 x4 P400VP1TBM28H
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ PATRIOT SSD P400 1TB V4 M.2 2280 PCIe Gen4 x4 P400VP1TBM28H', N'Patriot', 2500000, N'https://lh3.googleusercontent.com/52tG-vu2QfVb749grYkB5TjQi8RbLV_H1BXII1xg-yltEIsJZm13sZvMXnPNs3FurlzzQwcXyPlL0qlTJ2TaEdb4N8YM8_Ok=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD PATRIOT P210 512GB 2.5'''' SATA3 P210S512G25
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD PATRIOT P210 512GB 2.5'''' SATA3 P210S512G25', N'Patriot', 2500000, N'https://lh3.googleusercontent.com/AiwiC0xfcVtVwGO3ho7xRaUuQXqsHhANcvEFXU2Qmpz_f-aJ8sRG13e6KkSBewah-PLRe3uGPGzoRvGvNAn2ENlBVl2UbhfL=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ PATRIOT SSD P300 512GB NVMe M.2 PCIe P300P512GM28
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ PATRIOT SSD P300 512GB NVMe M.2 PCIe P300P512GM28', N'Patriot', 2500000, N'https://lh3.googleusercontent.com/JhmJUrQpWwNEtZwwgIYpSOTlLKCevte5Nm1Rj9HvNRGT2CPyTKy5gdkK9W4japhUxY_KoGqI1xT1c6Umyrw2Qh87N0YbbCc=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Patriot VIPER ELITE 5 RGB (1 x 16GB) DDR5 6000MHz (PVER516G60C30W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Patriot VIPER ELITE 5 RGB (1 x 16GB) DDR5 6000MHz (PVER516G60C30W)', N'Patriot', 1800000, N'https://lh3.googleusercontent.com/X2kZIkjW2h20-tOYNWXOcL4i3mBNM0nbF9i6NVOMIzx0hwf4nS6XKcHtLnbx3IcETaD01h88yEqV6DNTD68B7wG1ZnF7Ylf8=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- Case: Thùng máy/ Case Jonsbo D32 Pro (M-ATX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo D32 Pro (M-ATX)', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/ZUvGZ7WLdtOP125qm8ZNb-_a2x-_Yd--_5Z_iTxmlaKqY_0y_mjUxmUXkvUx-4UBOazpTj1varfJGl_pSvgkftEnVJnypJIx=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD WD SN3000 1TB NVMe Gen4x4 - Green (WDS100T5G0E)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD WD SN3000 1TB NVMe Gen4x4 - Green (WDS100T5G0E)', N'WD', 2500000, N'https://lh3.googleusercontent.com/ZY3x7YyIgXwjgPCjACV0NDVOzpIq0wYiaVa2ZyHmLed-E8dvaPbccSGVBdNmDvzZrjaL0_zZ1hHxmZS-8uqkJLCQu-wX7toY=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM laptop Kingston (1 x 16GB) DDR4 3200MHz (KVR32S22D8/16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston (1 x 16GB) DDR4 3200MHz (KVR32S22D8/16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/TPFEQqdCbdH_E6yyxcGG1ypOg9-eYTnrP4ACVdOiLSmPA0ylTqe_t0YcaHAT2ZxLB5-Dqe-GRRDeoREMq86coFSatOgqZEHk-Q=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 6000 96G MAX-Q (96GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 6000 96G MAX-Q (96GB GDDR7)', N'Other', 15000000, N'https://lh3.googleusercontent.com/gUDt4T7KKDtXUw4O0FSpMwdyMW2jETjzZvz6B6Ngv_e_9VuG5jCz14LmRwldgHL8z0gHHBWKkyTavjYP_PKbFCD91NZljB-s=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 96, 650, 300);

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 6000 96G WORKSTATION (96GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 6000 96G WORKSTATION (96GB GDDR7)', N'Other', 15000000, N'https://lh3.googleusercontent.com/Kbh89AWpQEBnwOzElEJBZ5owfwgBg9_C_-ilwSvVW9UktWTP0S-YRy_jqvwKKT2RMAs4gXN7YcfA281v4I5wz4-QnFN5JtHs=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 96, 650, 300);

    -- RAM: RAM desktop Kingston FURY Beast (1 x 8GB) DDR4 3200MHz (KF432C16BB/8WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast (1 x 8GB) DDR4 3200MHz (KF432C16BB/8WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/GSz2Yj4JykPBvngCCaTVwBER3YkLLlRZUd5dBywEYYAwKYnSnrJgudd-gdA0CaarkjaiXlzNgV--zuVaBgcbMU9Z811fUsKq=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- Case: Thùng máy/ CASE MSI MAG PANO 130R PZ (4 fan)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE MSI MAG PANO 130R PZ (4 fan)', N'MSI', 1500000, N'https://lh3.googleusercontent.com/lLn0oeCisQEs584xl8WhlDevyJABnSbyTV1IqLUY9m_pFklE4Zv9wKTX8mZYj9fCA2XYJo4dWP6GCXV8OZ0yCa51Q_J5cKatpA=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình LEADTEK NVIDIA RTX 4000 ADA 20G
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX 4000 ADA 20G', N'Other', 15000000, N'https://lh3.googleusercontent.com/48OcfRYC-GDHbymQ7g48wr7541Ah34A1x-4sI-cuXCTiAMCH9eLhMCzvcb4zXWWo0qLhPNzMVUuuPti80wsjwnzb_7C5tzc=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 2000 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 2000 16GB GDDR7', N'Other', 15000000, N'https://lh3.googleusercontent.com/YnBQXkrgMfz7F3vFjq09Nwz50dZkCRrSNp4u9JlK51g1i8rrDrM_xP0OD7-hScl2dc0iI7BYUwL-DzKHootmMkYZ1ZK6dnRcNQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 4000 SFF 24G (24GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 4000 SFF 24G (24GB GDDR7)', N'Other', 15000000, N'https://lh3.googleusercontent.com/W9DYURz-hLlgD48YkHurQmgNloLBmpUDRsxRCqyvo7hpKVCE4BYP7dR12mVK3H1H14QPUMPuKB8GzmqDZmu99FoCj3CZvag=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 24, 650, 300);

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 4000 24G (24GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 4000 24G (24GB GDDR7)', N'Other', 15000000, N'https://lh3.googleusercontent.com/yjRqOhOlpBCxKVrx5JAV_l0xvB_JGkNBv12foS-lpZbtegiO-3sfDYgVw5QFNduUxw9GoQPb-QRAMm_muMA_Zn0kyw6vQqs=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 24, 650, 300);

    -- GPU: Card màn hình LEADTEK NVIDIA RTX PRO 5000 48G GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình LEADTEK NVIDIA RTX PRO 5000 48G GDDR7', N'Other', 15000000, N'https://lh3.googleusercontent.com/BqLP5Gwt4YT5ESBTRn26hHYUI7jxRbmQHjO53wqiIbrgleke1Dl69WtdAs8Jt3aqN1cylhRwh5Umytiqt_F3xsyTZjLKkI7d=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình ASUS ROG Astral GeForce RTX 5080 16GB GDDR7 OC HATSUNE MIKU EDITION
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS ROG Astral GeForce RTX 5080 16GB GDDR7 OC HATSUNE MIKU EDITION', N'Asus', 15000000, N'https://lh3.googleusercontent.com/9VUu8JNmC39_4NVcC4jU_A3oF_p6m6FgvbACgF0MB4TaRmipNEh73DmQaRbJABCttNJQBtArDpyVicws94v4XyNLOMUtDPNn=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- Mainboard: Mainboard Msi PRO B840M-P WIFI6E
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO B840M-P WIFI6E', N'MSI', 4000000, N'https://lh3.googleusercontent.com/o2JyWweZNpHVch4--QuNt0KdCZFon-FBEVH8GBC209cSOh6Z9nLdNCwF5phv0VUxCsmDt73AHuJhrKsNCuUr7CXkT7Gb21NH=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: Tản nhiệt khí/ COOLER CPU ID-COOLING FROZN A410 TD
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khí/ COOLER CPU ID-COOLING FROZN A410 TD', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/9n3XM8197xeX2mkTZX7e1aREs59Zt41EupHAvimtcqqjx9USO9OFzPaxFtP5tHimmHjMe6yxOFmG5fXvOQ7bKE1iNHZTB8pF=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'Unknown', 6, 12, 3.5, 65, 1);

    -- Cooler: Tản nhiệt nước/ COOLER ID-COOLING FX240 ARGB LCD
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước/ COOLER ID-COOLING FX240 ARGB LCD', N'ID-COOLING', 1000000, N'https://lh3.googleusercontent.com/3eOFULTWV4zn4XWH3mczLHas7csgfM0_5h80sbg6dFVuJaUZLxceY1EW9A9VE1rJL7o7jpcck5jD7VedVEdFwmyUykeoB0I=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB1/16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB1/16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/wButLxkuiSDBAYRQz93A0dNwFYJxs-5awn_STxet6PkOwPrBD0-3FrMcLhgk22eM7g4rwSsbRP2dI4FeAdChuxDXpXTRPDs=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- RAM: RAM desktop TeamGroup Delta RGB (1 x 16GB) DDR5 6000MHz (FF3D516G6000HC38J01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup Delta RGB (1 x 16GB) DDR5 6000MHz (FF3D516G6000HC38J01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/xjnV2GdiwqlLrN6cgJMtIOt1DwuospoxacAaZwCtyLWut7F6E4eaIHcWdrS9tabtF1zJzycbPyrJ20JUDb47hggZZb63QPfy=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- GPU: Card màn hình INNO3D GEFORCE RTX 5060 Ti 16GB TWIN X2 OC GDDR7 (N506T2-16D7X-191073N)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình INNO3D GEFORCE RTX 5060 Ti 16GB TWIN X2 OC GDDR7 (N506T2-16D7X-191073N)', N'Inno3d', 15000000, N'https://lh3.googleusercontent.com/sgqvOocqzB5KIGrlPgjwsuvShRgLIh4x3FYkANiDUCAwN6KJnELiPKuBFQz9yjlNZ2PtwZQoURsCX_5vIXAoVDsPHWimbGge=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình INNO3D GeForce RTX 5060 Ti 16GB TWIN X2 GDDR7 (N506T2-16D7-191073N)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình INNO3D GeForce RTX 5060 Ti 16GB TWIN X2 GDDR7 (N506T2-16D7-191073N)', N'Inno3d', 15000000, N'https://lh3.googleusercontent.com/F5GLmivbktopFhDCB52hKBL2XlfdBzS_CXvzpc3yeQetac2vGQn-MzGPVIKgjiTFsXhaeo-LzG6PwWIkPIQklFKy7k28hzsp=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình INNO3D GEFORCE RTX 5060 TWIN X2 OC 8GB GDDR7 (N50602-08D7X-195070N)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình INNO3D GEFORCE RTX 5060 TWIN X2 OC 8GB GDDR7 (N50602-08D7X-195070N)', N'Inno3d', 15000000, N'https://lh3.googleusercontent.com/pUmicLiW3ncCDYyPjhdmMpPPJvd2nMIX-xj2D5qpTBj8IYENfTrPKX88vTAyyxSPzQBCXMFXEnKMw6NV-ReuVRHcFqC30809=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- RAM: RAM desktop Corsair Vengeance RGB (2 x 32GB) DDR5 6000MHz (CMH64GX5M2D6000C40)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Vengeance RGB (2 x 32GB) DDR5 6000MHz (CMH64GX5M2D6000C40)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/QWXTLtmkxBaexLfxiOYFcL8NwOT91Gs5V7wlfYwEwI-aOFfUSA2jE9O0ksdGefZ7Y3LBCpy3kAh_KzcXzaX3ugpbAslDKCge=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 6000, 'CL16');

    -- Storage: Ổ cứng gắn trong/ SSD ADATA 2.5" SU650 SATA III 256G (ASU650SS-256GT-R)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD ADATA 2.5" SU650 SATA III 256G (ASU650SS-256GT-R)', N'Adata', 2500000, N'https://lh3.googleusercontent.com/uxIXebpsavxeZjX1rTD6RLg79QX8m3lHiuaXCtYIV4hFZnn9kA21qzsejIDMRsMq9Yyg4uNOOzjOTSnZZEFqUsC3eNtbyzOs=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Asus H610M-K
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus H610M-K', N'Asus', 4000000, N'https://lh3.googleusercontent.com/LnbAnJah1XVV2dShmYLypQYV6pFfDL4IZTQPW8gVPijUtCHojVBO20-2Gt-TnLOwNXNyO-bNZ1LWnD1tn8_skw8B6z4nB8Fb=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM desktop TeamGroup T FORCE XTREEM ARGB (2 x 16GB) DDR5 7200MHz (FF9D532G7200HC34ADC01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup T FORCE XTREEM ARGB (2 x 16GB) DDR5 7200MHz (FF9D532G7200HC34ADC01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/_VF8tLrwHmLSFD20FNrRkCF5BX15ZtfKVttI5fVTb4NjIZBRb9Ky2Rx593KSkkIZBbSdWWUogWNxxkJwRjgp1sJMT2hFNJYQ=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 7200, 'CL16');

    -- Cooler: Tản nhiệt nước/ Cooler AIO Jonsbo TH-360 White
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước/ Cooler AIO Jonsbo TH-360 White', N'Jonsbo', 1000000, N'https://lh3.googleusercontent.com/6JP2XyXOn_Up95c_Lf1olwRyRKbowD4W3e7xe-6cOYf4MgzVpI5Kr-9tKTdW6CHTw1z9_oRupXuKsD01eqyeCP960mfYc44=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo Z20 Black
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo Z20 Black', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/P4jb8wTtqhLFQYJKZ4SGTJtPUrl0ICOsLXwVIBrk25jJlm0DQckEcYsGou0PR8sqnuuERyenxatkblI_9kmYru1W8lSmbps=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt tản nhiệt/ Fan Case Jonsbo ZA-240BR
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ Fan Case Jonsbo ZA-240BR', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/KVLiN4aZum9CYfxWh8TiWMdCETPbin1e38Su0pL1pv5zVHXBEomMZlT4UG1VXW0qOVVtAPnQXSGbMh3hQhEu75LA2cUUqkzy=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt tản nhiệt/ Fan Case Jonsbo ZA-360W
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ Fan Case Jonsbo ZA-360W', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/hDf91nRjnLygsUc4rnp0-3kMF4oMgC2e47-1X7zTkm3AQAcGk38iafHsk7_RyoQCyPNq_PJqz2ykC-QWCmDRMG2lz4ab9aI=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Art Ultra HM1 White ATX
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Art Ultra HM1 White ATX', N'Other', 1500000, N'https://lh3.googleusercontent.com/2WHbfGiWSLAXU9qtGu8NITJ1X1OanhTg0Jg7ZRlw4zJ9ZNTpBg2_UPntjMuWtZoUBxpYuExLgHCVcjY3_vN1kCq3FXtGyJg-EA=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Jonsbo TK-1 Black
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Jonsbo TK-1 Black', N'Jonsbo', 1500000, N'https://lh3.googleusercontent.com/dNwwvqSt8-Ef1sQlpvHzm1rP4LGPpwtOZ4Za6ID9jkpfWxjRz_RB6ZXfYCNI4-NT0kdIgZeINuaRLwRY7apSj9_PkBptSjY_VA=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước/ COOLER ASUS PRIME LC 240 ARGB (90RC0111-B0UAY0)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước/ COOLER ASUS PRIME LC 240 ARGB (90RC0111-B0UAY0)', N'Asus', 1000000, N'https://lh3.googleusercontent.com/d1u21GI1Sdxhghx_06-NJOLAnBCulP2fbxi5qZtbYr5DlYp2GloLhEVyg9vcPuTEtosDKEqIo8JXIF8Eie3cGuOQnWTUH5T5=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ CASE MAGIC CUBI-M ELITE BLACK
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE MAGIC CUBI-M ELITE BLACK', N'Other', 1500000, N'https://lh3.googleusercontent.com/O-exFfOMF07BveArJUyd-oKQ5kqNKcyG9w2obgoHBlxORoXCUpCAahjCR4HSm27zvfMUQkew_Atfd2jz9e-2ea4ioEWo0SY54w=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD ADATA LEGEND 860 NVMe PCIe Gen4 x4 M.2 2280 2TB (SLEG-860-2000GCS)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD ADATA LEGEND 860 NVMe PCIe Gen4 x4 M.2 2280 2TB (SLEG-860-2000GCS)', N'Adata', 2500000, N'https://lh3.googleusercontent.com/wbLpfNMdMpmyztJMPBSUUaNz4BKre8K8f44-lsZR0kZ-Qfjz1mtObMUle1ko9GbnEg7nA3fr-tf9hLq8gonh9jhzda3pjSo=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Asus B840M MAX GAMING AX-CSM DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus B840M MAX GAMING AX-CSM DDR5', N'Asus', 4000000, N'https://lh3.googleusercontent.com/BQuTpOHO4p_nU5K2XFAN0MjiDWWLAevdtJsk0q6SwFMNdkWmSe02L8dmG5Q21clg133Ol4ZqIdpo1Mtbn1I-wbw4PMpMaJze=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM laptop Kingston (1 x 16GB) DDR5 5600MHz (KVR56S46BS8-16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston (1 x 16GB) DDR5 5600MHz (KVR56S46BS8-16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/ExYHN65r-7FwpFaGQQkipJ2Gsg3DYf-vf21z9bJQVM81aFlN3YxeNGmkHXYqfZ9SZUtbfpF6rleftSZkEqc8h6xVsKqvi8Jh=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 5600, 'CL16');

    -- RAM: RAM desktop Corsair Vengeance RGB (2 x 64GB) DDR5 6400MHz (CMH128GX5M2B6400C42)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Vengeance RGB (2 x 64GB) DDR5 6400MHz (CMH128GX5M2B6400C42)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/v8l1pnuoBMvb-F4FBashK7056UUQ1IarOmjgkNxN1C7kKb8H-Lvi_2PHBAi5ATQJFIk5OVOKnrr0kesdQCkuTh4o7Ore-2M=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 64, 6400, 'CL16');

    -- Case: Thùng máy/ CASE MSI PAG PANO M110A
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE MSI PAG PANO M110A', N'MSI', 1500000, N'https://lh3.googleusercontent.com/iI8ifShh8dE1VMTgiytTgjWqN0_g6_IyDYD8xS-cDYq0o9nzr-ITPh2FEejazF9OqPmqv_SAyclhlvZ-y45LICG8FDDucPCsVg=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Bộ vi xử lý/ CPU AMD Ryzen 5 7500F MPK (6C - 12T | 38MB Cache | Upto 5.0GHz | Wraith Stealth | No iGPU | AM5) - Hàng không box
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU AMD Ryzen 5 7500F MPK (6C - 12T | 38MB Cache | Upto 5.0GHz | Wraith Stealth | No iGPU | AM5) - Hàng không box', N'AMD', 8500000, N'https://lh3.googleusercontent.com/InwR_56RNFeS_O0Q_y7CS9essNjg4hCVLjHxCVSnMLlOqkBIVu0dKlV9TbndGcEX3lbJYD15_RafdWt973sWqiV-9sU1TRo=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- RAM: RAM desktop Corsair Vengeance (1 x 16GB) DDR5 6000MHz (CMH16GX5M1E6000Z36)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Vengeance (1 x 16GB) DDR5 6000MHz (CMH16GX5M1E6000Z36)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/JAG3qAXTD1EFwQgeTrzf5pZz_AAlF8iplU1KD82hWYh52rHBjSTaLiy3VZ-NkR3wJp0nKXZRwKTBvI-0hA9f5cjlpZhMq0s=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- Case: Thùng máy/ CASE ASUS A31 ATX BLACK 4FA
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE ASUS A31 ATX BLACK 4FA', N'Asus', 1500000, N'https://lh3.googleusercontent.com/z-HmflszEuYa-j5IavNXGwwPq7zpEYfGTzg6yOyU1FY0ZLqLC5RC7VrqqVRNsUtraKfo9_1WEbOkH_610bZYF1umn-T5C6M=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Quạt tản nhiệt/ FAN Xigmatek Infinity Pro 3 - EN47756 - Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ FAN Xigmatek Infinity Pro 3 - EN47756 - Đen', N'Xigmatek', 1000000, N'https://lh3.googleusercontent.com/hDWsw8S3JVHi2d8TEWhL48FUKv4cg4tX9rguncLT7UqT-YznFb0QhvX3B1c5QPz9Qufx8Nbn_SS3Bj0cH8c10qxRRUHgG0k-Bg=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Quạt tản nhiệt/ FAN Xigmatek Infinity Pro 3 Arctic - EN47763 - Trắng
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt tản nhiệt/ FAN Xigmatek Infinity Pro 3 Arctic - EN47763 - Trắng', N'Xigmatek', 1000000, N'https://lh3.googleusercontent.com/8W_krzRZpC8Aspc1SpKG95X7bzu7Z48qbH0P2oHnFBksSbfdCfFB1OzzKYzPyqXs0tLmoSXZPrwoBXZKYBnCtacoaSqc2udd=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop SP XPOWER Zenith (1 x 16GB) DDR5 6000MHz (SP016GXLWU60CFSE)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop SP XPOWER Zenith (1 x 16GB) DDR5 6000MHz (SP016GXLWU60CFSE)', N'Other', 1800000, N'https://lh3.googleusercontent.com/gItvnnuOCgy6vUdoI0ysfnGAztEJ50QxpH0cEN131BWfo6depXqoBqSSjG5P7Rva0YNcmU3Bggvw4zwIaxzdr4c-_5Oq8WL2UA=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- RAM: RAM desktop SP XPOWER Zenith RGB (1 x 16GB) DDR4 3200MHz (SP016GXLZU320BSHK0)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop SP XPOWER Zenith RGB (1 x 16GB) DDR4 3200MHz (SP016GXLZU320BSHK0)', N'Other', 1800000, N'https://lh3.googleusercontent.com/WCPksQsonWtcMB5RE2Z00rV64PhZE1G-ruIbPKtzWebYj24yuurFWpIZxyVEB5vX5cMyEs2e68KbeFu82jvvJThFdj-nFWk=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Storage: Ổ cứng gắn trong/ SSD Teamgroup CX2 1TB Sata III 2.5" (T253X6001T0C101)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD Teamgroup CX2 1TB Sata III 2.5" (T253X6001T0C101)', N'TeamGroup', 2500000, N'https://lh3.googleusercontent.com/HCJzt4bPb5TrBv4qHEL2bpFMzSXWNKGO1Clk_Cg53VbPCpHVxkP7IjaxHpJnCGo5VATjG2UiQ8Ng2bWu6c4SxbwgKiK40LE7=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop SP XPOWER Zenith RGB (1 x 32GB) DDR5 6000MHz (SP032GXLWU60BFSH)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop SP XPOWER Zenith RGB (1 x 32GB) DDR5 6000MHz (SP032GXLWU60BFSH)', N'Other', 1800000, N'https://lh3.googleusercontent.com/5KKuTL7NKZTqTSGyvSb17IZnQPSYV2pjnb1k36OFkD58v6MA0NAGWB1gM008NVF5t2F9oicOZef9WaH-mfxBvN75XJpjh5V6=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 6000, 'CL16');

    -- Mainboard: Mainboard Msi PRO H610M-E DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO H610M-E DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/IMmxqLPmeJnb6RSQSnQnEYv3f5sbTWgrzQ6CLlhtH5IMdp6gbdKg-yqzd3zoyZ-UO2NDMzteNpVlcJjpffUZJyjKqKqUQavA4w=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Asus PRIME B760M-F WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus PRIME B760M-F WIFI DDR5', N'Asus', 4000000, N'https://lh3.googleusercontent.com/gZh2N8JCt0Ob0-HiRFUTGp10hw0n-z26gSOd97jXd1n6FNDRC0Upf3BcsqS6TWxWligEjVpFyPwg2qtt0Vsf-8UqhVhBzX-R=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình Msi RTX™ 5060 Ti 16G SHADOW 2X OC PLUS 16GB GDDR7 (G506T-16S2CP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi RTX™ 5060 Ti 16G SHADOW 2X OC PLUS 16GB GDDR7 (G506T-16S2CP)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/8rDi5hXpHDWd7F-69kpd_tRnZSjDbbSM8H_C8Izd2p4l98aIkjc1LcdVXZXc9XiOdZTMSCeQR8ddfg2blz1-qsRBONlwK7k=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- Case: Thùng máy/ Case MIK Mini Phong Vu V35 (Nguồn 300W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case MIK Mini Phong Vu V35 (Nguồn 300W)', N'Other', 1500000, N'https://lh3.googleusercontent.com/yWelIpGyOSM876TZfXjOgGN7-sKLqHkIda7V6hw7YwyrfFhq2aHp7wBURlsDbEtpPu5-QcCDczlUsdihNpIvlcVMWBUH63d2=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi X870E GAMING PLUS WF
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi X870E GAMING PLUS WF', N'MSI', 4000000, N'https://lh3.googleusercontent.com/1znV8eqZEgWxrtbBiS7QdQkMpNVMMZRRSAwPhsuvwn2vwZrp69LbugJ1Hy5P_XS-2q6W48je_UzVQyVFZFNhp6OWNeFY91Th=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM5', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình ASUS Dual GeForce RTX™ 5050 8GB GDDR6 OC Edition (DUAL-RTX5050-O8G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS Dual GeForce RTX™ 5050 8GB GDDR6 OC Edition (DUAL-RTX5050-O8G)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/Mnpvslm0O1RXs1T__ntfofrp-MVXh7htM-kCD2jHlDp7Plq0eqYLFQsUEU4YPG4wkUJorO-LRE1n0dhibz6CHUCJrz53vCvx=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Gigabyte GeForce RTX™ 5050 WINDFORCE OC 8GB GDDR6 (GV-N5050WF2OC-8GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte GeForce RTX™ 5050 WINDFORCE OC 8GB GDDR6 (GV-N5050WF2OC-8GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/uLo-AlzzAv30yaUJ0mrXPVtTnzfWq-Vss2p_WthVQfDetZpREuwzaa59zZBZlv_f0H5zAs49p6OVWQk8EDOAsWkCqv-sxUOd=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Mainboard: Mainboard Asus B760M-AYW WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus B760M-AYW WIFI DDR5', N'Asus', 4000000, N'https://lh3.googleusercontent.com/nf_HcDI1esLJY_ZETJteoJpd3OjtTp7dpCRlwleG52GkOppJQUxu8a87pe1oMNJLTaVk3HTfzwrul91HvoXmrAxPLfq16hQ_=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình Asus RTX™ 5050 8GB GDDR6 8GB GDDR6 (90YV0N73-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus RTX™ 5050 8GB GDDR6 8GB GDDR6 (90YV0N73-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/1RbF2h9wVYQdO5BX9qHqWsT0tizB7TwIvIyCWxGXp-uscaGstixksQg8KP0PUiEePmNs4tckT-0CTo4DQbukMPOlcd7TGDRYZQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Case: Thùng máy/ CASE MIK G3 PRISM GLASS M BLACK
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE MIK G3 PRISM GLASS M BLACK', N'Other', 1500000, N'https://lh3.googleusercontent.com/DgTu5-rbTGzyMU_pXTuuSJU0GfUq_at3NCkgn1xLK3kQebStDhud_lLPhY7ohcCS1mFEpNUiNQks9ZPMYVH6WcMUH4wJcdoo=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi B760M Gaming WF DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi B760M Gaming WF DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/LhVxsbvM4uNM1wyLLYAMkZ6XFiKqzHyjRSjh2a9tsbYYH_1KQ6_yGkP4OmLSoP9RRVZDtJflsWL7ahkoB-D8NZ2ecVUILO_B=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình MSI RTX 5050 8G SHADOW 2X OC (8GB GDDR6)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI RTX 5050 8G SHADOW 2X OC (8GB GDDR6)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/oWT2Nm8TpRQ67uOEqtbV01PJae17VKfweCJzZx0-2qwxMMKbm-NMhppkDagWXz29or4uxkH6elyN1AiFrLOfDhHeITCd0TYh=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình MSI RTX 5050 8G VENTUS 2X OC (8GB GDDR6)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI RTX 5050 8G VENTUS 2X OC (8GB GDDR6)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/aXy1X_K-UDAfGntMcUG6JYBFGx8rYx8mHiODSgsh6c74mAm3tW5zzclgrX7WJtg2TB9Aq7EFw5BWqFDb8t510hOy2mlPwxk=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- RAM: RAM desktop SP XPOWER Turbine (1 x 16GB) DDR4 3200MHz (SP016GXLZU320BSA)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop SP XPOWER Turbine (1 x 16GB) DDR4 3200MHz (SP016GXLZU320BSA)', N'Other', 1800000, N'https://lh3.googleusercontent.com/t3PL9O-N_kzYVjf0gVbLxLzCxtojS3yXBNl5TFR_h2BMksFJdSLz-WgG1QsXiBgGx8QetMLW4W-Fjr_i-YuX8dYRCqbiFHY=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- RAM: RAM desktop SP XPOWER Zenith (1 x 32GB) DDR5 6000MHz (SP032GXLWU60BFSF)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop SP XPOWER Zenith (1 x 32GB) DDR5 6000MHz (SP032GXLWU60BFSF)', N'Other', 1800000, N'https://lh3.googleusercontent.com/hZye2cQtTqqs5BO9KXqFY2P68z6WduqhdM37XER2UPUgzfDCm8A3IAsHcCpCbnysGTFP4B-vRGSv8BqQqWBLyU5KR1HkmejfMA=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 6000, 'CL16');

    -- GPU: Card màn hình Colorful iGame GeForce RTX 5060 Ultra W OC 8GB-V
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Colorful iGame GeForce RTX 5060 Ultra W OC 8GB-V', N'Colorful', 15000000, N'https://lh3.googleusercontent.com/lzQehrzr7F3XkwDZi5JiR-fwao5hY6y3UZ1to1T_28RZ0i0J6gHkY_LucG2eZ2E0ZqGBvpwmPxttqZ7wKIu7sH3bEL0jCJpy=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Colorful RTX 5060 Ultra W DUO OC 8GB-V (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Colorful RTX 5060 Ultra W DUO OC 8GB-V (8GB GDDR7)', N'Colorful', 15000000, N'https://lh3.googleusercontent.com/RLMtqQ_y3i9tVfIAKikd7WaLMJruNIXFD42SqmLMMNa-sdnGn0hb9CSXHwgDHptQgmlcCxxV2RuldPfTLdh65UDzVLL7Kcg95w=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Colorful GeForce RTX 3050 6GB-V4 6GB GDDR6
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Colorful GeForce RTX 3050 6GB-V4 6GB GDDR6', N'Colorful', 15000000, N'https://lh3.googleusercontent.com/KbXl6-aqB3FyZX7KQ1iubNYnO_6Ujg6mkLHArdMOuJpjaAiJP1-ZN2pVSyK_krQY0DNKtKyGCUz4_mIS_4dvTKZLfrcU3UDS=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- RAM: RAM desktop Kingston FURY Beast RGB EXPO (1 x 16GB) DDR5 6000MHz (KF560C36BBE2A-16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast RGB EXPO (1 x 16GB) DDR5 6000MHz (KF560C36BBE2A-16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/qFXzXX_sxMf8ABN6wt2pZQsBu7tycwOW6Gy_4dd83FpTesyashFWmDg7FEetJmUFWeAB7f45pVJgOKRJ-8DR4JC9IHdjeZE=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- Case: Thùng máy/ CASE NZXT H9 FLOW RGB (2025) ALL
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE NZXT H9 FLOW RGB (2025) ALL', N'NZXT', 1500000, N'https://lh3.googleusercontent.com/5i2OYOqRiIxbt-7ix3ocsyA4YaIduJvvPZpNCqmOK8j0LqzrcLultGbXBM-nGPUlUHvrLF4w3UdLSR0ZwoQWyTi_V_qqHSYw=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ CASE NZXT H3 FLOW ALL M-ATX
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE NZXT H3 FLOW ALL M-ATX', N'NZXT', 1500000, N'https://lh3.googleusercontent.com/cgh0hv0OXnO4p23Ykz40ZpqsUaE869MviTxsaDTIVoMUb0gbfTBK4gy6v92_deZDyBMAiTg8CKzDPAvRXV0OMB5olCsdGGM=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Kingston FURY Beast EXPO (1 x 16GB) DDR5 6000MHz (KF560C36BBE2-16WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast EXPO (1 x 16GB) DDR5 6000MHz (KF560C36BBE2-16WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/OHzbXlbZI-mUbiD1pUJ3FyRY5oIyahW32hwj73aKBV_1SIWd3sgpfMfFJxGR9T_22t7NGYz-xut8dugC_f-1amJxKuMloQC6=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- Cooler: BỘ TẢN NHIỆT NƯỚC NZXT KRAKEN PLUS 360 RGB V2 WHITE - 360MM (RL-KR360-W2)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT NƯỚC NZXT KRAKEN PLUS 360 RGB V2 WHITE - 360MM (RL-KR360-W2)', N'NZXT', 1000000, N'https://lh3.googleusercontent.com/CtI93IwbtG_5n16faT95DE78uGwJ0Ly_38flo7J25O9ikmpgvHOWk6jSmm13LC2KR292hyHDN-exbg9-uj7P2fykbRl9fbA=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Bộ tản nhiệt nước/ Cooler AIO NZXT Kraken Plus 360 RGB V2 Black (RL-KR360-B2)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ tản nhiệt nước/ Cooler AIO NZXT Kraken Plus 360 RGB V2 Black (RL-KR360-B2)', N'NZXT', 1000000, N'https://lh3.googleusercontent.com/o_a-Z6lHOfNdfLc-9XqouWTsAioxyxahupLlD_8hb9-LmHAoc-_3FDbep0TRLnemesoZfe6GLAO8zBsPVsXSJtoicX_4xhuOOQ=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Cooler Master CoolerMaster V Platinum 1600 V2 - 1600W - 80 Plus Platinum - Full Modular (MPZ-G002-AFAP-BEU)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Cooler Master CoolerMaster V Platinum 1600 V2 - 1600W - 80 Plus Platinum - Full Modular (MPZ-G002-AFAP-BEU)', N'Cooler Master', 2200000, N'https://lh3.googleusercontent.com/KGGioP7OmsPWQFzg0pR5fQNeqt-Si2fCYGS_HwIG7yHf2lcJIWI46s7MKlZe_TqGW0h8v3tTA7E-z256sroxJLcp_oaDHrhM=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case HYTE Y70 Standard
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case HYTE Y70 Standard', N'Other', 1500000, N'https://lh3.googleusercontent.com/IT_eLJsqVEua4Rq8pBLedPCig6p4aomS3WHFzHolKjZsr6FUjkYxOoWHmnMembTy8rCERx9M59h2X4otvsOO-x4XTvqtUBk=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi PRO Z790-P WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO Z790-P WIFI DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/Iaj5QgLpj_cvfVtgWkENyZwm9cHoP4iR9P05Zn5m2sy39bX1Lq4CQ-STHg1fTdzW2yhWabww7UuZrRhqa0r3JTg1c-PJEiDm=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM desktop Adata Lancer Blade (1 x 16GB) DDR5 6000MHz (AX5U6000C3616G-SLABRBK)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Adata Lancer Blade (1 x 16GB) DDR5 6000MHz (AX5U6000C3616G-SLABRBK)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/wliWTBqKNklxT2M30Fx2YQVBNEPqUBirsjT8DdVMPpocRvv05Hy5j2VDASeUsZLfHIARGVIzaiCApFSeGgSdwvWF63gDzsA=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- RAM: Ổ cứng gắn trong/ SSD NVMe 1TB KIOXIA EXCERIA G2 Gen3x4 wDRAM (LRC20Z001TG8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD NVMe 1TB KIOXIA EXCERIA G2 Gen3x4 wDRAM (LRC20Z001TG8)', N'WD', 1800000, N'https://lh3.googleusercontent.com/g3_jaqY-G-NDmL7DNl22fqP70hY4C9vDCFn_OfFttt3yPnL5fc4KAyZIuLDiv7CeDPqPKO3YGGTFxRfq8SvswxVA8jtDEfrCgQ=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- Storage: Ổ cứng gắn trong/ SSD NVMe 2TB KIOXIA EXCERIA PLUS G3 Gen4x4, HMB (LSD10Z002TG8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD NVMe 2TB KIOXIA EXCERIA PLUS G3 Gen4x4, HMB (LSD10Z002TG8)', N'Other', 2500000, N'https://lh3.googleusercontent.com/frdr-FpGx8KfOXcv8K_-sOWw3CL77b6bJwJ77C3UXMFqHvlFWi2u9y0kiYeUgl8C8laG5izvA3j0aqKqRE21L2VJw1eoN6YI=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD SATA 960GB KIOXIA EXCERIA (LTC10Z960GG8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD SATA 960GB KIOXIA EXCERIA (LTC10Z960GG8)', N'Other', 2500000, N'https://lh3.googleusercontent.com/Wo7yjDo8Vhl3lMYOu3Q5TgnA-aLHJUFfwc77AXbA-iBNzjfoEHLGhgt8o3urnifFvVc2i0imRps1fO43p6KcDcSk0IpsQmk=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD NVMe 2TB KIOXIA EXCERIA PLUS G4 Gen5x4, HMB (LVD10Z002TG8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD NVMe 2TB KIOXIA EXCERIA PLUS G4 Gen5x4, HMB (LVD10Z002TG8)', N'Other', 2500000, N'https://lh3.googleusercontent.com/h8wOZ4kBXQG2z8cbRBQstiO2YUkvlYMe9EmW6H9Y39Ay4QSj_sAgdWjZ9sqZAh8dbQcNe430Pt7wKpGeqIzcmwvNBPiTOQbN=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Asus Dual GeForce RTX™ 5060 8GB GDDR7 OC Edition (90YV0N12-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus Dual GeForce RTX™ 5060 8GB GDDR7 OC Edition (90YV0N12-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/IyWN7qNIS6S2wTtiP1u7h_DJ7UTgdXEU9XvTTtVClJBZw6aG2lthL5dmFUZgI9GTFqgTUqOYZXheAvSw9vVTgUS8gAF6WF2P=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5060 8G VENTUS 2X OC (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5060 8G VENTUS 2X OC (8GB GDDR7)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/mnu6R5ybVfwnb6_TaI6dF-x1vAd-fJbMbfg-tdHzGsnsQBfMd0XoJ07jpttTGaJJgCsXXCQugnJ1Mtx5NvoXLuwCAUpkYMTU=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Asus PRIME GeForce RTX™ 5060 Ti 8GB GDDR7 OC Edition 8GB GDDR7 (90YV0MP0-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus PRIME GeForce RTX™ 5060 Ti 8GB GDDR7 OC Edition 8GB GDDR7 (90YV0MP0-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/ZWdd1RkCo8LYQ4OCB1VqZAoOLhWc9IDVxE8dtC-Mxv-sgwXW2gWnDXqhT2fMQjJOyPK7mnGD1IVef66zzM-kby0lbBUOsrc=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5060 8G VENTUS 2X OC WHITE
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5060 8G VENTUS 2X OC WHITE', N'MSI', 15000000, N'https://lh3.googleusercontent.com/nE37h8AWJJz2aY4_AKQEWFvF0idSwND4e66CgRzVPS9odBSGbQTCjWQZT9Jgh24l9AupTQcSPwT0kjKnMPJbQvDF56JBofQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5060 8G GAMING TRIO OC (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5060 8G GAMING TRIO OC (8GB GDDR7)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/Dtg2_EKUNdWAvK8adQH8Nr-Mn75BchDQ9RTJ7exFRgTNulzHPNRBPlS2Gxxfcjn-Lzr9jExKgkqo47daw7lV62ThP_ydA6Q=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình ASUS TUF Gaming GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MG0-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS TUF Gaming GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MG0-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/NFYi5gEPyF-xYof9GC_oD7InkbEk8v_qxOh1yHUmowfKD-Si1d5ihkXAsGzew6URAOQiQIGG8eYlHrMyz53KMHUzvlCtKMJO=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình ASUS PRIME GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MH2-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS PRIME GeForce RTX™ 5060 Ti 16GB GDDR7 OC Edition (90YV0MH2-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/3T14fiX_TZdv8b5UGBzOuBQGBiisPPbZaJw_l_VEi9gHHYvtvE2IA-KTcj-k29HkKbj6kQZvxfX7AqAoByOH9Yq0dbXuryUF=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5060 8G INSPIRE 2X OC (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5060 8G INSPIRE 2X OC (8GB GDDR7)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/Dp5ZpIaEhgb4kXL1LxfmiF3n1pd575l_2gvEFctQ_1qPzSPWYaTz86Mek-puUD0NnGFfEQEqsx0MNQGl5lfTEs4-I87qqno4=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5060 8G SHADOW 2X OC (8GB GDDR7)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5060 8G SHADOW 2X OC (8GB GDDR7)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/mqzMGA-3fQ5ae6Mpos8f0V6YXb3vbWimBYtxR4rel3sK2Fmq6ybqUxXFYDGuClzVgzswhFWCzBoOGk-cR6oPiEwrcDAgMzVj=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình Gigabyte RTX™ 5060 WINDFORCE OC 8G (GV-N5060WF2OC-8GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte RTX™ 5060 WINDFORCE OC 8G (GV-N5060WF2OC-8GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/QgaIKOZoOexsY2VS_xuixxQcEA4yUTx65GLr7FaBOR4M2k1tCyFbARnwY0yJMiiJ178iCc8Z9DrQrlFHGW7uIJL7stdgL5rB=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Cooler: Tản nhiệt nước AIO Deepcool LE360 V2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước AIO Deepcool LE360 V2', N'Other', 1000000, N'https://lh3.googleusercontent.com/nkCDyPiCgnS_FRHyLboOE3DxQaXbF6Heuam3IlX8m-TO7tSsVcf2GOtnE6pCg4SNg7S79ceCcCxKp2mWhQ8sFWZbD46lKEM=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước AIO Deepcool LE240 V2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước AIO Deepcool LE240 V2', N'Other', 1000000, N'https://lh3.googleusercontent.com/BscPIoyWfVCWZVhIeLWL_wTvt4lK0gmXm_QMn909ixVQwwJ7tLaWfHEmVg6YYRGeLoQvpLyTDVTFcm7-0Iv54-nhf0D_2ZY=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Cooler Master MWE Gold 850 V3 ATX 3.1 - 850W - 80 Plus Gold - Full Modular (MPX-8503-AFAG-2***)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Cooler Master MWE Gold 850 V3 ATX 3.1 - 850W - 80 Plus Gold - Full Modular (MPX-8503-AFAG-2***)', N'Cooler Master', 2200000, N'https://lh3.googleusercontent.com/BYtBvS38t65biQCGTvNh30Frvcjk6aLjUxZ9iJc5i-l2LNw2S3sP5f0T6FB4csdtIuZjTuZAFXWysQu97540140dz1h4hhVQ=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Corsair 3500X Tempered Glass Mid-Tower (Đen) (CC-9011276-WW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Corsair 3500X Tempered Glass Mid-Tower (Đen) (CC-9011276-WW)', N'Corsair', 1500000, N'https://lh3.googleusercontent.com/XU6BUmdpXlEshBv36VwE2cdef_FDrTkyFReStaq_Xwwl8ZvYan8Rs3Md5_nrt49o0Z0JOsPclcwfwN_J5qomxnYrcibFf1ID=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 16GB) DDR5 6600 MHz (CMP32GX5M2X6600C32W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 16GB) DDR5 6600 MHz (CMP32GX5M2X6600C32W)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/N-r8_OWICCu2o4ENhpWWsrrY5X1glW_sxpEZDARjDaIo12H1oARomaPfltRsHmH-HYib0q-FQmzAhBsrv7XYI7QEASExcHDXHQ=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6600, 'CL16');

    -- GPU: Card màn hình Msi GeForce RTX 5060 Ti 16G VENTUS 2X OC PLUS 16GB GDDR7 (912-V535-027)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi GeForce RTX 5060 Ti 16G VENTUS 2X OC PLUS 16GB GDDR7 (912-V535-027)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/XQEH9tIo9CdNxUFqi8YhTkc_03JN9htG-FfrZie2J7cGMePQwUeN-UG2YJXSDvTNPkR0W5dyjei_5kkSG8uIQhTNC-zzZjWPRg=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Msi GeForce RTX 5090 32G GAMING TRIO OC 32GB GDDR7 (912-V530-024)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi GeForce RTX 5090 32G GAMING TRIO OC 32GB GDDR7 (912-V530-024)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/yefKFRiYeeD21VH0FBHqdlPu9KWJi81n1Gqyvec5pwBUFw2cSfM-NpKswFz606qTmg0lKRYA9hOAo9JfVvR5CFuDRit8SnHO=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 32, 650, 300);

    -- Storage: Ổ cứng gắn trong SSD Samsung 9100 PRO 1TB M.2 NVMe- MZ-VAP1T0BW
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong SSD Samsung 9100 PRO 1TB M.2 NVMe- MZ-VAP1T0BW', N'Samsung', 2500000, N'https://lh3.googleusercontent.com/0JSL-8ev-6PFCnFa03GpB-2PkziCL-3iy8hSCrl2rdiB9QqzCg_u5mUH3mXllySsEixXffxG_pA6R20YfBF_DDKMj2A4N6Lq=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Asus Dual GeForce RTX 5060 Ti 16GB GDDR7 OC Edition 16GB GDDR7 (90YV0MH0-M0NA00)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus Dual GeForce RTX 5060 Ti 16GB GDDR7 OC Edition 16GB GDDR7 (90YV0MH0-M0NA00)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/t_jtwjAtVNklYdNAQqsAnRzTpV6cl7UG5aBGvreZVo5kdFUBlHHpk5SNhgIB-9bddVRgqm-Q1ek_rRfQGhIFg1IHL3Eci69aew=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Msi RTX 5070 Ti 16G SHADOW 3X OC 16GB GDDR7 (912-V531-097)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi RTX 5070 Ti 16G SHADOW 3X OC 16GB GDDR7 (912-V531-097)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/wCKCGyhHVv9U35YQIj31T9biP8wnlt-wr-HECuHt-ODr0hgKrhrybBVhARepqO_GAqJ7Gq_6YCVmaqxm-ve2j44QY8pj86w=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Gigabyte GeForce RTX™ 3060 WINDFORCE OC 12G (GV-N3060WF2OC-12GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte GeForce RTX™ 3060 WINDFORCE OC 12G (GV-N3060WF2OC-12GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/2LNovZ7R7EMuTFNaXkMUji7MYL6yzjRUShyQJzcrO2YU1nz5zUk8WzAh47yX4UAhqJBaaeDTJiQYegyGDp9FS8NRrMQgUkMk=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- CPU: BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A610 ARGB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A610 ARGB', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/rGwUtcr55P0d8Bdlwd9-sQyw85kCHu_CkxSrPPlox7gFaIRC8QwFVIG9rsV73CmFTYCcksnIfK_vq2_aL0gNUkZLAgYkrOpK=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'Unknown', 6, 12, 3.5, 65, 1);

    -- CPU: BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A720 BLACK
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A720 BLACK', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/N8HYwSh-x9vLJZb90bbBZ48tLSg7jBheF5MD-ftvoQ22Dg47zKwNDlnZDoV4zEZfhW1-qhIAJaUlJ9RIY8UE28Io9js4lZy8=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'Unknown', 6, 12, 3.5, 65, 1);

    -- CPU: BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A410 GDL (Limited Edition)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT KHÍ CPU ID-COOLING FROZN A410 GDL (Limited Edition)', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/cQMKgOKossouEzh2hQw8gG_u_nDIz8XgOfT1GGPY6YOPZwRAl6iFfNgneiLZ-nlSTEe4WSaNZVno3K2LCvd1ffXkB-ZfP5Q9=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'Unknown', 6, 12, 3.5, 65, 1);

    -- RAM: Vỏ máy tính/ Case Cooler Master MasterFrame 600
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ Case Cooler Master MasterFrame 600', N'Cooler Master', 1800000, N'https://lh3.googleusercontent.com/hE4NowwNFi5ge-gw7XQEsI_e8v9Ot7sWVsKMYCoTakEksanKUl0qQU_X4dSlIZw6x0An0KYqb5kHcWjjSEy-uf-wQeM48oU=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- GPU: Card màn hình Msi GeForce RTX 5080 16G SHADOW 3X OC 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi GeForce RTX 5080 16G SHADOW 3X OC 16GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/NheSmPej9Ff_EgZtKSTcDTMFQnc6FrS4eQpaDLJdKBmDqt03uToTOoarYXWvetiEqI43SbW8jaUvHPZRlV1pf9sT8tiJqTZ3=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- PSU: Nguồn máy tính Corsair RM1000e - 1000W - Cybenetics Gold - Full Modular
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair RM1000e - 1000W - Cybenetics Gold - Full Modular', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/KmJzbnYjWiyIsBMBWlMXCStzK-SL2InOnAVcswMLMhBjpJr9D9JGcmDExjIR2mwHYBgzaqhQO9qRGE7xPGhYq2UBey2W7737=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair RM850ep - 850W - Cybenetics Gold - Full Modular (CP-9020296-NA)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair RM850ep - 850W - Cybenetics Gold - Full Modular (CP-9020296-NA)', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/2qK-_f9q3q2QeYkj-x7L3iVotaE-WR24QGNfBfHWBLjDF_T9K_DkUG-vK876zW3L9t7OOa95BRXv3u9lbFUbQAr6GyT4cVg=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD WD BLACK SN7100 NVMe - 1TB (WDS100T4X0E)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD WD BLACK SN7100 NVMe - 1TB (WDS100T4X0E)', N'WD', 2500000, N'https://lh3.googleusercontent.com/VVdipS1VnRX92jy8rYGoglco1LmZ8kB9_PxwSTIlaPVx7I1De-E35SU_7iuQlpaSlprpeuzM6oXWD53XKO-j2uAyCyTardk=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Corsair iCUE LINK TITAN 240 RX RGB Black/ CW-9061016-WW
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Corsair iCUE LINK TITAN 240 RX RGB Black/ CW-9061016-WW', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/JJzkCxjSS3rH9uYv1ptWQ0XLvuUpvuL34a10ffHY0oqbVyKILhetr5Mg-NjEmjZ-rjkaLgbclgHEELCyJYaOKXWGYSllmv4=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Msi RTX 5070 12G VENTUS 2X OC 12GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi RTX 5070 12G VENTUS 2X OC 12GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/h7Vpw4yR7dQYg9JaSy2kVipzRCe9DQofNHBl0gfSK8Qi2PkGsdvtUzde_mGYJFaBcaUPFFko2BWrKn1C8hDxbkO4Ai4wcDfv=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- GPU: Card màn hình Msi RTX 5070 12G SHADOW 3X OC 12GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi RTX 5070 12G SHADOW 3X OC 12GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/7wNWRBAjfTGyKUD_w0oNUaiOcnBV_rVcVwWkBxgxO64sFOqoqTMmkw8N-ky2_eukXMi_i0z-Lc7vyAYhUaskRkOUdr0YMk98=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- GPU: Card màn hình Msi RTX 5070 12G SHADOW 2X OC 12GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Msi RTX 5070 12G SHADOW 2X OC 12GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/5oWwEiZWew7vpVp1TG8N8RiUep-GnRLusjIXU1o4ejzTdBIPgqnLE0Sl5JtzpK0lTH04G7njVmnbgeIcJqTQv9c_wfGP1Dg5mQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- PSU: Nguồn máy tính Msi MAG A650BNL - 650W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Msi MAG A650BNL - 650W - 80 Plus Bronze', N'MSI', 2200000, N'https://lh3.googleusercontent.com/DUPRh-7cxYX2IZ26enI3JVZoJ4Bzsh3twkwLMt9F0-dyQvSO0ScYd7b2F73DS5SWoGwE5bHu6UptxlswOpZMkLPJM_v9SpXZWg=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU AMD Ryzen 9 9950X3D (16C-32T | Up to 5.7GHz | 144MB | Radeon Graphics 2CUs - RDNA 2.0 | No Cooler | AM5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD Ryzen 9 9950X3D (16C-32T | Up to 5.7GHz | 144MB | Radeon Graphics 2CUs - RDNA 2.0 | No Cooler | AM5)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/x5wjOd3mQ6XkeFJialWzitHqN5YBeox3DcsTzmh7k8bp3X_p_gSEOAmNiaY-60Nwf6QlcDbBwssJMsTxmJ2Y3ZgLTqdSZKk=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- GPU: Card màn hình Gigabyte Radeon RX 9070 GAMING OC 16G 16GB GDDR6 (GV-R9070GAMING OC-16GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte Radeon RX 9070 GAMING OC 16G 16GB GDDR6 (GV-R9070GAMING OC-16GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/2ZfmQGC9djU492bN_nl52m-366fWepx3Dt3SnQ2YtgMszJZ-g0n1PZBgqo_-6mAdYuwk9BHwhejtFse05Rvw_BS6tHRkqOg=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình GIGABYTE GeForce RTX 5070 GAMING OC 12G 12GB GDDR7 (GV-N5070GAMING OC-12GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình GIGABYTE GeForce RTX 5070 GAMING OC 12G 12GB GDDR7 (GV-N5070GAMING OC-12GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/na2vLszzkGje0ZzDSP4mPwRv27QIE9jQsnOG522CCfefDR72kqyQks8nk7gTBAYyCvKN5zeupOrX16bh_q602mzkdVoFSlni=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 3050 VENTUS 2X E 6G OC 6GB GDDR6 (912-V812-055)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 3050 VENTUS 2X E 6G OC 6GB GDDR6 (912-V812-055)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/Pyr2zCI2yvLVZh6oHL-62SZ9f-lGiOKk8aQVAsrahfoW87h3rCxGQY8VRRFMEmcW0WOqvumuaZI9umXGRif_5xo2NxZDKod6Qg=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- Case: Thùng máy/ CASE Xigmatek MYX Air 3F (3 Fan) (EN45967)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE Xigmatek MYX Air 3F (3 Fan) (EN45967)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/ACpnjJxqTe1wGYz2tsTBkPNgDXVwEybzQ4sUxNv1iXUDeJ8O22Yy0Dno4rmkJXxi17GeRFk08ARBVfVAf-L7zDUYICNhVVst=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ CASE MIK FOCALORS M BLACK (Đen)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ CASE MIK FOCALORS M BLACK (Đen)', N'Other', 1500000, N'https://lh3.googleusercontent.com/vL8qubbN9rTV0Y5PwcXtch3JoJWZQdchDNON9GZkdhHFKD9DFAN2iVbzuxxttMj6k2x-H986kl7rX2eRVO5HRxleUFzOdWjjsQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Asus ROG Astral GeForce RTX™ 5090 32GB GDDR7 OC Edition 32GB GDDR7 (ROG- ASTRAL- RTX5090-O32G-GAMING)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus ROG Astral GeForce RTX™ 5090 32GB GDDR7 OC Edition 32GB GDDR7 (ROG- ASTRAL- RTX5090-O32G-GAMING)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/GemjJC6rr75b04RHDrVubpN7QipOhIeyXy_86jriwJ2agj6WrVSVFioSsO3GPPCI_E4xaxDTxEVFBgkoXf6ujtNj0edHPs0=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 32, 650, 300);

    -- GPU: Card màn hình Asus TUF Gaming GeForce RTX™ 5090 32GB GDDR7 OC Edition 32GB GDDR7 (TUF-RTX5090-O32G-GAMING)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus TUF Gaming GeForce RTX™ 5090 32GB GDDR7 OC Edition 32GB GDDR7 (TUF-RTX5090-O32G-GAMING)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/2CiR-_UXGFs8wiT0AICQBtcIPbAeTCfb_c0bfzn0Le8QV-MOwWg7yntROAd5DNWw1b2Xu5QY2l_64sm1skDPKUlj_hhAa_He6Q=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 32, 650, 300);

    -- GPU: Card màn hình ASUS PRIME GeForce RTX™ 5070 12GB GDDR7 OC Edition(PRIME-RTX5070-O12G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS PRIME GeForce RTX™ 5070 12GB GDDR7 OC Edition(PRIME-RTX5070-O12G)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/9tMdh4RNEEb2CSxoGHpJehbCbGtCAUPWkIJn4vxTkOrL6Y5l_sjzyNmv3T6SGgds4M_PI86lBmuGBMxX3lW72r9Fy-oekdba=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- GPU: Card màn hình ASUS TUF Gaming GeForce RTX™ 5070 12GB GDDR7 OC Edition 12GB GDDR7 (TUF-RTX5070-O12G-GAMING)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS TUF Gaming GeForce RTX™ 5070 12GB GDDR7 OC Edition 12GB GDDR7 (TUF-RTX5070-O12G-GAMING)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/GXdZ2RGenpo9GHvpV3LAkr_QGSMTRTvrqmbPwyWvLMhI6McPIFhLwEBY_lZvgjrV6M3moWi8LmLc5ktBPzARLiP-XgzDhZhF=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 12, 650, 300);

    -- GPU: Card màn hình ASUS PRIME GeForce RTX 5070 Ti 16GB OC Edition GDDR7 16GB GDDR6 (PRIME-RTX5070TI-O16G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS PRIME GeForce RTX 5070 Ti 16GB OC Edition GDDR7 16GB GDDR6 (PRIME-RTX5070TI-O16G)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/Q33YBJTEAJLCzhmn2nf0aF5xBUX86edf7kbrKGcV9NKy9o7SSyo5tIw0IRe3Sigd6_PdkoN7MFjkQo4tU6S2-gJ_prtjeXo=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình Gigabyte GeForce RTX 3050 WINDFORCE OC V2 6G 6GB GDDR6 (GV-N3050WF2OCV2-6GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte GeForce RTX 3050 WINDFORCE OC V2 6G 6GB GDDR6 (GV-N3050WF2OCV2-6GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/YJaO5wWQddDkOdUvk06TOO9WNfJyIeuSAq_WUGbUbZSWSEr7N8PuVRQ1wRBuaWHpFGeIA9oWeji7sPtnDE6hkN2kZ0gBpiIl=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- GPU: Card màn hình GIGABYTE GeForce RTX 5070 Ti EAGLE OC ICE SFF 16G 16GB GDDR7 (GV-N507TEAGLEOC ICE-16GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình GIGABYTE GeForce RTX 5070 Ti EAGLE OC ICE SFF 16G 16GB GDDR7 (GV-N507TEAGLEOC ICE-16GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/6XEln96JQjluWffuzDKCHa7Dx6asuz77SE0AsKqVa_THCItHNJ-FqgiX5zdUhjLGxpipkPgsENKNGatPjE_ib0gUYitBwov2NQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình MSI RTX 5070 Ti 16G VENTUS 3X OC 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI RTX 5070 Ti 16G VENTUS 3X OC 16GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/GDaqCqNMKvu_iJm5Xs6h0A1bTJxC6kF6g61Vv-i5gXUdsn9RHok96Op9U1DxcdGQn1h_OzHCftDBnCikO-_NfTFsvLqrjicn=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình ASUS TUF Gaming GeForce RTX 5070 Ti 16GB GDDR7 OC Edition
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS TUF Gaming GeForce RTX 5070 Ti 16GB GDDR7 OC Edition', N'Asus', 15000000, N'https://lh3.googleusercontent.com/MSfnZ5G7_PJaJNlb69PA1wYhMMnBS6Y-GhC_dvQ5Fh4k7qZs2EcZHuPe8tYVWsfyP1yH-FlpSoJPqhmVPa-9dUcc4RqHfpeF=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- RAM: RAM laptop TeamGroup Elite (1 x 16GB) DDR4 3200MHz (TED416G3200C22-S01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop TeamGroup Elite (1 x 16GB) DDR4 3200MHz (TED416G3200C22-S01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/J3p7Fz9y24r3QEv6MsYR8Nyr_v938AR-g1gBjRV6VDZvgZzz-9inN6XrRf8dBQ8BxhvX81gKaUhKGDPSAotSff9AJvZidw=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- PSU: Nguồn máy tính Msi MAG A1250GL PCIE5 - 1250W - 80 Plus Gold - Full Modular
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Msi MAG A1250GL PCIE5 - 1250W - 80 Plus Gold - Full Modular', N'MSI', 2200000, N'https://lh3.googleusercontent.com/ocekyzu9ZlSlrkH13tnJaVHY9KzHS1T1dB1J3yYEG6AuLRlNxyM9httju2zyfancTjAI8z5iMxd9WzWj9ojr1pMtvmjbqprS=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi B860M GAMING PLUS WIFI
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi B860M GAMING PLUS WIFI', N'MSI', 4000000, N'https://lh3.googleusercontent.com/Hu5fjmDEppy2yZgX_thDBx7TkM6oGQDaGptjxKs2iGInut1AkzcxP-cCzFlQkIcDOA6-r9aVD3TagKRqq2ipUXmql8IFLYwoNQ=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình GIGABYTE GeForce RTX 5080 AERO OC SFF 16G GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình GIGABYTE GeForce RTX 5080 AERO OC SFF 16G GDDR7', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/vbwT9ryPJ5j1WtTjGtm87IqfmjDlb123NcymAFUSABS1XtI9AC1uNa7jwQ4ydYcnVjG371S4iTh7IiozsiSUzYDoM9KliFbOSQ=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- GPU: Card màn hình ASUS TUF Gaming GeForce RTX™ 5080 16GB GDDR7 OC Edition 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS TUF Gaming GeForce RTX™ 5080 16GB GDDR7 OC Edition 16GB GDDR7', N'Asus', 15000000, N'https://lh3.googleusercontent.com/CTV_FZGU18gsx8-sfvYBpchYxqiSOVVIOWqHJ1WWut9rQiShiZkWcWkMVCKS8ECjimYRrJyICif-tawNCUktwQG17OGhF7x5=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình MSI GeForce RTX 5080 16G INSPIRE 3X OC 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI GeForce RTX 5080 16G INSPIRE 3X OC 16GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/YGy450OYaX_iqRC7coRffGtENBx1-TZ9hZwDWiNnUSeeXsZbqg1EOzQjRKoXPrx-4RGRUuHFob25JA8U1lbDPWTlmn2Ozr0g=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- GPU: Card màn hình MSI RTX 5080 16G GAMING TRIO OC 16GB GDDR7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI RTX 5080 16G GAMING TRIO OC 16GB GDDR7', N'MSI', 15000000, N'https://lh3.googleusercontent.com/5mkJGs94NnVfgMf2sJ-mKPeIqO-pc9nGOX0k-iZLwsel-2z-OObsIKJ1jMEvBMfF5vp0wxr5Q9l3nhlCAYCgbS6TqO-t7VCV=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 16, 650, 300);

    -- CPU: CPU Intel Core Ultra 5-225 (10 nhân 10 luồng - Boost tối đa 4.9 GHz - 20MB - 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core Ultra 5-225 (10 nhân 10 luồng - Boost tối đa 4.9 GHz - 20MB - 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/1-bkq4gHJT29TgRbZouqnXuFR44fnWkAnfpc3PHP6C2cYlV-7mnxAwptzPEilaSspJmY7rDotIFO_88rjMO1Q5HCn07GEYA=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 10, 10, 3.5, 65, 1);

    -- CPU: CPU Intel Core Ultra 5-225F (10 nhân 10 luồng - Boost tối đa 4.9 GHz - 20MB - 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core Ultra 5-225F (10 nhân 10 luồng - Boost tối đa 4.9 GHz - 20MB - 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/FzpTYh5PuKnHhYsi4ZcTeP1gxIkw4VWD5YRCnWfdevHVeUrqfYoeCp_0IDgxy_ahtX5DQjh03EUjOmYZPJBmImdO9hEZi_O1=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 10, 10, 3.5, 65, 1);

    -- CPU: CPU Intel Core Ultra 7-265 (20 nhân 20 luồng - Boost tối đa 5.3 GHz - 30MB - 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core Ultra 7-265 (20 nhân 20 luồng - Boost tối đa 5.3 GHz - 30MB - 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/g25xHRxNELbFPfpEpziXr6AzYCLu--ssZcIetSgOW-7nAc5ulLnhO8IgiIOFdwJlo4oKshmb_dp8ZlpdDcxkkez4sJilV57C=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 20, 20, 3.5, 65, 1);

    -- Storage: Ổ Cứng gắn trong SSD Samsung 990 EVO Plus 1TB M.2 2280 PCIe 4.0 x4 NVMe 2.0 (MZ-V9S1T0BW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ Cứng gắn trong SSD Samsung 990 EVO Plus 1TB M.2 2280 PCIe 4.0 x4 NVMe 2.0 (MZ-V9S1T0BW)', N'Samsung', 2500000, N'https://lh3.googleusercontent.com/gHYShL11YSVHdeuoEmMHTRieZ5ZEHRgz1gZPHLDRylVWHBYEfjw8q6qb9Kkq_7KHUJxoP_Bzg-_OD8U8WXFPv3SJzQ2Wa6IYAw=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước MSI MAG CORELIQUID I240 WHITE
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước MSI MAG CORELIQUID I240 WHITE', N'MSI', 1000000, N'https://lh3.googleusercontent.com/QLamoLfskza1Cn87rhzo3IYCEibZWW_58AQyNh_WRXBOVsp9iEkw-qiBnDtHnWtlRfnaQbs-VUjB_0CyzM2EkeFEapujdOk=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước MSI MAG CORELIQUID I240
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước MSI MAG CORELIQUID I240', N'MSI', 1000000, N'https://lh3.googleusercontent.com/wSfkNgrVWkRVeBbUfu1afKWekZS-kOWRK4CRD2khZOtqnGkoJZR85DVhqKy03INSn4U3W0-DUuLdvO6qgCd0BKyrBLniA3o8=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: BỘ TẢN NHIỆT NƯỚC ID-COOLING FX240 INF ARGB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT NƯỚC ID-COOLING FX240 INF ARGB', N'ID-COOLING', 1000000, N'https://lh3.googleusercontent.com/J7SBICoEwkUowLcJZxUnYyLyh9hzbyNAqqrbAsJPiYkqewnVB1MZM-GuXoyRZHscuAO7olxE56vCNm8CoPcImqNwxW-AWSQ6Ug=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Corsair NAUTILUS 240 ARGB White/CW-9060094-WW
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Corsair NAUTILUS 240 ARGB White/CW-9060094-WW', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/yPTnXmC2A8x-7D4IRM0-kFhhfN9BDqNQiTkme_5sXk7q__TZCOSotwRGwuUV4xGyJEzcJqIEI7kjsVDzOOw-9qNl-9UVVChvgQ=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Bộ 3 Quạt case Corsair RS120 ARGB Triple Pack White (CO-9050185-WW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ 3 Quạt case Corsair RS120 ARGB Triple Pack White (CO-9050185-WW)', N'Corsair', 1500000, N'https://lh3.googleusercontent.com/GYe_eM7ys4Fo9f9C9EzQAf6gfSHoJeVBxJiET0qo9LxDMoy5bJFdusDoJIRceoYJc1splAcTRxh1hsYnELlqRniBGtVo5uza-A=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Corsair NAUTILUS 360 RS ARGB (CW-9060093-WW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Corsair NAUTILUS 360 RS ARGB (CW-9060093-WW)', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/t-KM0t0rCKTAIHVJiHBBBcy5avepB75hBX89G8GXIpdBFjj3kIYDfe9eoFgVu65dmcoP3qw9iZ76cVJxiU-5ujrZlQQsxwNgow=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case MIK BARBATOS - Màu Đen
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case MIK BARBATOS - Màu Đen', N'Other', 1500000, N'https://lh3.googleusercontent.com/82c80Pn85UirAPVUaBVeZ9y8FQE2tfhhNcQmzQ2LJy5nWKuG7GP-Jt_yHGf6TznHP1ldR534AoIxNyPx5dQ0TeeXrFAKYw0=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case NZXT H7 Flow V2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case NZXT H7 Flow V2', N'NZXT', 1500000, N'https://lh3.googleusercontent.com/QhvXmc9yfUKLJs7BLEg2N71P_5A6gr3YgpIvT01OuHPUMIGo9k6W5Z_qx6l9tKZCblfGwoPh78wu-i3qjVXa6DgO4ovnmYNs=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Msi B760M Gaming Plus WIFI DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi B760M Gaming Plus WIFI DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/k1OD7sSjnM7qFCPxvCbqB1uFqRASV0ym65B2-oDXvHUov-gxdTdtgGo5or29GprKeHZpf557P-G8xcMFaK7d25Uyx3RyBROm=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Case: Thùng máy/ Case NZXT H5 Flow RGB V2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case NZXT H5 Flow RGB V2', N'NZXT', 1500000, N'https://lh3.googleusercontent.com/jBp6ps1nyj_UaACeXAlUEomZG7S_zmE_cPlCFZ8DaYyYwtKAxCTUyvjBQDbrGBjmu_y_unoBj1oFY-v6AUQddQqko8LMiiZB=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU AMD Ryzen 7 9800X3D (8 nhân 16 luồng - Boost to 5.2 GHz - 104MB - AM5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD Ryzen 7 9800X3D (8 nhân 16 luồng - Boost to 5.2 GHz - 104MB - AM5)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/64tmRD_sagy1ULbzfRl-mg6b_Rw313Vyw7W35o6FGK2lkaGzPnWn7azny6N-FGS4zUuNKQX7ARrD67vZ3NF-ZHFpBdtNegc0Iw=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 8, 16, 3.5, 65, 1);

    -- Cooler: Bộ 3 quạt máy tính Corsair RS120 ARGB Black
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ 3 quạt máy tính Corsair RS120 ARGB Black', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/QH8qv7Prn9QVG68Nm9IzP0Nz2PYMTkcg0F_eieQlMzzdzMKXz_t1h9AWW-lB8gf83pg_lrRZX-mZUIGYvgiozSg67fBR-bk=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Deepcool LT360 WH ARGB - Trắng
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Deepcool LT360 WH ARGB - Trắng', N'Other', 1000000, N'https://lh3.googleusercontent.com/LqNCVc66Ak__sIDeSLQj5S6B6Pu7H8_kOEUw4ZfpMxBdhTGhanh7LL3tiGvvzp8UyHVi7QOCNH5QxxRNUUaJSoYkbHRHwaOq=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Deepcool MYSTIQUE 360 WH
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Deepcool MYSTIQUE 360 WH', N'Other', 1000000, N'https://lh3.googleusercontent.com/SIBIEUV3UlvWZ6kYaXrqvoWZgBCmCzrmghKSvjwHUkKhp2njvUly194eeu8-1G6jlRlfNO7uTDSh30gKiX-5x5zNt-xxPgEX=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard ASUS Prime PRIME Z890-P-CSM | DDR5 - Wifi 7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard ASUS Prime PRIME Z890-P-CSM | DDR5 - Wifi 7', N'Asus', 4000000, N'https://lh3.googleusercontent.com/t_1LiHKC2fUp6_mWzi9uthOrBldS4eqLFHOWFSKtm5aaN8m6OmhImZuxTYDJcwHSwQ9VUD1TJuWECY-QJmLP4ti4H48A_kRsgQ=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: CPU Intel® Core™ Ultra 5-245KF (14 nhân 14 luồng - Turbo Boost to 5.2 GHz - 24MB - 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel® Core™ Ultra 5-245KF (14 nhân 14 luồng - Turbo Boost to 5.2 GHz - 24MB - 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/3IuRxUMW4P9r6r03867h3Dss1OhGpSbU65gH16gZhLq6_Zrh--EfA6Dwi-9jZY3NdhdKJC7eqEmUQzjyUIi3oXsI6DdbjE0=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 14, 14, 3.5, 65, 1);

    -- CPU: CPU Intel Core Ultra 9-285K (24 nhân 24 luồng - Turbo boost to 5.7 GHz - 36MB - LGA 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core Ultra 9-285K (24 nhân 24 luồng - Turbo boost to 5.7 GHz - 36MB - LGA 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/b3PSGTJMFzes5ZvQNmgmWuAcm4nKOUEPFJvghedGg7jEbXzFPIOA_MwEtX4YfpTDEkzAkLp4XJ83j2fjXIZ00vgalUODrE0=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 24, 24, 3.5, 65, 1);

    -- CPU: CPU Intel Core Ultra 5-245K (14 nhân 14 luồng - Turbo boost to 5.2GHz - 24MB - LGA 1851)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core Ultra 5-245K (14 nhân 14 luồng - Turbo boost to 5.2GHz - 24MB - LGA 1851)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/_CoiOLdxkmDdXYeYAvQmbPMV6iqHjvZGgcfDqKN78ae8AePB_5_oO5fL3k2fOq1Ij2jbZ18ZSlP4s04tJVo4QDcvc6U33YVi=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 14, 14, 3.5, 65, 1);

    -- Mainboard: Mainboard MSI PRO PRO Z890 S | DDR5 - Wifi 7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI PRO PRO Z890 S | DDR5 - Wifi 7', N'MSI', 4000000, N'https://lh3.googleusercontent.com/ActGQswE__Iy-0mAkHdgYCMPrcLwzT4pWofZNTWhaXInbzINHTwGPLx44l3nezZBvEPRdlUzY6JJ2HVFQqvJFZor5n6oC6Hj=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard MSI MAG MAG Z890 TOMAHAWK | DDR5 - Wifi 7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI MAG MAG Z890 TOMAHAWK | DDR5 - Wifi 7', N'MSI', 4000000, N'https://lh3.googleusercontent.com/ExqFPvkP_3NppH1P-N1gHVqw7Bi3f_99v3fa3nP6WUJq6uEokJsgEW1p2gXJH8rTColOtxnsnsMMtJhWvr1qSE7rn5DEc2SlSw=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Storage: Ổ cứng SSD WD Blue SN5000 1TB NVMe M.2-2280 Gen4 x4 (WDS100T4B0E)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD WD Blue SN5000 1TB NVMe M.2-2280 Gen4 x4 (WDS100T4B0E)', N'WD', 2500000, N'https://lh3.googleusercontent.com/AwZCqzdlV6Ty5XZS3QS5-SFEdmLYAOIh_SPOCkK54JCZ6deElp6d1M1MGv0UqbJXuNdy7nObcbVvYn2Z_af5lDwgh5tecNWIrA=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Gigabyte X870 A ELITE WIFI7
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte X870 A ELITE WIFI7', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/bBZuo36d1hFeR5STTB0ZXe125rqKKqV0WOM3T6Rn_hCmyBp6P5s6Jik2ENYbNXRG6rYghRM22-k9xREqQdkgbmeW2pANhkrW=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM5', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM laptop Kingston (1 x 8GB) DDR5 5200MHz (KVR52S42BS6-8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston (1 x 8GB) DDR5 5200MHz (KVR52S42BS6-8)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/bec9OTgUiP45SejCFOxjXtIduj23wSnldgP4hSJfnA_t6vv1E59RkmhlF9PXxpVreTUsgnNTBjkNOLLygjkWX3RHvQyFRDw=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 8, 5200, 'CL16');

    -- GPU: Card màn hình Leadtek A400 4GB GDDR6
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Leadtek A400 4GB GDDR6', N'Other', 15000000, N'https://lh3.googleusercontent.com/DvRGfHhJ_5EYEQndS_TpZ7s22KrFLulU4PFlfvlRnjqVzbVAEh9hsk-y-IiQPO2sEnoY-ff6kpgjStIk7olYAZdxMKFMI-MT=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 4, 650, 300);

    -- GPU: Card màn hình Leadtek A1000 8GB GDDR6
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Leadtek A1000 8GB GDDR6', N'Other', 15000000, N'https://lh3.googleusercontent.com/R2wQZy8JL-SdIwmTnuT-Di_XQS2qBqHENb5ueNl-fl1QAIlqKZVZBv8wV27OYSu-xtvpRJfitUTxwRMsGYDC_FVeFIvpNZB_=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- Case: Thùng máy/ Case Corsair 6500X Tempered Glass Mid-Tower, CC-9011258-WW
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Corsair 6500X Tempered Glass Mid-Tower, CC-9011258-WW', N'Corsair', 1500000, N'https://lh3.googleusercontent.com/KJqOD8Ss4KpOLuWG1Xee_YfHaBC1uPzqwpYgdXIMJD8pPFt_JUQd_k9yYb_OQdx6anlhKNXk-b6mOm-fUzeeBGs_l5mGAYw=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Asus TUF GAMING B760M-PLUS WIFI II DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus TUF GAMING B760M-PLUS WIFI II DDR5', N'Asus', 4000000, N'https://lh3.googleusercontent.com/_q17JQCv-FRVqK9RPAPZHfyY2fcpczx3KUOxuDuAVL9nkvj8USZ_16l3cVcS5MbJY1lpc3sBCRAsBJt0-UCzxchUrOt2Qaes=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Storage: Ổ cứng SSD Kingston NV3 M.2 2280 PCIe Gen 4.0 NVMe 1TB (SNV3S/1000G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD Kingston NV3 M.2 2280 PCIe Gen 4.0 NVMe 1TB (SNV3S/1000G)', N'Kingston', 2500000, N'https://lh3.googleusercontent.com/Etnp_ZiAKp91cmmq2wcOlY8LY_muhXZHVwonjwwsPc2YDemvErYKEdT5yW4foL8Uo3C9Zu8jiKoD9KWBDjPyqdIM7iNhWOw=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Gigabyte B760M GAMING PLUS WIFI DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte B760M GAMING PLUS WIFI DDR4', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/2D8AqJW3Wwe7Ygqow9N6ACJwpMfr0VPyI7Df_eFe0uFTsJHe3y9ywP2kgSy1_64CkPlAbIeFhYybSOuRyhRBAUv0GtEy0snO5Q=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM desktop TeamGroup Elite Plus (1 x 8GB) DDR4 3200MHz (TPD48G3200HC2201)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup Elite Plus (1 x 8GB) DDR4 3200MHz (TPD48G3200HC2201)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/6bbu2YVcWbKk-cVaWmERl7VnnVKcF-M7WTw6YRrI3czfYRXQJdsXEJ8WJIs6OmAkU8V5n4_RSTGjmIxbB9ArfKuOE7H77pk=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- Case: Thùng máy/ Case MIK MORAX 3FA BLACK
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case MIK MORAX 3FA BLACK', N'Other', 1500000, N'https://lh3.googleusercontent.com/U6-Qk2tFioHBOIjr4ZH19-ZlE138MbfRZTzIOV7_UfBV_XVm1hXT5CcXYLVZwocH_gETn5hnFdbWOkLzovPQGkm1zjRGspY=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Gigabyte GP-P650SS - 650W - 80 Plus Silver
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Gigabyte GP-P650SS - 650W - 80 Plus Silver', N'Gigabyte', 2200000, N'https://lh3.googleusercontent.com/QsHEs9IF5u4qkgsptIbNsllQPqWY6a7YlNb7_7uiSG4Jw4KFr_N4NHfgb6aBI4JIfS-U2KOXDaUYeqh6REZcbGL0r1KsMmZS=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng SSD TeamGroup MP33 256GB M.2 PCIe Gen3x4 (TM8FP6256G0C101)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD TeamGroup MP33 256GB M.2 PCIe Gen3x4 (TM8FP6256G0C101)', N'TeamGroup', 2500000, N'https://lh3.googleusercontent.com/4VGEJynfh744BTdZsDbMqd_WJ_sZZhMnimHwHCjIA0IOh0jnuxD4qsO7K4puDvVoRisTCbSb2DsTQk11pxDUsMkKoHMOzc5o8g=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước AIO Deepcool MYSTIQUE 360 (R-LX750-BKDSNMP-G-1)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước AIO Deepcool MYSTIQUE 360 (R-LX750-BKDSNMP-G-1)', N'Other', 1000000, N'https://lh3.googleusercontent.com/a7kEB66XIh5lNItBwCiqH3JkymCjKj9yAlLjE4uNchodqjJCNEaImP-v2TbtQ34LTDkKjrquWls9jYd7kcsBZR-W3XmUTqdYPw=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop TEAM TED48G3200C2201 (1 x 8GB) DDR4 3200MHz (TED48G3200C2201)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TEAM TED48G3200C2201 (1 x 8GB) DDR4 3200MHz (TED48G3200C2201)', N'Other', 1800000, N'https://lh3.googleusercontent.com/1WTgtDZ6j3-DWVPFoUqlDHJpGeQ2AzjpR0I7qSoNOkDJgicc3JlbaMpnMfUd38Fzfg3nOjzzVi4nxp0lipv-xh1c8HqVXqiq=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- RAM: RAM desktop CORSAIR CMG8GX4M1D3600C18 (1 x 8GB) DDR4 3600MHz (CMG8GX4M1D3600C18)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop CORSAIR CMG8GX4M1D3600C18 (1 x 8GB) DDR4 3600MHz (CMG8GX4M1D3600C18)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/3orL2fY1uhgL_sF7VYz8EorFsVRSoplIJyZhm9ca3Q3DzkeotPAvjhQzZLK3LKbLH5i49ch-EBx4nKpV8aCp0zoxBTaDlvXK3A=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3600, 'CL16');

    -- Mainboard: Mainboard Gigabyte H610M H V3 DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte H610M H V3 DDR4', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/aJCr6-tFB-CPQz2XrzGc5PlmEmsRJWnWgXKtOgfy5EJ5VMwrakmlzABADKHbakOqdTYpS-4E8uwHnHiw3tDiTgZ_oYNdT3IL=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Case: Quạt case Xigmatek Infinity Arctic 120mm Fan - EN44571 (Trắng)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt case Xigmatek Infinity Arctic 120mm Fan - EN44571 (Trắng)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/ET56Uhn8cJrgYfiqNk0OlXV4ixryEwKV56vRsoTC0lmSE5_psFEtfLuA7eKmo10UbUic4n2hdPoIpKN6NlkMbSl8OBA-bSU=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt case Quạt Xigmatek Infinity Arctic Reverse 120mm Fan - EN44595 (Trắng)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt case Quạt Xigmatek Infinity Arctic Reverse 120mm Fan - EN44595 (Trắng)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/2FevnSCsq4NfodfKANVpy4yOXYLhBlEEfOcerb0KTEdB93ddxjGNZyEo5T0tRZf8DhjSk7CVfpcEwd_uxACwX92tIRJgSFw=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case MIK Phong Vu Office
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case MIK Phong Vu Office', N'Other', 1500000, N'https://lh3.googleusercontent.com/KdvYz4z2DIfZ3Edvpx_t2V0G2ibWPDTxtPJ5lrhxmqgMxKA9f5kh-Wzcr8ycGU-xFPkO0pPJ1VcHyZ8uAWHFM7ayImxWWE9JpQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Case Xigmatek Alphard M 3GF(3 FAN RGB) - EN44090
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Case Xigmatek Alphard M 3GF(3 FAN RGB) - EN44090', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/Sg-70UCsdWJyjg_O3M7rmHilnS_c9V_Q8QZNV2y-JqgWRT5kPLRvIrwvVyYZD7BStievG3PuIncXaX67D5_b_Mtt_cxr_AGV=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU AMD RYZEN™ 5 5500GT (6 Core/12 Threads - 3.6GHz Boost to 4.4Ghz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 5 5500GT (6 Core/12 Threads - 3.6GHz Boost to 4.4Ghz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/nyJSg1SgK_4ymjqKvJEZQDAmSDx9ET6R0qyVf3oi0ElGNYBWGS33KypN0bd3nwe47WbBa-t7qFlolJ1DeExr_MsWwKKw7rxxuw=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- RAM: RAM desktop TeamGroup Delta RGB (1 x 16GB) DDR4 3200MHz (TF3D416G3200HC16F01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup Delta RGB (1 x 16GB) DDR4 3200MHz (TF3D416G3200HC16F01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/k9yMrDnwy3IBG9q_gb5LubWU89kpkyIcHE-UbW9Ti2KIpK66MAlcr0uKeUGFAB3tJa2hYCh6JbbFWYYzZN7KQwcqpWz7Zieohw=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- RAM: RAM laptop ADATA AD5S560016G-S (1 x 16GB) DDR5 5600MHz
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop ADATA AD5S560016G-S (1 x 16GB) DDR5 5600MHz', N'Adata', 1800000, N'https://lh3.googleusercontent.com/pqrls6cm50Aa0j268FdVv9mhsMgyLtPYlkpSr8d8KWJbXJbnh9rtaJoh3jj7SUoPozkZxv8ynXlQ6Qp6jva568WooeZaoMgk=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 5600, 'CL16');

    -- Mainboard: Mainboard MSI B650M GAMING PLUS WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI B650M GAMING PLUS WIFI DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/VGVcIeZhPm6zNgVq1XRnJ2NoviuFQt7RXmxDQ1vb0Io_KJRjfvYe_hyQNn6_hTPqsC36EWPD2ImDFmU7-D8mkmMzUrJTXrM=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM5', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard MSI Z790 GAMING PLUS WF DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI Z790 GAMING PLUS WF DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/GDZse8vV3gopHn44J311ZX1ToBMG7fym70OmCoyjKAo_q8fUBAu70i7KXjNRVp7vWXOGOiW4oKCPDVnj0uXXb9uWeJn-yy_f0A=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard ASUS PRIME A520M-K (DDR4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard ASUS PRIME A520M-K (DDR4)', N'Asus', 4000000, N'https://lh3.googleusercontent.com/LptdJt6jE7sL5BAimGRf_zgZQq78nUz5rYEjCpqOHJRJOaDdXdpnsVgv4RP87L3tZb5jfHWBu-hMEFTFTPbrccLnz06eVTzG=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Storage: Ổ cứng di động SSD Samsung Portable T9 1TB (MU-PG1T0B/WW) (Đen)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng di động SSD Samsung Portable T9 1TB (MU-PG1T0B/WW) (Đen)', N'Samsung', 2500000, N'https://lh3.googleusercontent.com/svNtui7pMLuhFEbH0pf5-qRVUTBM32KogTg-oXXFHMR2E6oWL1kgFj_NafvdzcyuwNPYL5MhUVRZT9Onxug7LmdpL8Sh_dKexA=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong SEAGATE HDD SkyHawk 6TB, 5400 RPM, Cache 256MB (ST6000VX009)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong SEAGATE HDD SkyHawk 6TB, 5400 RPM, Cache 256MB (ST6000VX009)', N'Seagate', 2500000, N'https://lh3.googleusercontent.com/qZlICWP0mdoETcijZGCSz-ulef_X4Px-T3Xv3NZ3wZA-NPUhdD0KGPStwbW6hJNRdsDERlZBuenfQ0dVO9b8OFKyZtDVAfII=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong/ SSD WD GREEN 1TB SN350 NVMe M.2-2280 PCIe Gen3x4 (WDS100T3G0C)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD WD GREEN 1TB SN350 NVMe M.2-2280 PCIe Gen3x4 (WDS100T3G0C)', N'WD', 2500000, N'https://lh3.googleusercontent.com/rn76yyAHvYS6sRL1mmVnmC2x2Z3JZuauQPfwf1kMy0gUHoCGGwhNRYcTaUmQ0poKkOHleajwsrGmhGiOfJY7D-O0esaZaV8=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình ASUS RTX 3050 OC Edition 6GB GDDR6 6GB GDDR6 (ASUS DUAL-RTX3050-O6G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình ASUS RTX 3050 OC Edition 6GB GDDR6 6GB GDDR6 (ASUS DUAL-RTX3050-O6G)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/kWj0bCzOJLXMBH8ybchSKfbwLFkO9iR1nqEUvTGrS8QO-Gs5HyNKcsqNmQxEE95NegSB0DHA1K-yojsYYdeLc1hT1HMHwU5LEw=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- Mainboard: Mainboard MSI B760M GAMING PLUS WIFI DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI B760M GAMING PLUS WIFI DDR5', N'MSI', 4000000, N'https://lh3.googleusercontent.com/FCbt_T4swCI_iRQoiuezlUqSwvNNLQsn7nw_7TOADDEbohQa0y5VNWh4DOp1JkK3-FGIoXB2wMGVSt6tpzavag-gosnGT1lF6g=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- GPU: Card màn hình MSI RTX 3050 VENTUS 2X 6G OC 6GB GDDR6 (912- V812 - 016)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình MSI RTX 3050 VENTUS 2X 6G OC 6GB GDDR6 (912- V812 - 016)', N'MSI', 15000000, N'https://lh3.googleusercontent.com/ZrX1xSg8J9FSJeAtRZ4gDxAiXVx_78WzmFjBwva9Ezzi3IkUoc-dJWRB-2wbj21WqDoeGE01FqI81xi_3lK6-EvNkYvSBScg=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 6, 650, 300);

    -- CPU: CPU AMD RYZEN™ 5 5600GT (6 Core/12 Threads - 3.6 GHz Boost to 4.6 GHz - 19MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 5 5600GT (6 Core/12 Threads - 3.6 GHz Boost to 4.6 GHz - 19MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/SjaOXLFiF1Wnzr9BjH5gcwxujT0k4UMbnxpIk1MCdthQODLDVrpz7G6qSLlgHQ9VpUX3MPhy0k4geswjeWvlt5fivuz7_L4=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU AMD Ryzen 5 8500G (6 nhân 12 luồng - Boost to 5.0 GHz - 22MB - AM5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD Ryzen 5 8500G (6 nhân 12 luồng - Boost to 5.0 GHz - 22MB - AM5)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/9NfcUhMySGfs7DqpM5-ekSzaLFRV6Eepf_xt7U3iUiimkGI9gXrC_7jMKBMyTi7pUaph-HW14b58PJrmpILxNZ8LCsO_HnX7=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Case: Vỏ máy tính/ Case Golden Field PV886b
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Vỏ máy tính/ Case Golden Field PV886b', N'Other', 1500000, N'https://lh3.googleusercontent.com/rzXIOHs7g3THejs77cGNyCM1tlbJxks8xrPB_hP8t_fuacJCtQE9XtuXHISUgpgu1Yvih8ozLdKWzy3JQ3JVkE_83L0xmzk=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Asus PRIME H610M-K D4-CSM
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus PRIME H610M-K D4-CSM', N'Asus', 4000000, N'https://lh3.googleusercontent.com/FGP7inbiAiV5uWV8udjhSochENCT16-PhSi83hmAXaB4OYyJ3Vr52QcNgIaxUWBS7Fyn4ipk6IjpFG22llZDQI7Ts4iBHPm8=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- PSU: Nguồn máy tính Corsair CX750 - 750W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair CX750 - 750W - 80 Plus Bronze', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/LjtPeBU5sjAj7e_PXaKyz4-MyNTkOPVRL-GtBoeI27DDHD-FXjnpBX4uEIjP962nYGAnm1IMKOoXbj06PsvlHgTBN6ZvtoHK=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair CX650 - 650W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair CX650 - 650W - 80 Plus Bronze', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/c1gJ0VpSFkFZ1RsIScumhVoLeuUbvBeN0lzeYtoFemdwPuoDby5NUqoy3J_ktvowMpkyYPgxXJYfozSvQh8SjOY-A3df6Q3r=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Corsair CX550 - 550W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Corsair CX550 - 550W - 80 Plus Bronze', N'Corsair', 2200000, N'https://lh3.googleusercontent.com/LkYnfqkqB860ToVaSQEL5etxlMSAWabkAVbJsna0c-MA_GogdNohud3Lt-qofEXm5gVnbEfxavVmYItg-HcYGrKwsdeZs-Tb=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU Intel Core i9-14900 (24 nhân 32 luồng - Boost to 5.8 GHz - 36MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i9-14900 (24 nhân 32 luồng - Boost to 5.8 GHz - 36MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/7UXpEkxCyTprzNGwkY6VcxYRj6ui3JZdX2bEdUHhVXHWbbEKx7tfg-VhZUoLtZogykeg8lkIKPspzErQghbkGdujQf8jDeQ=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 24, 32, 3.5, 65, 1);

    -- CPU: CPU Intel Core i5-14400 (10 nhân 16 luồng - Boost to 4.7 GHz - 20MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i5-14400 (10 nhân 16 luồng - Boost to 4.7 GHz - 20MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/KSz0AIdZTPfjdFx8RHMXXUMtQUCpqnStMbKW6aitqkmFuWW9OhMmn79VrUJyZtI0DiJE_9gOjcBwVG2L7H3yqY3XVvEnFMSqOQ=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 10, 16, 3.5, 65, 1);

    -- CPU: CPU Intel Core i3-14100 (4 nhân 8 luồng - Boost to 4.7 GHz - 12MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i3-14100 (4 nhân 8 luồng - Boost to 4.7 GHz - 12MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/0V0fkQJW-Jx4rKZqqdCtf7pyec55ttEYworqv5M23mT4IV2EzzKjk6Zw4TBs0wjHMpAA2wjVCBkhcVq5nTVgspJt-IEcSGs=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 4, 8, 3.5, 65, 1);

    -- RAM: RAM desktop Adata XPG D35 (1 x 8GB) DDR4 3200MHz (AX4U320016G16A-SBKD35)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Adata XPG D35 (1 x 8GB) DDR4 3200MHz (AX4U320016G16A-SBKD35)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/zB5VORlLPz1UKRatfSdSVhvygo3RazhTrCTWcIOqjqgp96b-eeKJ29Ri-4inpz5t9WrKSuZMCN9lQo4bDyjJwmHYdS9qF1Yk=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- Case: Case MSI MAG FORGE 320R AIRFLOW (306-7G23R21-809)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Case MSI MAG FORGE 320R AIRFLOW (306-7G23R21-809)', N'MSI', 1500000, N'https://lh3.googleusercontent.com/lomgIo8O2LghFEPJc3soJi3h8yCvfZcfOGmKqbcPb1en246uxXjkEnFsyBlLgm0AlTkbrLCEl8XaoSugc9LVecDlh4wWbcoU=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn ngoài HDD Lacie 20TB 2BIG.20000.Thunderbolt3 + USB 3.1.0 - STLG20000400
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn ngoài HDD Lacie 20TB 2BIG.20000.Thunderbolt3 + USB 3.1.0 - STLG20000400', N'Other', 2500000, N'https://lh3.googleusercontent.com/pk7OzHUwd4LKECzWX6Nf8dlH2vlC0XlxNe3xOSxQPlNnH8qktU7-WbhRvv_iPnKWYa55dEZT0zhE66mgeJLP60-GSQuOdCg0Zw=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 32GB) DDR5 6000MHz (CMP64GX5M2B6000C30W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 32GB) DDR5 6000MHz (CMP64GX5M2B6000C30W)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/dzG87-yI_DJMaJAG_D-BODg_8TynbwsMeGTtd7ug-MDx6U1Ji7hKnovlFhPrF_B276HENoXGiiDhBopBl7M-t4i2fwNzNRw=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 6000, 'CL16');

    -- RAM: RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 16GB) DDR5 6000MHz (CMP32GX5M2B6000C30W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair DOMINATOR TITANIUM RGB (2 x 16GB) DDR5 6000MHz (CMP32GX5M2B6000C30W)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/YjHi-J1c3MpVIIN34jpNEWXvArdYbBjOyfNBGjNDhHfqr-yGxgaajGDg8zl9XK5eWqcmod-q1NGBbfk5OHW9EYE8iqgY0mM=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- CPU: CPU Intel Core i7-14700KF (20 nhân 28 luồng - Boost to 5.6 GHz - 33MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i7-14700KF (20 nhân 28 luồng - Boost to 5.6 GHz - 33MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/Qba6Cu8lzanPmkkNRn_P9qbm4THYZL36A40kmeWNOL0EUDzjn9INpmHgUyPJq1vXQWvxUbdV56vCCgfhen4CfkkoiVCb-MU=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 20, 28, 3.5, 65, 1);

    -- CPU: CPU Intel Core i9-14900KF (24 nhân 32 luồng - Boost to 6.0 GHz - 36MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i9-14900KF (24 nhân 32 luồng - Boost to 6.0 GHz - 36MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/kq3H_yDyl_30zSplzHTeZS-ZexhxehOnsXn-uSJswxB3CuzrrMzhnGaomWfKF6w-Is0EUuTDm6aTadsmpylX1YxB1UUux-EG=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 24, 32, 3.5, 65, 1);

    -- CPU: CPU Intel Core i9-14900K (24 nhân 32 luồng - Boost to 6.0 GHz - 36MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i9-14900K (24 nhân 32 luồng - Boost to 6.0 GHz - 36MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/fq8rC5JuKgMLeT5m7x6T25OeXDP1TvAI9wEbUwsOOZIp7ijGKiYQSGfZ4zc_cqJ_IsUXwOxgqgnrLaKyfu6IRLJHdca8QLjF=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 24, 32, 3.5, 65, 1);

    -- Case: Case MIK AETHER GAMING (BLACK)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Case MIK AETHER GAMING (BLACK)', N'Other', 1500000, N'https://lh3.googleusercontent.com/iE0xLve-ZiDQPOKxlGk5sT6nHSBy5b3qPr5_su1d5iIQiWmQkWOQreumhckFqenlVzQ9sKCJXJKX2T4FP1qI7wq8qi7B3uv3=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính MIK C650B - 650W - 80 Plus Bronze
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính MIK C650B - 650W - 80 Plus Bronze', N'Other', 2200000, N'https://lh3.googleusercontent.com/gCWXy3vo07C8ndyqA25TQBBbawZVIjUOQVU0YUJ9Di2ByMnDNVNvgF0Xq4R4bGydeXrW-Obif3jwW3NjcFgKt0kk8x7ClW2UZA=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt/ Fan case Xigmatek Starlink Ultra Arctic (Pack x 3) (EN40856)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt/ Fan case Xigmatek Starlink Ultra Arctic (Pack x 3) (EN40856)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/Z_sEyzXG5dgFDTQ1RDfklE501_mksBYpCunGPynNUKX6_mlmssWsZUL-yV1gcSdWEjdSw1UCTW7FVjdJ3dAH46FShUxexvc=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt khí Xigmatek Starlink Arctic (Pack x 3) (EN41310)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khí Xigmatek Starlink Arctic (Pack x 3) (EN41310)', N'Xigmatek', 1000000, N'https://lh3.googleusercontent.com/CrOp0KJKh7dc5MZyQPMsL46G4LTZYxDtvL_s8G4rLuRjP1VcwXtwdD3OoO64fOyJnHpbZLaDS6YWaZHIavhTchogApIep5Iz=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Quạt/ Fan case Xigmatek Starlink (Pack x 3) (EN41303)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt/ Fan case Xigmatek Starlink (Pack x 3) (EN41303)', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/oxAzdVoUxr-adO8gLOGPbESc6lwKgTeQAYb2J29jaQ6Qn8lsUD8eGW7LKXazRg4oASNhkyKRqJOQcKdRy6SU84zIBzAcKgp-=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard ASUS PRIME B760M-A D4-CSM (DDR4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard ASUS PRIME B760M-A D4-CSM (DDR4)', N'Asus', 4000000, N'https://lh3.googleusercontent.com/Rpw0hdG-w9N0eqOeZ98oDiaOEx7zC1TVswqSyQ_AdlH8qxN666so5uLLYYUkhDl0oLlGT-SLcCuhZjXuf8DTYL--NyUvGRc=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Storage: Ổ cứng gắn trong/ HDD WD 6TB Blue 5400RPM 256MB 3.5" SATA 3 (WD60EZAX)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ HDD WD 6TB Blue 5400RPM 256MB 3.5" SATA 3 (WD60EZAX)', N'WD', 2500000, N'https://lh3.googleusercontent.com/TNiyb4xt1UoXE-mVsi4n8rZo6cCZ4bXViIQc9IwpsBelDVX-_TMXCaRylGJAGnBhTmI5o_-sMQ2X1k5kQbZ3ELyq0BPMivLM=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard Gigabyte B760M D DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte B760M D DDR4', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/oVLpvMOWZiIvVfwOy_EHDUmakmZBr0mAx10a_y-3yuW7dhvKbyPaSdyoq3CIsapuqFZ4vyFSty_WX4xh3FUGUn148gUgThVqJA=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- PSU: PSU MSI MAG A850GL PCIE5 80 PLUS Gold, Full Modular (306-7ZP8A11-CE0)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'PSU MSI MAG A850GL PCIE5 80 PLUS Gold, Full Modular (306-7ZP8A11-CE0)', N'MSI', 2200000, N'https://lh3.googleusercontent.com/E319AJayShlk_MOHtgVR65f5Fi7nHf0HXSXwqjt-CxPtUWb8EsAhXxOlK-dkYnxPEju035A03ynoj2NPxnplTgjv4mJmbEIy=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Mainboard: Mainboard ASUS PRIME A620M-A DDR5 (90MB1F10-M0UAY0)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard ASUS PRIME A620M-A DDR5 (90MB1F10-M0UAY0)', N'Asus', 4000000, N'https://lh3.googleusercontent.com/dyyI7qJQRQR_hfs2QAVd5A_NfoC380-x2QrC0QiC1-eYFMejBf6oHfIruDPEAu8e7ToUbKMqo3M0wy7uG0UrKsP_4PMpua8-RQ=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM desktop Adata XPG LANCER RGB (1 x 16GB) DDR5 6000MHz (AX5U6000C3016G-CLARWH)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Adata XPG LANCER RGB (1 x 16GB) DDR5 6000MHz (AX5U6000C3016G-CLARWH)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/kDA8TG7n-zGmWDJn1dyNITTr6bRutoC41hIm9sW_CI5A4tep01UlZB2S0k0Aw2nlMVkb-B3SylhmtSKAu8Lvdn0lYFCjpfn_=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 6000, 'CL16');

    -- RAM: RAM desktop TeamGroup T-Force Delta RGB (1 x 8GB) DDR4 3600MHz (TF4D48G3600HC18J01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup T-Force Delta RGB (1 x 8GB) DDR4 3600MHz (TF4D48G3600HC18J01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/eJIOl_hAs65gk3uFHzyDGSyBRXCLneAAeDkYgaB2-_LnuBGJdHhFd0IhFb0FF3msnICreURiFt8aEPJvnHYjsUEylIsfh3yF=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3600, 'CL16');

    -- Storage: Ổ cứng HDD WD My Book Multi (WDBBGBHBK-SESN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng HDD WD My Book Multi (WDBBGBHBK-SESN)', N'WD', 2500000, N'https://lh3.googleusercontent.com/uyusaPIziWnTNUf6f89IkoEyNiqPugMI68NnrIAkRbGy3pb0yEhZu_QpjpxHUxI2np6ZcL6KDj7KM-JS3fheoaaT0othEBxy=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt nước Corsair iCUE LINK H100i RGB (CW-9061001-WW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước Corsair iCUE LINK H100i RGB (CW-9061001-WW)', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/vGUV7SfNBYDSc5JPQ6Gx7NGJ618vVD4pj5mRI4tHDIfB4au-aGAaWGeQKRWsK8_R5BpHIcBokpjL0oVes5DvNJWqVBksaJ_k=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU AMD Ryzen 5 7600 (6 nhân 12 luồng - Boost to 5.1 GHz - 32MB - AM5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD Ryzen 5 7600 (6 nhân 12 luồng - Boost to 5.1 GHz - 32MB - AM5)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/wR0u3rLjTzTFESVSNWMbk7XxjYuwJK_l8-ajP7d7hwp5hnWdEKoCWEaQvpe0Y0Vyncjml0UZnPA5Tbw9SeR9zti_3hRprscScQ=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Mainboard: Mainboard Asus PRIME H510M-K R2.0
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus PRIME H510M-K R2.0', N'Asus', 4000000, N'https://lh3.googleusercontent.com/mOTh-TpctMRImqtsCUS4jhObp56VRdUCDYK77ZW2E8TsOUsoTPFvY_pqyA9zENdUL6oKVckyCl4rLd6rTtUxiRWTb1aKK9s=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'AM4', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Storage: Ổ cứng di động HDD Transcend StoreJet 8TB 3.5" T3(TS8TSJ35T3)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng di động HDD Transcend StoreJet 8TB 3.5" T3(TS8TSJ35T3)', N'Transcend', 2500000, N'https://lh3.googleusercontent.com/xBDukHgkw1CBgXNFG1pHnkVAE024zJqthR80p4yY2Mf7jyhJtSAtbzb5d9Cde9GAPdpeLYnO45SZ_naXZLUsYsD52WSqei-0OA=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn trong SSD Samsung 990 Pro 2TB M2 PCIe 4.0 (MZ-V9P2T0BW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong SSD Samsung 990 Pro 2TB M2 PCIe 4.0 (MZ-V9P2T0BW)', N'Samsung', 2500000, N'https://lh3.googleusercontent.com/_JD1lV2F3XaKUOm7Y1naRoMc0zkyM2PPfXQnBJudM23rJSlxUMMMkwfPNmc4b_iYo0aIScDn-6lY4gd7v_vx6-37mGxiJJ4=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: BỘ TẢN NHIỆT NƯỚC NZXT KRAKEN 240 RGB WHITE (RL-KR240-W1)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'BỘ TẢN NHIỆT NƯỚC NZXT KRAKEN 240 RGB WHITE (RL-KR240-W1)', N'NZXT', 1000000, N'https://lh3.googleusercontent.com/XKVoJ4S_8YaUJYxlj2vswWvRKQCHaBbQ4Z7VbDUj7nolVMuyS_9dke0gsM3dBZGRnh6OiE6JdpYCzTi6-rN75hhBB967lcgpwg=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Card màn hình Asus GeForce 710 2GB EVO 2GB GDDR5 (GT710-SL-2GD5-BRK-EVO)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asus GeForce 710 2GB EVO 2GB GDDR5 (GT710-SL-2GD5-BRK-EVO)', N'Asus', 15000000, N'https://lh3.googleusercontent.com/nFd1eU-m7BNj8UGUa56rpAnwImtmTYLV6Lkd5Z0kMifSffvHa_PvQp-4-Gvr00SF_LLMnvWpjEZUn5bR-G5OopXzwLER9mkh8w=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 2, 650, 300);

    -- Storage: Ổ cứng gắn ngoài HDD Western Black D10 Game Drive 8TB (WDBA3P0080HBK-SESN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn ngoài HDD Western Black D10 Game Drive 8TB (WDBA3P0080HBK-SESN)', N'WD', 2500000, N'https://lh3.googleusercontent.com/ndmPMD0XDWQxyvgFECikDmA9qS3M2xtevXac_DcAfQQsCIwKhbrY_5-J1Lkd234z7xXpPbCK2q3fp4PfZqXIa5tMtLbW8jf_=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Tản nhiệt khí SEGOTEP Lumos G4-150W ARGB (Only Intel LGA) (SC365N300500)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt khí SEGOTEP Lumos G4-150W ARGB (Only Intel LGA) (SC365N300500)', N'Intel', 1000000, N'https://lh3.googleusercontent.com/j9xpVovR3ypVLKeNqLsiGZL-gn-NM_uTIWWiK3GFJ46-jRuFzu3Zs-HcNhYVVS-OvlkESxsyGDfH8S5e1OEYrzmoxtauv0k=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Bộ 2 Quạt Tản Nhiệt NZXT F140RGB 140mm Twin White
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ 2 Quạt Tản Nhiệt NZXT F140RGB 140mm Twin White', N'NZXT', 1000000, N'https://lh3.googleusercontent.com/QwzjYEmDGugJo9x2AzFYzz19zYdph6sFMzXjeX2Db0_3s0RSWuY2cti_-VKnY81lbyF6Zh9iqmjJSwahbEaF8s4ttpxbbio=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Cooler: Bộ 3 Quạt Tản Nhiệt ASUS TUF GAMING TF120 ARGB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ 3 Quạt Tản Nhiệt ASUS TUF GAMING TF120 ARGB', N'Asus', 1000000, N'https://lh3.googleusercontent.com/BtdZ75gaTnzy_5dHWu-pdNAnYF6oSz8oXg6SEjDE-kUqQvXCYKC8Ip_sKitsuQJscce884fBaBJSvSeEXfY-wqu9hLZLhZ6R4g=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy tính/ Case MIK LV12 MINI ELITE
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy tính/ Case MIK LV12 MINI ELITE', N'Other', 1500000, N'https://lh3.googleusercontent.com/3vWOTf_2HJYfuEUc3Kth5lJHuQNNsD-p0Ass0hKwmi4Cq2DgGBWWyl7MRAdI5WvpjixghKiuhTWRalVjKCmGbZbt4sHxy13-=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Msi MPG A1000G PCIE5 - 1000W - 80 Plus Gold - Full Modular
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Msi MPG A1000G PCIE5 - 1000W - 80 Plus Gold - Full Modular', N'MSI', 2200000, N'https://lh3.googleusercontent.com/4a67klcPPe9ghfGfolNs6RIbozbFCc_o8Hf5N-jHYbTsgz0CIzMgvdklnKCFhi4WSmvHzkq7MH5afluBhiDT9ARw_iCzUW-I=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM laptop Adata (1 x 8GB) DDR5 4800MHz (AD5S48008G-S)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Adata (1 x 8GB) DDR5 4800MHz (AD5S48008G-S)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/5PIljiMYXFJLSf1sJ905vqYih1ZuRAa5Kyn9NpcQjsbAP0JW-1OYrrlpEMLKsoebwKcpao1r-3a0FiM-3IUPSvBNNG6qYUfY=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 8, 4800, 'CL16');

    -- RAM: Ram Desktop ADATA XPG D50 DDR4 16GB (1x16GB) 3200 RGB Grey (AX4U320016G16A-ST50)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ram Desktop ADATA XPG D50 DDR4 16GB (1x16GB) 3200 RGB Grey (AX4U320016G16A-ST50)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/cGnrvo9B18dkarXFdsEyEzgwm1q0xA3eFX2RjqzCKrlvmtruHByS69q5kp2FPQPPXs2fvNRu8CBZDDUmLEwCdaOyUzdK67tg=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Storage: Ổ cứng WD MY PASSPORT SSD 4TB - Space Gray (WDBAGF0040BGY-WESN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng WD MY PASSPORT SSD 4TB - Space Gray (WDBAGF0040BGY-WESN)', N'WD', 2500000, N'https://lh3.googleusercontent.com/xHq4ifjjgctt_P4DYOphYLE2rF4sxiZMdqMwgZJLhzB1SGVr8fA7-2Pl_MCe3Q0HiBNsdVkY7yuJY7qBB4iHY4vmi3pZdacF=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn ngoài WD ELEMENTS DESKTOP 16TB MULTI-CITY ASIA (WDBBKG0160HBK-SESN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn ngoài WD ELEMENTS DESKTOP 16TB MULTI-CITY ASIA (WDBBKG0160HBK-SESN)', N'WD', 2500000, N'https://lh3.googleusercontent.com/bslQhatwNBI7CzJ17toKHpm6-K4pHwraSGZHD_ptnqVVg-aq92gpifXgVCimX6kr0GGKZqKxKBM1CAXGOcsafW75LbWp3bo=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Corsair Dominator Platinum RGB (2 x 32GB) DDR5 5600MHz (CMT64GX5M2B5600C40W)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Dominator Platinum RGB (2 x 32GB) DDR5 5600MHz (CMT64GX5M2B5600C40W)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/LZ_8DI1scb78fsFQ9Zi-AgQtZLDH8Mv6Tv7VLOjOf0bmO05bL8huqBreiB2n3lWtigeUXfPlHRt02iOJ-h0iEPLKo43y9TI=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 32, 5600, 'CL16');

    -- Mainboard: Mainboard Msi PRO B760M-P DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO B760M-P DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/BWOvhhA5FvBIybj7gn5mlLeRPzjnsiAB4BWtflcAm-50yTEq9Y04c8Oz3sPMRmBy4DKXls-jf9_VTYo0_Otclh4FqSEtd4ZczA=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Msi PRO B760M-A WIFI DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Msi PRO B760M-A WIFI DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/RrbUm1lU9hxU31DuoMgGCFqXNsf_7ejLa_TDNg8SjnTZu1O-EDbhSxPaZJNeo0JIU47U-izO_DsqSZoEN8_-taaqbMtf_kE=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Gigabyte Z790M AORUS ELITE AX DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte Z790M AORUS ELITE AX DDR5', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/gySQ5T5iaGm7f-bU3K6c1RgoHmB-XY6qMmmEkFBipXBeNtDPiHMfW6m5VXsHSmOq1rLPKz7rnSMD6BDyFPhXhlQ75E5B5Hov6A=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Gigabyte B760M DS3H DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte B760M DS3H DDR4', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/R456bjilFfPSmy6hvQaAiNSYaG2cw08tFhs8vKOCfQdGiBJxaqDWYJoWunIBAPp4iG8B603HqI6PZA8EY7Uwg0A13AjMSGqw=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: CPU Intel Core i3-13100 (4 nhân 8 luồng - Boost tối đa 4.5 GHz - 12MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i3-13100 (4 nhân 8 luồng - Boost tối đa 4.5 GHz - 12MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/IPDzBPUR0JdiSIWUUXFNSE0-oRZ1ENgqRdqDhjfTvaaSSI-Am8GAPeulNcuThy6saiCJaFTozVBTYXr6vsjyj4t4IKgFQcFK=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 4, 8, 3.5, 65, 1);

    -- Mainboard: Mainboard MSI PRO H610M-E DDR4
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard MSI PRO H610M-E DDR4', N'MSI', 4000000, N'https://lh3.googleusercontent.com/4hH0wL0dbi0qBhWejIXnWLoSctWJD89WXYCPv7VpK6yesqgvebPplpJGzqqes0nTQCAxC_9OK96Ymf_f9KPXNpI70e6x0hKc=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- RAM: RAM laptop Adata (1 x 16GB) DDR4 3200MHz (AD4S320016G22-SGN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Adata (1 x 16GB) DDR4 3200MHz (AD4S320016G22-SGN)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/N4Hry2Cku-F4179z_tMNuDqeedoBQUTE1MOHj5SqwiE3BdFtzdPll2c-baTNMWdSKjniw6rzXTIrX4KuTPzFvgVZ5CVADKI1=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Storage: Ổ cứng gắn trong/ SSD Adata LEGEND 710 1TB M.2 NVMe Gen3 X4 (ALEG-710-1TCS)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD Adata LEGEND 710 1TB M.2 NVMe Gen3 X4 (ALEG-710-1TCS)', N'Adata', 2500000, N'https://lh3.googleusercontent.com/yzidrXA1Y4cNHAIEZbbyLNdMGtUbj3OKfDP3cLnXZjgVyos6R3gJd6D1VZaL5nJwrf-vY2gZkTmVSNX1jpK-5NCmIVr6pFHRUw=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: Ram Desktop ADATA XPG D50 DDR4 8GB (1x8GB) 3200 RGB White (AX4U32008G16A-SW50)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ram Desktop ADATA XPG D50 DDR4 8GB (1x8GB) 3200 RGB White (AX4U32008G16A-SW50)', N'Adata', 1800000, N'https://lh3.googleusercontent.com/fXjgi0R_fR7Ad2arhS_yPWZKTCdubRSZpoxJURcwgjhRCkeS4pAxnkoMowE3N8Bf8hVAX8XOADx_wk8GvVBdXB3JI13Z-50l=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- Mainboard: Mainboard Asus PRIME Z790-P WIFI-CSM DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Asus PRIME Z790-P WIFI-CSM DDR5', N'Asus', 4000000, N'https://lh3.googleusercontent.com/5dD24snivfPsYH-ZQWfhxF-wVIPnbg6DqhM9rjkSSShZY6zitDzc06mJ5Q3VdAo7fBN_gxtcttw2LiH6hMOUqq2U2He6PUzH=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Gigabyte Z790 UD DDR5 | Socket 1700
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte Z790 UD DDR5 | Socket 1700', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/9lYLgpkIkF1GYMMeNa85Z6r3kqfXxJTtIDUz8Nrp_Vxmjizp1R7d0mRtZao5l2SwxdM1D8cyV2p7zhY8HbTGLBEGoadH89Dw=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- Mainboard: Mainboard Gigabyte Z790 UD AX DDR5
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Mainboard Gigabyte Z790 UD AX DDR5', N'Gigabyte', 4000000, N'https://lh3.googleusercontent.com/ztS2gjO00RUheoUaKy9UdtgnfEB9XTLSkar2F9s0feRPG7AzEoAATvBuLcD_GY0Ess7sxwmNSSxunAAHYh10tYVjq_kqYzSh=w230-rw', @MainboardId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Mainboard_Specs (MainId, SocketType, Chipset, FormFactor, RamSlotCount, MaxRamCapacity, RamTypeSupported) VALUES (@CurrentPId, 'LGA1700', 'B760', 'M-ATX', 4, 128, 'DDR4');

    -- CPU: CPU AMD Ryzen 5 7600X (6 nhân 12 luồng - Boost to 5.3 GHz - 32MB - AM5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD Ryzen 5 7600X (6 nhân 12 luồng - Boost to 5.3 GHz - 32MB - AM5)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/Alk_MPf37oTCEpc2J4IentkcXuULmeyMNdTRuuJDq5Sb8AqR1dWd1jIoLmIy9PoermcwJTDKUaPPzk4OnTJUs9V8JiyoU-aR6g=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Case: Thùng máy/ Case MSI MAG FORCE M100A (4 Fan RGB)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case MSI MAG FORCE M100A (4 Fan RGB)', N'MSI', 1500000, N'https://lh3.googleusercontent.com/njx3uM_e8kZEzZt1dy0rnfq3qD6nehyZyhpxeelB4BDzHGV3XTPvu0AmcPp-HjqZ7uVU282KA3gtT01ZUF4kL10-PhDcwrZC=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính MIK SPOWER 500 - 500W -
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính MIK SPOWER 500 - 500W -', N'Other', 2200000, N'https://lh3.googleusercontent.com/exVHrCwBzvrYdw5D8RXCUCZ8oQK6IQOPb4oABVlwq3iSAQ7Ot4QFpleHtebr8KaidRwoXMSPw5Ed1x2WOYHPwEo3E4dSpjMG=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM laptop Crucial (1 x 16GB) DDR5 4800MHz (CT16G48C40S5)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Crucial (1 x 16GB) DDR5 4800MHz (CT16G48C40S5)', N'Other', 1800000, N'https://lh3.googleusercontent.com/nhsU6c1ddzVVjqm04sETfLLh8ZgLQeIyKfVZ7WofKYbHHrouJxNpVIr0lg0PTkCwvWcNfPQAfQgkmHq7culPJQ2y7-4-VzICEA=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 4800, 'CL16');

    -- Storage: Ổ cứng SSD Crucial BX500 1TB 2.5" SATA III (CT1000BX500SSD1)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD Crucial BX500 1TB 2.5" SATA III (CT1000BX500SSD1)', N'Other', 2500000, N'https://lh3.googleusercontent.com/nsXYNQJXhTWJ-FULAkb6h3h3EmhJqmrm47aO1A18jjNkFaSThX8MNSGKGmW3ceilXZnxQHY61qcVSBZmBMDbFa35L7XrTZQfhg=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop Kingston FURY Beast (2 x 16GB) DDR5 5600MHz (KF556C40BBK2-32WP)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast (2 x 16GB) DDR5 5600MHz (KF556C40BBK2-32WP)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/onw2JW2aGIhFyCj2mt9uXDwgrfG52Zwji7Hkg8Ue6ePdON9Ey3t8-Sq9HDjXEXZQYIMIK69ibT-wjzE2Je6TZEMYfGyZT66a=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 16, 5600, 'CL16');

    -- RAM: RAM laptop Kingston Fury Impact (1 x 8GB) DDR5 4800MHz (KF548S38IB-8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston Fury Impact (1 x 8GB) DDR5 4800MHz (KF548S38IB-8)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/ki1cwlsfBzjoK1Xlo2805Nsvn4oxxn24IU8X7tRIUSl5EikmDVPiz6R1NgRcygnCfJqAP7t4YecX_y8JJ8YxJ8QqQcMzZT7t4Q=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 8, 4800, 'CL16');

    -- RAM: RAM laptop Kingston (1 x 8GB) DDR5 4800MHz (KVR48S40BS6-8)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM laptop Kingston (1 x 8GB) DDR5 4800MHz (KVR48S40BS6-8)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/zlYZ2qkG-9m66fz71S1rttgKWPaws-ucLW6Zg2ln1IO2zQKPTG36_MbLoiB4UX1Wfx9HfqnSrUEAUQinpBdq9tgoVGAThFAeHw=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR5', 8, 4800, 'CL16');

    -- GPU: Card màn hình Asrock Radeon RX 6500 XT Phantom Gaming D 4GB OC 4GB GDDR6 (90-GA3DZZ-00UANF)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Asrock Radeon RX 6500 XT Phantom Gaming D 4GB OC 4GB GDDR6 (90-GA3DZZ-00UANF)', N'Other', 15000000, N'https://lh3.googleusercontent.com/wPM8-R4pdH5b9QANtZCtZbyK_4ICF1A2-CSdUeqSsGJFmlgzXQxYkHWDMsTvEESeSCZmfRec6l4Fy0yNWUlvtx3UjZ9rkAU=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 4, 650, 300);

    -- PSU: Nguồn máy tính Xigmatek X-Power III 650 - 600W -
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Xigmatek X-Power III 650 - 600W -', N'Xigmatek', 2200000, N'https://lh3.googleusercontent.com/qnI4HpVKxwC1LYLTZtgSUd4ryGeqdsZJKvD9p2Gs2YArog454L53nhrem3D0LkFEixf9qvQCdOQj9gOxURz2WEX4f_irJznS=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- PSU: Nguồn máy tính Xigmatek X-Power III 550 - 500W - 80 Plus
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Xigmatek X-Power III 550 - 500W - 80 Plus', N'Xigmatek', 2200000, N'https://lh3.googleusercontent.com/3K_U2jF_-8MCiPgxdCZ0THpJwmudtMdf29ZQjlxQag3fogSD_IEjpVhvntoHrymftChjioIoGMiOOMkYWQf708e28j6x0Eys=w230-rw', @PSUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Tản Nhiệt Khí CPU ID-Cooling ARGB White (SE-214-XT)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản Nhiệt Khí CPU ID-Cooling ARGB White (SE-214-XT)', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/HOAeRYwEYAqX6z7KRvoFjtVFRqOe8CHePtchxoIdkRvGlHdejqwkdkYDluSSWkHVem7mZ_TXZqNl_5htKKoMpMzoJIEnWwwBmA=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: Tản Nhiệt Khí CPU ID-COOLING SE-214-XT
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản Nhiệt Khí CPU ID-COOLING SE-214-XT', N'ID-COOLING', 8500000, N'https://lh3.googleusercontent.com/WKyxJY8LZJ8q4Czvh7K-vghbCuUhRNKiKDI327pOUX_RY25j1q4MYrsauzHmKMIT3aBJAWOry38gYq2KSGLLPZQsUUTUrLP7fQ=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- RAM: RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB/16)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Kingston FURY Beast (1 x 16GB) DDR4 3200MHz (KF432C16BB/16)', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/unYg4X0Q6t8sFDhqL8m881seifrfgBCB9R91qASYt-nd_PMv_qCG_ExGjGZd-vqVu0lgZ7yjqlptJflW2Kex8njIbuPy6t1dww=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- RAM: RAM desktop Corsair Vengeance RGB RS (1 x 8GB) DDR4 3200MHz (CMG8GX4M1E3200C16)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Vengeance RGB RS (1 x 8GB) DDR4 3200MHz (CMG8GX4M1E3200C16)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/IhbT64G7x_rrNQlWXkL2RPJq_RnmQXi9ColXx9snyGU9C-bNF1icRPcMx3EOixtX_w2O_Lbzy4H_nCZSyOE_nOeLL5tQvQA=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- RAM: RAM desktop Corsair Vengeance LPX (1 x 16GB) DDR4 3200MHz (CMK16GX4M1E3200C16)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop Corsair Vengeance LPX (1 x 16GB) DDR4 3200MHz (CMK16GX4M1E3200C16)', N'Corsair', 1800000, N'https://lh3.googleusercontent.com/eDC6WmRWRrd2FbjtXbvcJoR-R0LJX3mfsGBYQ235T0wuYtCu4ArvDU9fd8WI4xc8g9TWc6QaygNVGGFbKfww3pxBK_i_oK6_Dg=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 16, 3200, 'CL16');

    -- Case: Thùng máy/ Case Xigmatek XA-22 (ATX) EN47567
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Xigmatek XA-22 (ATX) EN47567', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/Frsl-aWvH6H2x3OwiiiC0WDAk-x3_mQvn3zifMD-F9Hg4hwvgIzoOsLO2fuK3GHAprJppnmFIWZAxFtZ6KAI7j7osDSJ7PL8EQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM desktop TeamGroup T-Force Delta RGB (1 x 8GB) DDR4 3200MHz (TF4D48G3200HC16C01)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM desktop TeamGroup T-Force Delta RGB (1 x 8GB) DDR4 3200MHz (TF4D48G3200HC16C01)', N'TeamGroup', 1800000, N'https://lh3.googleusercontent.com/gd9J1RpwyuQwq6fQKTwktZy3GwC45L1HPyqKeXbP7BW5CMWk3tOVvkIooy-fsSC_Qbs5W_h6fYcvFqK-HDEoUVNH-UlzmAUW=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- CPU: CPU Intel Core i7 12700 (12 nhân 20 luồng - Boost tối đa 4.9 GHz - 25MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i7 12700 (12 nhân 20 luồng - Boost tối đa 4.9 GHz - 25MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/QeLS8I3SDcVFFhzddVa91zGXzmu2Mn5HpMaquWV-CbDU8d_TWdoUe6h_6S2Qa8rQEoCPfTjGLegtTH3X_TN6S_D0W0mQOHKo=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 12, 20, 3.5, 65, 1);

    -- CPU: Bộ vi xử lý/ CPU Intel Core i5-12500 (6C-12T | Up to 4.60GHz | 18MB | UHD Graphics 770 | LGA1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Bộ vi xử lý/ CPU Intel Core i5-12500 (6C-12T | Up to 4.60GHz | 18MB | UHD Graphics 770 | LGA1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/YHDSV6HbyHrldbyqNZiwhXtcAQnVOabkiESJH81YrD02wsxQXRcoIsKUS30_ELc7ttESo-JDduOBGFOmiuFXcPc_utIRKBxIeg=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU Intel Core i5-12400 (6 nhân 12 luồng - Boost tối đa 4.4 GHz - 18MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i5-12400 (6 nhân 12 luồng - Boost tối đa 4.4 GHz - 18MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/wxwqYcEobO1IblY-dsEHmX1ilKSvQ2T28F0TnS7EI-dMslwjiBSivvjBAqu73-C1Oqd_cM7XYfMS_8Zerpvm67go4IZ9xcKA=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU Intel Core i5-12400F (6 nhân 12 luồng - Boost tối đa 4.4 GHz - 18MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i5-12400F (6 nhân 12 luồng - Boost tối đa 4.4 GHz - 18MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/bS481zyhlAwA76r5LJ8NBo4NPDwfH3mm379rSwKVgClX7pTICwk2nPp63clj8t7avWkgCiHWgSGXotcCG1R0h4E_LU825n57=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU Intel Core i3 12100F (4 nhân 8 luồng - Boost tối đa 4.3 GHz - 12MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i3 12100F (4 nhân 8 luồng - Boost tối đa 4.3 GHz - 12MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/NZdYMEdMAqsThjgpo4XGHf4AkCUwJz37pOTiwINmWU5PNp-3KF9lJO_2VSHB84BZB3b60BK6YMlE-uWavk_KIe8glHdKLkNCrA=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 4, 8, 3.5, 65, 1);

    -- GPU: Card màn hình Gigabyte Radeon RX 6500 XT EAGLE 4GB GDDR6 4GB GDDR6 (R65XTEAGLE-4GD)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Card màn hình Gigabyte Radeon RX 6500 XT EAGLE 4GB GDDR6 4GB GDDR6 (R65XTEAGLE-4GD)', N'Gigabyte', 15000000, N'https://lh3.googleusercontent.com/5jxMFBbyhUfEkMqFLvqhMMwdSF44bdz8qiWD_AcE6XSsM_grexEt7Q609xtruzS0UAKKYwnhbEKr4y6c4OlJpAlKj3vfR5s=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 4, 650, 300);

    -- CPU: CPU Intel Core i5-12600K (10 nhân 16 luồng - Boost tối đa 4.9 GHz - 20MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i5-12600K (10 nhân 16 luồng - Boost tối đa 4.9 GHz - 20MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/_KZ0suSdLRf3231-bncLXg4dlp4_yn7JN1AE9o_UPIM--GGpEqOVhbYyxqiv8mlGSP5cWSCDP9x-TscJ8mTsFaQr6apHvXF6=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 10, 16, 3.5, 65, 1);

    -- Cooler: Tản nhiệt nước/ AIO Corsair H100 RGB (CW-9060053-WW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Tản nhiệt nước/ AIO Corsair H100 RGB (CW-9060053-WW)', N'Corsair', 1000000, N'https://lh3.googleusercontent.com/UYPLIdOYbz5dFWD4pFTt7FHDjdqn22XdDo7uaV2NqIU6nNsOUWkktuP_jrq2yADizpBiwCsLSBmflAK1OJijSpAmKZmK10_a=w230-rw', @CoolerId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU Intel Core i7-12700KF (12 nhân 20 luồng - Boost tối đa 5.0 GHz - 25MB - 1700)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU Intel Core i7-12700KF (12 nhân 20 luồng - Boost tối đa 5.0 GHz - 25MB - 1700)', N'Intel', 8500000, N'https://lh3.googleusercontent.com/dN3GKbyRDAebLUwsydY--lNKNeDHfX7ETJe0Udvv_oN-CwsPSvMny3wt9tInL8iQ41ZbW-hVRuDmBVPtEEG8ZK2ONGn4DKE=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 12, 20, 3.5, 65, 1);

    -- Case: Thùng máy/ Case máy tính Deepcool Matrexx 40 3FS
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case máy tính Deepcool Matrexx 40 3FS', N'Other', 1500000, N'https://lh3.googleusercontent.com/RzdA51i7UbEdZZJ_EgFqgb6OwJNgvBdaew8Au4t45g4O3--sagH0RDk4OOMVRJAoDM9q_XQTiMr95EhYuHtrDxh_N0knnX9-=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Storage: Ổ cứng gắn ngoài HDD WD Element - 14TB 3.5'''' (WDBBKG0140HBK-SESN)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn ngoài HDD WD Element - 14TB 3.5'''' (WDBBKG0140HBK-SESN)', N'WD', 2500000, N'https://lh3.googleusercontent.com/Y1Ur0-V4j-0IjrebBEzXwrE53WpG0wKjICW-YIL_oO4o90bbTGJKJT2kSTnMdDd_uH7JVU-TJgDCyKQMgTg76J7Z0w6uPRs=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Phong Vũ PV-880B (Black)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Phong Vũ PV-880B (Black)', N'Other', 1500000, N'https://lh3.googleusercontent.com/xz99JjjvJdYDpFApQhAzyfQ-rCC1AzaFMtEEfZ7npj6BEeZID2iIkxf6k9b84iqyRnpvX1_uAGXOnp1H48dfMbiMwR2UoG0=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: Quạt CPU CM Hyper 212 Spectrum V2
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Quạt CPU CM Hyper 212 Spectrum V2', N'Other', 8500000, N'https://lh3.googleusercontent.com/RINgoFD3NyHUaqD0ZwY569tGI9J21Qm8QYnKaF9sb4PhxHx9qwuNAfKwwNhf_D3qHOwCYvzd4yfXMiwC4mSFRTbf3oi19B6h=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- Storage: Ổ cứng gắn trong/ SSD Samsung 870 EVO 1TB SATA III 2.5 inch (MZ-77E1T0BW)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng gắn trong/ SSD Samsung 870 EVO 1TB SATA III 2.5 inch (MZ-77E1T0BW)', N'Samsung', 2500000, N'https://lh3.googleusercontent.com/s77gZKAuA7JOhZAWRIkg8XZuFVQUMcEWDqQETv7eyKQJu-UViA85UqhJ-9iehv2V31LMcsm6Pl6Cb0lGN22mXGG8wP6jY3Uu=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- Case: Thùng máy/ Case Xigmatek XA-20 (ATX) EN46072
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Thùng máy/ Case Xigmatek XA-20 (ATX) EN46072', N'Xigmatek', 1500000, N'https://lh3.googleusercontent.com/QCxURWC9YCdM0Cw-wwsY3VQI3QrX2DeoQgSmiYGgu6O28-sLg6UuAZtnyho7Wm11uvynQQiaoC3hQM2x0EwVpK12EhWK70WkRQ=w230-rw', @CaseId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- RAM: RAM Laptop DDR4 Kingston 8GB
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'RAM Laptop DDR4 Kingston 8GB', N'Kingston', 1800000, N'https://lh3.googleusercontent.com/nb3WdiSwMzMAe1RHfSrXfxiqqrL5kZUqAJQSSNXBd1Hg-_YygHVAsgNqyTVyGN_6w7WO8QxKEAN4Fw9Qs71L=w230-rw', @RAMId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Ram_Specs (RamId, RamType, Capacity, BusSpeed, Latency) VALUES (@CurrentPId, 'DDR4', 8, 3200, 'CL16');

    -- CPU: CPU AMD RYZEN™ 3 3100 (4 Core/8 Threads - 3.6 GHz Up to 3.9 GHz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 3 3100 (4 Core/8 Threads - 3.6 GHz Up to 3.9 GHz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/jjjhG837xam0LscMe-veRAhxf517Ci07OsOoq5804nKtRb9IEV8zeUYx1rhroUTaxkX26Y5AVCUSlHVfNQtbk2qT2wfbyZYH=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- CPU: CPU AMD RYZEN™ 5 3500 (6 Core/6 Threads - 3.6 GHz up to 4.1 GHz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 5 3500 (6 Core/6 Threads - 3.6 GHz up to 4.1 GHz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/LZ25GgiDK-2iUPR61RYozt2blBHxwmJt8OevqyVGnnAxr_PcU_WuUdGxJE9aP_CZOSKwSD7v0-mKCZX0Ze4B=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- Storage: Ổ cứng di động HDD WD My Passport 1TB 2.5" USB 3.2 (WDBYVG0010BRD-WESN) (Đỏ)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng di động HDD WD My Passport 1TB 2.5" USB 3.2 (WDBYVG0010BRD-WESN) (Đỏ)', N'WD', 2500000, N'https://lh3.googleusercontent.com/gfoOuw2WQHIH_7BlVXesGbn4TEvZp0ranMjoHZYitNB5t9q72pzroODvYELLZyoNHS0O_ZQfI345vbox_fXf=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- CPU: CPU AMD RYZEN™ 7 1800X (8 Core/16 Threads - 3.6 GHz Boost to 4 GHz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 7 1800X (8 Core/16 Threads - 3.6 GHz Boost to 4 GHz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/eQ4oxrFdD9ydOWoTfwzj67Lfgkjru8UyQenOQ4tDNT73GU21STn4YnPBdkwKM8mi8Izueyo145HsKZSnBDQr=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'AM5', 6, 12, 3.5, 65, 1);

    -- Storage: Ổ cứng SSD Kingston A400 240GB Sata 3 (SA400S37/240G)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Ổ cứng SSD Kingston A400 240GB Sata 3 (SA400S37/240G)', N'Kingston', 2500000, N'https://lh3.googleusercontent.com/UE9L3DwlVtE3pZnCwR29zgrf_SjHNOdopT3sunQbPWvIdYB3NYNanTkL-g9YNubL65chw7m1j4z7mEs53g=w230-rw', @StorageId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();

    -- GPU: Nguồn máy tính Golden Field Dragon GTX580 - 500W
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'Nguồn máy tính Golden Field Dragon GTX580 - 500W', N'Other', 15000000, N'https://lh3.googleusercontent.com/hmQtg8PakAnp42ciPWrqlYUxnfR3jjbU0wvTKDkYyJIyQKIZFyMHtWK1YoawXGG3fP62ovBx-TnknNv2bL4=w230-rw', @GPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Gpu_Specs (GpuId, VramSize, PowerRequirement, Length) VALUES (@CurrentPId, 8, 650, 300);

    -- CPU: CPU AMD RYZEN™ 5 2600 (6 Core/12 Threads - 3.4 GHz Boost to 3.9 GHz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 5 2600 (6 Core/12 Threads - 3.4 GHz Boost to 3.9 GHz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/x2jhKl5LlrHdtKrhuhKXiXiXpWUichYSEUGSZ206ijL1b0q5bhNnV0_bu9VdPlMRdPeDvf76uMqNh8qsH78=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU AMD RYZEN™ 5 2600X (6 Core/12 Threads - 3.6 GHz Boost to 4.2 GHz - 16MB Cache - AM4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ 5 2600X (6 Core/12 Threads - 3.6 GHz Boost to 4.2 GHz - 16MB Cache - AM4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/QH2o8bOLn9ue8BgKtTGdQN-cYIpuY9wdQ8busetwVO4H3NwEnqXiV11jSyowRoKuDjkSr0sr4mzAa1o6CLE=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    -- CPU: CPU AMD RYZEN™ Threadripper 1920X (12 Core/24 Threads - 3.5 GHz Boost to 4.0 GHz - 39MB Cache - TR4)
    INSERT INTO Products (ProductName, Brand, Price, ImagePath, CategoryId, CreatedAt, IsActive, IsHiddenFromRecommendation) VALUES (N'CPU AMD RYZEN™ Threadripper 1920X (12 Core/24 Threads - 3.5 GHz Boost to 4.0 GHz - 39MB Cache - TR4)', N'AMD', 8500000, N'https://lh3.googleusercontent.com/Hv_QSEPcYcFkF414c6IM3nkJ1kq-ft-zf8Hky4VCB4bV2vgROSKUdBTRholISnFWdeAZCaxn9rqpS9S-ig=w230-rw', @CPUId, GETDATE(), 1, 0);
    SET @CurrentPId = SCOPE_IDENTITY();
    INSERT INTO Cpu_Specs (CpuId, SocketType, Cores, Threads, BaseClock, TDP, HasIntegratedGraphics) VALUES (@CurrentPId, 'LGA1700', 6, 12, 3.5, 65, 1);

    COMMIT TRANSACTION;
    PRINT N'✅ Seeded successfully!';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
    PRINT N'❌ Error during seeding: ' + @ErrMsg;
END CATCH
GO