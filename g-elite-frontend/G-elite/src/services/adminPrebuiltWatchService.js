import api from './api';

export const getAdminPrebuiltWatches = () => api.get('/admin/prebuilt-watches');
export const getAdminPrebuiltWatch = (id) => api.get(`/admin/prebuilt-watches/${id}`);

export const createAdminPrebuiltWatch = (formData) =>
  api.post('/admin/prebuilt-watches', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });

export const updateAdminPrebuiltWatch = (id, formData) =>
  api.post(`/admin/prebuilt-watches/${id}`, formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });

export const deleteAdminPrebuiltWatch = (id) =>
  api.delete(`/admin/prebuilt-watches/${id}`);