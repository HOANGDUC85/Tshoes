namespace FCSP.DTOs.CustomShoeDesign
{
    public class UpdateCustomShoeDesignRequest
    {
        public long Id { get; set; }
        public long? CustomShoeDesignTemplateId { get; set; }
        public string? DesignData { get; set; }
        public string? Preview3DFileUrl { get; set; }
        public decimal? Price { get; set; }
        public List<long>? TextureIds { get; set; }
    }
} 