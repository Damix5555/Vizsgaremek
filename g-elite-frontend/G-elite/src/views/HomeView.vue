<template>
  <div>
    <!-- HERO -->
<section
  class="py-5 text-white w-100"
  style="background: linear-gradient(135deg, #0b132b 0%, #1c2541 100%);"
>
  <div class="container py-lg-5">
    <div class="row align-items-center g-4">
      <div class="col-12 col-lg-7">

        <h1 class="display-4 fw-bold mb-3">
          Egyedi órák, prémium megjelenéssel
        </h1>

        <p class="lead text-white-50 mb-4">
          Konfigurálj saját órát prémium alkatrészekből, vagy válassz előre
          összeállított modellek közül gyorsan és egyszerűen.
        </p>

        <div class="d-flex flex-wrap gap-3">
          <router-link to="/configurator" class="btn btn-primary btn-lg px-4">
            Óra konfigurálása
          </router-link>

          <router-link to="/prebuilt-watches" class="btn btn-outline-light btn-lg px-4">
            Kész órák megtekintése
          </router-link>
        </div>
      </div>

      <div class="col-12 col-lg-5">
        <div class="card border-0 shadow-lg bg-white text-dark">
          <div class="card-body p-4 p-lg-5">
            <h2 class="h4 fw-bold mb-3">Miért a G-Elite Customs?</h2>

            <ul class="list-unstyled mb-0">
              <li class="mb-3 d-flex align-items-start gap-2">
                <span class="badge bg-primary mt-1">1</span>
                <span>Egyedi konfigurálási lehetőség több alkatrésztípusból.</span>
              </li>

              <li class="mb-3 d-flex align-items-start gap-2">
                <span class="badge bg-primary mt-1">2</span>
                <span>Gyors és egyszerű vásárlás.</span>
              </li>

              <li class="d-flex align-items-start gap-2">
                <span class="badge bg-primary mt-1">3</span>
                <span>Mindent egy helyen kezelhet.</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

    <!-- FEATURE BLOKKOK -->
    <section class="py-5 bg-body-tertiary">
      <div class="container">
        <div class="row mb-4">
          <div class="col-12 text-center">
            <h2 class="fw-bold mb-2">Mit kínálunk?</h2>
            <p class="text-muted mb-0">
              A webshop egyszerűen használható vásárlói és adminisztrációs funkciókat biztosít.
            </p>
          </div>
        </div>

        <div class="row g-4">
          <div class="col-12 col-md-6 col-xl-3">
            <div class="card h-100 shadow-sm border-0">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold mb-3">Egyedi konfigurálás</h3>
                <p class="text-muted mb-0">
                  Szabadon kombinálhatod a tokokat, szíjakat, számlapokat és mutatókat.
                </p>
              </div>
            </div>
          </div>

          <div class="col-12 col-md-6 col-xl-3">
            <div class="card h-100 shadow-sm border-0">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold mb-3">Minőségi alkatrészek</h3>
                <p class="text-muted mb-0">
                  Gondosan válogatott elemekből építheted fel a saját órádat.
                </p>
              </div>
            </div>
          </div>

          <div class="col-12 col-md-6 col-xl-3">
            <div class="card h-100 shadow-sm border-0">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold mb-3">Egyszerű rendelés</h3>
                <p class="text-muted mb-0">
                  Gyors kosárkezelés, menthető konfigurációk és átlátható rendelési folyamat.
                </p>
              </div>
            </div>
          </div>

          <div class="col-12 col-md-6 col-xl-3">
            <div class="card h-100 shadow-sm border-0">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold mb-3">Adminisztrált rendszer</h3>
                <p class="text-muted mb-0">
                  Teljes admin felület a termékek, kész órák és rendelések kezelésére.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- KIEMELT KÉSZ ÓRÁK -->
    <section class="py-5">
      <div class="container">
        <div class="row align-items-center mb-4 g-3">
          <div class="col-12 col-md-8">
            <h2 class="fw-bold mb-2">Kiemelt kész órák</h2>
            <p class="text-muted mb-0">
              Válassz azonnal elérhető, előre összeállított modellek közül.
            </p>
          </div>

          <div class="col-12 col-md-4 text-md-end">
            <router-link to="/prebuilt-watches" class="btn btn-outline-primary">
              Összes kész óra
            </router-link>
          </div>
        </div>

        <div v-if="loading" class="alert alert-info mb-0" role="alert">
          Betöltés...
        </div>

        <div v-else-if="featuredWatches.length === 0" class="alert alert-secondary mb-0" role="alert">
          Jelenleg nincs kiemelt kész óra.
        </div>

        <div v-else class="row g-4">
          <div
            class="col-12 col-md-6 col-xl-4"
            v-for="watch in featuredWatches"
            :key="watch.id"
          >
            <PrebuiltWatchCard
              :watch="watch"
              :isAuthenticated="isAuthenticated"
              @action="handleAction"
            />
          </div>
        </div>
      </div>
    </section>

    <!-- ALSÓ BEMUTATÓ BLOKK -->
    <section class="py-5 bg-light border-top">
      <div class="container">
        <div class="row g-4 align-items-center">
          <div class="col-12 col-lg-6">
            <h2 class="fw-bold mb-3">Miért a G-Elite?</h2>
            <p class="text-muted mb-3">
              A rendszer célja, hogy a felhasználók egyszerűen és átláthatóan tudjanak
              egyedi órát konfigurálni, illetve kész modellek közül választani.
            </p>
            <p class="text-muted mb-4">
              A webshop admin felülettel, audit loggal és rendeléskezeléssel támogatja
              a teljes folyamatot, így nemcsak vásárlói, hanem adminisztrációs oldalról is
              teljes értékű megoldást nyújt.
            </p>

            <div class="d-flex flex-wrap gap-3">
              <router-link to="/configurator" class="btn btn-primary">
                Konfigurálás indítása
              </router-link>
              <router-link to="/prebuilt-watches" class="btn btn-outline-secondary">
                Kész órák böngészése
              </router-link>
            </div>
          </div>

          <div class="col-12 col-lg-6">
            <div class="card border-0 shadow-sm">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold mb-3">Rendszerfunkciók röviden</h3>

                <div class="row g-3">
                  <div class="col-12 col-sm-6">
                    <div class="p-3 rounded bg-body-tertiary h-100">
                      <strong>Vendég nézet</strong>
                      <div class="text-muted small mt-1">
                        Böngészés regisztráció nélkül.
                      </div>
                    </div>
                  </div>

                  <div class="col-12 col-sm-6">
                    <div class="p-3 rounded bg-body-tertiary h-100">
                      <strong>Felhasználói fiók</strong>
                      <div class="text-muted small mt-1">
                        Saját konfigurációk és rendelések kezelése.
                      </div>
                    </div>
                  </div>

                  <div class="col-12 col-sm-6">
                    <div class="p-3 rounded bg-body-tertiary h-100">
                      <strong>Admin felület</strong>
                      <div class="text-muted small mt-1">
                        Termékek, kész órák és rendelések adminisztrációja.
                      </div>
                    </div>
                  </div>

                  <div class="col-12 col-sm-6">
                    <div class="p-3 rounded bg-body-tertiary h-100">
                      <strong>Audit log</strong>
                      <div class="text-muted small mt-1">
                        Műveletek naplózása és követése.
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { getPrebuiltWatches } from '../services/prebuiltWatchService';
import { useUserStore } from '../stores/user';
import PrebuiltWatchCard from '../components/PrebuiltWatchCard.vue';

const router = useRouter();
const userStore = useUserStore();

const watches = ref([]);
const loading = ref(false);

const isAuthenticated = computed(() => userStore.isAuthenticated);

const featuredWatches = computed(() =>
  watches.value.filter((w) => w.is_active).slice(0, 3)
);

const loadWatches = async () => {
  loading.value = true;

  try {
    const response = await getPrebuiltWatches();
    watches.value = response.data;
  } finally {
    loading.value = false;
  }
};

const handleAction = () => {
  if (!isAuthenticated.value) {
    router.push('/login');
    return;
  }

  router.push('/prebuilt-watches');
};

onMounted(loadWatches);
</script>