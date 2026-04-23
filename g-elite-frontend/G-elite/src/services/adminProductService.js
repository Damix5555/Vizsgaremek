import api from './api';

export const getAdminProducts = () => api.get('/admin/products');
export const getAdminProduct = (id) => api.get(`/admin/products/${id}`);

export const createAdminProduct = (formData) =>
  api.post('/admin/products', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });

export const updateAdminProduct = (id, formData) =>
  api.post(`/admin/products/${id}`, formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });

export const deleteAdminProduct = (id) =>
  api.delete(`/admin/products/${id}`);