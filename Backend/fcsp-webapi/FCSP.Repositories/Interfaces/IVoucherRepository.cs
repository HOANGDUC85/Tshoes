using FCSP.Models.Entities;

namespace FCSP.Repositories.Interfaces
{
    public interface IVoucherRepository : IGenericRepository<Voucher>
    {
        Task<IEnumerable<Voucher>> GetAllVoucherAsync();
        Task<IEnumerable<Voucher>> GetNonExpiredVouchersAsync();
        Task<Voucher> GetVoucherByOrderIdAsync(long orderId);
        Task<int> UpdateExpiredVouchersAsync();
        Task<Voucher> FindByIdAsync(long id);
    }
}