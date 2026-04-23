import api from './api';

export const getProducts = (params = {}) => api.get('/products', { params });
export const getProductsByType = (type) => api.get(`/products/type/${type}`);
export const getProduct = (id) => api.get(`/products/${id}`);