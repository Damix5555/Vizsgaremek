import { createApp } from 'vue';
import { createPinia } from 'pinia';
import App from './App.vue';
import router from './router';
import './assets/main.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import { useUserStore } from './stores/user';


const app = createApp(App);
const pinia = createPinia();

app.use(pinia);
app.use(router);

const userStore = useUserStore();
userStore.initUser().finally(() => {
  app.mount('#app');
});