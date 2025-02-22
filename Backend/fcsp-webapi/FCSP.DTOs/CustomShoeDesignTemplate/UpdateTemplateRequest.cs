﻿namespace FCSP.DTOs.CustomShoeDesignTemplate
{
    public class UpdateTemplateRequest
    {
        public long Id { get; set; }
        public string? Name { get; set; }

        public string? Description { get; set; }

        public decimal? Price { get; set; }

        public string? ImageUrl { get; set; }
    }
}
