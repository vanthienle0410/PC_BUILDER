using System;
using System.Collections.Generic;

namespace PCBuilder_DACS.Models;

public partial class GpuSpec
{
    public int GpuId { get; set; }

    public int? VramSize { get; set; }

    public int? PowerRequirement { get; set; }

    public int? Length { get; set; }

    public virtual Product Gpu { get; set; } = null!;
}
