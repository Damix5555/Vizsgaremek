import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
  }),

  getters: {
    totalPrice: (state) => {
      return state.items.reduce((sum, item) => {
        return sum + Number(item.price) * Number(item.quantity);
      }, 0);
    },
  },

  actions: {
    addConfiguration(configuration) {
      this.items.push({
        type: 'configuration',
        configuration_id: configuration.id,
        name: configuration.name,
        price: Number(configuration.total_price),
        quantity: 1,
      });
    },

    addPrebuiltWatch(watch) {
      const existing = this.items.find(
        (item) =>
          item.type === 'prebuilt' &&
          item.prebuilt_watch_id === watch.id
      );

      if (existing) {
        existing.quantity += 1;
        return;
      }

      this.items.push({
        type: 'prebuilt',
        prebuilt_watch_id: watch.id,
        name: watch.name,
        price: Number(watch.price),
        quantity: 1,
      });
    },

    removeItem(index) {
      this.items.splice(index, 1);
    },

    clearCart() {
      this.items = [];
    },
  },
});