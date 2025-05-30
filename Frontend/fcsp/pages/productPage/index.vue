<template>
  <div class="product-wrapper">
    <Header />

    <!-- Main Content Section -->
    <section class="container my-5">
      <!-- Filters and Sort -->
      <div class="controls">
        <div class="controls-left">
          <div class="search-box">
            <i class="bi bi-search search-icon"></i>
            <input 
              type="text" 
              v-model="searchQuery" 
              placeholder="Search products..." 
              class="search-input"
            />
          </div>
        </div>
        <div class="sort">
          Sort by:
          <select v-model="sortOption" class="sort-select">
            <option value="featured">Featured</option>
            <option value="price-low">Price: Low to High</option>
            <option value="price-high">Price: High to Low</option>
            <option value="name-asc">Name: A to Z</option>
            <option value="name-desc">Name: Z to A</option>
          </select>
        </div>
      </div>
      
      <div class="row">
        <!-- Product Grid -->
        <div class="col-12">
          <div v-if="loading" class="row g-4">
            <div v-for="n in 12" :key="n" class="col-md-3">
              <div class="card sneaker-card h-100 shadow-lg rounded overflow-hidden">
                <div class="skeleton-img"></div>
                <div class="card-body d-flex flex-column">
                  <div class="skeleton-text mb-2"></div>
                  <div class="skeleton-text mb-3"></div>
                  <div class="skeleton-text mb-3"></div>
                  <div class="skeleton-button"></div>
                </div>
              </div>
            </div>
          </div>
          <div v-else>
            <div class="row g-4">
              <div v-for="product in paginatedProducts" :key="product.id" class="col-md-3">
                <div 
                  class="card sneaker-card h-100 shadow-lg rounded overflow-hidden clickable-card"
                  @click="goToDetailPage(product.id)"
                >
                  <div class="position-relative">
                    <img
                      :src="product.previewImageUrl"
                      :alt="product.name"
                      class="card-img-top sneaker-img"
                      loading="lazy"
                    />
                  </div>
                  <div class="card-body d-flex flex-column">
                    <h5
                      class="card-title text-dark fw-bold"
                      style="cursor: pointer"
                    >
                      {{ product.name }}
                    </h5>
                    <div class="rating mb-2">
                      <div class="stars">
                        <i 
                          v-for="index in 5" 
                          :key="index"
                          class="bi"
                          :class="getStarClass(product.rating, index)"
                          aria-hidden="true"
                        ></i>
                      </div>
                      <span class="rating-value">({{ product.rating }} / {{ product.ratingCount }} reviews)</span>
                    </div>
                    <h5 class="text-sneaker-blue mb-3">{{ formatPrice(product.total) }} đ</h5>
                    <button
                      class="btn btn-sneaker w-100 py-3 fw-bold text-uppercase"
                      @click.stop="goToDetailPage(product.id)"
                      aria-label="View product details"
                    >
                      View Details
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pagination -->
            <nav class="mt-5 d-flex justify-content-center" aria-label="Product pagination">
              <ul class="pagination">
                <li class="page-item" :class="{ disabled: currentPage === 1 }">
                  <button 
                    class="page-link" 
                    @click="changePage(currentPage - 1)"
                    :disabled="currentPage === 1"
                    aria-label="Previous page"
                  >
                    Previous
                  </button>
                </li>
                <li
                  v-for="page in totalPages"
                  :key="page"
                  class="page-item"
                  :class="{ active: page === currentPage }"
                >
                  <button 
                    class="page-link" 
                    @click="changePage(page)"
                    :aria-current="page === currentPage ? 'page' : null"
                  >
                    {{ page }}
                  </button>
                </li>
                <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                  <button 
                    class="page-link" 
                    @click="changePage(currentPage + 1)"
                    :disabled="currentPage === totalPages"
                    aria-label="Next page"
                  >
                    Next
                  </button>
                </li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
    </section>

    <!-- Newsletter Section -->
    <div class="newsletter-section">
      <img 
        src="https://i.pinimg.com/736x/87/88/95/878895303d804635464c69ca3b932995.jpg" 
        alt="Newsletter Visual" 
        class="newsletter-bg-img"
        loading="lazy"
      >
      <div class="newsletter-content">
        <div class="newsletter-text">
          <div class="newsletter-label">Newsletter</div>
          <h4 class="newsletter-title">Get Weekly Updates</h4>
          <form class="newsletter-form">
            <input 
              type="email" 
              class="newsletter-input" 
              placeholder="example@gmail.com" 
              required
            />
            <button class="newsletter-button" type="submit">Subscribe</button>
          </form>
          <div class="newsletter-website">www.DownloadNewThemes.com</div>
        </div>
      </div>
    </div>

    <!-- Services Section -->
    <div class="services-section">
      <div class="services-container">
        <div class="service-item">
          <i class="bi bi-truck"></i>
          <div class="service-title">Fast & Safe Delivery</div>
          <div class="service-description">Excellent delivery speed</div>
        </div>
        <div class="service-item">
          <i class="bi bi-arrow-counterclockwise"></i>
          <div class="service-title">Money Back Guarantee</div>
          <div class="service-description">Refund within 10 days</div>
        </div>
        <div class="service-item">
          <i class="bi bi-clock-history"></i>
          <div class="service-title">24h Return Policy</div>
          <div class="service-description">No questions asked</div>
        </div>
        <div class="service-item">
          <i class="bi bi-headset"></i>
          <div class="service-title">Quality Support</div>
          <div class="service-description">24/7 Support</div>
        </div>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from "vue";
import { useRouter } from "vue-router";
import { getAllProducts } from "~/server/product-service";

const router = useRouter();
const products = ref([]);
const filteredProducts = ref([]);
const loading = ref(true);
const currentPage = ref(1);
const itemsPerPage = 12;
const searchQuery = ref('');
const sortOption = ref('featured');

// Watch for search and sort changes
watch([searchQuery, sortOption], () => {
  filterAndSortProducts();
});

// Filter and sort products
const filterAndSortProducts = () => {
  let filtered = [...products.value];
  
  // Apply search filter
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase();
    filtered = filtered.filter(product => 
      product.name.toLowerCase().includes(query)
    );
  }
  
  // Apply sorting
  switch (sortOption.value) {
    case 'price-low':
      filtered.sort((a, b) => a.total - b.total);
      break;
    case 'price-high':
      filtered.sort((a, b) => b.total - a.total);
      break;
    case 'name-asc':
      filtered.sort((a, b) => a.name.localeCompare(b.name));
      break;
    case 'name-desc':
      filtered.sort((a, b) => b.name.localeCompare(a.name));
      break;
    // 'featured' is default order
  }
  
  filteredProducts.value = filtered;
  currentPage.value = 1;
};

// Fetch products from API
const fetchProducts = async () => {
  try {
    loading.value = true;
    const response = await getAllProducts();
    console.log(response);

    if (response.data?.designs?.length) {
      const activeProducts = response.data.designs.filter(product => product.status === 1);
      products.value = activeProducts;
      filteredProducts.value = activeProducts;
    } else {
      products.value = [];
      filteredProducts.value = [];
    }
    
  } catch (error) {
    console.error('Error fetching products:', error);
    products.value = [];
    filteredProducts.value = [];
  } finally {
    loading.value = false;
  }
};

const paginatedProducts = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  return filteredProducts.value.slice(start, end);
});

const totalPages = computed(() => Math.ceil(filteredProducts.value.length / itemsPerPage));

const changePage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page;
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
};

const goToDetailPage = (productId) => {
  router.push(`/productPage/${productId}`);
};

const getStarClass = (rating, position) => {
  const roundedRating = Math.round(rating * 2) / 2;
  if (position <= Math.floor(roundedRating)) {
    return 'bi-star-fill text-warning';
  } else if (position === Math.ceil(roundedRating) && !Number.isInteger(roundedRating)) {
    return 'bi-star-half text-warning';
  }
  return 'bi-star text-warning';
};

const formatPrice = (price) => {
  if (typeof price === 'number') {
    return price.toLocaleString('vi-VN');
  }
  return '0';
};

onMounted(async () => {
  await fetchProducts();
});
</script>

<style scoped>
.product-wrapper {
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f2 100%);
  min-height: 100vh;
  font-family: 'Poppins', sans-serif;
  position: relative;
}

.product-wrapper::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 10%, transparent 10%);
  background-size: 30px 30px;
  opacity: 0.5;
  z-index: 0;
}

.container {
  position: relative;
  z-index: 1;
}

/* Card Styles */
.sneaker-card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border: none;
  background: #ffffff;
  border-radius: 15px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
  border: 1px solid rgba(0, 0, 0, 0.05);
  animation: fadeInUp 0.5s ease;
}

.clickable-card {
  cursor: pointer;
}

.clickable-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1) !important;
}

.sneaker-img {
  height: 200px;
  object-fit: cover;
  cursor: pointer;
  transition: transform 0.3s ease;
  /* border-radius: 15px 15px 0 0; */
}

.sneaker-img:hover {
  transform: scale(1.05);
}

/* Rating Styles */
.rating {
  display: flex;
  align-items: center;
  gap: 5px;
}

.stars {
  display: inline-flex;
  gap: 2px;
  margin-right: 8px;
}

.rating-value {
  color: #34495e;
  font-size: 0.9rem;
}

/* Button Styles */
.btn-sneaker {
  background: #AAAAAA;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 12px;
  font-weight: 600;
  font-size: 1.1rem;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(170, 170, 170, 0.3);
}

.btn-sneaker:hover {
  background: #888888;
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(170, 170, 170, 0.4);
}

.btn-sneaker:active {
  transform: translateY(0);
  box-shadow: 0 3px 10px rgba(170, 170, 170, 0.2);
}

/* Pagination Styles */
.pagination .page-link {
  color: #AAAAAA;
  border: none;
  padding: 10px 15px;
  transition: all 0.3s ease;
  border-radius: 8px;
  margin: 0 5px;
}

.pagination .page-item.active .page-link {
  background: #AAAAAA;
  color: #fff;
  box-shadow: 0 5px 15px rgba(170, 170, 170, 0.3);
}

.pagination .page-link:hover {
  background: #888888;
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(170, 170, 170, 0.3);
}

.pagination .page-item.disabled .page-link {
  color: #ccc;
  cursor: not-allowed;
}

/* Skeleton Loading */
.skeleton-img {
  height: 200px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
  border-radius: 15px 15px 0 0;
}

.skeleton-text {
  height: 20px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
  border-radius: 8px;
  margin-bottom: 10px;
}

.skeleton-button {
  height: 44px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
  border-radius: 8px;
}

@keyframes loading {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}

/* Newsletter Section */
.newsletter-section {
  position: relative;
  margin: 50px auto;
  border-radius: 24px;
  overflow: hidden;
  width: 100%;
  max-width: 1300px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
}

.newsletter-bg-img {
  width: 100%;
  height: 320px;
  object-fit: cover;
}

.newsletter-content {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
}

.newsletter-text {
  text-align: center;
  color: white;
  padding: 20px;
}

.newsletter-label {
  font-size: 1rem;
  font-weight: bold;
  margin-bottom: 10px;
  color: #AAAAAA;
}

.newsletter-title {
  font-size: 1.8rem;
  font-weight: bold;
  margin-bottom: 20px;
}

.newsletter-form {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 20px;
  max-width: 420px;
  margin: 0 auto 20px;
}

.newsletter-input {
  flex: 1;
  padding: 10px 20px;
  border-radius: 30px;
  border: 1px solid #e0e0e0;
  height: 44px;
  background: #f9f9f9;
  transition: all 0.3s ease;
}

.newsletter-input:focus {
  border-color: #3498db;
  background: #fff;
  box-shadow: 0 0 10px rgba(52, 152, 219, 0.2);
  outline: none;
}

.newsletter-button {
  padding: 10px 30px;
  border-radius: 30px;
  background: #777777;
  color: white;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}

.newsletter-button:hover {
  background: #555555;
  transform: translateY(-2px);
}

.newsletter-website {
  font-weight: bold;
  font-size: 1.05rem;
}

/* Services Section */
.services-section {
  padding: 50px 0;
  background: #ffffff;
  border-radius: 15px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
  margin: 50px auto;
  max-width: 1300px;
}

.services-container {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.service-item {
  text-align: center;
  padding: 20px;
  flex: 1;
  min-width: 200px;
  transition: transform 0.3s ease;
}

.service-item:hover {
  transform: translateY(-5px);
}

.service-item i {
  font-size: 2rem;
  color: #777777;
  margin-bottom: 15px;
}

.service-title {
  font-weight: bold;
  margin-bottom: 10px;
  color: #34495e;
}

.service-description {
  color: #7f8c8d;
  font-size: 0.9rem;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Controls (Filters and Sort) */
.controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  background: #ffffff;
  padding: 1rem;
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.controls:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

.controls-left {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.search-box {
  position: relative;
  min-width: 250px;
}

.search-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #AAAAAA;
}

.search-input {
  width: 100%;
  padding: 0.5rem 1rem 0.5rem 2.5rem;
  border: 2px solid #E5E7EB;
  border-radius: 8px;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.search-input:focus {
  outline: none;
  border-color: #AAAAAA;
  box-shadow: 0 0 0 4px rgba(170, 170, 170, 0.1);
}

.filters {
  font-weight: 600;
  color: #AAAAAA;
  cursor: pointer;
  transition: all 0.3s ease;
}

.filters:hover {
  transform: translateX(5px);
}

.sort {
  font-size: 0.9rem;
  color: #6B7280;
}

.sort-select {
  padding: 0.5rem;
  border: 2px solid #E5E7EB;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.sort-select:focus {
  outline: none;
  border-color: #AAAAAA;
  box-shadow: 0 0 0 4px rgba(170, 170, 170, 0.1);
  transform: translateY(-2px);
}

/* Responsive Styles */
@media (max-width: 992px) {
  .sneaker-img {
    height: 180px;
  }
  
  .card-body {
    padding: 15px;
  }
  
  .pagination .page-link {
    padding: 8px 12px;
  }
  
  .newsletter-section {
    width: 90%;
    margin: 30px auto;
  }
  
  .newsletter-section .newsletter-bg-img { 
    border-radius: 12px; 
  }

  .services-container {
    flex-direction: column;
    align-items: center;
  }

  .service-item {
    width: 100%;
    max-width: 300px;
  }
}

@media (max-width: 576px) {
  .sneaker-img {
    height: 160px;
  }

  .newsletter-section {
    width: 95%;
    margin: 20px auto;
  }
}
</style>