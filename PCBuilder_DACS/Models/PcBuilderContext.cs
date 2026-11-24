using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace PCBuilder_DACS.Models;

public partial class PcBuilderContext : IdentityDbContext<ApplicationUser, IdentityRole<int>, int>
{
    public PcBuilderContext()
    {
    }

    public PcBuilderContext(DbContextOptions<PcBuilderContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<CpuSpec> CpuSpecs { get; set; }

    public virtual DbSet<GpuSpec> GpuSpecs { get; set; }

    public virtual DbSet<MainboardSpec> MainboardSpecs { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<RamSpec> RamSpecs { get; set; }

    // Bỏ DbSet<User> vì IdentityDbContext đã có Users

    public virtual DbSet<UserInteraction> UserInteractions { get; set; }
    public virtual DbSet<ProductReview> ProductReviews { get; set; }
    public virtual DbSet<Order> Orders { get; set; }
    public virtual DbSet<OrderDetail> OrderDetails { get; set; }
    public virtual DbSet<InstallmentSchedule> InstallmentSchedules { get; set; }
    public virtual DbSet<Voucher> Vouchers { get; set; }
    public virtual DbSet<VoucherUsage> VoucherUsages { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=.;Database=PC_Builder;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.CategoryId).HasName("PK__Categori__19093A0B664CDDEA");

            entity.Property(e => e.CategoryName).HasMaxLength(100);
        });

        modelBuilder.Entity<CpuSpec>(entity =>
        {
            entity.HasKey(e => e.CpuId).HasName("PK__Cpu_Spec__CAD9B6B30B70E715");

            entity.ToTable("Cpu_Specs");

            entity.Property(e => e.CpuId).ValueGeneratedNever();
            entity.Property(e => e.SocketType).HasMaxLength(50);
            entity.Property(e => e.Tdp).HasColumnName("TDP");

            entity.HasOne(d => d.Cpu).WithOne(p => p.CpuSpec)
                .HasForeignKey<CpuSpec>(d => d.CpuId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Cpu_Product");
        });

        modelBuilder.Entity<GpuSpec>(entity =>
        {
            entity.HasKey(e => e.GpuId).HasName("PK__Gpu_Spec__E542DFA4A513F42A");

            entity.ToTable("Gpu_Specs");

            entity.Property(e => e.GpuId).ValueGeneratedNever();

            entity.HasOne(d => d.Gpu).WithOne(p => p.GpuSpec)
                .HasForeignKey<GpuSpec>(d => d.GpuId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Gpu_Product");
        });

        modelBuilder.Entity<MainboardSpec>(entity =>
        {
            entity.HasKey(e => e.MainId).HasName("PK__Mainboar__71F8F5CC4A85A9AB");

            entity.ToTable("Mainboard_Specs");

            entity.Property(e => e.MainId).ValueGeneratedNever();
            entity.Property(e => e.Chipset).HasMaxLength(50);
            entity.Property(e => e.FormFactor).HasMaxLength(20);
            entity.Property(e => e.RamTypeSupported).HasMaxLength(20);
            entity.Property(e => e.SocketType).HasMaxLength(50);

            entity.HasOne(d => d.Main).WithOne(p => p.MainboardSpec)
                .HasForeignKey<MainboardSpec>(d => d.MainId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Main_Product");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Products__B40CC6CD4D42EFD7");

            entity.Property(e => e.Brand).HasMaxLength(100);
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.ProductName).HasMaxLength(255);

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .HasConstraintName("FK_Product_Category");
        });

        modelBuilder.Entity<RamSpec>(entity =>
        {
            entity.HasKey(e => e.RamId).HasName("PK__Ram_Spec__8840B2776FC6CF22");

            entity.ToTable("Ram_Specs");

            entity.Property(e => e.RamId).ValueGeneratedNever();
            entity.Property(e => e.Latency).HasMaxLength(20);
            entity.Property(e => e.RamType).HasMaxLength(20);

            entity.HasOne(d => d.Ram).WithOne(p => p.RamSpec)
                .HasForeignKey<RamSpec>(d => d.RamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Ram_Product");
        });

        // Xóa cấu hình cũ của bảng User (Sử dụng cấu hình của Identity)

        modelBuilder.Entity<UserInteraction>(entity =>
        {
            entity.HasKey(e => e.InteractionId).HasName("PK__UserInte__922C04963AE65C79");

            entity.Property(e => e.InteractionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.InteractionType).HasMaxLength(20);

            entity.HasOne(d => d.Product).WithMany(p => p.UserInteractions)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_Interact_Product");

            entity.HasOne(d => d.User).WithMany(p => p.UserInteractions)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_Interact_ApplicationUser");
        });

        modelBuilder.Entity<ProductReview>(entity =>
        {
            entity.HasKey(e => e.ReviewId);

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.Property(e => e.Sentiment).HasMaxLength(20);

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_Review_Product");

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_Review_User");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId);
            entity.Property(e => e.OrderDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.TotalAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Status).HasMaxLength(50);

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK_Order_User")
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.OrderDetailId);
            entity.Property(e => e.UnitPrice).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_OrderDetail_Order")
                .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_OrderDetail_Product")
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<InstallmentSchedule>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Amount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Status).HasMaxLength(20);

            entity.HasOne(d => d.Order).WithMany(p => p.InstallmentSchedules)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_InstallmentSchedule_Order")
                .OnDelete(DeleteBehavior.Cascade);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
