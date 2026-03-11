<template>

<div>

  <h2 class="mb-4">Your Cart</h2>

  <CartItem
    name="Classic Steel"
    type="Prebuilt Watch"
    :price="150.00"
    image="https://picsum.photos/150"
  />

  <CartItem
    name="Custom Watch"
    type="Custom Watch"
    :price="130.00"
    image="https://picsum.photos/150"
  />

  <div class="text-end mt-4">

    <h4>Total: $280.00</h4>

    <button class="btn btn-success">
      Place Order
    </button>

  </div>

</div>

</template>

<script setup>

import CartItem from '../components/cart/CartItem.vue'

</script>