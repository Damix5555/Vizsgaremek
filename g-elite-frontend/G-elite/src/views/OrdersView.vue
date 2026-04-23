<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <h1 class="mb-1">Rendeléseim</h1>
        <p class="text-muted mb-0">
          Itt láthatod a leadott rendeléseidet és azok részleteit.
        </p>
      </div>

      <div class="col-12">
        <div v-if="loading" class="alert alert-info mb-0" role="alert">
          Betöltés...
        </div>

        <div v-if="error" class="alert alert-danger mb-0" role="alert">
          {{ error }}
        </div>
      </div>

      <div v-if="!loading && !error && orders.length === 0" class="col-12">
        <div class="alert alert-secondary mb-0" role="alert">
          Még nincs leadott rendelésed!
        </div>
      </div>

      <div
        v-for="order in orders"
        :key="order.id"
        class="col-12"
      >
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <div
              class="d-flex flex-column flex-lg-row justify-content-between align-items-start gap-4 mb-4"
            >
              <div>
                <h2 class="h4 mb-3">Rendelés #{{ order.id }}</h2>

                <p class="mb-2">
                  <strong>Státusz:</strong>
                  <span
                    class="badge ms-2"
                    :class="getStatusBadgeClass(order.status)"
                  >
                    {{ getStatusLabel(order.status) }}
                  </span>
                </p>

                <p class="mb-2"><strong>Cím:</strong> {{ order.address }}</p>
                <p class="mb-2"><strong>Telefon:</strong> {{ order.phone }}</p>
                <p class="mb-0">
                  <strong>Végösszeg:</strong> {{ order.total_price }} USD
                </p>
              </div>
            </div>

            <div v-if="order.items?.length">
              <h3 class="h5 mb-3">Tételek</h3>

              <div class="list-group">
                <div
                  v-for="item in order.items"
                  :key="item.id"
                  class="list-group-item"
                >
                  <div
                    class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-2"
                  >
                    <div>
                      <strong v-if="item.configuration">
                        Konfiguráció: {{ item.configuration.name }}
                      </strong>

                      <strong v-else-if="item.prebuilt_watch">
                        Kész óra: {{ item.prebuilt_watch.name }}
                      </strong>

                      <strong v-else>
                        Ismeretlen tétel
                      </strong>
                    </div>

                    <div class="text-md-end">
                      <div><strong>Darab:</strong> {{ item.quantity }}</div>
                      <div><strong>Ár:</strong> {{ item.price }} USD</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div v-else class="alert alert-light border mt-3 mb-0">
              Ehhez a rendeléshez nem tartozik megjeleníthető tétel.
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { getMyOrders } from '../services/orderService';

const orders = ref([]);
const loading = ref(false);
const error = ref('');

const loadOrders = async () => {
  loading.value = true;
  error.value = '';

  try {
    const response = await getMyOrders();
    orders.value = response.data;
  } catch (err) {
    error.value = err.response?.data?.message || 'Nem sikerült betölteni a rendeléseket.';
  } finally {
    loading.value = false;
  }
};

const getStatusLabel = (status) => {
  switch (status) {
    case 'pending':
      return 'Függőben';
    case 'completed':
      return 'Teljesítve';
    case 'cancelled':
      return 'Törölve';
    default:
      return status;
  }
};

const getStatusBadgeClass = (status) => {
  switch (status) {
    case 'completed':
      return 'text-bg-success';
    case 'cancelled':
      return 'text-bg-danger';
    case 'pending':
    default:
      return 'text-bg-warning';
  }
};

onMounted(loadOrders);
</script>