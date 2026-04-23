<template>
  <div class="app-shell">
    <NavBar />
    <main class="app-main">
      <router-view />
    </main>
    <AppFooter />
  </div>
</template>

<script setup>
import NavBar from './components/NavBar.vue';
import AppFooter from './components/AppFooter.vue';
</script>