<template>
  <Navbar />

  <div class="container mt-4">
    <router-view />
  </div>
  <Footer/>
</template>

<script setup>
import Navbar from './components/layout/Navbar.vue'
import Footer from './components/layout/Footer.vue'
</script>