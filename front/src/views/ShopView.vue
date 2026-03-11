<template>

<div>

  <h2 class="mb-4">Prebuilt Watches</h2>

  <div class="row">

    <div
      class="col-md-4"
      v-for="n in 6"
      :key="n"
    >
      <PrebuiltWatchCard />
    </div>

  </div>

</div>

</template>

<script setup>
import PrebuiltWatchCard from '../components/watches/PrebuiltWatchCard.vue'
</script>