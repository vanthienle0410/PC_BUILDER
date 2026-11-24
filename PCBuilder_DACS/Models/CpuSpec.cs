using System;
using System.Collections.Generic;

namespace PCBuilder_DACS.Models;

public partial class CpuSpec
{
    public int CpuId { get; set; }

    public string SocketType { get; set; } = null!;

    public int? Cores { get; set; }

    public int? Threads { get; set; }

    public double? BaseClock { get; set; }

    public int? Tdp { get; set; }

    public bool? HasIntegratedGraphics { get; set; }

    public virtual Product Cpu { get; set; } = null!;
}
