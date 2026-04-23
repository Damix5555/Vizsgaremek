import api from './api';

export const login = (payload) => api.post('/login', payload);
export const register = (payload) => api.post('/register', payload);
export const me = () => api.get('/me');
export const logout = () => api.post('/logout');