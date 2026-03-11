<template>

<div>

  <div class="row">

    <div class="col-md-6">

      <img
        :src="'https://picsum.photos/500/350?random=' + Math.random()"
        class="img-fluid rounded"
      />

    </div>

    <div class="col-md-6">

      <h2>{{ watch.name }}</h2>

      <p class="text-muted">
        {{ watch.description }}
      </p>

      <h4 class="mb-3">
        ${{ watch.price }}
      </h4>

      <button class="btn btn-primary">
        Add to Cart
      </button>

    </div>

  </div>

  <hr class="my-5">

  <h4>Specifications</h4>

  <ul class="list-group">

    <li class="list-group-item">
      Case: Stainless Steel
    </li>

    <li class="list-group-item">
      Dial: Blue
    </li>

    <li class="list-group-item">
      Strap: Leather
    </li>

    <li class="list-group-item">
      Hands: Silver
    </li>

  </ul>

</div>

</template>

<script setup>

import { useRoute } from 'vue-router'

const route = useRoute()

// később majd API-ból jön le
const watch = {
  id: route.params.id,
  name: "Classic Steel",
  description: "Minimal steel watch with blue dial and leather strap.",
  price: 149.99
}

</script>