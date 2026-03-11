import { createRouter, createWebHistory } from 'vue-router'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap'
import HomeView from '../views/HomeView.vue'
import ShopView from '../views/ShopView.vue'
import ConfiguratorView from '../views/ConfiguratorView.vue'
import CartView from '../views/CartView.vue'
import WatchDetailsView from '../views/WatchDetailsView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/shop',
    name: 'shop',
    component: ShopView
  },
  {
    path: '/configurator',
    name: 'configurator',
    component: ConfiguratorView
  },
  {
    path: '/watch/:id',
    name: 'watchDetails',
    component: WatchDetailsView
  },
  {
    path: '/cart',
    name: 'cart',
    component: CartView
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router