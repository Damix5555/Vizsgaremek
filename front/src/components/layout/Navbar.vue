<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">

      <router-link class="navbar-brand" to="/">
        G-Elite Watches
      </router-link>

      <div class="collapse navbar-collapse">

        <ul class="navbar-nav me-auto">

          <li class="nav-item">
            <router-link class="nav-link" to="/">
              Home
            </router-link>
          </li>

          <li class="nav-item">
            <router-link class="nav-link" to="/shop">
              Watches
            </router-link>
          </li>

          <li class="nav-item">
            <router-link class="nav-link" to="/configurator">
              Build Your Watch
            </router-link>
          </li>

        </ul>

        <router-link class="btn btn-outline-light" to="/cart">
          Cart
        </router-link>

      </div>
    </div>
  </nav>
</template>