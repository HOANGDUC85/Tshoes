<template>
  <div class="admin-layout">
    <AdminSidebar />
    <div class="main-content">
      <div class="container-fluid py-4">
        <div class="row">
          <div class="col-12">
            <h1 class="mb-4 text-primary fw-bold">Account Management</h1>
            
            <!-- Search and Filter Section -->
            <div class="card mb-4 search-card">
              <div class="card-body">
                <div class="row g-3">
                  <div class="col-12 col-md-4">
                    <div class="input-group">
                      <span class="input-group-text bg-light">
                        <i class="bi bi-search"></i>
                      </span>
                      <input 
                        type="text" 
                        class="form-control" 
                        v-model="search" 
                        placeholder="Search accounts"
                      >
                      <button 
                        v-if="search" 
                        class="btn btn-outline-secondary" 
                        type="button"
                        @click="search = ''"
                      >
                        <i class="bi bi-x"></i>
                      </button>
                    </div>
                  </div>
                  <div class="col-12 col-md-4">
                    <div class="input-group">
                      <span class="input-group-text bg-light">
                        <i class="bi bi-funnel"></i>
                      </span>
                      <select class="form-select" v-model="roleFilter">
                        <option value="">All Roles</option>
                        <option v-for="role in userRoles" :key="role.value" :value="role.value">
                          {{ role.label }}
                        </option>
                      </select>
                    </div>
                  </div>
                  <div class="col-12 col-md-4">
                    <div class="input-group">
                      <span class="input-group-text bg-light">
                        <i class="bi bi-toggle-on"></i>
                      </span>
                      <select class="form-select" v-model="statusFilter">
                        <option value="">All Status</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
    
            <!-- Accounts Table -->
            <div class="card accounts-card">
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                      <tr>
                        <th>ID</th>
                        <th>Account</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Created Date</th>
                        <th class="text-end">Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="account in paginatedAccounts" :key="account.id">
                        <td class="fw-medium">{{ account.id }}</td>
                        <td>
                          <div class="d-flex align-items-center">
                            <div class="avatar-wrapper me-2">
                              <img 
                                :src="'https://ui-avatars.com/api/?name=' + encodeURIComponent(account.name) + '&background=random'" 
                                class="avatar rounded-circle"
                                alt="Avatar"
                              >
                            </div>
                            <div>
                              <div class="fw-medium">{{ account.name }}</div>
                              <div class="text-muted small">{{ account.email }}</div>
                            </div>
                          </div>
                        </td>
                        <td>{{ account.name }}</td>
                        <td>
                          <span :class="['badge', getRoleBadgeClass(userRoles.find(r => r.value === account.role)?.label)]">
                            {{ userRoles.find(r => r.value === account.role)?.label || account.role }}
                          </span>
                        </td>
                        <td>
                          <span :class="['badge', account.status === 'active' ? 'bg-success' : 'bg-danger']">
                            {{ account.status === 'active' ? 'Active' : 'Inactive' }}
                          </span>
                        </td>
                        <td class="date-text">{{ formatDate(account.createdAt) }}</td>
                        <td class="text-end">
                          <button 
                            class="btn btn-sm btn-outline-success me-1" 
                            data-bs-toggle="tooltip" 
                            title="Edit"
                            @click="editAccount(account)"
                          >
                            <i class="bi bi-pencil"></i>
                          </button>
                          <button 
                            class="btn btn-sm btn-outline-primary me-1" 
                            data-bs-toggle="tooltip" 
                            title="Send Email"
                            @click="openEmailModal(account)"
                          >
                            <i class="bi bi-envelope"></i>
                          </button>
                          <button 
                            v-if="isAdmin"
                            class="btn btn-sm"
                            :class="account.status === 'active' ? 'btn-outline-danger' : 'btn-outline-success'"
                            data-bs-toggle="tooltip" 
                            :title="account.status === 'active' ? 'Lock Account' : 'Unlock Account'"
                            @click="toggleAccountStatus(account)"
                          >
                            <i class="bi" :class="account.status === 'active' ? 'bi-lock' : 'bi-unlock'"></i>
                          </button>
                        </td>
                      </tr>
                      <tr v-if="loading">
                        <td colspan="7" class="text-center py-4">
                          <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                          </div>
                        </td>
                      </tr>
                      <tr v-if="!loading && filteredAccounts.length === 0">
                        <td colspan="7" class="text-center py-4">
                          No accounts found
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="card-footer bg-white">
                <div class="d-flex flex-column align-items-center">
                  <nav aria-label="Page navigation">
                    <ul class="pagination mb-0">
                      <li class="page-item" :class="{ disabled: currentPage === 1 }">
                        <a class="page-link" href="#" @click.prevent="currentPage = 1">
                          <i class="bi bi-chevron-double-left"></i>
                        </a>
                      </li>
                      <li class="page-item" :class="{ disabled: currentPage === 1 }">
                        <a class="page-link" href="#" @click.prevent="currentPage--">
                          <i class="bi bi-chevron-left"></i>
                        </a>
                      </li>
                      <li v-for="page in displayedPages" :key="page" class="page-item" :class="{ active: currentPage === page }">
                        <a v-if="page !== '...'" class="page-link" href="#" @click.prevent="currentPage = page">{{ page }}</a>
                        <span v-else class="page-link">...</span>
                      </li>
                      <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                        <a class="page-link" href="#" @click.prevent="currentPage++">
                          <i class="bi bi-chevron-right"></i>
                        </a>
                      </li>
                      <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                        <a class="page-link" href="#" @click.prevent="currentPage = totalPages">
                          <i class="bi bi-chevron-double-right"></i>
                        </a>
                      </li>
                    </ul>
                  </nav>
                </div>
              </div>
            </div>
    
            <!-- Edit Account Modal -->
            <div class="modal fade" :class="{ show: showEditModal }" style="display: block;" v-if="showEditModal">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Edit Account Role & Commission</h5>
                    <button type="button" class="btn-close btn-close-white" @click="showEditModal = false"></button>
                  </div>
                  <div class="modal-body">
                    <form @submit.prevent="saveAccount">
                      <div class="mb-3">
                        <label class="form-label">ID</label>
                        <input type="text" class="form-control" v-model="editedAccount.id" disabled />
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Role</label>
                        <select class="form-select" v-model.number="editedAccount.role" required>
                          <option v-for="role in userRoles" :key="role.value" :value="role.value">
                            {{ role.label }} ({{ role.value }})
                          </option>
                        </select>
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Commission Rate</label>
                        <input type="number" class="form-control" v-model.number="editedAccount.commissionRate" min="0" step="0.01" />
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" @click="showEditModal = false">Cancel</button>
                        <button type="submit" class="btn btn-success">Save</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
    
            <!-- Send Email Modal -->
            <div class="modal fade" :class="{ show: showEmailModal }" style="display: block;" v-if="showEmailModal">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Send Email to {{ selectedAccount?.name }}</h5>
                    <button type="button" class="btn-close btn-close-white" @click="showEmailModal = false"></button>
                  </div>
                  <div class="modal-body">
                    <form @submit.prevent="sendEmail">
                      <div class="mb-3">
                        <label class="form-label">Subject</label>
                        <input type="text" class="form-control" v-model="emailForm.subject" required />
                      </div>
                      <div class="mb-3">
                        <label class="form-label">Body</label>
                        <textarea class="form-control" v-model="emailForm.body" rows="5" required></textarea>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" @click="showEmailModal = false">Cancel</button>
                        <button type="submit" class="btn btn-primary">Send Email</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
    
            <!-- Confirm Status Change Modal -->
            <div class="modal fade" id="confirmStatusModal" tabindex="-1" ref="confirmStatusModal">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header" :class="selectedAccount && selectedAccount.status === 'active' ? 'bg-danger text-white' : 'bg-success text-white'">
                    <h5 class="modal-title">{{ selectedAccount && selectedAccount.status === 'active' ? 'Lock Account' : 'Unlock Account' }}</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body" v-if="selectedAccount">
                    <p>Are you sure you want to {{ selectedAccount.status === 'active' ? 'lock' : 'unlock' }} account <strong>{{ selectedAccount.name }}</strong>?</p>
                    <p v-if="selectedAccount.status === 'active'">
                      <i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>
                      The account will not be able to log in after being locked.
                    </p>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button 
                      type="button" 
                      :class="selectedAccount && selectedAccount.status === 'active' ? 'btn btn-danger' : 'btn btn-success'"
                      @click="confirmStatusChange"
                    >
                      {{ selectedAccount && selectedAccount.status === 'active' ? 'Lock Account' : 'Unlock Account' }}
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getAllUser, updateStatus, updateRole } from '@/server/manageAccounts-service';
import AdminSidebar from '@/components/AdminSidebar.vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import { useRouter } from 'vue-router';
import axios from 'axios';

export default {
  name: 'AccountManagement',
  components: {
    AdminSidebar
  },
  setup() {
    const router = useRouter();
    return { router };
  },
  data() {
    return {
      search: '',
      roleFilter: '',
      statusFilter: '',
      loading: false,
      selectedAccount: null,
      editedAccount: {},
      showEditModal: false,
      showEmailModal: false,
      emailForm: {
        subject: '',
        body: ''
      },
      currentPage: 1,
      itemsPerPage: 7,
      userRoles: [
        { label: 'Admin', value: 3 },
        { label: 'Designer', value: 2 },
        { label: 'Manufacturer', value: 1 },
        { label: 'Customer', value: 0 }
      ],
      availablePermissions: [
        'Manage Accounts',
        'Manage Products',
        'Manage Orders',
        'Manage Categories',
        'Manage Promotions',
        'Manage Payments',
        'View Reports',
        'Export Reports',
        'System Configuration'
      ],
      accounts: []
    }
  },
  computed: {
    filteredAccounts() {
      let result = [...this.accounts];
      
      // Apply role filter
      if (this.roleFilter) {
        result = result.filter(account => Number(account.role) === Number(this.roleFilter));
      }
      
      // Apply status filter
      if (this.statusFilter) {
        result = result.filter(account => account.status === this.statusFilter);
      }
      
      // Apply search filter
      if (this.search) {
        const searchLower = this.search.toLowerCase();
        result = result.filter(account => {
          const roleLabel = this.userRoles.find(r => r.value === account.role)?.label?.toLowerCase() || '';
          return (
            account.id.toString().toLowerCase().includes(searchLower) ||
            account.name.toLowerCase().includes(searchLower) ||
            account.email.toLowerCase().includes(searchLower) ||
            account.role.toString().toLowerCase().includes(searchLower) ||
            roleLabel.includes(searchLower)
          );
        });
      }
      
      return result;
    },
    paginatedAccounts() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      return this.filteredAccounts.slice(start, end);
    },
    totalPages() {
      return Math.ceil(this.filteredAccounts.length / this.itemsPerPage);
    },
    displayedPages() {
      const pages = [];
      const maxDisplayedPages = 5;
      
      if (this.totalPages <= maxDisplayedPages) {
        for (let i = 1; i <= this.totalPages; i++) {
          pages.push(i);
        }
      } else {
        pages.push(1);
        
        let startPage = Math.max(2, this.currentPage - 1);
        let endPage = Math.min(this.totalPages - 1, this.currentPage + 1);
        
        if (startPage > 2) {
          pages.push('...');
        }
        
        for (let i = startPage; i <= endPage; i++) {
          pages.push(i);
        }
        
        if (endPage < this.totalPages - 1) {
          pages.push('...');
        }
        
        pages.push(this.totalPages);
      }
      
      return pages;
    },
    isAdmin() {
      try {
        return typeof window !== 'undefined' && localStorage && localStorage.getItem('role') === 'Admin';
      } catch (e) {
        return false;
      }
    }
  },
  methods: {
    checkAdminAccess() {
      try {
        if (!this.isAdmin) {
          ElMessage({
            type: 'error',
            message: 'Access denied. Only administrators can access this page.'
          });
          this.router.push('/');
          return false;
        }
        return true;
      } catch (e) {
        this.router.push('/');
        return false;
      }
    },
    formatDate(date) {
      if (!date) return '';
      return new Date(date).toLocaleDateString('en-US');
    },
    formatDateTime(dateTime) {
      if (!dateTime) return '';
      return new Date(dateTime).toLocaleString('vi-VN');
    },
    getRoleBadgeClass(role) {
      const classes = {
        'Admin': 'bg-danger',
        'Designer': 'bg-warning text-dark',
        'Manufacturer': 'bg-info'
      };
      return classes[role] || 'bg-secondary';
    },
    toggleAccountStatus(account) {
      if (!account) return;
      
      if (!this.isAdmin) {
        ElMessage({
          type: 'warning',
          message: 'Only administrators can lock/unlock accounts'
        });
        return;
      }

      try {
        const currentUserId = typeof window !== 'undefined' && localStorage ? localStorage.getItem('userId') : null;
        if (currentUserId === account.id) {
          ElMessage({
            type: 'warning',
            message: 'You cannot lock your own account'
          });
          return;
        }
      } catch (e) {
        console.error('Error accessing localStorage:', e);
        return;
      }
      
      const action = account.status === 'active' ? 'lock' : 'unlock';
      
      ElMessageBox.confirm(
        `Are you sure you want to ${action} account "${account.name}"?`,
        `${action.charAt(0).toUpperCase() + action.slice(1)} Account`,
        {
          confirmButtonText: action.charAt(0).toUpperCase() + action.slice(1),
          cancelButtonText: 'Cancel',
          type: action === 'lock' ? 'warning' : 'success'
        }
      )
      .then(async () => {
        try {
          const newStatus = account.status === 'active' ? 'inactive' : 'active';
          await updateStatus(account.id, account.status === 'active');
          
          account.status = newStatus;
          
          await this.fetchAccounts();
          
          ElMessage({
            type: 'success',
            message: `Account has been ${newStatus === 'active' ? 'unlocked' : 'locked'} successfully`
          });
        } catch (error) {
          console.error('Error updating status:', error);
          ElMessage({
            type: 'error',
            message: error.message || 'Failed to update account status'
          });
        }
      })
      .catch(() => {
        // User cancelled the operation
      });
    },
    editAccount(account) {
      this.editedAccount = JSON.parse(JSON.stringify(account));
      this.showEditModal = true;
    },
    async saveAccount() {
      try {
        const roleNumber = typeof this.editedAccount.role === 'number' ? this.editedAccount.role : this.userRoles.find(r => r.value === this.editedAccount.role)?.value;
        await updateRole(this.editedAccount.id, roleNumber, this.editedAccount.commissionRate || 0);
        await this.fetchAccounts();
        ElMessage({
          type: 'success',
          message: 'Account updated successfully'
        });
        this.showEditModal = false;
      } catch (error) {
        ElMessage({
          type: 'error',
          message: error.message || 'Failed to save account'
        });
      }
    },
    openEmailModal(account) {
      this.selectedAccount = account;
      this.emailForm = { subject: '', body: '' };
      this.showEmailModal = true;
    },
    async sendEmail() {
      try {
        const response = await axios.post('https://fcspwebapi20250527114117.azurewebsites.net/api/Auth/SendEmailToUser', {
          userId: this.selectedAccount.id,
          subject: this.emailForm.subject,
          body: this.emailForm.body,
          isHtml: true
        }, {
          headers: {
            'Content-Type': 'application/json',
            'accept': '*/*'
          }
        });

        if (response.data.code === 200) {
          ElMessage({
            type: 'success',
            message: response.data.message || 'Email sent successfully'
          });
          this.showEmailModal = false;
        } else {
          throw new Error('Failed to send email');
        }
      } catch (error) {
        console.error('Error sending email:', error);
        ElMessage({
          type: 'error',
          message: error.message || 'Failed to send email'
        });
      }
    },
    async fetchAccounts() {
      this.loading = true;
      try {
        const response = await getAllUser();
        this.accounts = response.map(user => ({
          id: user.id,
          name: user.name,
          email: user.email,
          role: typeof user.role === 'string'
            ? this.userRoles.find(r => r.label.toLowerCase() === user.role.toLowerCase())?.value
            : user.role,
          status: user.status === 'Active' ? 'active' : 'inactive',
          createdAt: user.createdAt
        }));
      } catch (error) {
        console.error('Error loading accounts:', error);
        ElMessage({
          type: 'error',
          message: 'Error loading accounts'
        });
      } finally {
        this.loading = false;
      }
    },
  },
  async created() {
    if (!this.checkAdminAccess()) return;
  },
  async mounted() {
    if (!this.checkAdminAccess()) return;

    try {
      await this.fetchAccounts();
    } catch (error) {
      console.error('Error in mounted hook:', error);
      ElMessage({
        type: 'error',
        message: 'Error initializing the page'
      });
    }
  },
}
</script>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
}

.main-content {
  flex: 1;
  margin-left: 250px;
  padding: 20px;
}

.search-card {
  border: none;
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
  transition: all 0.3s ease;
}

.search-card:hover {
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
}

.accounts-card {
  border: none;
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
  overflow: hidden;
}

.table th {
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.8rem;
  letter-spacing: 0.5px;
}

.table td {
  vertical-align: middle;
  padding: 0.75rem 1rem;
}

.avatar {
  width: 40px;
  height: 40px;
  object-fit: cover;
}

.avatar-large {
  width: 150px;
  height: 150px;
  object-fit: cover;
  border: 5px solid #fff;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}

.avatar-container {
  position: relative;
  display: inline-block;
}

.date-text {
  color: #6c757d;
  font-size: 0.9rem;
}

.badge {
  padding: 0.5em 0.75em;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-size: 0.75rem;
}

.modal-header {
  border-bottom: 0;
}

.modal-footer {
  border-top: 0;
}

.card-title {
  font-weight: 600;
  font-size: 1.1rem;
}

.list-group-item {
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
  border-color: rgba(0, 0, 0, 0.05);
}

.btn-sm {
  padding: 0.25rem 0.5rem;
  font-size: 0.8rem;
}

.btn-outline-primary, .btn-outline-success, .btn-outline-danger {
  transition: all 0.2s ease;
}

.btn-outline-primary:hover, .btn-outline-success:hover, .btn-outline-danger:hover {
  transform: translateY(-2px);
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.permission-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.permission-item {
  background-color: #f8f9fa;
  padding: 0.5rem 0.75rem;
  border-radius: 0.25rem;
  font-size: 0.875rem;
}

.permission-checkboxes {
  max-height: 200px;
  overflow-y: auto;
}

.badge {
  transition: background-color 0.3s ease;
}

@media (max-width: 768px) {
  .card-body {
    padding: 1rem;
  }
  
  .table th, .table td {
    padding: 0.5rem;
  }
  
  .btn-sm {
    padding: 0.2rem 0.4rem;
  }
  
  .avatar-large {
    width: 100px;
    height: 100px;
  }
}

.pagination {
  margin-bottom: 0;
  justify-content: center;
}

.card-footer {
  padding: 1rem;
}

.card-footer .d-flex {
  width: 100%;
}

.page-link {
  padding: 0.375rem 0.75rem;
  color: #6c757d;
  background-color: #fff;
  border: 1px solid #dee2e6;
}

.page-item.active .page-link {
  background-color: #0d6efd;
  border-color: #0d6efd;
  color: #fff;
}

.page-item.disabled .page-link {
  color: #6c757d;
  pointer-events: none;
  background-color: #fff;
  border-color: #dee2e6;
}

.page-link:hover {
  z-index: 2;
  color: #0d6efd;
  background-color: #e9ecef;
  border-color: #dee2e6;
}
</style>