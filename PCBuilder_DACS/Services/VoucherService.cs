using PCBuilder_DACS.Models;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

namespace PCBuilder_DACS.Services
{
    public class VoucherService
    {
        private readonly PcBuilderContext _context;
        private readonly LoyaltyService _loyaltyService;

        public VoucherService(PcBuilderContext context, LoyaltyService loyaltyService)
        {
            _context = context;
            _loyaltyService = loyaltyService;
        }

        public async Task<(bool IsValid, string Message, Voucher? Voucher)> ValidateVoucherAsync(string code, int userId, decimal currentSubtotal)
        {
            if (string.IsNullOrWhiteSpace(code))
                return (false, "Mã giảm giá không hợp lệ.", null);

            var voucher = await _context.Vouchers.FirstOrDefaultAsync(v => v.Code == code.ToUpper());

            if (voucher == null)
                return (false, "Mã giảm giá không tồn tại.", null);

            if (!voucher.IsActive)
                return (false, "Mã giảm giá đã bị khóa.", null);

            var now = DateTime.Now;
            if (now < voucher.StartDate)
                return (false, "Mã giảm giá chưa đến thời gian sử dụng.", null);

            if (now > voucher.EndDate)
                return (false, "Mã giảm giá đã hết hạn.", null);

            if (voucher.UsageLimit > 0 && voucher.UsageCount >= voucher.UsageLimit)
                return (false, "Mã giảm giá đã hết lượt sử dụng.", null);

            if (currentSubtotal < voucher.MinSpend)
                return (false, $"Đơn hàng tối thiểu để áp dụng mã này là {voucher.MinSpend:N0} đ.", null);

            // Check UsageLimitPerUser
            var userUsageCount = await _context.VoucherUsages
                .CountAsync(vu => vu.VoucherId == voucher.Id && vu.UserId == userId);

            if (userUsageCount >= voucher.UsageLimitPerUser)
                return (false, "Bạn đã vượt quá số lượt sử dụng mã này.", null);

            return (true, "Áp dụng mã giảm giá thành công!", voucher);
        }

        public decimal CalculateVoucherDiscount(Voucher voucher, decimal amount)
        {
            if (voucher == null) return 0;

            if (voucher.DiscountType == DiscountType.FixedAmount)
            {
                return Math.Min(voucher.DiscountValue, amount); // Cannot discount more than total
            }
            else // Percentage
            {
                decimal discount = amount * (voucher.DiscountValue / 100);
                if (voucher.MaxDiscount.HasValue && voucher.MaxDiscount.Value > 0)
                {
                    return Math.Min(discount, voucher.MaxDiscount.Value);
                }
                return discount;
            }
        }

        public async Task<decimal> CalculateBestDiscountAsync(ApplicationUser user, decimal subtotal, Voucher? appliedVoucher)
        {
            decimal loyaltyDiscount = _loyaltyService.GetTierDiscount(user.Tier, subtotal);

            if (appliedVoucher == null)
            {
                return loyaltyDiscount;
            }

            // Stackable logic
            if (appliedVoucher.IsStackableWithMembership)
            {
                // Sequential: Apply loyalty first, then apply voucher on remaining balance
                decimal remainingBalance = Math.Max(0, subtotal - loyaltyDiscount);
                decimal voucherDiscount = CalculateVoucherDiscount(appliedVoucher, remainingBalance);
                return loyaltyDiscount + voucherDiscount;
            }
            else
            {
                // Non-stackable: Best Deal
                decimal voucherDiscount = CalculateVoucherDiscount(appliedVoucher, subtotal);
                return Math.Max(loyaltyDiscount, voucherDiscount);
            }
        }
        
        public async Task RecordVoucherUsageAsync(int voucherId, int userId, int? orderId)
        {
            var voucher = await _context.Vouchers.FindAsync(voucherId);
            if (voucher != null)
            {
                voucher.UsageCount++;
                _context.VoucherUsages.Add(new VoucherUsage
                {
                    VoucherId = voucherId,
                    UserId = userId,
                    OrderId = orderId,
                    UsedAt = DateTime.Now
                });
                await _context.SaveChangesAsync();
            }
        }
    }
}
