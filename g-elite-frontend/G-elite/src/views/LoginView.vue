<template>
  <div class="d-flex justify-content-center py-5">
    <div class="card p-4" style="width: 100%; max-width: 420px">
      <h2 class="section-title mb-4">Bejelentkezés</h2>

      <form @submit.prevent="submitLogin" class="form-group">
        <div class="mb-3">
          <label for="email" class="form-label">E-mail</label>
          <input v-model="form.email" type="email" class="form-control" id="email" />
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Jelszó</label>
          <input v-model="form.password" type="password" class="form-control" id="password" />
        </div>

        <button type="submit" :disabled="userStore.loading" class="btn btn-primary w-100">
          {{ userStore.loading ? 'Belépés...' : 'Bejelentkezés' }}
        </button>
      </form>

      <p v-if="error" class="alert alert-danger mt-3">{{ error }}</p>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '../stores/user';

const router = useRouter();
const userStore = useUserStore();

const form = reactive({
  email: '',
  password: '',
});

const error = ref('');

const submitLogin = async () => {
  error.value = '';

  try {
    await userStore.loginUser(form);

    if (userStore.isAdmin) {
      router.push('/admin');
    } else {
      router.push('/');
    }
  } catch (err) {
    if (err.response?.data?.errors?.email?.length) {
      error.value = err.response.data.errors.email[0];
    } else if (err.response?.data?.message) {
      error.value = err.response.data.message;
    } else {
      error.value = 'Sikertelen bejelentkezés.';
    }
  }
};
</script>

