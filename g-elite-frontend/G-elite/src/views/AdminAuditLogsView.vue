<template>
  <section class="container py-4">
    <div class="row g-4">
      <div class="col-12">
        <h1 class="mb-1">Admin - Audit log</h1>
        <p class="text-muted mb-0">
          Műveleti napló és módosítások követése.
        </p>
      </div>

      <div class="col-12">
        <div class="card shadow-sm border-0">
          <div class="card-body">
            <div class="row g-3 align-items-end">
              <div class="col-12 col-md-4">
                <label class="form-label">Művelet</label>
                <input
                  v-model="filters.action"
                  type="text"
                  class="form-control"
                  placeholder="pl. create, update, delete"
                />
              </div>

              <div class="col-12 col-md-4">
                <label class="form-label">Entitás típusa</label>
                <input
                  v-model="filters.entity_type"
                  type="text"
                  class="form-control"
                  placeholder="pl. product, order"
                />
              </div>

              <div class="col-12 col-md-4">
                <div class="d-flex gap-2">
                  <button class="btn btn-primary" @click="loadLogs(1)">
                    Szűrés
                  </button>
                  <button class="btn btn-outline-secondary" @click="resetFilters">
                    Törlés
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12">
        <div v-if="loading" class="alert alert-info mb-0" role="alert">
          Betöltés...
        </div>

        <div v-else-if="error" class="alert alert-danger mb-0" role="alert">
          {{ error }}
        </div>

        <div v-else-if="logs.length === 0" class="alert alert-secondary mb-0" role="alert">
          Nincs megjeleníthető audit log.
        </div>

        <div v-else class="row g-4">
          <div v-for="log in logs" :key="log.id" class="col-12">
            <div class="card shadow-sm border-0">
              <div class="card-body">
                <div class="row g-3">
                  <div class="col-12 col-lg-6">
                    <p class="mb-2"><strong>ID:</strong> {{ log.id }}</p>
                    <p class="mb-2">
                      <strong>Felhasználó:</strong>
                      {{ log.user?.username || 'ismeretlen' }}
                    </p>
                    <p class="mb-2"><strong>Művelet:</strong> {{ log.action }}</p>
                    <p class="mb-2"><strong>Entitás:</strong> {{ log.entity_type }}</p>
                    <p class="mb-2"><strong>Entitás ID:</strong> {{ log.entity_id || '-' }}</p>
                    <p class="mb-0"><strong>Dátum:</strong> {{ log.created_at }}</p>
                  </div>

                  <div class="col-12 col-lg-6">
                    <div class="mb-3">
                      <label class="form-label fw-bold">Régi adatok</label>
                      <pre class="bg-light border rounded p-3 small mb-0">{{ formatJson(log.old_values) }}</pre>
                    </div>

                    <div>
                      <label class="form-label fw-bold">Új adatok</label>
                      <pre class="bg-light border rounded p-3 small mb-0">{{ formatJson(log.new_values) }}</pre>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div v-if="pagination.last_page > 1" class="col-12">
            <div class="d-flex justify-content-center align-items-center gap-3 flex-wrap">
              <button
                class="btn btn-outline-secondary"
                :disabled="pagination.current_page <= 1"
                @click="loadLogs(pagination.current_page - 1)"
              >
                Előző
              </button>

              <span class="fw-semibold">
                {{ pagination.current_page }} / {{ pagination.last_page }}
              </span>

              <button
                class="btn btn-outline-secondary"
                :disabled="pagination.current_page >= pagination.last_page"
                @click="loadLogs(pagination.current_page + 1)"
              >
                Következő
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue';
import { getAuditLogs } from '../services/auditLogService';

const logs = ref([]);
const loading = ref(false);
const error = ref('');

const pagination = ref({
  current_page: 1,
  last_page: 1,
});

const filters = reactive({
  action: '',
  entity_type: '',
});

const loadLogs = async (page = 1) => {
  loading.value = true;
  error.value = '';

  try {
    const response = await getAuditLogs({
      page,
      action: filters.action || undefined,
      entity_type: filters.entity_type || undefined,
    });

    logs.value = response.data.data || [];
    pagination.value = {
      current_page: response.data.current_page || 1,
      last_page: response.data.last_page || 1,
    };
  } catch (err) {
    error.value =
      err.response?.data?.message || 'Nem sikerült betölteni az audit logokat.';
  } finally {
    loading.value = false;
  }
};

const resetFilters = async () => {
  filters.action = '';
  filters.entity_type = '';
  await loadLogs(1);
};

const formatJson = (value) => {
  if (!value) return '-';

  try {
    if (typeof value === 'string') {
      return JSON.stringify(JSON.parse(value), null, 2);
    }

    return JSON.stringify(value, null, 2);
  } catch {
    return String(value);
  }
};

onMounted(() => loadLogs(1));
</script>