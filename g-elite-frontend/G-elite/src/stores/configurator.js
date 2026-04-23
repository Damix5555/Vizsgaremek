import { defineStore } from 'pinia';

export const useConfiguratorStore = defineStore('configurator', {
  state: () => ({
    selectedCase: null,
    selectedStrap: null,
    selectedDial: null,
    selectedHands: null,
    savedConfiguration: null,
  }),

  getters: {
    totalPrice: (state) => {
      const items = [
        state.selectedCase,
        state.selectedStrap,
        state.selectedDial,
        state.selectedHands,
      ];

      return items.reduce((sum, item) => {
        return sum + Number(item?.price || 0);
      }, 0);
    },

    isComplete: (state) => {
      return !!(
        state.selectedCase &&
        state.selectedStrap &&
        state.selectedDial &&
        state.selectedHands
      );
    },

    selectedPartsIds: (state) => {
      return [
        state.selectedCase?.id,
        state.selectedStrap?.id,
        state.selectedDial?.id,
        state.selectedHands?.id,
      ].filter(Boolean);
    },
  },

  actions: {
    setPart(type, product) {
      if (type === 'case') this.selectedCase = product;
      if (type === 'strap') this.selectedStrap = product;
      if (type === 'dial') this.selectedDial = product;
      if (type === 'hands') this.selectedHands = product;
    },

    clearConfiguration() {
      this.selectedCase = null;
      this.selectedStrap = null;
      this.selectedDial = null;
      this.selectedHands = null;
      this.savedConfiguration = null;
    },

    setSavedConfiguration(configuration) {
      this.savedConfiguration = configuration;
    },
  },
});