<template>
  <div class="card h-100">
    <img
      v-if="watch.image_url"
      :src="fullImageUrl(watch.image_url)"
      alt="watch"
      class="card-img-top"
      style="height: 180px; object-fit: cover"
    />

    <div class="card-body d-flex flex-column">
      <h3 class="card-title">{{ watch.name }}</h3>
      <p class="card-text">{{ watch.description }}</p>
      <p class="card-text">
        <small>
          Készlet: {{ watch.stock }}<br />
          Ár: {{ watch.price }} USD
        </small>
      </p>
      <button @click="$emit('action', watch)" class="btn btn-primary btn-sm w-100 mt-auto">
        {{ isAuthenticated ? 'Kosárba' : 'Bejelentkezés szükséges' }}
      </button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  watch: {
    type: Object,
    required: true,
  },
  isAuthenticated: {
    type: Boolean,
    required: true,
  },
});

const apiBase = import.meta.env.VITE_API_URL.replace('/api', '');
const fullImageUrl = (path) => `${apiBase}/${path}`;
</script>

