using System.Collections.Generic;

namespace FCSP.DTOs.CustomShoeDesign
{
    public class GetCustomShoeDesignByIdRequest
    {
        public long Id { get; set; }
    }

    public class GetAllPublicCustomShoeDesignsResponse
    {
        public IEnumerable<GetCustomShoeDesignByIdResponse>? Designs { get; set; }
    }

    public class GetCustomShoeDesignsByUserIdRequest 
    {
        public long UserId { get; set; }
    }

    public class GetListCustomShoeDesignsResponse 
    {
        public IEnumerable<GetCustomShoeDesignByIdResponse>? Designs { get; set; }
    }

    public class GetCustomShoeDesignByIdResponse
    {
        public long Id { get; set; }
        public string? Name { get; set; }
        public string? PreviewImageUrl { get; set; }
        public float? Rating { get; set; }
        public int? RatingCount { get; set; }
        public float? Price { get; set; }
    }

    public class AddCustomShoeDesignRequest
    {
        public long? UserId { get; set; }
        public long? CustomShoeDesignTemplateId { get; set; }
        public string? DesignData { get; set; }
        public string? Description { get; set; }
        public float? DesignerMarkup { get; set; }
        public float? TotalAmount { get; set; }
        public List<long>? TextureIds { get; set; }
    }

    public class AddCustomShoeDesignResponse
    {
        public bool Success { get; set; }
    }

    public class UpdateCustomShoeDesignRequest
    {
        public long Id { get; set; }
        public long CustomShoeDesignTemplateId { get; set; }
        public string? DesignData { get; set; }
        public float? TotalAmount { get; set; }
        public List<long>? TextureIds { get; set; }
    }

    public class UpdateCustomShoeDesignResponse
    {
        public bool Success { get; set; }
    }

    public class DeleteCustomShoeDesignRequest
    {
        public long Id { get; set; }
    }

    public class DeleteCustomShoeDesignResponse
    {
        public bool Success { get; set; }
    }
} 