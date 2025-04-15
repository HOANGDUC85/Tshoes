using FCSP.Common.Enums;
using FCSP.Models.Context;
using FCSP.Models.Entities;
using FCSP.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace FCSP.Repositories.Implementations
{
    public class VoucherRepository : GenericRepository<Voucher>, IVoucherRepository
    {
        public VoucherRepository(FcspDbContext context) : base(context)
        {

        }

        public async Task<IEnumerable<Voucher>> GetNonExpiredVouchersAsync()
        {
            return await _context.Vouchers
                 .Where(v => v.ExpirationDate >= DateTime.UtcNow && v.Status == (int)VoucherStatus.Active && !v.IsDeleted)
                 .ToListAsync();
        }
        public async Task<IEnumerable<Voucher>> GetAllVoucherAsync()
        {
            return await _context.Vouchers
                .Where(v => !v.IsDeleted)
                .Include(v => v.Orders)
                .ToListAsync();
        }

        public async Task<Voucher> GetVoucherByOrderIdAsync(long orderId)
        {
            return await _context.Vouchers
                .Include(v => v.Orders)
                .FirstOrDefaultAsync(v => v.Orders.Any(o => o.Id == orderId) && !v.IsDeleted);
        }

        public async Task<int> UpdateExpiredVouchersAsync()
        {
            var expiredVouchers = await _context.Vouchers
                .Where(v => v.ExpirationDate < DateTime.UtcNow && v.Status == (int)VoucherStatus.Active && !v.IsDeleted)
                .ToListAsync();

            foreach (var voucher in expiredVouchers)
            {
                voucher.Status = (int)VoucherStatus.Expired;
                voucher.UpdatedAt = DateTime.Now;
            }

            await _context.SaveChangesAsync();
            return expiredVouchers.Count; 
        }
    }
}