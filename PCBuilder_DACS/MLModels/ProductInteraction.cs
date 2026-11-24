using Microsoft.ML.Data;

namespace PCBuilder_DACS.MLModels
{
    public class ProductInteraction
    {
        [LoadColumn(0)]
        public float UserId { get; set; }

        [LoadColumn(1)]
        public float ProductId { get; set; }

        [LoadColumn(2)]
        public float Label { get; set; }
    }
}
