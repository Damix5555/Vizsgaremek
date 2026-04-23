<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <h1 class="mb-1">Kosár és rendelés</h1>
        <p class="text-muted mb-0">
          Itt ellenőrizheted a kiválasztott tételeket, majd leadhatod a rendelést.
        </p>
      </div>

      <div class="col-12">
        <div v-if="message" class="alert alert-success mb-0" role="alert">
          {{ message }}
        </div>

        <div v-if="error" class="alert alert-danger mb-0" role="alert">
          {{ error }}
        </div>
      </div>

      <div v-if="cart.items.length === 0" class="col-12">
        <div class="alert alert-secondary mb-0" role="alert">
          A kosár jelenleg üres.
        </div>
      </div>

      <template v-else>
        <!-- Bal oldal: kosártételek -->
        <div class="col-12 col-xl-8">
          <div class="card shadow-sm border-0">
            <div class="card-body">
              <h2 class="h4 mb-4">Kosár tartalma</h2>

              <div class="row g-4">
                <div
                  v-for="(item, index) in cart.items"
                  :key="index"
                  class="col-12"
                >
                  <div class="border rounded p-3 h-100 bg-light">
                    <div
                      class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-3"
                    >
                      <div>
                        <h3 class="h5 mb-2">{{ item.name }}</h3>
                        <p class="mb-1">
                          <strong>Típus:</strong> {{ item.type }}
                        </p>
                        <p class="mb-1">
                          <strong>Mennyiség:</strong> {{ item.quantity }}
                        </p>
                        <p class="mb-0">
                          <strong>Egységár:</strong> {{ item.price }} USD
                        </p>
                      </div>

                      <div class="ms-md-auto">
                        <button
                          class="btn btn-outline-danger"
                          @click="cart.removeItem(index)"
                          :disabled="submitting"
                        >
                          Törlés
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <hr class="my-4" />

              <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h3 class="h5 mb-0">Végösszeg</h3>
                <div class="fs-4 fw-bold">
                  {{ cart.totalPrice.toFixed(2) }} USD
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Jobb oldal: rendelési űrlap -->
        <div class="col-12 col-xl-4">
          <div class="card shadow-sm border-0">
            <div class="card-body">
              <h2 class="h4 mb-4">Rendelési adatok</h2>

              <form @submit.prevent="submitOrder" class="row g-3">
                <div class="col-12">
                  <label for="address" class="form-label">Cím</label>
                  <input
                    id="address"
                    v-model="address"
                    type="text"
                    class="form-control"
                    placeholder="Pl. Budapest, Teszt utca 1."
                  />
                </div>

                <div class="col-12">
                  <label for="phone" class="form-label">Telefonszám</label>
                  <input
                    id="phone"
                    v-model="phone"
                    type="text"
                    class="form-control"
                    placeholder="Pl. +36 30 123 4567"
                  />
                </div>

                <div class="col-12 d-grid">
                  <button
                    type="submit"
                    class="btn btn-primary btn-lg"
                    :disabled="submitting"
                  >
                    {{ submitting ? 'Küldés...' : 'Rendelés leadása' }}
                  </button>
                </div>
              </form>

              <div class="mt-4 p-3 rounded bg-light border">
                <p class="mb-1"><strong>Tételek száma:</strong> {{ cart.items.length }}</p>
                <p class="mb-0">
                  <strong>Fizetendő:</strong> {{ cart.totalPrice.toFixed(2) }} USD
                </p>
              </div>
            </div>
          </div>
        </div>
      </template>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue';
import { useCartStore } from '../stores/cart';
import { createOrder } from '../services/orderService';

const cart = useCartStore();

const address = ref('');
const phone = ref('');
const submitting = ref(false);
const message = ref('');
const error = ref('');

const submitOrder = async () => {
  submitting.value = true;
  message.value = '';
  error.value = '';

  try {
    const items = cart.items.map((item) => ({
      configuration_id: item.configuration_id || null,
      prebuilt_watch_id: item.prebuilt_watch_id || null,
      quantity: item.quantity,
    }));

    const payload = {
      address: address.value,
      phone: phone.value,
      items,
    };

    await createOrder(payload);

    message.value = 'A rendelés sikeresen leadva.';
    cart.clearCart();
    address.value = '';
    phone.value = '';
  } catch (err) {
    if (err.response?.data?.errors) {
      error.value = Object.values(err.response.data.errors).flat().join(' ');
    } else if (err.response?.data?.message) {
      error.value = err.response.data.message;
    } else {
      error.value = 'Nem sikerült leadni a rendelést.';
    }
  } finally {
    submitting.value = false;
  }
};
</script>