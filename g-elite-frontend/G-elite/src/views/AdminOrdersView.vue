<template>
  <section class="container py-4">
    <div class="row g-4">
      <!-- Fejléc -->
      <div class="col-12">
        <h1 class="mb-1">Admin - Rendelések</h1>
        <p class="text-muted mb-0">
          Összes rendelés kezelése.
        </p>
      </div>

      <!-- Kereső -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <div class="row g-3 align-items-center">
              <div class="col-12 col-lg-6">
                <input
                  v-model="search"
                  type="text"
                  class="form-control"
                  placeholder="Keresés név, email vagy rendelés ID alapján..."
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Üzenetek -->
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

      <!-- Üres állapot -->
      <div v-if="!loading && filteredOrders.length === 0" class="col-12">
        <div class="alert alert-secondary mb-0" role="alert">
          Nincs megjeleníthető rendelés.
        </div>
      </div>

      <!-- Rendelések -->
      <div
        v-for="order in filteredOrders"
        :key="order.id"
        class="col-12"
      >
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <div class="row g-4 align-items-start">
              <!-- Bal oldal: adatok -->
              <div class="col-12 col-lg-8">
                <h2 class="h4 mb-3">Rendelés #{{ order.id }}</h2>

                <div class="row g-3">
                  <div class="col-12 col-md-6">
                    <p class="mb-2">
                      <strong>Felhasználó:</strong>
                      {{ order.user?.username || '-' }}
                    </p>
                    <p class="mb-2">
                      <strong>Email:</strong>
                      {{ order.user?.email || '-' }}
                    </p>
                    <p class="mb-2">
                      <strong>Cím:</strong>
                      {{ order.address }}
                    </p>
                  </div>

                  <div class="col-12 col-md-6">
                    <p class="mb-2">
                      <strong>Telefon:</strong>
                      {{ order.phone }}
                    </p>
                    <p class="mb-0">
                      <strong>Végösszeg:</strong>
                      {{ order.total_price }} USD
                    </p>
                  </div>
                </div>
              </div>

              <!-- Jobb oldal: státusz -->
              <div class="col-12 col-lg-4">
                <div class="border rounded p-3 bg-light">
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Jelenlegi státusz</label>
                    <div>
                      <span class="badge" :class="statusBadgeClass(order.status)">
                        {{ getStatusLabel(order.status) }}
                      </span>
                    </div>
                  </div>

                  <div>
                    <label class="form-label fw-semibold">Státusz módosítása</label>
                    <select
                      v-model="order.status"
                      class="form-select"
                      @change="changeStatus(order)"
                    >
                      <option value="pending">Függőben</option>
                      <option value="completed">Teljesítve</option>
                      <option value="cancelled">Törölve</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { getAdminOrders, updateOrderStatus } from '../services/orderService';

const orders = ref([]);
const loading = ref(false);
const error = ref('');
const message = ref('');
const search = ref('');

const loadOrders = async () => {
  loading.value = true;
  error.value = '';
  message.value = '';

  try {
    const response = await getAdminOrders();
    orders.value = response.data;
  } catch (err) {
    error.value =
      err.response?.data?.message || 'Nem sikerült betölteni a rendeléseket.';
  } finally {
    loading.value = false;
  }
};

const filteredOrders = computed(() => {
  const term = search.value.trim().toLowerCase();

  if (!term) return orders.value;

  return orders.value.filter((order) => {
    return (
      String(order.id).includes(term) ||
      order.user?.username?.toLowerCase().includes(term) ||
      order.user?.email?.toLowerCase().includes(term)
    );
  });
});

const changeStatus = async (order) => {
  error.value = '';
  message.value = '';

  try {
    await updateOrderStatus(order.id, order.status);
    message.value = `A(z) #${order.id} rendelés státusza frissítve lett.`;
  } catch (err) {
    error.value =
      err.response?.data?.message || 'Nem sikerült frissíteni a státuszt.';
    await loadOrders();
  }
};

const statusBadgeClass = (status) => {
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
onMounted(loadOrders);
</script>