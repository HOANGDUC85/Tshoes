using FCSP.DTOs.CustomShoeDesign;
using FCSP.Services.CustomShoeDesignService;
using Microsoft.AspNetCore.Mvc;

namespace FCSP.WebAPI.Controllers.CustomShoeDesign;

/// <summary>
/// API Controller for managing custom shoe designs
/// </summary>
[Route("api/[controller]")]
[ApiController]
public class CustomShoeDesignController : ControllerBase
{
    private readonly ICustomShoeDesignService _customShoeDesignService;

    public CustomShoeDesignController(ICustomShoeDesignService customShoeDesignService)
    {
        _customShoeDesignService = customShoeDesignService;
    }

    /// <summary>
    /// Get all custom shoe designs
    /// </summary>
    /// <returns>List of all custom shoe designs</returns>
    [HttpGet]
    public async Task<IActionResult> GetAllPublicDesigns()
    {
        var response = await _customShoeDesignService.GetAllPublicDesigns();
        return StatusCode(response.Code, response);
    }
    
    /// <summary>
    /// Get top 5 best selling designs
    /// </summary>
    /// <returns>List of top 5 best selling designs</returns>
    [HttpGet("top-5-best-selling")]
    public async Task<IActionResult> GetTopFiveBestSellingDesigns()
    {
        var response = await _customShoeDesignService.GetTopFiveBestSellingPublicDesigns();
        return StatusCode(response.Code, response);
    }

    /// <summary>
    /// Get a custom shoe design by ID
    /// </summary>
    /// <param name="id">Custom shoe design ID</param>
    /// <returns>Custom shoe design details</returns>
    [HttpGet("{id}")]
    public async Task<IActionResult> GetCustomShoeDesignById(GetCustomShoeDesignByIdRequest request)
    {
        var response = await _customShoeDesignService.GetDesignById(request);
        return StatusCode(response.Code, response);
    }

    /// <summary>
    /// Get all designs by a specific user
    /// </summary>
    /// <param name="userId">User ID</param>
    /// <returns>List of designs by user</returns>
    [HttpGet("user/{userId}")]
    public async Task<IActionResult> GetDesignsByUser(GetCustomShoeDesignsByUserIdRequest request)
    {
        var response = await _customShoeDesignService.GetDesignsByUserId(request);
        return StatusCode(response.Code, response);
    }

    /// <summary>
    /// Create a new custom shoe design
    /// </summary>
    /// <param name="request">Custom shoe design data</param>
    /// <returns>Created custom shoe design</returns>
    [HttpPost]
    public async Task<IActionResult> CreateCustomShoeDesign([FromBody] AddCustomShoeDesignRequest request)
    {
        var response = await _customShoeDesignService.AddCustomShoeDesign(request);
        return StatusCode(response.Code, response);
    }

    /// <summary>
    /// Update an existing custom shoe design
    /// </summary>
    /// <param name="id">Custom shoe design ID</param>
    /// <param name="designDto">Updated custom shoe design data</param>
    /// <returns>Updated custom shoe design</returns>
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateCustomShoeDesign(long id, [FromBody] UpdateCustomShoeDesignRequest designDto)
    {
        var response = await _customShoeDesignService.UpdateCustomShoeDesign(designDto);
        return StatusCode(response.Code, response);
    }

    /// <summary>
    /// Delete a custom shoe design
    /// </summary>
    /// <param name="id">Custom shoe design ID</param>
    /// <returns>No content if successful</returns>
    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteCustomShoeDesign(DeleteCustomShoeDesignRequest request)
    {
        var response = await _customShoeDesignService.DeleteCustomShoeDesign(request);
        return StatusCode(response.Code, response);
    }
} 