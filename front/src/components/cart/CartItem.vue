<template>

<div class="card mb-3">

  <div class="row g-0 align-items-center">

    <div class="col-md-2">
      <img
        :src="image"
        class="img-fluid rounded-start"
        alt="watch"
      >
    </div>

    <div class="col-md-6">

      <div class="card-body">

        <h5 class="card-title">{{ name }}</h5>

        <p class="card-text text-muted">
          {{ type }}
        </p>

      </div>

    </div>

    <div class="col-md-2 text-center">

      <p class="fw-bold">
        ${{ price }}
      </p>

    </div>

    <!--Bootstrap ikonokkal kiegésziteni!-->
    <div class="col-md-2 text-center">

      <button
        class="btn btn-danger btn-sm"
      >
        Remove
      </button>

    </div>

  </div>

</div>

</template>

<script setup>

defineProps({
  name: String,
  price: Number,
  image: String,
  type: String
})

</script>