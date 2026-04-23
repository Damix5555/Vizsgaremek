import { defineStore } from 'pinia';
import { login, register, me, logout } from '../services/authService';

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token') || null,
    loading: false,
    initialized: false,
  }),

  getters: {
    isAuthenticated: (state) => !!state.token && !!state.user,
    isAdmin: (state) => state.user?.role === 'admin',
    isGuest: (state) => !state.token || !state.user,
  },

  actions: {
    async initUser() {
      if (!this.token) {
        this.initialized = true;
        return;
      }

      try {
        this.loading = true;
        const response = await me();
        this.user = response.data;
      } catch (error) {
        this.clearAuth();
      } finally {
        this.loading = false;
        this.initialized = true;
      }
    },

    async loginUser(payload) {
      this.loading = true;

      try {
        const response = await login(payload);

        this.token = response.data.token;
        this.user = response.data.user;

        localStorage.setItem('token', response.data.token);

        return response;
      } finally {
        this.loading = false;
      }
    },

    async registerUser(payload) {
      this.loading = true;

      try {
        const response = await register(payload);

        this.token = response.data.token;
        this.user = response.data.user;

        localStorage.setItem('token', response.data.token);

        return response;
      } finally {
        this.loading = false;
      }
    },

    async logoutUser() {
      try {
        if (this.token) {
          await logout();
        }
      } catch (error) {
        // nem állítjuk meg a logoutot
      } finally {
        this.clearAuth();
      }
    },

    clearAuth() {
      this.token = null;
      this.user = null;
      localStorage.removeItem('token');
    },
  },
});