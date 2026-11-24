using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace PCBuilder_DACS.Services
{
    public interface IEmailService
    {
        Task SendEmailAsync(string toEmail, string subject, string body);
    }

    public class MockEmailService : IEmailService
    {
        private readonly ILogger<MockEmailService> _logger;

        public MockEmailService(ILogger<MockEmailService> logger)
        {
            _logger = logger;
        }

        public Task SendEmailAsync(string toEmail, string subject, string body)
        {
            _logger.LogInformation("================================================");
            _logger.LogInformation($"[MOCK EMAIL SENT TO]: {toEmail}");
            _logger.LogInformation($"[SUBJECT]: {subject}");
            _logger.LogInformation($"[BODY]: {body}");
            _logger.LogInformation("================================================");
            return Task.CompletedTask;
        }
    }
}
