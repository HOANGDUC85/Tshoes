﻿using System.ComponentModel.DataAnnotations;

namespace FCSP.DTOs.CustomShoeDesignTemplate
{
    public class GetTemplateByIdRequest
    {
        public long Id { get; set; }
    }

    public class GetTemplateByIdResponse
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string PreviewImageUrl { get; set; } = null!;
        public string Model3DUrl { get; set; } = null!;
        public decimal BasePrice { get; set; }
        public bool IsAvailable { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }

    public class AddTemplateRequest
    {
        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; } = null!;
        [Required(ErrorMessage = "Description is required")]
        public string Description { get; set; } = null!;
        [Required(ErrorMessage = "Gender is required")]
        public string Gender { get; set; } = null!;
        [Required(ErrorMessage = "Color is required")]
        public string Color { get; set; } = null!;
        [Required(ErrorMessage = "PreviewImageUrl is required")]
        [Url(ErrorMessage = "Invalid URL format")]
        public string PreviewImageUrl { get; set; } = null!;
        [Required(ErrorMessage = "Model3DUrl is required")]
        [Url(ErrorMessage = "Invalid URL format")]
        public string Model3DUrl { get; set; } = null!;
        [Range(0, double.MaxValue, ErrorMessage = "BasePrice cannot be negative")]
        public decimal BasePrice { get; set; }
        public bool IsAvailable { get; set; }
        [Required(ErrorMessage = "UserId is required")]
        public long UserId { get; set; } // Thêm UserId
    }

    public class AddTemplateResponse
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public string PreviewImageUrl { get; set; } = null!;
    }

    public class UpdateTemplateRequest
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string Gender { get; set; } = null!;
        public string Color { get; set; } = null!;
        public string PreviewImageUrl { get; set; } = null!;
        public string Model3DUrl { get; set; } = null!;
        public decimal BasePrice { get; set; }
        public bool IsAvailable { get; set; }
    }

    public class UpdateTemplateResponse
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public string PreviewImageUrl { get; set; } = null!;
    }

    public class DeleteTemplateRequest
    {
        public long Id { get; set; }
    }

    public class DeleteTemplateResponse
    {
        public bool Success { get; set; }
    }
    public class GetCustomShoeDesignIdsByTemplateRequest
    {
        public long TemplateId { get; set; }
    }

    public class GetCustomShoeDesignIdsByTemplateResponse
    {
        public IEnumerable<long> CustomShoeDesignIds { get; set; } = [];
    }
    public class SearchTemplatesRequest
    {
        public string? Name { get; set; }
        public string? Gender { get; set; }
        public string? Color { get; set; }
        public decimal? MinPrice { get; set; }
        public decimal? MaxPrice { get; set; }
        public bool? IsAvailable { get; set; } = true; // Mặc định chỉ lấy các template available
    }
    public class RestoreTemplateRequest
    {
        public long Id { get; set; }
    }
    public class RestoreTemplateResponse
    {
        public long Id { get; set; }
        public bool Success { get; set; }
        public string Message { get; set; } = null!;
    }
    public class GetTemplateStatsRequest
    {
        public long Id { get; set; }
    }

    public class GetTemplateStatsResponse
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public int CustomShoeDesignCount { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? LastUpdatedAt { get; set; }
        public bool IsAvailable { get; set; }
    }
    public class GetPopularTemplatesRequest
    {
        public int Limit { get; set; } = 10; 
    }

    public class GetPopularTemplatesResponse
    {
        public long Id { get; set; }
        public string Name { get; set; } = null!;
        public string PreviewImageUrl { get; set; } = null!;
        public int CustomShoeDesignCount { get; set; }
    }
} 