<template>
  <div class="admin-container">
    <AdminSidebar />
    <div class="content">
      
     <div class="header">
      <h1 class="mb-4 text-primary fw-bold">Manage Products</h1>
      </div>
      
      <!-- Search and Filter -->
      <div class="search-filter">
        <div class="search-box">
          <input 
            type="text" 
            v-model="searchQuery" 
            placeholder="Search products..."
          />
          <i class="fas fa-search"></i>
        </div>
        <div class="filter-box">
          <select v-model="categoryFilter">
            <option value="">All Status</option>
            <option value="1">Active</option>
            <option value="2">Inactive</option>
          </select>
        </div>
      </div>

      <!-- Products Table -->
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Image</th>
              <th>Product Name</th>
              <th>Price</th>
              <th>Rating</th>
              <th>Rating Count</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="product in paginatedProducts" :key="product.id">
              <td>{{ product.id }}</td>
              <td>
                <img :src="product.image" :alt="product.name" class="product-image">
              </td>
              <td>{{ product.name }}</td>
              <td>{{ formatPrice(product.price) }}</td>
              <td>{{ product.rating }}/5</td>
              <td>{{ product.ratingCount }}</td>
              <td>
                <span :class="['status-text', getStatusClass(product.status)]">
                  {{ getStatusText(product.status) }}
                </span>
              </td>
              <td class="actions">
                <button 
                  class="btn btn-sm btn-outline-success me-1" 
                  data-bs-toggle="tooltip" 
                  title="Edit Status"
                  @click="openStatusModal(product)"
                >
                  <i class="bi bi-pencil"></i>
                </button>
                <button 
                  class="delete-btn" 
                  @click="confirmDelete(product)" 
                  title="Delete"
                > 
                  <i class="fas fa-trash-alt"></i>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
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
                <a class="page-link" href="#" @click.prevent="previousPage">
                  <i class="bi bi-chevron-left"></i>
                </a>
              </li>
              <li v-for="page in displayedPages" :key="page" class="page-item" :class="{ active: currentPage === page }">
                <a v-if="page !== '...'" class="page-link" href="#" @click.prevent="changePage(page)">{{ page }}</a>
                <span v-else class="page-link">...</span>
              </li>
              <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                <a class="page-link" href="#" @click.prevent="nextPage">
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

      <!-- Add/Edit Product Modal -->
      <div v-if="showAddModal || showEditModal" class="modal">
        <div class="modal-content">
          <span class="close" @click="closeModal">&times;</span>
          <h2>{{ showAddModal ? 'Add New Product' : 'Edit Product' }}</h2>
          <form @submit.prevent="showAddModal ? addProduct() : updateProduct()">
            <div class="form-group">
              <label>Product Name</label>
              <input type="text" v-model="productForm.name" required>
            </div>
            <div class="form-group">
              <label>Price</label>
              <input type="number" v-model="productForm.price" required>
            </div>
            <div class="form-group">
              <label>Description</label>
              <textarea v-model="productForm.description" required></textarea>
            </div>
            <div class="form-group">
              <label>Image</label>
              <input type="file" @change="handleImageUpload" accept="image/*">
              <img v-if="productForm.previewImageUrl" :src="productForm.previewImageUrl" class="preview-image">
            </div>
            <div class="form-group">
              <label>Status</label>
              <select v-model="productForm.status">
                <option :value="1">Active</option>
                <option :value="2">Inactive</option>
              </select>
            </div>
            <div class="form-actions">
              <button type="submit" class="submit-btn">
                {{ showAddModal ? 'Add' : 'Update' }}
              </button>
              <button type="button" class="cancel-btn" @click="closeModal">Cancel</button>
            </div>
          </form>
        </div>
      </div>

      <!-- Modal Update Status (Bootstrap style) -->
      <div class="modal fade" id="statusModal" tabindex="-1" ref="statusModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header bg-primary text-white">
              <h5 class="modal-title">Update Product Status</h5>
              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label for="status-select" class="form-label">Select new status:</label>
                <select id="status-select" class="form-select" v-model="selectedStatus">
                  <option :value="1">Public</option>
                  <!-- <option :value="2">Private</option> -->
                  <option :value="3">Archived</option>
                  <option :value="4">Pending</option>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-success" @click="confirmUpdateStatus">Update</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <client-only>
      <teleport to="body">
        <transition name="fade">
          <div v-if="showDeleteModal" class="modal-overlay">
            <div class="modal-wrapper delete-modal-wrapper">
              <div class="modal-container delete-modal-container">
                <div class="modal-header delete-modal-header">
                  <span class="delete-icon">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#dc3545" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10" fill="#fff"/><path d="M15 9l-6 6M9 9l6 6"/></svg>
                  </span>
                  <h3>Confirm product deletion</h3>
                  <button class="modal-close" @click="showDeleteModal = false">×</button>
                </div>
                <div class="modal-body delete-modal-body">
                  <p v-if="selectedProduct" class="delete-modal-title">Are you sure you want to delete<b>"{{ selectedProduct.name }}"</b>?</p>
                  <p class="text-danger delete-modal-warning">This action cannot be undone.</p>
                </div>
                <div class="modal-footer delete-modal-footer">
                  <button class="btn-cancel" @click="showDeleteModal = false">Cancel</button>
                  <button class="btn-delete" @click="handleDelete">Delete</button>
                </div>
              </div>
            </div>
          </div>
        </transition>
      </teleport>
    </client-only>
  </div>
</template>

<script>
import AdminSidebar from '@/components/AdminSidebar.vue'
import { getAllProducts, deleteProduct } from '@/server/product-service'
import { updateStatus } from '@/server/designUp-service'

export default {
  name: 'ManageProduct',
  components: {
    AdminSidebar
  },
  data() {
    return {
      products: [],
      categories: [],
      searchQuery: '',
      categoryFilter: '',
      currentPage: 1,
      itemsPerPage: 7,
      maxVisiblePages: 5,
      showAddModal: false,
      showEditModal: false,
      showDeleteModal: false,
      showStatusModal: false,
      productForm: {
        name: '',
        previewImageUrl: '',
        rating: 0,
        ratingCount: 0,
        price: 0,
        description: '',
        status: 1,
        gender: null
      },
      selectedProduct: null,
      selectedStatus: null,
      statusModal: null
    }
  },
  computed: {
    filteredProducts() {
      let filtered = this.products
      
      if (this.searchQuery) {
        filtered = filtered.filter(product => 
          product.name.toLowerCase().includes(this.searchQuery.toLowerCase())
        )
      }
      
      if (this.categoryFilter) {
        filtered = filtered.filter(product => 
          product.status === parseInt(this.categoryFilter)
        )
      }
      
      return filtered
    },
    paginatedProducts() {
      const start = (this.currentPage - 1) * this.itemsPerPage
      const end = start + this.itemsPerPage
      return this.filteredProducts.slice(start, end)
    },
    totalPages() {
      return Math.ceil(this.filteredProducts.length / this.itemsPerPage)
    },
    displayedPages() {
      const pages = [];
      const maxDisplayedPages = 5;
      
      if (this.totalPages <= maxDisplayedPages) {
        // Nếu tổng số trang ít hơn hoặc bằng maxDisplayedPages, hiển thị tất cả
        for (let i = 1; i <= this.totalPages; i++) {
          pages.push(i);
        }
      } else {
        // Luôn hiển thị trang đầu tiên
        pages.push(1);
        
        // Tính toán các trang ở giữa
        let startPage = Math.max(2, this.currentPage - 1);
        let endPage = Math.min(this.totalPages - 1, this.currentPage + 1);
        
        // Điều chỉnh để luôn hiển thị 3 trang ở giữa
        if (startPage > 2) {
          pages.push('...');
        }
        
        for (let i = startPage; i <= endPage; i++) {
          pages.push(i);
        }
        
        // Thêm dấu ... nếu cần
        if (endPage < this.totalPages - 1) {
          pages.push('...');
        }
        
        // Luôn hiển thị trang cuối cùng
        pages.push(this.totalPages);
      }
      
      return pages;
    }
  },
  methods: {
    async fetchProducts() {
      try {
        const response = await getAllProducts()
        console.log(response)
        if (response && response.code === 200 && response.data && response.data.designs) {
          this.products = response.data.designs.map(design => ({
            id: design.id,
            name: design.name,
            image: design.previewImageUrl,
            price: design.total || 0,
            status: design.status,
            description: design.description || '',
            rating: design.rating || 0,
            ratingCount: design.ratingCount || 0
          }))
        }
      } catch (error) {
        console.error('Error fetching products:', error)
      }
    },
    formatPrice(price) {
      return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
      }).format(price)
    },
    getStatusText(status) {
      switch (status) {
        case 1: return 'Public';
        
        case 3: return 'Archived';
        case 4: return 'Pending';
        default: return 'Unknown';
      }
    },
    getStatusClass(status) {
      switch (status) {
        case 1: return 'public';
        case 3: return 'archived';
        case 4: return 'pending';
        default: return '';
      }
    },
    handleImageUpload(event) {
      const file = event.target.files[0]
      if (file) {
        this.productForm.previewImageUrl = URL.createObjectURL(file)
      }
    },
    editProduct(product) {
      this.selectedProduct = product
      this.productForm = {
        name: product.name,
        previewImageUrl: product.image,
        price: product.price,
        description: product.description,
        status: product.status,
        rating: product.rating,
        ratingCount: product.ratingCount,
        gender: product.gender
      }
      this.showEditModal = true
    },
    async updateProduct() {
      try {
        if (this.selectedProduct) {
          // Update the product status
          const response = await updateStatus(this.selectedProduct.id, this.productForm.status);
          
          if (response && response.code === 200) {
            // Show success message or notification
            alert('Product status updated successfully!');
            this.closeModal();
            await this.fetchProducts(); // Refresh the product list
          } else {
            throw new Error('Failed to update product status');
          }
        }
      } catch (error) {
        console.error('Error updating product:', error);
        alert('An error occurred while updating the product!');
      }
    },
    confirmDelete(product) {
      console.log('Confirming delete for product:', product);
      this.selectedProduct = product;
      this.showDeleteModal = true;
      console.log('Modal state:', this.showDeleteModal);
    },
    async handleDelete() {
      try {
        if (!this.selectedProduct) {
          console.log('No product selected for deletion');
          alert('No product selected for deletion');
          return;
        }
        
        console.log('Selected product for deletion:', this.selectedProduct);
        console.log('Attempting to delete product with ID:', this.selectedProduct.id);
        
        const response = await deleteProduct(this.selectedProduct.id);
        console.log('Delete response:', response);
        
        // If we reach here, deletion was successful
        alert('Product deleted successfully!');
        this.showDeleteModal = false;
        this.selectedProduct = null;
        await this.fetchProducts(); // Refresh the list
        
      } catch (error) {
        console.error('Error deleting product:', error);
        console.error('Error details:', {
          message: error.message,
          response: error.response,
          status: error.response?.status
        });
        alert(error.message || 'An error occurred while deleting the product');
      } finally {
        this.showDeleteModal = false;
      }
    },
    closeModal() {
      this.showAddModal = false
      this.showEditModal = false
      this.productForm = {
        name: '',
        previewImageUrl: '',
        rating: 0,
        ratingCount: 0,
        price: 0,
        description: '',
        status: 1,
        gender: null
      }
    },
    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page
      }
    },
    previousPage() {
      if (this.currentPage > 1) {
        this.currentPage--
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++
      }
    },
    openStatusModal(product) {
      if (!this.statusModal && window.bootstrap) {
        this.statusModal = new window.bootstrap.Modal(this.$refs.statusModal);
      }
      this.selectedProduct = product;
      this.selectedStatus = product.status;
      this.statusModal.show();
    },
    closeStatusModal() {
      if (this.statusModal) this.statusModal.hide();
      this.selectedProduct = null;
      this.selectedStatus = null;
    },
    async confirmUpdateStatus() {
      if (!this.selectedProduct) return;
      try {
        const response = await updateStatus(this.selectedProduct.id, this.selectedStatus);
        if (response && response.code === 200) {
          this.selectedProduct.status = this.selectedStatus;
          alert('Status updated successfully!');
          this.closeStatusModal();
        } else {
          throw new Error('Failed to update status');
        }
      } catch (error) {
        alert('Error updating status!');
      }
    }
  },
  mounted() {
    this.fetchProducts();
    // Ensure Bootstrap JS is available
    if (typeof window !== 'undefined' && !window.bootstrap) {
      import('bootstrap/dist/js/bootstrap.bundle.min.js').then((mod) => {
        window.bootstrap = mod;
      });
    }
  }
}
</script>

<style scoped>
.admin-container {
  display: flex;
  min-height: 100vh;
  background-color: white;
  margin-left: 250px; /* Add margin for sidebar */
  width: calc(100% - 250px); /* Adjust width to account for sidebar */
}

.content {
  flex: 1;
  padding: 20px;
  width: 100%;
  overflow-x: auto;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.add-btn {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
}

.search-filter {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}

.search-box, .filter-box {
  position: relative;
}

.search-box input, .filter-box select {
  padding: 10px 40px 10px 15px;
  border: 1px solid #ddd;
  border-radius: 4px;
  width: 300px;
}

.search-box i {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
}

.table-container {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed;
}

th, td {
  padding: 12px 15px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  vertical-align: middle;
}

th:last-child, td:last-child {
  width: 120px;
  text-align: center;
}

th {
  background-color: #f8f9fa;
  font-weight: 600;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  border-radius: 4px;
}

.status-toggle {
  display: flex;
  align-items: center;
  gap: 10px;
}

.status-text {
  font-size: 14px;
  font-weight: 500;
}

.status-text.public {
  color: #4CAF50;
}

.status-text.private {
  color: #f44336;
}

.status-text.archived {
  color: #2196F3;
}

.status-text.pending {
  color: #FF9800;
}

.status-update-btn {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 16px;
  color: #666;
}

.actions {
  display: flex;
  gap: 8px;
  justify-content: center;
  align-items: center;
  border-right: none;
  margin-top: 18px;
}

.edit-btn, .delete-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.edit-btn {
  background-color: #2196F3;
  color: white;
}

.edit-btn:hover {
  background-color: #1976D2;
}

.delete-btn {
  background-color: #f44336;
  color: white;
}

.delete-btn:hover {
  background-color: #d32f2f;
}

.edit-btn i, .delete-btn i {
  font-size: 16px;
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

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 99999;
}

.modal-content {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  width: 90%;
  max-width: 400px;
  position: relative;
  z-index: 100000;
}

.delete-modal {
  text-align: center;
  margin: auto;
}

.delete-modal h2 {
  margin-bottom: 1rem;
  color: #333;
}

.delete-modal p {
  margin-bottom: 1rem;
  color: #666;
}

.text-danger {
  color: #dc3545;
  font-weight: 500;
}

.delete-actions {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.5rem;
}

.btn-cancel,
.btn-delete {
  padding: 0.5rem 1.5rem;
  border: none;
  border-radius: 4px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-cancel {
  background-color: #6c757d;
  color: white;
}

.btn-cancel:hover {
  background-color: #5a6268;
}

.btn-delete {
  background-color: #dc3545;
  color: white;
}

.btn-delete:hover {
  background-color: #c82333;
}

/* Transition animations */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.modal-overlay {
  position: fixed;
  top: 0; left: 0; width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 99999;
}

.delete-modal-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100vw;
  height: 100vh;
}
.delete-modal-container {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(220,53,69,0.15), 0 1.5px 4px rgba(0,0,0,0.08);
  max-width: 380px;
  width: 100%;
  padding: 0;
  overflow: hidden;
  animation: popIn 0.25s cubic-bezier(.4,2,.6,1) both;
}
@keyframes popIn {
  0% { transform: scale(0.8); opacity: 0; }
  100% { transform: scale(1); opacity: 1; }
}
.delete-modal-header {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 20px 24px 10px 24px;
  border-bottom: 1px solid #f1f1f1;
  background: #fff;
}
.delete-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff0f1;
  border-radius: 50%;
  padding: 8px;
  margin-right: 8px;
}
.delete-modal-header h3 {
  font-size: 20px;
  font-weight: 600;
  color: #dc3545;
  margin: 0;
  flex: 1;
}
.modal-close {
  background: none;
  border: none;
  font-size: 24px;
  color: #888;
  cursor: pointer;
  margin-left: 8px;
  transition: color 0.2s;
}
.modal-close:hover {
  color: #dc3545;
}
.delete-modal-body {
  padding: 18px 24px 0 24px;
  text-align: center;
}
.delete-modal-title {
  font-size: 16px;
  color: #333;
  margin-bottom: 8px;
}
.delete-modal-warning {
  font-size: 14px;
  color: #dc3545;
  margin-bottom: 0;
}
.delete-modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 18px 24px 20px 24px;
  background: #fff;
  border-top: 1px solid #f1f1f1;
}
.btn-cancel {
  background: #f1f1f1;
  color: #333;
  border: none;
  border-radius: 4px;
  padding: 8px 20px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s;
}
.btn-cancel:hover {
  background: #e0e0e0;
}
.btn-delete {
  background: #dc3545;
  color: #fff;
  border: none;
  border-radius: 4px;
  padding: 8px 20px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s;
  box-shadow: 0 2px 8px rgba(220,53,69,0.08);
}
.btn-delete:hover {
  background: #b52a37;
}
</style>
