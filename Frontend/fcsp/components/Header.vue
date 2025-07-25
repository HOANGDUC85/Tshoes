<!-- Header Component - Flexbox Optimized Sneaker Theme -->
<template>
  <header class="sneaker-header" :class="{ 'scrolled': isScrolled }">
    <div class="header-container">
      <!-- Logo Section -->
      <router-link to="/homePage" class="logo-wrapper">
        <img 
          src="https://th.bing.com/th/id/OIP.EL5hPJ7k0B7W_D7EbZoexgHaEd?w=338&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7" 
          alt="Sneaker Logo" 
          class="logo-img" 
          @mouseover="animateLogo"
          @mouseleave="resetLogo" 
        />
        <span class="brand-text">WPY</span>
      </router-link>

      <!-- Navigation -->
      <nav class="navbar-nav" :class="{ 'nav-open': isNavOpen }">
        <template v-for="item in navItems" :key="item.path || item.label">
          <router-link 
            v-if="item.path && item.path !== '/customPage'" 
            :to="item.path" 
            class="nav-link"
            :class="{ active: isActiveRoute(item.path) }"
            @click="toggleNav"
          >
            <a-icon :type="item.icon" /> {{ item.label }}
          </router-link>
          
          <div v-else-if="item.path === '/customPage'" class="custom-dropdown">
            <div class="nav-link" style="cursor: pointer;">
              <a-icon :type="item.icon" /> {{ item.label }}
              <DownOutlined style="margin-left: 5px; font-size: 12px;" />
            </div>
            <div class="dropdown-content">
              <router-link to="/customPage" class="dropdown-item" @click="toggleNav">
                <ShoppingOutlined style="margin-right: 8px;" /> Customize Product
              </router-link>
              <router-link to="/mycustomPage" class="dropdown-item" @click="toggleNav">
                <UserOutlined style="margin-right: 8px;" /> My Customize
              </router-link>
            </div>
          </div>

          <div v-else-if="item.subItems" class="custom-dropdown">
            <div class="nav-link" style="cursor: pointer;">
              <a-icon :type="item.icon" /> {{ item.label }}
              <DownOutlined style="margin-left: 5px; font-size: 12px;" />
            </div>
            <div class="dropdown-content">
              <router-link 
                v-for="subItem in item.subItems" 
                :key="subItem.path"
                :to="subItem.path" 
                class="dropdown-item" 
                @click="toggleNav"
              >
                <a-icon :type="subItem.icon" style="margin-right: 8px;" /> {{ subItem.label }}
              </router-link>
            </div>
          </div>
        </template>
      </nav>
      <!-- <span class="balance-display">{{ formatCurrency(userBalance) }}</span> -->
      <!-- User Actions -->
      <div class="user-actions">
        <!-- Cart Button -->
        <router-link to="/shoppingCartPage" class="sneaker-btn-icon cart-btn">
          <ShoppingCartOutlined />
          <span class="sneaker-badge">{{ cartCount }}</span>
          
        </router-link>

        <!-- Wallet Section -->
        <section v-if="isAuthenticated" class="custom-dropdown wallet-dropdown">
           <div class="nav-link" style="cursor: pointer;">
             <i class="bi bi-wallet2"></i> <!-- Wallet icon -->
           </div>
           <div class="dropdown-content">
              <div class="dropdown-item balance-display" style="font-weight: bold;">
                 Balance: {{ formatCurrency(userBalance) }}
              </div>
              <hr class="dropdown-divider">
              <router-link class="dropdown-item" to="/depositPage"> <!-- Placeholder link -->
                 <i class="bi bi-cash"></i> Deposit
              </router-link>
              <router-link class="dropdown-item" to="/withdrawPage"> <!-- Placeholder link -->
                 <i class="bi bi-credit-card"></i> Withdraw
              </router-link>
           </div>
        </section>

        <!-- User Section -->
        <section v-if="isAuthenticated">
          <div class="user-dropdown">
            <div class="nav-link" style="cursor: pointer;">
              <i class="bi bi-person-circle me-1"></i> {{ userName }}
            </div>
            <ul class="dropdown-content" aria-labelledby="userDropdown">
              <li>
                <router-link class="dropdown-item" to="/profilePage">
                  <i class="bi bi-person me-2"></i> Profile
                </router-link>
              </li>
              <li>
                <router-link class="dropdown-item" to="/shippingPage">
                  <i class="bi bi-truck me-2"></i> Shipping
                </router-link>
              </li>
              <li>
                <router-link class="dropdown-item" to="/historyshoppingPage">
                  <i class="bi bi-clock-history me-2"></i> Order History
                </router-link>
              </li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <a class="dropdown-item text-danger" href="#" @click.prevent="logout">
                  <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
              </li>
            </ul>
          </div>
        </section>
        
        <!-- Login Link (Non-Authenticated) -->
        <section v-else>
          <router-link to="/loginPage" class="login-btn">
            <UserOutlined /> Login
          </router-link>
        </section>
      </div>

      <!-- Mobile Toggle Button -->
      <button class="navbar-toggler" @click="toggleNav">
        <span class="toggler-icon"></span>
      </button>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed, watch, nextTick } from 'vue';
import { 
  ShoppingCartOutlined, 
  UserOutlined, 
  DownOutlined, 
  ProfileOutlined, 
  SettingOutlined, 
  LogoutOutlined, 
  HeartOutlined,
  BellOutlined,
  ShoppingOutlined,
  WalletOutlined,
  DollarCircleOutlined
} from '@ant-design/icons-vue';
import { useRouter, useRoute } from 'vue-router';
import { useCart } from '~/composables/useCart';
import { getUserBalance } from '@/server/user-service';
import { getBalance } from '@/server/balance-service';

const router = useRouter();
const route = useRoute();
const { cartCount } = useCart();
const isAuthenticated = ref(false);
const userName = ref('SneakerFan');
const isNavOpen = ref(false);
const isSearchOpen = ref(false);
const searchQuery = ref('');
const isDarkTheme = ref(true);
const isScrolled = ref(false);
const userBalance = ref(0);

const navItems = [
  { path: '/homePage', label: 'Home', icon: 'home' },
  { path: '/productPage', label: 'Products', icon: 'shop' },
  { path: '/customPage', label: 'Customize', icon: 'edit' },
  { 
    label: 'Pages', 
    icon: 'appstore',
    subItems: [
      { path: '/contactPage', label: 'Contact', icon: 'mail' },
      { path: '/aboutPage', label: 'About', icon: 'info-circle' },
      { path: '/blogPage', label: 'Blog', icon: 'info-circle' }
    ]
  }
];

// Helper function to format currency
const formatCurrency = (amount) => {
  if (amount === null || amount === undefined) return '0 đ';
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(amount);
};

// Function to fetch user balance
const fetchUserBalance = async () => {
  if (process.client && localStorage.getItem('userId')) {
    const userId = localStorage.getItem('userId');
    if (userId) {
      try {
        const balance = await getBalance(userId);
        console.log(balance);
        userBalance.value = balance.data.balance;
      } catch (error) {
        console.error('Failed to fetch user balance:', error);
        userBalance.value = 0; // Reset balance on error
      }
    }
  }
};

// Watch for authentication state changes and fetch balance
watch(() => {
  const usernameToken = localStorage.getItem('username');
  const userIdToken = localStorage.getItem('userId');
  isAuthenticated.value = !!usernameToken; // isAuthenticated depends on username token

  if (isAuthenticated.value) {
    userName.value = usernameToken || 'User';
    // Fetch balance when authenticated state becomes true
    fetchUserBalance();
  } else {
      // Reset balance when user logs out
      userBalance.value = 0;
      userName.value = 'SneakerFan'; // Reset username on logout
  }
}, { immediate: true });

// Handle scroll event
const handleScroll = () => {
  isScrolled.value = window.scrollY > 50;
};

const initDropdowns = async () => {
  if (process.client) {
    try {
      const bootstrap = await import('bootstrap/dist/js/bootstrap.bundle.min.js');
      const dropdownElements = document.querySelectorAll('.user-dropdown > .nav-link, .custom-dropdown > .nav-link'); // Select dropdown triggers

      dropdownElements.forEach(element => {
        // Check if a dropdown instance already exists to avoid re-initialization
        if (!bootstrap.Dropdown.getInstance(element)) {
           new bootstrap.Dropdown(element);
        }
      });
    } catch (error) {
      console.error('Error initializing dropdowns:', error); // Updated error message
    }
  }
};

onMounted(() => {
  window.addEventListener('scroll', handleScroll);
  nextTick(() => {
    initDropdowns();
  });
  // fetchUserBalance is already called by the immediate watcher on mount
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});

const toggleNav = () => {
  isNavOpen.value = !isNavOpen.value;
  if (isSearchOpen.value) isSearchOpen.value = false;
};

const toggleSearch = () => {
  isSearchOpen.value = !isSearchOpen.value;
  if (isSearchOpen.value) searchQuery.value = '';
};

const onSearch = (value) => {
  console.log('Searching for:', value);
  isSearchOpen.value = false;
};

const logout = () => {
  // Clear localStorage for the current tab
  if (typeof window !== 'undefined') {
    localStorage.removeItem('userToken');
    localStorage.removeItem('userEmail');
    localStorage.removeItem('role');
    localStorage.removeItem('userId');
    localStorage.removeItem('userName');
    localStorage.removeItem('userRole');
    localStorage.removeItem('username');
  }

  // Reset authentication state
  isAuthenticated.value = false;
  userName.value = '';
  userBalance.value = 0;

  // Redirect to home page
  router.push('/homePage');
};

const isActiveRoute = (path) => {
  // So sánh chính xác path hiện tại
  return route.path === path;
};
</script>

<style scoped>
.sneaker-header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  padding: 1rem 0;
  box-shadow: 0 4px 20px rgba(0, 123, 255, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  transition: all 0.3s ease;
}

.sneaker-header.scrolled {
  padding: 0.5rem 0;
  background: rgba(255, 255, 255, 0.9);
  box-shadow: 0 6px 25px rgba(0, 123, 255, 0.1);
}

.header-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.logo-wrapper {
  display: flex;
  align-items: center;
  text-decoration: none;
  transition: transform 0.3s ease;
}

.logo-img {
  width: 45px;
  height: 45px;
  transition: all 0.3s ease;
  margin-right: 12px;
  border-radius: 50%;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.brand-text {
  font-size: 1.8rem;
  font-weight: 700;
  color: #555555;
  letter-spacing: 1px;
  transition: all 0.3s ease;
}

.navbar-nav {
  display: flex;
  flex-direction: row;
  gap: 1.5rem;
  align-items: center;
}

.nav-link {
  display: flex;
  align-items: center;
  color: #555555;
  font-weight: 600;
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 10px;
  transition: all 0.3s ease;
  position: relative;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 2px;
  background: #555555;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.nav-link:hover::after {
  width: 80%;
}

/* Always show underline for active nav-link */
.nav-link.active::after {
  width: 80%;
}

.nav-link:hover {
  transform: none;
  box-shadow: none;
  background: none;
}

.user-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.sneaker-btn-icon {
  position: relative;
  background: linear-gradient(135deg, #555555, #444444);
  color: #fff;
  border-radius: 24px;
  padding: 0.5rem;
  transition: all 0.3s ease;
}

.sneaker-btn-icon:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 102, 102, 0.2);
  background: linear-gradient(135deg, #444444, #333333);
}

.sneaker-badge {
  position: absolute;
  top: -5px;
  right: -5px;
  background: #555555;
  color: #fff;
  border-radius: 50%;
  padding: 0.2rem 0.5rem;
  font-size: 0.75rem;
  box-shadow: 0 2px 8px rgba(102, 102, 102, 0.2);
}

/* Dropdown styling */
.dropdown,
.custom-dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-menu,
.dropdown-content {
  position: absolute;
  top: 100%;
  left: 0;
  display: none;
  background: rgba(255, 255, 255, 0.98);
  min-width: 180px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  z-index: 1;
  border-radius: 10px;
  padding: 8px 0;
  margin-top: 10px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

/* Add padding for dropdown to create safe spacing */
.dropdown-menu::before,
.dropdown-content::before {
  content: '';
  position: absolute;
  top: -10px;
  left: 0;
  width: 100%;
  height: 10px;
  background: transparent;
}

.dropdown-item {
  color: #555555;
  text-decoration: none;
  display: flex;
  align-items: center;
  padding: 10px 16px;
  transition: all 0.3s ease;
  font-weight: 500;
}

.dropdown-item:hover {
  background-color: rgba(85, 85, 85, 0.08);
  transform: translateX(3px);
}

.dropdown:hover .dropdown-menu,
.custom-dropdown:hover .dropdown-content {
  display: block;
  opacity: 1;
  visibility: visible;
}

/* Mobile styles */
@media (max-width: 991px) {
  .header-container {
    flex-direction: row;
    align-items: center;
  }

  .navbar-nav {
    display: none;
    flex-direction: column;
    width: 100%;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    padding: 1rem;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 24px;
  }

  .nav-open {
    display: flex;
  }

  .user-actions {
    gap: 0.75rem;
  }

  .dropdown-menu,
  .dropdown-content {
    position: static;
    display: none;
    box-shadow: none;
    margin-top: 0;
    padding-left: 1rem;
    opacity: 1;
    visibility: visible;
    transition: none;
  }
  
  .dropdown:hover .dropdown-menu,
  .custom-dropdown:hover .dropdown-content {
    display: block;
  }
}

.login-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  background: linear-gradient(135deg, #555555, #444444);
  color: white;
  border-radius: 24px;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(102, 102, 102, 0.2);
}

.login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 102, 102, 0.3);
  background: linear-gradient(135deg, #444444, #333333);
}

.login-btn:active {
  transform: translateY(0);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Add style for dropdown divider */
.dropdown-divider {
  margin: 8px 0;
  border-top: 1px solid rgba(85, 85, 85, 0.1);
}

/* Adjust style for user dropdown */
.user-dropdown {
  position: relative;
  display: inline-block;
}

.user-dropdown .nav-link {
  padding: 8px 16px;
  background: linear-gradient(135deg, #555555, #444444);
  color: white;
  border-radius: 24px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(102, 102, 102, 0.2);
}

/* Remove underline for user dropdown */
.user-dropdown .nav-link::after {
  display: none;
}

.user-dropdown .nav-link:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 102, 102, 0.3);
  background: linear-gradient(135deg, #444444, #333333);
}

.user-dropdown .dropdown-content {
  position: absolute;
  top: 100%;
  right: 0;
  display: none;
  background: rgba(255, 255, 255, 0.98);
  min-width: 180px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  z-index: 1;
  border-radius: 10px;
  padding: 8px 0;
  margin-top: 10px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

.user-dropdown .dropdown-content::before {
  content: '';
  position: absolute;
  top: -10px;
  left: 0;
  width: 100%;
  height: 10px;
  background: transparent;
}

.user-dropdown:hover .dropdown-content {
  display: block;
  opacity: 1;
  visibility: visible;
}

/* Adjust style for dropdown items */
.user-dropdown .dropdown-item {
  padding: 10px 16px;
  color: #555555;
  text-decoration: none;
  display: flex;
  align-items: center;
  transition: all 0.3s ease;
  font-weight: 500;
}

.user-dropdown .dropdown-item:hover {
  background-color: rgba(85, 85, 85, 0.08);
  transform: translateX(3px);
}

.user-dropdown .dropdown-item.text-danger {
  color: #ff4d4f;
}

.user-dropdown .dropdown-item.text-danger:hover {
  background-color: rgba(255, 77, 79, 0.08);
}

.balance-display {
  color: #555555;
  font-weight: 600;
  margin-left: 0.5rem;
  white-space: nowrap; /* Prevent wrapping */
}

/* Add styles for Wallet Dropdown */
.wallet-dropdown .nav-link {
  /* Style for the wallet icon button */
  display: flex;
  align-items: center;
  gap: 5px; /* Space between icon and text if text were present */
  padding: 0.5rem 1rem; /* Adjusted padding */
  background: linear-gradient(135deg, #555555, #444444); /* Match login/cart button gradient */
  color: white;
  border-radius: 24px; /* Rounded like other buttons */
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(102, 102, 102, 0.2); /* Match login/cart button shadow */
  min-width: auto; /* Allow button to size based on content */
}

.wallet-dropdown .nav-link:hover {
  transform: translateY(-2px); /* Hover effect */
  box-shadow: 0 4px 12px rgba(102, 102, 102, 0.3); /* Hover shadow */
  background: linear-gradient(135deg, #444444, #333333); /* Darker hover gradient */
}

.wallet-dropdown .nav-link i {
    font-size: 1.2rem; /* Adjust icon size */
    margin-right: 0; /* Remove margin as it's an icon-only button */
}

.wallet-dropdown .dropdown-content {
  /* Style for the dropdown menu */
  background: #ffffff; /* White background */
  border: 1px solid #e0e0e0;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  border-radius: 12px;
  padding: 8px 0; /* Adjusted padding */
  margin-top: 10px;
  min-width: 180px; /* Ensure a reasonable width */
}

.wallet-dropdown .dropdown-item {
  /* Style for individual items in the dropdown */
  padding: 10px 16px;
  color: #555555;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  font-weight: 500; /* Match user dropdown item font-weight */
}

.wallet-dropdown .dropdown-item:hover {
  background-color: rgba(85, 85, 85, 0.08); /* Light highlight on hover, match user dropdown */
  transform: translateX(3px); /* Slide effect on hover, match user dropdown */
}

.wallet-dropdown .dropdown-item i {
  margin-right: 10px; /* Space between icon and text */
  font-size: 1rem; /* Consistent icon size */
}

.wallet-dropdown .balance-display {
  /* Style specifically for the balance display item */
  font-weight: bold;
  color: #AAAAAA; /* Highlight color for balance */
  padding: 10px 16px;
  background-color: transparent !important;
  transform: none !important;
  cursor: default; /* Change cursor for non-interactive item */
}

/* Ensure dropdown divider has correct styling */
.wallet-dropdown .dropdown-divider {
    margin: 8px 0;
    border-top: 1px solid rgba(85, 85, 85, 0.1);
}
</style>