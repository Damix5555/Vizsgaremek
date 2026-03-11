<template>

<div class="card">

  <img
    :src="'https://picsum.photos/500/350?random=' + Math.random()"
    class="card-img-top"
  >

  <div class="card-body">

    <h5 class="card-title">Silver Steel</h5>

    <p>$150</p>

    <router-link
      class="btn btn-primary"
      to="/watch/1"
    >
      View
    </router-link>

  </div>

</div>

</template>