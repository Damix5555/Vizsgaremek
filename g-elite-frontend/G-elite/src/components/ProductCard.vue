<template>
  <div class="card h-100">
    <img
      v-if="product.image_url"
      :src="fullImageUrl(product.image_url)"
      alt="product"
      class="card-img-top"
      style="height: 180px; object-fit: cover"
    />

    <div class="card-body">
      <h3 class="card-title">{{ product.name }}</h3>
      <p class="card-text">
        <small>
          Típus: {{ product.type }}<br />
          Szín: {{ product.color }}<br />
          Anyag: {{ product.material }}<br />
          Ár: {{ product.price }} USD
        </small>
      </p>
      <button @click="$emit('select', product)" class="btn btn-primary btn-sm w-100">Kiválaszt</button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  product: {
    type: Object,
    required: true,
  },
});

const apiBase = import.meta.env.VITE_API_URL.replace('/api', '');
const fullImageUrl = (path) => `${apiBase}/${path}`;
</script>

