using Microsoft.EntityFrameworkCore;
using PCBuilder_DACS.Models;
using PCBuilder_DACS.Services;
using System.Text.Json.Serialization; // Thư viện để xử lý JSON

using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

// =========================================================
// 1. CẤU HÌNH SERVICES
// =========================================================

// Kết nối Database SQL Server
builder.Services.AddDbContext<PcBuilderContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Cấu hình Identity
builder.Services.AddIdentity<ApplicationUser, IdentityRole<int>>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequiredLength = 6;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequireLowercase = false;
})
.AddRoles<IdentityRole<int>>()
.AddEntityFrameworkStores<PcBuilderContext>()
.AddDefaultTokenProviders();

// Cấu hình Cookie Đăng nhập
builder.Services.ConfigureApplicationCookie(options =>
{
    options.LoginPath = "/Account/Login";
    options.LogoutPath = "/Account/Logout";
    options.AccessDeniedPath = "/Account/AccessDenied";
});

// CẬP NHẬT: Hỗ trợ MVC + Web API và FIX LỖI VÒNG LẶP JSON
builder.Services.AddControllersWithViews()
    .AddJsonOptions(options =>
    {
        // Dòng này cực kỳ quan trọng: Giúp AI và API không bị lỗi "Object cycle"
        options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
        options.JsonSerializerOptions.WriteIndented = true;
    });

// Cấu hình Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Đăng ký Service AI
builder.Services.AddScoped<IRecommendationService, RecommendationService>();
builder.Services.AddSingleton<ISentimentAnalysisService, SentimentAnalysisService>();

// Đăng ký Service Khách hàng thân thiết
builder.Services.AddScoped<LoyaltyService>();
builder.Services.AddScoped<VoucherService>();

// Đăng ký Service Trả góp
builder.Services.AddSingleton<IEmailService, MockEmailService>();
builder.Services.AddHostedService<InstallmentReminderWorker>();

// Hỗ trợ lấy HttpContext
builder.Services.AddHttpContextAccessor();
builder.Services.AddSession(); // Kích hoạt dịch vụ Session

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        await PCBuilder_DACS.Services.RoleSeeder.SeedRolesAsync(services);
    }
    catch (Exception ex)
    {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "An error occurred while seeding roles.");
    }
}

// =========================================================
// 2. CẤU HÌNH MIDDLEWARE
// =========================================================

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}
app.UseSession(); // Cho phép ứng dụng sử dụng Session

app.UseHttpsRedirection();

// QUAN TRỌNG: Cho phép Web load ảnh/CSS/JS từ wwwroot
app.UseStaticFiles();

app.UseRouting();

// Thêm UseAuthentication TRƯỚC UseAuthorization
app.UseAuthentication();
app.UseAuthorization();

// ĐỊNH NGHĨA AREA ROUTE CHO ADMIN
app.MapControllerRoute(
    name: "areas",
    pattern: "{area:exists}/{controller=Admin}/{action=Index}/{id?}");

// ĐỊNH NGHĨA TRANG DANH MỤC (URL đẹp: /Products thay vì /Product/Index)
app.MapControllerRoute(
    name: "products",
    pattern: "Products",
    defaults: new { controller = "Product", action = "Index" });

// ĐỊNH NGHĨA TRANG CHỦ MVC
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// Giữ lại đường dẫn API (Dành cho AI và Swagger)
app.MapControllers();

app.Run();