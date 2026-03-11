<template>

<div class="card">

  <div class="card-body">

    <h5>{{ title }}</h5>

    <select class="form-select">
      <option>Select {{ title }}</option>
    </select>

  </div>

</div>

</template>

<script setup>
defineProps({
  title: String
})
</script>