using System;
using System.Collections.Generic;

namespace PCBuilder_DACS.Models;

public partial class RamSpec
{
    public int RamId { get; set; }

    public string RamType { get; set; } = null!;

    public int? Capacity { get; set; }

    public int? BusSpeed { get; set; }

    public string? Latency { get; set; }

    public virtual Product Ram { get; set; } = null!;
}
