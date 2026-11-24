using PCBuilder_DACS.Models;
using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace PCBuilder_DACS.Services
{
    public class LoyaltyService
    {
        private readonly UserManager<ApplicationUser> _userManager;

        public LoyaltyService(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }

        public int CalculatePoints(decimal amount)
        {
            // 100,000 VND = 1 Point
            return (int)(amount / 100000);
        }

        public async Task AwardPointsAsync(Order order, ApplicationUser user)
        {
            if (order.IsPointsAwarded) return; // Prevent double awarding

            int points = CalculatePoints(order.TotalAmount);
            user.TotalPoints += points;
            user.CurrentPoints += points;

            UpdateTier(user);

            order.IsPointsAwarded = true;
            await _userManager.UpdateAsync(user);
        }

        public async Task ReversePointsAsync(Order order, ApplicationUser user)
        {
            if (!order.IsPointsAwarded) return; // Cannot reverse if not awarded

            int pointsToDeduct = CalculatePoints(order.TotalAmount);
            
            // Deduct but prevent going below 0
            user.CurrentPoints = Math.Max(0, user.CurrentPoints - pointsToDeduct);
            user.TotalPoints = Math.Max(0, user.TotalPoints - pointsToDeduct);

            UpdateTier(user);

            order.IsPointsAwarded = false;
            await _userManager.UpdateAsync(user);
        }

        private void UpdateTier(ApplicationUser user)
        {
            if (user.TotalPoints >= 5000)
                user.Tier = MembershipTier.Diamond;
            else if (user.TotalPoints >= 2000)
                user.Tier = MembershipTier.Gold;
            else if (user.TotalPoints >= 500)
                user.Tier = MembershipTier.Silver;
            else
                user.Tier = MembershipTier.Bronze;
        }

        public decimal GetTierDiscount(MembershipTier tier, decimal totalAmount)
        {
            switch (tier)
            {
                case MembershipTier.Silver:
                    return totalAmount * 0.02m;
                case MembershipTier.Gold:
                    return totalAmount * 0.05m;
                case MembershipTier.Diamond:
                    decimal discount = totalAmount * 0.10m;
                    return Math.Min(discount, 1000000m); // Max 1,000,000 VND
                default:
                    return 0;
            }
        }
    }
}
