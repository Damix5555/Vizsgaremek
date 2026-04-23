import { createRouter, createWebHistory } from 'vue-router';

import HomeView from '../views/HomeView.vue';
import ConfiguratorView from '../views/ConfiguratorView.vue';
import PrebuiltWatchesView from '../views/PrebuiltWatchesView.vue';
import CheckoutView from '../views/CheckoutView.vue';
import OrdersView from '../views/OrdersView.vue';
import LoginView from '../views/LoginView.vue';
import RegisterView from '../views/RegisterView.vue';
import MyConfigurationsView from '../views/MyConfigurationsView.vue';

import AdminDashboardView from '../views/AdminDashboardView.vue';
import AdminProductsView from '../views/AdminProductsView.vue';
import AdminPrebuiltWatchesView from '../views/AdminPrebuiltWatchesView.vue';
import AdminAuditLogsView from '../views/AdminAuditLogsView.vue';
import AdminOrdersView from '../views/AdminOrdersView.vue';

import NotFoundView from '../views/NotFoundView.vue';
import { useUserStore } from '../stores/user';

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView,
    meta: { guestOnly: true },
  },
  {
    path: '/register',
    name: 'register',
    component: RegisterView,
    meta: { guestOnly: true },
  },
  {
    path: '/configurator',
    name: 'configurator',
    component: ConfiguratorView,
    meta: { requiresAuth: true },
  },
  {
    path: '/prebuilt-watches',
    name: 'prebuilt-watches',
    component: PrebuiltWatchesView,
  },
  {
    path: '/checkout',
    name: 'checkout',
    component: CheckoutView,
    meta: { requiresAuth: true },
  },
  {
    path: '/orders',
    name: 'orders',
    component: OrdersView,
    meta: { requiresAuth: true },
  },
  {
    path: '/my-configurations',
    name: 'my-configurations',
    component: MyConfigurationsView,
    meta: { requiresAuth: true },
  },
  {
    path: '/admin',
    name: 'admin-dashboard',
    component: AdminDashboardView,
    meta: { requiresAuth: true, requiresAdmin: true },
  },
  {
    path: '/admin/products',
    name: 'admin-products',
    component: AdminProductsView,
    meta: { requiresAuth: true, requiresAdmin: true },
  },
  {
    path: '/admin/prebuilt-watches',
    name: 'admin-prebuilt-watches',
    component: AdminPrebuiltWatchesView,
    meta: { requiresAuth: true, requiresAdmin: true },
  },
  {
    path: '/admin/audit-logs',
    name: 'admin-audit-logs',
    component: AdminAuditLogsView,
    meta: { requiresAuth: true, requiresAdmin: true },
  },
  {
    path: '/admin/orders',
    name: 'admin-orders',
    component: AdminOrdersView,
    meta: { requiresAuth: true, requiresAdmin: true },
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: NotFoundView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach(async (to, from, next) => {
  const userStore = useUserStore();

  if (!userStore.initialized) {
    await userStore.initUser();
  }

  if (to.meta.requiresAuth && !userStore.isAuthenticated) {
    return next('/login');
  }

  if (to.meta.guestOnly && userStore.isAuthenticated) {
    return next('/');
  }

  if (to.meta.requiresAdmin && !userStore.isAdmin) {
    return next('/');
  }

  next();
});

export default router;