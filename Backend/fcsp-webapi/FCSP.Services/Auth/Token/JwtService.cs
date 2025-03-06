﻿using FCSP.Common.Configurations;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FCSP.Services.Auth.Token;

public class JwtService : ITokenService
{
    #region Fields
    private readonly JwtConfigurations _config;
    #endregion

    #region Constructors
    public JwtService(JwtConfigurations config)
    {
        _config = config;
    }
    #endregion

    #region Public methods
    public string GetToken()
    {
        return GetJwt();
    }
    #endregion

    #region Private methods
    private string GetJwt()
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config.Key));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expiry = DateTime.Now.AddMinutes(_config.ExpiryMinutes);
        var claims = new List<Claim>
        {
            new Claim(JwtRegisteredClaimNames.Sub, "user_id"), // Replace with actual user ID
            new Claim(JwtRegisteredClaimNames.Email, "user@example.com"), // Replace with actual email
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(ClaimTypes.Role, "User") // Add roles as needed
        };

        var token = new JwtSecurityToken(
            _config.Issuer,
            _config.Audience,
            claims,
            null,
            expiry,
            creds
        );

        var tokenHandler = new JwtSecurityTokenHandler();
        return tokenHandler.WriteToken(token);
    }
    #endregion
}
