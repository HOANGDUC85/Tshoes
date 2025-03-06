using FCSP.DTOs.CustomShoeDesignTexture;
using FCSP.Models.Entities;
using FCSP.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FCSP.Services.CustomShoeDesignTextureService
{
    public class CustomShoeDesignTextureService : ICustomShoeDesignTextureService
    {
        private readonly ICustomShoeDesignTextureRepository _customShoeDesignTextureRepository;

        public CustomShoeDesignTextureService(ICustomShoeDesignTextureRepository customShoeDesignTextureRepository)
        {
            _customShoeDesignTextureRepository = customShoeDesignTextureRepository;
        }

        public async Task<IEnumerable<CustomShoeDesignTexture>> GetAllCustomShoeDesignTextures()
        {
            var response = await _customShoeDesignTextureRepository.GetAllAsync();
            return response;
        }

        public async Task<GetCustomShoeDesignTextureByIdResponse> GetCustomShoeDesignTextureById(GetCustomShoeDesignTextureByIdRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = GetEntityFromGetByIdRequest(request);
            return new GetCustomShoeDesignTextureByIdResponse
            {
                CustomShoeDesignId = customShoeDesignTexture.CustomShoeDesignId,
                TextureId = customShoeDesignTexture.TextureId
            };
        }

        public async Task<AddCustomShoeDesignTextureResponse> AddCustomShoeDesignTexture(AddCustomShoeDesignTextureRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = GetEntityFromAddRequest(request);
            var addedCustomShoeDesignTexture = await _customShoeDesignTextureRepository.AddAsync(customShoeDesignTexture);
            return new AddCustomShoeDesignTextureResponse { Id = addedCustomShoeDesignTexture.Id };
        }

        public async Task<AddCustomShoeDesignTextureResponse> UpdateCustomShoeDesignTexture(UpdateCustomShoeDesignTextureRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = GetEntityFromUpdateRequest(request);
            await _customShoeDesignTextureRepository.UpdateAsync(customShoeDesignTexture);
            return new AddCustomShoeDesignTextureResponse { Id = customShoeDesignTexture.Id };
        }

        public async Task<AddCustomShoeDesignTextureResponse> DeleteCustomShoeDesignTexture(DeleteCustomShoeDesignTextureRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = GetEntityFromDeleteRequest(request);
            await _customShoeDesignTextureRepository.DeleteAsync(customShoeDesignTexture.Id);
            return new AddCustomShoeDesignTextureResponse { Id = customShoeDesignTexture.Id };
        }

        private CustomShoeDesignTexture GetEntityFromGetByIdRequest(GetCustomShoeDesignTextureByIdRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = _customShoeDesignTextureRepository.Find(request.Id);
            if (customShoeDesignTexture == null)
            {
                throw new InvalidOperationException("CustomShoeDesignTexture not found");
            }
            return customShoeDesignTexture;
        }

        private CustomShoeDesignTexture GetEntityFromAddRequest(AddCustomShoeDesignTextureRequest request)
        {
            return new CustomShoeDesignTexture
            {
                CustomShoeDesignId = request.CustomShoeDesignId,
                TextureId = request.TextureId,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
        }

        private CustomShoeDesignTexture GetEntityFromUpdateRequest(UpdateCustomShoeDesignTextureRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = _customShoeDesignTextureRepository.Find(request.Id);
            if (customShoeDesignTexture == null)
            {
                throw new InvalidOperationException("CustomShoeDesignTexture not found");
            }
            
            customShoeDesignTexture.TextureId = request.TextureId;
            customShoeDesignTexture.UpdatedAt = DateTime.UtcNow;
            
            return customShoeDesignTexture;
        }

        private CustomShoeDesignTexture GetEntityFromDeleteRequest(DeleteCustomShoeDesignTextureRequest request)
        {
            CustomShoeDesignTexture customShoeDesignTexture = _customShoeDesignTextureRepository.Find(request.Id);
            if (customShoeDesignTexture == null)
            {
                throw new InvalidOperationException("CustomShoeDesignTexture not found");
            }
            return customShoeDesignTexture;
        }
    }
} 