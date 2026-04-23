<template>
  <div class="d-flex justify-content-center py-5">
    <div class="card p-4" style="width: 100%; max-width: 420px">
      <h2 class="section-title mb-4">Regisztráció</h2>

      <form @submit.prevent="submitRegister" class="form-group">
        <div class="mb-3">
          <label for="username" class="form-label">Felhasználónév</label>
          <input v-model="form.username" type="text" class="form-control" id="username" />
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">E-mail</label>
          <input v-model="form.email" type="email" class="form-control" id="email" />
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Jelszó</label>
          <input v-model="form.password" type="password" class="form-control" id="password" />
        </div>

        <div class="mb-3">
          <label for="password_confirmation" class="form-label">Jelszó újra</label>
          <input v-model="form.password_confirmation" type="password" class="form-control" id="password_confirmation" />
        </div>

        <button type="submit" :disabled="userStore.loading" class="btn btn-primary w-100">
          {{ userStore.loading ? 'Regisztráció...' : 'Regisztráció' }}
        </button>
      </form>

      <div v-if="errors.length" class="alert alert-danger mt-3">
        <p v-for="(item, index) in errors" :key="index" class="mb-0">{{ item }}</p>
      </div>
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
  username: '',
  email: '',
  password: '',
  password_confirmation: '',
});

const errors = ref([]);

const submitRegister = async () => {
  errors.value = [];

  try {
    await userStore.registerUser(form);
    router.push('/');
  } catch (err) {
    if (err.response?.data?.errors) {
      errors.value = Object.values(err.response.data.errors).flat();
    } else if (err.response?.data?.message) {
      errors.value = [err.response.data.message];
    } else {
      errors.value = ['Sikertelen regisztráció.'];
    }
  }
};
</script>

