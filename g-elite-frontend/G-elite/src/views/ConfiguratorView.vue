<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
          <div>
            <h1 class="mb-1">Órakonfigurátor</h1>
            <p class="text-muted mb-0">
              Válaszd ki az órád alkatrészeit, és mentsd el a saját konfigurációdat.
            </p>
          </div>
        </div>
      </div>

      <div class="col-12">
        <div v-if="loading" class="alert alert-info mb-0" role="alert">
          Betöltés...
        </div>

        <div v-if="error" class="alert alert-danger mb-0" role="alert">
          {{ error }}
        </div>

        <div v-if="successMessage" class="alert alert-success mb-0" role="alert">
          {{ successMessage }}
        </div>
      </div>

      <!-- Összegző kártya -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-3">Összegzés</h2>

            <div class="row g-3">
              <div class="col-12 col-md-6 col-lg-3">
                <div class="p-3 bg-light rounded h-100">
                  <strong>Kiválasztott tok</strong>
                  <div class="text-muted mt-1">{{ configurator.selectedCase?.name || '-' }}</div>
                </div>
              </div>

              <div class="col-12 col-md-6 col-lg-3">
                <div class="p-3 bg-light rounded h-100">
                  <strong>Kiválasztott szíj</strong>
                  <div class="text-muted mt-1">{{ configurator.selectedStrap?.name || '-' }}</div>
                </div>
              </div>

              <div class="col-12 col-md-6 col-lg-3">
                <div class="p-3 bg-light rounded h-100">
                  <strong>Kiválasztott számlap</strong>
                  <div class="text-muted mt-1">{{ configurator.selectedDial?.name || '-' }}</div>
                </div>
              </div>

              <div class="col-12 col-md-6 col-lg-3">
                <div class="p-3 bg-light rounded h-100">
                  <strong>Kiválasztott mutató</strong>
                  <div class="text-muted mt-1">{{ configurator.selectedHands?.name || '-' }}</div>
                </div>
              </div>
            </div>

            <div class="mt-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
              <div class="fs-4 fw-bold">
                Összár: {{ configurator.totalPrice.toFixed(2) }} USD
              </div>

              <div class="d-flex flex-wrap gap-2">
                <button
                  class="btn btn-primary"
                  @click="saveConfiguration"
                  :disabled="!configurator.isComplete || saving"
                >
                  {{ saving ? 'Mentés...' : 'Konfiguráció mentése' }}
                </button>

                <button
                  class="btn btn-outline-secondary"
                  @click="configurator.clearConfiguration()"
                  :disabled="saving"
                >
                  Kiválasztás törlése
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Tokok -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-3">Tokok</h2>

            <div v-if="cases.length === 0" class="alert alert-secondary mb-0">
              Nincs elérhető tok.
            </div>

            <div v-else class="row g-4">
              <div
                v-for="item in cases"
                :key="item.id"
                class="col-12 col-sm-6 col-lg-4 col-xl-3"
              >
                <ProductCard
                  :product="item"
                  @select="configurator.setPart('case', $event)"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Szíjak -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-3">Szíjak</h2>

            <div v-if="straps.length === 0" class="alert alert-secondary mb-0">
              Nincs elérhető szíj.
            </div>

            <div v-else class="row g-4">
              <div
                v-for="item in straps"
                :key="item.id"
                class="col-12 col-sm-6 col-lg-4 col-xl-3"
              >
                <ProductCard
                  :product="item"
                  @select="configurator.setPart('strap', $event)"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Számlapok -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-3">Számlapok</h2>

            <div v-if="dials.length === 0" class="alert alert-secondary mb-0">
              Nincs elérhető számlap.
            </div>

            <div v-else class="row g-4">
              <div
                v-for="item in dials"
                :key="item.id"
                class="col-12 col-sm-6 col-lg-4 col-xl-3"
              >
                <ProductCard
                  :product="item"
                  @select="configurator.setPart('dial', $event)"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Mutatók -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-3">Mutatók</h2>

            <div v-if="hands.length === 0" class="alert alert-secondary mb-0">
              Nincs elérhető mutató.
            </div>

            <div v-else class="row g-4">
              <div
                v-for="item in hands"
                :key="item.id"
                class="col-12 col-sm-6 col-lg-4 col-xl-3"
              >
                <ProductCard
                  :product="item"
                  @select="configurator.setPart('hands', $event)"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import ProductCard from '../components/ProductCard.vue';
import { getProductsByType } from '../services/productService';
import { createConfiguration } from '../services/configurationService';
import { useConfiguratorStore } from '../stores/configurator';
import { useCartStore } from '../stores/cart';

const configurator = useConfiguratorStore();
const cart = useCartStore();

const cases = ref([]);
const straps = ref([]);
const dials = ref([]);
const hands = ref([]);
const loading = ref(false);
const saving = ref(false);
const error = ref('');
const successMessage = ref('');

const loadProducts = async () => {
  loading.value = true;
  error.value = '';
  successMessage.value = '';

  try {
    const [caseRes, strapRes, dialRes, handsRes] = await Promise.all([
      getProductsByType('case'),
      getProductsByType('strap'),
      getProductsByType('dial'),
      getProductsByType('hands'),
    ]);

    cases.value = caseRes.data;
    straps.value = strapRes.data;
    dials.value = dialRes.data;
    hands.value = handsRes.data;
  } catch {
    error.value = 'Nem sikerült betölteni az alkatrészeket.';
  } finally {
    loading.value = false;
  }
};

const saveConfiguration = async () => {
  saving.value = true;
  error.value = '';
  successMessage.value = '';

  try {
    const payload = {
      name: 'Frontendből mentett konfiguráció',
      parts: configurator.selectedPartsIds,
    };

    const response = await createConfiguration(payload);
    configurator.setSavedConfiguration(response.data.configuration);
    cart.addConfiguration(response.data.configuration);
    successMessage.value = 'A konfiguráció elmentve és a kosárba került.';
  } catch (err) {
    if (err.response?.data?.errors) {
      error.value = Object.values(err.response.data.errors).flat().join(' ');
    } else if (err.response?.data?.message) {
      error.value = err.response.data.message;
    } else {
      error.value = 'Nem sikerült elmenteni a konfigurációt.';
    }
  } finally {
    saving.value = false;
  }
};

onMounted(loadProducts);
</script>