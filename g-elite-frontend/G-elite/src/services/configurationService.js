import api from './api';

export const createConfiguration = (payload) =>
  api.post('/configurations', payload);

export const getConfiguration = (id) =>
  api.get(`/configurations/${id}`);

export const getMyConfigurations = () =>
  api.get('/configurations/mine');