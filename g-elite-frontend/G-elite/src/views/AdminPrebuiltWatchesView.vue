<template>
  <section class="container py-4">
    <div class="row g-4">
      <!-- Fejléc -->
      <div class="col-12">
        <h1 class="mb-1">Admin - Előre összeállított órák</h1>
        <p class="text-muted mb-0">
          Előre összeállított órák létrehozása, módosítása és törlése.
        </p>
      </div>

      <!-- Üzenetek -->
      <div class="col-12">
        <div v-if="errors.length" class="alert alert-danger mb-0" role="alert">
          <div v-for="(item, index) in errors" :key="index">
            {{ item }}
          </div>
        </div>

        <div v-if="message" class="alert alert-success mb-0" role="alert">
          {{ message }}
        </div>
      </div>

      <!-- Űrlap -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <h2 class="h4 mb-4">
              {{ editingId ? 'Óra módosítása' : 'Új óra létrehozása' }}
            </h2>

            <form @submit.prevent="submitForm" class="row g-3">
              <div class="col-12 col-md-6 col-xl-3">
                <label class="form-label">Név</label>
                <input v-model="form.name" type="text" class="form-control" />
              </div>

              <div class="col-12 col-md-6 col-xl-4">
                <label class="form-label">Leírás</label>
                <textarea
                  v-model="form.description"
                  class="form-control"
                  rows="2"
                ></textarea>
              </div>

              <div class="col-12 col-md-6 col-xl-2">
                <label class="form-label">Ár</label>
                <input
                  v-model="form.price"
                  type="number"
                  step="0.01"
                  class="form-control"
                />
              </div>

              <div class="col-12 col-md-6 col-xl-2">
                <label class="form-label">Készlet</label>
                <input
                  v-model="form.stock"
                  type="number"
                  class="form-control"
                />
              </div>

              <div class="col-12 col-md-6 col-xl-1">
                <label class="form-label">Aktív</label>
                <select v-model="form.is_active" class="form-select">
                  <option :value="true">Igen</option>
                  <option :value="false">Nem</option>
                </select>
              </div>

              <div class="col-12 col-lg-6">
                <label class="form-label">Kép</label>
                <input type="file" class="form-control" @change="handleFileChange" />
              </div>

              <div class="col-12 d-flex flex-wrap gap-2 pt-2">
                <button type="submit" class="btn btn-primary" :disabled="saving">
                  {{ saving ? 'Mentés...' : editingId ? 'Módosítás mentése' : 'Létrehozás' }}
                </button>

                <button
                  type="button"
                  class="btn btn-outline-secondary"
                  @click="resetForm"
                  :disabled="saving"
                >
                  Űrlap törlése
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- Lista -->
      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <div
              class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4"
            >
              <h2 class="h4 mb-0">Kész órák listája</h2>

              <div class="w-100" style="max-width: 420px;">
                <input
                  v-model="search"
                  type="text"
                  class="form-control"
                  placeholder="Keresés név vagy leírás alapján..."
                />
              </div>
            </div>

            <div v-if="loading" class="alert alert-info mb-0" role="alert">
              Betöltés...
            </div>

            <template v-else>
              <div v-if="filteredWatches.length === 0" class="alert alert-secondary mb-0" role="alert">
                Nincs a keresésnek megfelelő kész óra.
              </div>

              <div v-else class="table-responsive">
                <table class="table table-hover align-middle">
                  <thead class="table-light">
                    <tr>
                      <th>ID</th>
                      <th>Név</th>
                      <th>Ár</th>
                      <th>Készlet</th>
                      <th>Aktív</th>
                      <th>Kép</th>
                      <th>Műveletek</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="watch in filteredWatches" :key="watch.id">
                      <td>{{ watch.id }}</td>
                      <td>{{ watch.name }}</td>
                      <td>{{ watch.price }}</td>
                      <td>{{ watch.stock }}</td>
                      <td>
                        <span
                          class="badge"
                          :class="watch.is_active ? 'text-bg-success' : 'text-bg-secondary'"
                        >
                          {{ watch.is_active ? 'Igen' : 'Nem' }}
                        </span>
                      </td>
                      <td>
                        <img
                          v-if="watch.image_url"
                          :src="fullImageUrl(watch.image_url)"
                          alt="watch"
                          class="img-thumbnail"
                          style="width: 110px; height: 110px; object-fit: cover;"
                        />
                        <span v-else class="text-muted">-</span>
                      </td>
                      <td>
                        <div class="d-flex flex-wrap gap-2">
                          <button
                            class="btn btn-sm btn-outline-primary"
                            @click="editWatch(watch)"
                          >
                            Szerkesztés
                          </button>

                          <button
                            class="btn btn-sm btn-outline-danger"
                            @click="removeWatch(watch.id)"
                          >
                            Törlés
                          </button>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </template>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue';
import {
  getAdminPrebuiltWatches,
  createAdminPrebuiltWatch,
  updateAdminPrebuiltWatch,
  deleteAdminPrebuiltWatch,
} from '../services/adminPrebuiltWatchService';

const watches = ref([]);
const loading = ref(false);
const saving = ref(false);
const editingId = ref(null);
const selectedFile = ref(null);
const message = ref('');
const errors = ref([]);
const search = ref('');

const form = reactive({
  name: '',
  description: '',
  price: '',
  stock: '',
  is_active: true,
});

const apiBase = import.meta.env.VITE_API_URL.replace('/api', '');

const fullImageUrl = (path) => `${apiBase}/${path}`;

const filteredWatches = computed(() => {
  const term = search.value.trim().toLowerCase();

  if (!term) return watches.value;

  return watches.value.filter((watch) =>
    watch.name?.toLowerCase().includes(term) ||
    watch.description?.toLowerCase().includes(term)
  );
});

const loadWatches = async () => {
  loading.value = true;
  errors.value = [];

  try {
    const response = await getAdminPrebuiltWatches();
    watches.value = response.data;
  } catch {
    errors.value = ['Nem sikerült betölteni a kész órákat.'];
  } finally {
    loading.value = false;
  }
};

const handleFileChange = (event) => {
  selectedFile.value = event.target.files[0] || null;
};

const buildFormData = () => {
  const formData = new FormData();

  formData.append('name', form.name);
  formData.append('description', form.description);
  formData.append('price', form.price);
  formData.append('stock', form.stock);
  formData.append('is_active', form.is_active ? 1 : 0);

  if (selectedFile.value) {
    formData.append('image', selectedFile.value);
  }

  return formData;
};

const submitForm = async () => {
  saving.value = true;
  errors.value = [];
  message.value = '';

  try {
    const formData = buildFormData();

    if (editingId.value) {
      await updateAdminPrebuiltWatch(editingId.value, formData);
      message.value = 'Az óra sikeresen módosítva.';
    } else {
      await createAdminPrebuiltWatch(formData);
      message.value = 'Az óra sikeresen létrehozva.';
    }

    resetForm();
    await loadWatches();
  } catch (err) {
    if (err.response?.data?.errors) {
      errors.value = Object.values(err.response.data.errors).flat();
    } else if (err.response?.data?.message) {
      errors.value = [err.response.data.message];
    } else {
      errors.value = ['Hiba történt a mentés során.'];
    }
  } finally {
    saving.value = false;
  }
};

const editWatch = (watch) => {
  editingId.value = watch.id;
  form.name = watch.name;
  form.description = watch.description || '';
  form.price = watch.price;
  form.stock = watch.stock;
  form.is_active = !!watch.is_active;
  selectedFile.value = null;
  message.value = '';
  errors.value = [];
};

const removeWatch = async (id) => {
  const confirmed = confirm('Biztosan törölni szeretnéd ezt az órát?');

  if (!confirmed) return;

  errors.value = [];
  message.value = '';

  try {
    await deleteAdminPrebuiltWatch(id);
    message.value = 'Az óra sikeresen törölve.';
    await loadWatches();

    if (editingId.value === id) {
      resetForm();
    }
  } catch (err) {
    if (err.response?.data?.message) {
      errors.value = [err.response.data.message];
    } else {
      errors.value = ['Nem sikerült törölni az órát.'];
    }
  }
};

const resetForm = () => {
  editingId.value = null;
  selectedFile.value = null;
  form.name = '';
  form.description = '';
  form.price = '';
  form.stock = '';
  form.is_active = true;
  errors.value = [];
  message.value = '';
};

onMounted(loadWatches);
</script>