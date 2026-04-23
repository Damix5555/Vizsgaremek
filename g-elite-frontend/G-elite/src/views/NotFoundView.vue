<template>
  <section class="card">
    <div class="text-center py-5">
      <h1 class="page-title display-1">404</h1>
      <h2 class="section-title">Az oldal nem található</h2>
      <p>A keresett oldal nem létezik, vagy másik útvonalra került.</p>

      <div class="d-flex gap-2 justify-content-center flex-wrap mt-4">
        <router-link to="/" class="btn btn-primary">Vissza a főoldalra</router-link>
        <router-link to="/prebuilt-watches" class="btn btn-outline-primary">Kész órák</router-link>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from 'vue-router';
</script>

