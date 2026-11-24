using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;

namespace PCBuilder_DACS.Models;

public class ApplicationUser : IdentityUser<int>
{
    // --- Loyalty System ---
    public int TotalPoints { get; set; } = 0;
    public int CurrentPoints { get; set; } = 0;
    public MembershipTier Tier { get; set; } = MembershipTier.Bronze;

    // Cột Username và Email đã có sẵn trong IdentityUser, nên không cần định nghĩa lại
    public virtual ICollection<UserInteraction> UserInteractions { get; set; } = new List<UserInteraction>();
}
