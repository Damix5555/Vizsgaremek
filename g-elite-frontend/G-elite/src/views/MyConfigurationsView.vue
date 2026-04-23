<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <h1 class="mb-1">Saját konfigurációim</h1>
        <p class="text-muted mb-0">
          Itt láthatod az elmentett órakonfigurációidat, és újra kosárba teheted őket.
        </p>
      </div>

      <div class="col-12">
        <div v-if="loading" class="alert alert-info mb-0" role="alert">
          Betöltés...
        </div>

        <div v-if="error" class="alert alert-danger mb-0" role="alert">
          {{ error }}
        </div>

        <div v-if="message" class="alert alert-success mb-0" role="alert">
          {{ message }}
        </div>
      </div>

      <div v-if="!loading && configurations.length === 0" class="col-12">
        <div class="alert alert-secondary mb-0" role="alert">
          Még nincs mentett konfigurációd.
        </div>
      </div>

      <div
        v-for="config in configurations"
        :key="config.id"
        class="col-12 col-lg-6"
      >
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body d-flex flex-column">
            <div class="mb-3">
              <h2 class="h4 mb-2">{{ config.name }}</h2>
              <p class="mb-0">
                <strong>Ár:</strong> {{ config.total_price }} Ft
              </p>
            </div>

            <div v-if="config.parts?.length" class="mb-4">
              <h3 class="h5 mb-3">Alkatrészek</h3>

              <div class="list-group">
                <div
                  v-for="part in config.parts"
                  :key="part.id"
                  class="list-group-item"
                >
                  <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <span>{{ part.product?.name || 'Ismeretlen alkatrész' }}</span>
                    <span class="badge text-bg-secondary">
                      {{ part.product?.type || 'nincs típus' }}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div v-else class="alert alert-light border mb-4">
              Ehhez a konfigurációhoz nem tartozik megjeleníthető alkatrész.
            </div>

            <div class="mt-auto d-grid">
              <button class="btn btn-primary" @click="addToCart(config)">
                Kosárba
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { getMyConfigurations } from '../services/configurationService';
import { useCartStore } from '../stores/cart';

const configurations = ref([]);
const loading = ref(false);
const error = ref('');
const message = ref('');
const cart = useCartStore();

const loadConfigurations = async () => {
  loading.value = true;
  error.value = '';
  message.value = '';

  try {
    const response = await getMyConfigurations();
    configurations.value = response.data;
  } catch (err) {
    error.value =
      err.response?.data?.message || 'Nem sikerült betölteni a konfigurációkat.';
  } finally {
    loading.value = false;
  }
};

const addToCart = (configuration) => {
  cart.addConfiguration(configuration);
  message.value = 'A konfiguráció a kosárba került.';
};

onMounted(loadConfigurations);
</script>