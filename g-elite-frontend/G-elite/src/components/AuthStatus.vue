<template>
  <div class="auth-box">
    <template v-if="userStore.isAuthenticated">
      <span>
        Bejelentkezve:
        <strong>{{ userStore.user?.username }}</strong>
        ({{ userStore.user?.role }})
      </span>
      <button @click="handleLogout">Kilépés</button>
    </template>

    <template v-else>
      <RouterLink to="/login">Bejelentkezés</RouterLink>
      <RouterLink to="/register">Regisztráció</RouterLink>
    </template>
  </div>
</template>

<script setup>
import { RouterLink, useRouter } from 'vue-router';
import { useUserStore } from '../stores/user';

const userStore = useUserStore();
const router = useRouter();

const handleLogout = async () => {
  await userStore.logoutUser();
  router.push('/login');
};
</script>

