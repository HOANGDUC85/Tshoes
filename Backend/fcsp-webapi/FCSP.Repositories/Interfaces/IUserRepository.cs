﻿using FCSP.Models.Entities;

namespace FCSP.Repositories.Interfaces;

public interface IUserRepository : IGenericRepository<User>
{
    Task<User> GetByEmailAsync(string email);
}
