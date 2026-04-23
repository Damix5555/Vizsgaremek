<template>
  <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #0b132b">
    <div class="container-fluid">
      <router-link to="/" class="navbar-brand">
        <img :src="logo" alt="G-Elite logo" style="height: 50px" />
      </router-link>

      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        aria-label="Toggle navigation"
        @click="mobileOpen = !mobileOpen"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto gap-3">
          <li class="nav-item">
            <router-link to="/" class="nav-link">Főoldal</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/prebuilt-watches" class="nav-link">Kész órák</router-link>
          </li>
          <li v-if="isAuthenticated" class="nav-item">
            <router-link to="/configurator" class="nav-link">Konfigurátor</router-link>
          </li>
          <li v-if="isAuthenticated" class="nav-item">
            <router-link to="/checkout" class="nav-link">Kosár / Rendelés</router-link>
          </li>
          <li v-if="isAuthenticated" class="nav-item">
            <router-link to="/orders" class="nav-link">Rendeléseim</router-link>
          </li>
          <li v-if="isAuthenticated" class="nav-item">
            <router-link to="/my-configurations" class="nav-link">Konfigurációim</router-link>
          </li>
          <li v-if="isAdmin" class="nav-item">
            <router-link to="/admin" class="nav-link">Admin</router-link>
          </li>
        </ul>

        <div class="ms-auto d-flex gap-2 align-items-center">
          <template v-if="!isAuthenticated">
            <router-link to="/login" class="btn btn-outline-primary">Bejelentkezés</router-link>
            <router-link to="/register" class="btn btn-primary">Regisztráció</router-link>
          </template>

          <template v-else>
            <span class="text-light">{{ user?.username }} ({{ user?.role }})</span>
            <button @click="logout" class="btn btn-danger btn-sm">Kilépés</button>
          </template>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { computed, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '../stores/user';
import logo from '../assets/logo.svg';

const router = useRouter();
const userStore = useUserStore();

const mobileOpen = ref(false);

const user = computed(() => userStore.user);
const isAuthenticated = computed(() => userStore.isAuthenticated);
const isAdmin = computed(() => userStore.user?.role === 'admin');

const closeMobile = () => {
  mobileOpen.value = false;
};

const logout = async () => {
  await userStore.logoutUser();
  closeMobile();
  router.push('/login');
};
</script>

