import api from './api';

export const createOrder = (payload) =>
  api.post('/orders', payload);

export const getOrder = (id) =>
  api.get(`/orders/${id}`);

export const getMyOrders = () =>
  api.get('/orders/mine');

export const getAdminOrders = () => api.get('/admin/orders');

export const updateOrderStatus = (id, status) =>
  api.put(`/admin/orders/${id}/status`, { status });

