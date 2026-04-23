<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <h1 class="mb-1">Admin felület</h1>
        <p class="text-muted mb-0">
          Itt érhetők el az adminisztrációs funkciók.
        </p>
      </div>

      <div class="col-12 col-md-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body d-flex flex-column">
            <h2 class="h4 mb-3">Termékkezelés</h2>
            <p class="text-muted mb-4">
              Alkatrészek létrehozása, módosítása és törlése.
            </p>

            <div class="mt-auto d-grid">
              <router-link to="/admin/products" class="btn btn-primary">
                Megnyitás
              </router-link>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body d-flex flex-column">
            <h2 class="h4 mb-3">Kész órák kezelése</h2>
            <p class="text-muted mb-4">
              Előre összeállított órák adminisztrációja.
            </p>

            <div class="mt-auto d-grid">
              <router-link to="/admin/prebuilt-watches" class="btn btn-primary">
                Megnyitás
              </router-link>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body d-flex flex-column">
            <h2 class="h4 mb-3">Rendelések</h2>
            <p class="text-muted mb-4">
              Összes rendelés kezelése és státuszfrissítés.
            </p>

            <div class="mt-auto d-grid">
              <router-link to="/admin/orders" class="btn btn-primary">
                Megnyitás
              </router-link>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body d-flex flex-column">
            <h2 class="h4 mb-3">Audit log</h2>
            <p class="text-muted mb-4">
              Műveleti napló és módosítások követése.
            </p>

            <div class="mt-auto d-grid">
              <router-link to="/admin/audit-logs" class="btn btn-primary">
                Megnyitás
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from 'vue-router';
</script>