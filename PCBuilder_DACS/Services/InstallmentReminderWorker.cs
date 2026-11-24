using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using PCBuilder_DACS.Models;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Services
{
    public class InstallmentReminderWorker : BackgroundService
    {
        private readonly ILogger<InstallmentReminderWorker> _logger;
        private readonly IServiceScopeFactory _scopeFactory;

        public InstallmentReminderWorker(ILogger<InstallmentReminderWorker> logger, IServiceScopeFactory scopeFactory)
        {
            _logger = logger;
            _scopeFactory = scopeFactory;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Installment Reminder Worker started.");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    _logger.LogInformation("Checking for due installments...");
                    await CheckAndSendRemindersAsync();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error occurred while checking installments.");
                }

                // Check every 24 hours
                await Task.Delay(TimeSpan.FromHours(24), stoppingToken);
            }
        }

        private async Task CheckAndSendRemindersAsync()
        {
            // CRITICAL: Use IServiceScopeFactory to resolve DbContext within Singleton BackgroundService
            using (var scope = _scopeFactory.CreateScope())
            {
                var context = scope.ServiceProvider.GetRequiredService<PcBuilderContext>();
                var emailService = scope.ServiceProvider.GetRequiredService<IEmailService>();

                var targetDate = DateTime.Now.AddDays(3).Date;

                var dueSchedules = await context.InstallmentSchedules
                    .Include(s => s.Order)
                    .ThenInclude(o => o.User)
                    .Where(s => s.Status == "Unpaid" 
                             && s.DueDate.Date == targetDate
                             && (s.LastNotified == null || s.LastNotified.Value.Date < DateTime.Now.Date))
                    .ToListAsync();

                foreach (var schedule in dueSchedules)
                {
                    if (schedule.Order?.User != null)
                    {
                        string email = schedule.Order.User.Email ?? "no-email@example.com";
                        string name = schedule.Order.User.UserName ?? "Khách hàng";
                        string subject = $"Nhắc nhở thanh toán trả góp đơn hàng #{schedule.OrderId}";
                        string body = $"Chào {name},\n\nBạn có lịch trả góp (kỳ {schedule.MonthNumber}) cho đơn hàng #{schedule.OrderId} sắp đến hạn vào ngày {schedule.DueDate:dd/MM/yyyy}.\nSố tiền cần thanh toán: {schedule.Amount:N0} đ.\n\nVui lòng thanh toán đúng hạn để tránh phát sinh phí phạt.\nCảm ơn bạn!";

                        await emailService.SendEmailAsync(email, subject, body);

                        // Update LastNotified to avoid duplicate emails on the same day if the service restarts
                        schedule.LastNotified = DateTime.Now;
                    }
                }

                if (dueSchedules.Any())
                {
                    await context.SaveChangesAsync();
                    _logger.LogInformation($"Sent reminders for {dueSchedules.Count} installments.");
                }
            }
        }
    }
}
