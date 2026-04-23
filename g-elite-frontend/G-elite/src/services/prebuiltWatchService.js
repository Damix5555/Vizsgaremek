import api from './api';

export const getPrebuiltWatches = () => api.get('/prebuilt-watches');
export const getPrebuiltWatch = (id) => api.get(`/prebuilt-watches/${id}`);