using System;
using System.Collections.Generic;

namespace PCBuilder_DACS.Models;

public partial class MainboardSpec
{
    public int MainId { get; set; }

    public string SocketType { get; set; } = null!;

    public string? Chipset { get; set; }

    public string? FormFactor { get; set; }

    public int? RamSlotCount { get; set; }

    public int? MaxRamCapacity { get; set; }

    public string? RamTypeSupported { get; set; }

    public virtual Product Main { get; set; } = null!;
}
