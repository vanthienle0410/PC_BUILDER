using System;

namespace PCBuilder_DACS.Models
{
    public class InstallmentSchedule
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int MonthNumber { get; set; }
        public DateTime DueDate { get; set; }
        public decimal Amount { get; set; }
        public string Status { get; set; } = "Unpaid"; // Unpaid, Paid
        public DateTime? LastNotified { get; set; }

        public virtual Order Order { get; set; }
    }
}
