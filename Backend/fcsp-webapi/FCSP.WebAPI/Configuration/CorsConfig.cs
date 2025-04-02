namespace FCSP.WebAPI.Configuration;

internal static class CorsConfig
{
    #region Public methods
    public static void Configure(IServiceCollection services)
    {
        ConfigureCors(services);
    }
    #endregion

    #region Private methods
    private static void ConfigureCors(IServiceCollection services)
    {
        services.AddCors(options =>
        {
            options.AddPolicy("AllowAll", builder =>
                builder.SetIsOriginAllowed(_ => true) // Allow any origin
                       .AllowAnyMethod()
                       .AllowAnyHeader()
                       .AllowCredentials());
                       
            // Alternatively, for more restrictive policy
            // options.AddPolicy("AllowSpecific", builder =>
            //     builder.WithOrigins("https://yourfrontend.com", "https://anotherdomain.com")
            //            .WithMethods("GET", "POST", "PUT", "DELETE")
            //            .AllowAnyHeader());
        });
    }
    #endregion
} 