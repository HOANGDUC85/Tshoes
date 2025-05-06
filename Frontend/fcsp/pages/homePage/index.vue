<!-- Home Page Template - Custom Sneaker Theme -->
<template>
  <div class="home-wrapper">
    <!-- Header Component -->
    <Header />

    <!-- Hero Section -->
    <section class="hero-section new-arrivals-section d-flex align-items-center justify-content-center">
      <div class="container">
        <div class="row align-items-center">
          <!-- Text bên trái -->
          <div class="col-md-6 text-start">
            <h1 class="display-3 fw-bold text-new-arrivals mb-3">
              {{ heroSlides[currentSlide].title }}
            </h1>
            <p class="lead text-muted mb-4">
              {{ heroSlides[currentSlide].description }}
            </p>
            <NuxtLink :to="heroSlides[currentSlide].link" class="btn btn-view-collection fw-bold">
              View Collection <span class="ms-2">&#8594;</span>
            </NuxtLink>
          </div>
          <!-- Ảnh giày bên phải -->
          <div class="col-md-6 text-center">
            <img :src="heroSlides[currentSlide].image" alt="New Arrivals Shoes" class="img-fluid hero-shoe-img" />
          </div>
        </div>
        <!-- Nút chuyển slide -->
        <button class="hero-arrow hero-arrow-left" @click="prevSlide">
          <span>&#8592;</span>
        </button>
        <button class="hero-arrow hero-arrow-right" @click="nextSlide">
          <span>&#8594;</span>
        </button>
      </div>
    </section>

    <!-- Collection Section -->
    <section class="collection-section container py-5">
      <h2 class="collection-title text-center">Our Collections</h2>
      <p class="collection-desc text-center">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.
      </p>
      <div class="row g-4">
        <div
          v-for="(product, idx) in collections"
          :key="product.id"
          class="col-md-3 col-6"
        >
          <div class="product-card-collection" @mouseenter="hoverIdx = idx" @mouseleave="hoverIdx = null">
            <div class="product-img-wrap">
              <img :src="product.image" :alt="product.name" class="img-fluid" />
              <div
                class="product-overlay"
                v-if="hoverIdx === idx"
              >
                <button class="overlay-btn"><i class="bi bi-eye"></i></button>
                <button class="overlay-btn"><i class="bi bi-bag"></i></button>
              </div>
            </div>
            <div class="product-info text-center mt-2">
              <div class="product-name">{{ product.name }}</div>
              <div class="product-price" v-html="product.price"></div>
              <div class="product-rating">
                <span v-for="star in 5" :key="star">
                  <i class="bi" :class="star <= product.rating ? 'bi-star-fill text-warning' : 'bi-star text-muted'"></i>
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center mt-4">
        <NuxtLink to="/productPage" class="btn btn-outline-collection">View All Products</NuxtLink>
      </div>
    </section>

    <!-- How It Works Section -->
    <section class="how-it-works-section py-5 bg-light">
      <div class="container">
        <div class="row align-items-center">
          <!-- Text bên trái -->
          <div class="col-md-6 text-start">
            <h1 class="display-3 fw-bold text-new-arrivals mb-3">
              {{ heroSlides[currentSlide].title }}
            </h1>
            <p class="lead text-muted mb-4">
              {{ heroSlides[currentSlide].description }}
            </p>
            <NuxtLink to="/aboutPage" class="btn btn-view-purchase fw-bold">
              View About
            </NuxtLink>
          </div>
          <!-- Ảnh giày bên phải -->
          <div class="col-md-6 text-center">
            <img :src="heroSlides[currentSlide].image" alt="New Arrivals Shoes" class="img-fluid hero-shoe-img" />
          </div>
        </div>
      </div>
    </section>

    <!-- Featured Designs Section -->
    <section class="featured-designs-section container py-5">
      <div class="row g-4">
        <div class="col-md-4" v-for="(item, idx) in featuredDesigns" :key="idx">
          <div class="design-card-custom">
            <div class="design-img-wrap">
              <img :src="item.image" :alt="item.title" class="img-fluid rounded" />
              <div class="design-date-badge">
                <span class="date-day">{{ item.dateDay }}</span>
                <span class="date-month">{{ item.dateMonth }}</span>
              </div>
            </div>
            <h5 class="design-title">{{ item.title }}</h5>
            <p class="design-desc">{{ item.desc }}</p>
          </div>
        </div>
      </div>
      <div class="text-center mt-4">
        <NuxtLink to="/blogPage" class="btn btn-sneaker px-5 py-3 fw-bold text-uppercase">
          View All Blogs
        </NuxtLink>
      </div>
    </section>

    <!-- Best Seller Sneakers Section -->
    <section class="best-seller-highlight-section py-5">
      <div class="container">
        <div class="row align-items-center justify-content-center">
          <!-- Ảnh giày bên trái -->
          <div class="col-md-6 text-center">
            <img :src="bestSeller.image" :alt="bestSeller.name" class="img-fluid best-seller-img" />
          </div>
          <!-- Thông tin bên phải -->
          <div class="col-md-6">
            <h2 class="best-seller-title">{{ bestSeller.name }}</h2>
            <div class="best-seller-rating mb-2">
              <span v-for="star in 5" :key="star">
                <i class="bi" :class="star <= bestSeller.rating ? 'bi-star-fill text-warning' : 'bi-star text-muted'"></i>
              </span>
            </div>
            <p class="best-seller-desc">{{ bestSeller.desc }}</p>
            <div class="best-seller-colors mb-4">
              <span
                v-for="(color, idx) in bestSeller.colors"
                :key="idx"
                :style="{ background: color }"
                class="color-dot"
              ></span>
            </div>
            <NuxtLink :to="bestSeller.link" class="btn btn-best-seller-buy">Buy Now</NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section py-5 bg-light">
      <div class="container">
        <h2 class="text-center fw-bold mb-5 text-sneaker-orange">What Our Customers Say</h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="testimonial-box p-4 rounded">
              <p class="text-muted">"The customization tool is amazing! My sneakers turned out exactly as I wanted."</p>
              <h6 class="mt-3 fw-bold">John D.</h6>
              <span class="text-sneaker-star">★★★★★</span>
            </div>
          </div>
          <div class="col-md-4">
            <div class="testimonial-box p-4 rounded">
              <p class="text-muted">"Fast delivery and perfect fit. I'm already designing my next pair!"</p>
              <h6 class="mt-3 fw-bold">Sarah K.</h6>
              <span class="text-sneaker-star">★★★★★</span>
            </div>
          </div>
          <div class="col-md-4">
            <div class="testimonial-box p-4 rounded">
              <p class="text-muted">"Hands down the best sneaker experience. Worth every penny."</p>
              <h6 class="mt-3 fw-bold">Mike L.</h6>
              <span class="text-sneaker-star">★★★★★</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Readmore Section -->
    <section class="readmore-section container py-5">
      <h2 class="text-center fw-bold mb-5 text-sneaker-orange">Sneaker Stories</h2>
      <div class="row g-4">
        <div class="col-md-6" v-for="article in readmoreArticles" :key="article.id">
          <div class="readmore-card d-flex">
            <img :src="article.image" :alt="article.title" class="img-fluid rounded" style="max-width: 200px;" />
            <div class="ms-3">
              <h5 class="fw-bold">{{ article.title }}</h5>
              <p class="text-muted">{{ article.excerpt }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Call to Action Section -->
    <section class="cta-section text-center py-5">
      <div class="container">
        <h2 class="fw-bold text-white">Ready to Elevate Your Style?</h2>
        <p class="text-light mt-3">Join thousands of sneaker enthusiasts who have turned their dreams into reality.</p>
        <NuxtLink to="/customPage" class="btn btn-sneaker px-5 py-3 mt-4 fw-bold text-uppercase">
          Start Designing
        </NuxtLink>
      </div>
    </section>

    <!-- Footer Component -->
    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useCartStore } from '@/server/cart'
import { GetBestSelling } from '~/server/BestSelling-service'

// Define reactive state
const products = ref([])
const router = useRouter()
const hoverIdx = ref(null)
const cartStore = useCartStore()
const isLoading = ref(false)
const error = ref(null)

// Fetch products on component mount
onMounted(async () => {
  isLoading.value = true
  error.value = null
  try {
    const response = await GetBestSelling()
    if (response && response.data.designs) {
      products.value = response.data.designs.map(product => ({
        id: product.id,
        name: product.name,
        image: product.previewImageUrl,
        price: product.price,
        rating: product.rating,
        reviews: product.ratingCount
      }))
    }
  } catch (err) {
    error.value = err.message || 'Có lỗi xảy ra khi tải dữ liệu'
    console.error('Error fetching products:', err)
  } finally {
    isLoading.value = false
  }
})

// Hàm thêm vào giỏ hàng
const addToCart = (product) => {
  cartStore.addItem({
    id: product.id,
    name: product.name,
    price: product.price,
    image: product.image,
    quantity: 1
  })
}

const navigateToProduct = (productId) => {
  router.push(`/productPage/${productId}`);
};

// Slider cho Hero Section
const heroSlides = [
  {
    title: 'New Arrivals',
    description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad veniam, quis nostrud.',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/2b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-air-zoom-pegasus-33.jpg',
    link: '/collection'
  },
  {
    title: 'Hot Trend 2024',
    description: 'Khám phá những mẫu giày hot nhất năm 2024, phong cách trẻ trung, năng động và cá tính.',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/1b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-air-max-2024.jpg',
    link: '/collection'
  }
]
const currentSlide = ref(0)
function prevSlide() {
  currentSlide.value = (currentSlide.value - 1 + heroSlides.length) % heroSlides.length
}
function nextSlide() {
  currentSlide.value = (currentSlide.value + 1) % heroSlides.length
}

const collections = [
  {
    id: 1,
    name: 'Jungle Moc Slip-on',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/2b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-air-zoom-pegasus-33.jpg',
    price: '$300.00',
    rating: 4
  },
  {
    id: 2,
    name: 'Jungle Moc Slip-on',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/1b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-air-max-2024.jpg',
    price: '$300.00',
    rating: 3
  },
  {
    id: 3,
    name: 'Cloudfoam Race Sneaker',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/3b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-cloudfoam.jpg',
    price: '$120.00',
    rating: 5
  },
  {
    id: 4,
    name: 'Low waterproof Boot',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/4b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-waterproof.jpg',
    price: '$400.00',
    rating: 4
  },
  {
    id: 5,
    name: 'Garren Cap Toe Brogue',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/5b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-garren.jpg',
    price: '$290.00',
    rating: 3
  },
  {
    id: 6,
    name: 'Dunham Lexington',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/6b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-dunham.jpg',
    price: '<span style="text-decoration:line-through;color:#bbb;">$550</span> <span style="color:#3ec6a7;">$450.00</span>',
    rating: 5
  },
  {
    id: 7,
    name: 'Merrell Encore Bypass',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/7b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-merrell.jpg',
    price: '$300.00',
    rating: 4
  },
  {
    id: 8,
    name: 'Sperry Top-Sider Lanyard',
    image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/8b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-sperry.jpg',
    price: '$250.00',
    rating: 3
  }
]

const featuredDesigns = [
  {
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    dateDay: '22',
    dateMonth: 'Aug',
    title: 'Get 20% OFF on Nike Air Uomo',
    desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut l',
    link: '/blog/1'
  },
  {
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    dateDay: '10',
    dateMonth: 'Jul',
    title: 'Best Nike Sports Shoe Ever!',
    desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut l',
    link: '/blog/2'
  },
  {
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    dateDay: '11',
    dateMonth: 'May',
    title: 'Top 20 Runing Shoes for Men',
    desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut l',
    link: '/blog/3'
  }
]

const bestSeller = {
  name: 'Nike Metcon 2',
  image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/2b0b2e2c-2e7e-4e2e-8e2e-2e7e2e7e2e7e/nike-air-zoom-pegasus-33.jpg',
  rating: 5,
  desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  colors: ['#bdbba7', '#c2b8a3', '#b6b6c7', '#aeb8c6'],
  link: '/productPage/1'
}

const readmoreArticles = [
  {
    id: 1,
    title: 'Custom Shoes: Company Swag That Gets People Talking',
    excerpt: 'When it comes to company swag, businesses are always on the lookout for something unique, memorable, and practical. Custom shoes have emerged as a stan...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  },
  {
    id: 2,
    title: 'Best Company Branded Shoes in 2025',
    excerpt: 'As we step into 2025, branded shoes continue to dominate the market with their innovation, style, and functionality. The footwear industry has expanded its offerings, introducing products that cate...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  },
  {
    id: 3,
    title: 'How Custom Shoes Can Reflect Company Values',
    excerpt: 'We\'re proud to announce a bold direction in footwear that goes beyond simple style. When it comes to expressing who we are, custom shoes speak volumes. They help us show the world the things our co...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  },
  {
    id: 4,
    title: 'The Rise of Sustainable Custom Shoes in 2025',
    excerpt: 'Explore how eco-friendly materials and sustainable manufacturing are shaping the custom shoe industry. Highlight companies leading the charge and how businesses can align their brand with sustainability trends...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  },
  {
    id: 5,
    title: 'Top 10 Companies Revolutionizing Custom Footwear Design',
    excerpt: 'Showcase innovative companies using AI, 3D printing, or unique design techniques to create custom shoes. Include visuals of standout designs and interviews or quotes from industry leaders...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  },
  {
    id: 6,
    title: 'How to Build Brand Loyalty with Custom Shoe Campaigns',
    excerpt: 'Discuss strategies for companies to use custom shoes as a marketing tool to boost customer engagement and loyalty. Include case studies or examples of successful campaigns...',
    image: 'https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=363&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  }
]
</script>

<style scoped>
  /* Global Styles */
  .home-wrapper {
    background-color: #f8f9fa;
  }

  /* Hero Section Styles */
  .hero-section {
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDqac8qPp6UPCFaPYroGCkAmNeJfp6sAcAzg&s');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    color: #fff;
    padding: 150px 0;
    position: relative;
    overflow: hidden;
  }

  .hero-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, rgba(52, 152, 219, 0.1), rgba(0, 188, 212, 0.1));
    z-index: 1;
  }

  .hero-section .container {
    position: relative;
    z-index: 2;
  }

  .text-sneaker-orange {
    color: #00bcd4;
    font-weight: bold;
  }

  .text-sneaker-star {
    color: #ffd700;
  }

  .btn-sneaker {
    background: #00bcd4;
    color: #fff;
    border: none;
    border-radius: 8px;
    padding: 12px 30px;
    font-weight: 600;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
  }

  .btn-sneaker:hover {
    background: #008ba3;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
  }

  /* Best Seller Section */
  .best-seller-highlight-section {
    background: #f5f8fa;
    padding: 60px 0 40px 0;
  }
  .best-seller-img {
    max-width: 420px;
    width: 100%;
    filter: drop-shadow(0 10px 20px rgba(0,0,0,0.15));
  }
  .best-seller-title {
    font-size: 2.3rem;
    font-weight: 700;
    color: #222;
    margin-bottom: 10px;
    letter-spacing: 0;
  }
  .best-seller-rating i {
    font-size: 1.2rem;
    margin-right: 2px;
  }
  .best-seller-desc {
    color: #888;
    font-size: 1.08rem;
    margin-bottom: 18px;
    margin-top: 8px;
    max-width: 500px;
  }
  .best-seller-colors {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
  }
  .color-dot {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    border: 2px solid #e0e0e0;
    display: inline-block;
    cursor: pointer;
    transition: border 0.2s;
  }
  .color-dot:hover {
    border: 2px solid #3ec6a7;
  }
  .btn-best-seller-buy {
    background: #3ec6a7;
    color: #fff !important;
    border: none;
    border-radius: 4px;
    padding: 10px 38px;
    font-weight: 700;
    font-size: 1.1rem;
    letter-spacing: 0.5px;
    box-shadow: 0 4px 16px rgba(62,198,167,0.08);
    transition: background 0.2s, transform 0.2s;
    outline: none;
    display: inline-block;
  }
  .btn-best-seller-buy:hover {
    background: #249e7a;
    color: #fff;
    transform: translateY(-2px) scale(1.04);
    box-shadow: 0 8px 24px rgba(62,198,167,0.15);
    text-decoration: none;
  }

  /* CTA Section */
  .cta-section {
    background: #00bcd4;
    color: #fff;
    padding: 80px 0;
  }

  /* Testimonials */
  .testimonial-box {
    background: #fff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
  }

  .testimonial-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  }

  /* Readmore Cards */
  .readmore-card {
    background: #fff;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
  }

  .readmore-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
  }

  .readmore-card img {
    border-radius: 8px;
    transition: transform 0.3s ease;
  }

  .readmore-card:hover img {
    transform: scale(1.03);
  }

  /* New Arrivals Section Styles */
  .new-arrivals-section {
    background: #f5f8fa;
    min-height: 500px;
    position: relative;
    padding: 60px 0;
  }
  .text-new-arrivals {
    color: #3ec6a7;
    font-size: 3rem;
    font-weight: bold;
  }
  .btn-view-collection {
    color: #3ec6a7;
    background: none;
    border: none;
    font-size: 1.1rem;
    transition: color 0.2s;
  }
  .btn-view-collection:hover {
    color: #249e7a;
    text-decoration: underline;
  }

  .btn-view-purchase {
    background: linear-gradient(90deg, #3ec6a7 0%, #00bcd4 100%);
    color: #fff !important;
    border: none;
    border-radius: 8px;
    padding: 12px 36px;
    font-weight: 700;
    font-size: 1.1rem;
    letter-spacing: 0.5px;
    box-shadow: 0 4px 16px rgba(62,198,167,0.08);
    transition: background 0.2s, transform 0.2s;
    outline: none;
  }
  .btn-view-purchase:hover {
    background: linear-gradient(90deg, #249e7a 0%, #0097a7 100%);
    color: #fff;
    transform: translateY(-2px) scale(1.04);
    box-shadow: 0 8px 24px rgba(62,198,167,0.15);
    text-decoration: none;
  }

  .hero-shoe-img {
    max-width: 420px;
    width: 100%;
    filter: drop-shadow(0 10px 20px rgba(0,0,0,0.15));
  }
  .hero-arrow {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 50%;
    width: 38px;
    height: 38px;
    display: flex;
    justify-content: center;
    font-size: 1.3rem;
    color: #3ec6a7;
    cursor: pointer;
    transition: background 0.2s;
    z-index: 2;
  }
  .hero-arrow-left {
    left: -60px;
  }
  .hero-arrow-right {
    right: -60px;
  }
  .hero-arrow:hover {
    background: #e0f7f4;
  }

  /* Collection Section Styles */
  .collection-section {
    background: #fff;
    padding: 60px 0 40px 0;
  }
  .collection-title {
    font-size: 2.2rem;
    font-weight: 500;
    color: #222;
    margin-bottom: 10px;
  }
  .collection-desc {
    color: #888;
    font-size: 1.1rem;
    margin-bottom: 40px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
  }
  .product-card-collection {
    background: none;
    border: none;
    box-shadow: none;
    padding: 0;
    position: relative;
    transition: box-shadow 0.2s;
  }
  .product-img-wrap {
    position: relative;
    overflow: hidden;
    background: #f8f8f8;
    border-radius: 4px;
  }
  .product-img-wrap img {
    width: 100%;
    display: block;
    transition: transform 0.3s;
  }
  .product-card-collection:hover img {
    transform: scale(1.04);
  }
  .product-overlay {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(40,40,40,0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 16px;
    z-index: 2;
  }
  .overlay-btn {
    background: #fff;
    border: none;
    border-radius: 4px;
    width: 38px;
    height: 38px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    color: #222;
    margin: 0 2px;
    transition: background 0.2s;
  }
  .overlay-btn:hover {
    background: #e0e0e0;
  }
  .product-info {
    text-align: center;
    padding: 10px 0 0 0;
  }
  .product-info .product-name {
    font-size: 1.08rem;
    font-weight: 600;
    color: #222;
    margin-bottom: 4px;
    line-height: 1.3;
    min-height: 38px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .product-info .product-price {
    color: #3ec6a7;
    font-size: 1.08rem;
    font-weight: 500;
    margin-bottom: 4px;
  }
  .product-info .product-rating {
    margin-top: 2px;
    margin-bottom: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 2px;
  }
  .product-info .product-rating i {
    font-size: 1rem;
    margin: 0 1px;
  }
  .btn-outline-collection {
    border: 1.5px solid #3ec6a7;
    color: #222;
    background: #fff;
    border-radius: 4px;
    padding: 8px 32px;
    font-weight: 600;
    transition: all 0.2s;
  }
  .btn-outline-collection:hover {
    background: #3ec6a7;
    color: #fff;
  }

  .btn-view-collection .ms-2 {
    transition: transform 0.2s;
  }
  .btn-view-collection:hover .ms-2 {
    transform: translateX(4px);
  }

  .btn-view-purchase .ms-2 {
    transition: transform 0.2s;
  }
  .btn-view-purchase:hover .ms-2 {
    transform: translateX(4px);
  }

  /* Featured Designs Section Styles */
  .featured-designs-section {
    background: #fff;
    padding: 60px 0 40px 0;
  }
  .design-card-custom {
    background: none;
    border: none;
    box-shadow: none;
    padding: 0;
    text-align: left;
  }
  .design-img-wrap {
    position: relative;
    border-radius: 8px;
    overflow: hidden;
  }
  .design-img-wrap img {
    width: 100%;
    border-radius: 8px;
    display: block;
  }
  .design-date-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    background: #3ec6a7;
    color: #fff;
    border-radius: 6px;
    padding: 4px 10px 2px 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    font-size: 0.95rem;
    font-weight: 600;
    min-width: 38px;
    box-shadow: 0 2px 8px rgba(62,198,167,0.08);
  }
  .date-day {
    font-size: 1.1rem;
    font-weight: 700;
    line-height: 1;
  }
  .date-month {
    font-size: 0.85rem;
    font-weight: 400;
    line-height: 1;
    margin-top: 1px;
    letter-spacing: 0.5px;
  }
  .design-title {
    font-size: 1.13rem;
    font-weight: 700;
    color: #222;
    margin: 16px 0 6px 0;
    line-height: 1.3;
  }
  .design-desc {
    color: #888;
    font-size: 1rem;
    margin-bottom: 6px;
    min-height: 38px;
  }
  .design-readmore {
    color: #3ec6a7;
    font-size: 1rem;
    font-weight: 500;
    text-decoration: none;
    transition: color 0.2s;
  }
  .design-readmore:hover {
    color: #249e7a;
    text-decoration: underline;
  }

  /* Responsive Styles */
  @media (max-width: 768px) {
    .hero-section {
      padding: 80px 0;
    }

    .new-arrivals-section .row {
      flex-direction: column-reverse;
    }
    .hero-shoe-img {
      max-width: 80vw;
      margin-bottom: 30px;
    }

    .best-seller-title {
      font-size: 1.5rem;
    }
    .best-seller-img {
      max-width: 90vw;
      margin-bottom: 30px;
    }
  }
</style>