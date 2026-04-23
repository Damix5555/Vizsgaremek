<template>
  <footer class="bg-dark text-light border-top border-secondary-subtle">
    <div class="container py-4">
      <div class="row align-items-center text-center text-md-start gy-4">
        <div class="col-12 col-md-4">
          <p class="mb-0 text-light-emphasis">
            © 2026 G-Elite. Minden jog fenntartva.
          </p>
        </div>

        <div class="col-12 col-md-4 text-center">
          <img
            src="../assets/logo.svg"
            alt="G-Elite footer logo"
            class="footer-logo"
          />
        </div>

        <div class="col-12 col-md-4">
          <div class="d-flex flex-wrap justify-content-center justify-content-md-end gap-3">
            <router-link to="/" class="footer-link">Főoldal</router-link>
            <router-link to="/prebuilt-watches" class="footer-link">Kész órák</router-link>
            <router-link to="/configurator" class="footer-link">Konfigurátor</router-link>
            <router-link to="/login" class="footer-link">Bejelentkezés</router-link>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { RouterLink } from 'vue-router';
</script>

<style scoped>
.footer-logo {
  height: 42px;
  width: auto;
  display: inline-block;
}

.footer-link {
  color: rgba(255, 255, 255, 0.85);
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-link:hover {
  color: white;
}
</style>