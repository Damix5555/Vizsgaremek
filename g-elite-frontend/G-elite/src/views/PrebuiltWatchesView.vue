<template>
  <section class="py-5">
    <div class="container">
      <h2 class="section-title mb-4">Előre összeállított órák</h2>

      <div v-if="loading" class="alert alert-info">Betöltés...</div>
      <div v-if="error" class="alert alert-danger">{{ error }}</div>

      <div v-if="!loading && !error" class="row g-4">
        <div class="col-md-6 col-lg-4" v-for="watch in watches" :key="watch.id">
          <PrebuiltWatchCard
            :watch="watch"
            :is-authenticated="userStore.isAuthenticated"
            @action="handleWatchAction"
          />
        </div>
      </div>

      <p v-if="message" class="alert alert-success mt-3">{{ message }}</p>
    </div>
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import PrebuiltWatchCard from '../components/PrebuiltWatchCard.vue';
import { getPrebuiltWatches } from '../services/prebuiltWatchService';
import { useCartStore } from '../stores/cart';
import { useUserStore } from '../stores/user';

const watches = ref([]);
const loading = ref(false);
const error = ref('');
const message = ref('');
const cart = useCartStore();
const userStore = useUserStore();
const router = useRouter();

const loadWatches = async () => {
  loading.value = true;
  error.value = '';

  try {
    const response = await getPrebuiltWatches();
    watches.value = response.data;
  } catch  {
    error.value = 'Nem sikerült betölteni az órákat.';
  } finally {
    loading.value = false;
  }
};

const handleWatchAction = (watch) => {
  message.value = '';

  if (!userStore.isAuthenticated) {
    router.push('/login');
    return;
  }

  cart.addPrebuiltWatch(watch);
  message.value = 'Az óra a kosárba került.';
};

onMounted(loadWatches);
</script>

