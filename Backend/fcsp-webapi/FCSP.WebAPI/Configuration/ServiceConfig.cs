﻿using FCSP.Services.Auth;
using FCSP.Services.Auth.Hash;
using FCSP.Services.Auth.Token;
using FCSP.Services.CustomShoeDesignService;
using FCSP.Services.CustomShoeDesignTextureService;
using FCSP.Services.DesignPreviewService;
using FCSP.Services.DesignServiceService;
using FCSP.Services.NotificationService;
using FCSP.Services.OrderDetailService;
using FCSP.Services.OrderService;
using FCSP.Services.PaymentGatewayService;
using FCSP.Services.PaymentService;
using FCSP.Services.PostService;
using FCSP.Services.PostsCommentsService;
using FCSP.Services.RatingService;
using FCSP.Services.ReturnedCustomShoeService;
using FCSP.Services.ServiceService;
using FCSP.Services.ShippingInfoService;
using FCSP.Services.TemplateService;
using FCSP.Services.TextureService;
using FCSP.Services.UserActivityService;
using FCSP.Services.UserRecommendationService;
using FCSP.Services.VoucherService;
using Microsoft.AspNet.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using FCSP.DTOs.Texture;
using Microsoft.Extensions.Options;
using FCSP.Common.Configurations;
using FCSP.Services.SizeService;
using FCSP.Services;
using FCSP.Services.ManufacturerService;
using FCSP.Services.CartService;
using FCSP.Repositories.Implementations;
using FCSP.Repositories.Interfaces;
using FCSP.Services.ManufacturerCriteriaService;
namespace FCSP.WebAPI.Configuration;

internal static class ServiceConfig
{
    public static void Configure(IServiceCollection services)
    {
        RegisterServices(services);
    }

    private static void RegisterServices(IServiceCollection services)
    {
        // Configure TogetherAI settings
        services.Configure<TogetherAIConfig>(
            services.BuildServiceProvider().GetService<IConfiguration>().GetSection("TogetherAI")
        );

        // Configure HttpClient for TextureService with TogetherAI settings
        services.AddHttpClient("TextureService", (serviceProvider, client) =>
        {
            var config = serviceProvider.GetRequiredService<IOptions<TogetherAIConfig>>().Value;
            client.BaseAddress = new Uri(config.BaseUrl);
            client.DefaultRequestHeaders.Add("Authorization", $"Bearer {config.ApiKey}");
        });

        // Authentication services
        services.AddScoped<IPasswordHasher, PasswordHasher>();
        services.AddScoped<IPasswordHashingService, PasswordHashingService>();
        services.AddScoped<ITokenService, JwtService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IGoogleAuthService, GoogleAuthService>();

        // User services
        services.AddScoped<IUserActivityService, UserActivityService>();
        services.AddScoped<IUserRecommendationService, UserRecommendationService>();
        //Cart services
        services.AddScoped<ICartService, CartService>();
        // Post & Comment services
        services.AddScoped<IPostService, PostService>();
        services.AddScoped<IPostsCommentsService, PostsCommentsService>();

        // Design services
        services.AddScoped<ICustomShoeDesignService, CustomShoeDesignService>();
        services.AddScoped<ICustomShoeDesignTextureService, CustomShoeDesignTextureService>();
        services.AddScoped<ITemplateService, TemplateService>();
        services.AddScoped<IDesignPreviewService, DesignPreviewService>();
        services.AddScoped<IDesignServiceService, DesignServiceService>();
        services.AddScoped<IReturnedCustomShoeService, ReturnedCustomShoeService>();

        // Order & Payment services
        services.AddScoped<IOrderService, OrderService>();
        services.AddScoped<IOrderDetailService, OrderDetailService>();
        services.AddScoped<IPaymentService, PaymentService>();
        services.AddScoped<IPaymentGatewayService, PaymentGatewayService>();
        services.AddScoped<IVoucherService, VoucherService>();
        services.AddScoped<IPaymentProcessor, PaymentProcessor>();


        // Service services
        services.AddScoped<IServiceService, ServiceService>();

        // Texture & Rating services
        services.AddScoped<ITextureService, TextureService>();
        services.AddScoped<IRatingService, RatingService>();

        // Notification service
        services.AddScoped<INotificationService, NotificationService>();

        // Manufacturer services 
        services.AddScoped<IManufacturerService, ManufacturerService>();
        services.AddScoped<IManufacturerCriteriaService, ManufacturerCriteriaService>();
  

        // Shipping service
        services.AddScoped<IShippingInfoService, ShippingInfoService>();

        // Size service
        services.AddScoped<ISizeService, SizeService>();
    }
}
