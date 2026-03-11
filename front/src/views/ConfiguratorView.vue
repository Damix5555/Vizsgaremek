<template>

<div>

  <h2 class="mb-4">Build Your Watch</h2>

  <div class="row">

    <div class="col-md-3">
      <WatchPartSelector title="Case" />
    </div>

    <div class="col-md-3">
      <WatchPartSelector title="Strap" />
    </div>

    <div class="col-md-3">
      <WatchPartSelector title="Dial" />
    </div>

    <div class="col-md-3">
      <WatchPartSelector title="Hands" />
    </div>

  </div>

</div>

</template>

<script setup>
import WatchPartSelector from '../components/watches/WatchPartSelector.vue'
</script>