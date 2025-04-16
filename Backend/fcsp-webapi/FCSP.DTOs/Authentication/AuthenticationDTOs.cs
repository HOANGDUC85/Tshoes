﻿using FCSP.Common.Enums;

namespace FCSP.DTOs.Authentication;

public class GetAllUsersResponse
{
    public IEnumerable<UsersInfo> Users { get; set; } = new List<UsersInfo>();
}

public class UsersInfo
{
    public long Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public string CreatedAt { get; set; } = string.Empty;
}
public class GetUserByIdRequest
{
    public long Id { get; set; }
}

public class GetUserByIdResponse
{
    public long Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Dob { get; set; } = string.Empty;
    public string Gender { get; set; } = string.Empty;
}

public class UserLoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

public class UserLoginResponse
{
    public string Token { get; set; } = string.Empty;
}

public class UserRegisterRequest
{
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

public class UpdateUserStatusRequest
{
    public long Id { get; set; }
    public bool IsDeleted { get; set; }
}

public class UpdateUserStatusResponse
{
    public bool Success { get; set; }
}



public class UserRegisterResponse
{
    public bool Success { get; set; }
}

public class UpdateUserPasswordRequest
{
    public long Id { get; set; }
    public string? CurrentPassword { get; set; }
    public string? NewPassword { get; set; }
}

public class UpdateUserPasswordResponse
{
    public bool Success { get; set; }
}

public class UserDeleteRequest
{
    public long Id { get; set; }
    public string Password { get; set; } = null!;
}

public class UserDeleteResponse
{
    public bool Success { get; set; }
}

public class UpdateUserInformationRequest
{
    public long Id { get; set; }
    public string Name { get; set; } = null!;
    public string Gender { get; set; } = null!;
    public string Dob { get; set; } = null!;
}

public class UpdateUserInformationResponse
{
    public bool Success { get; set; }
}

// DTO mới để cập nhật UserRole
public class UpdateUserRoleRequest
{
    public long Id { get; set; }
    public UserRole Role { get; set; } // Sử dụng enum UserRole
}

public class UpdateUserRoleResponse
{
    public bool Success { get; set; }
    public UserRole NewRole { get; set; }
}