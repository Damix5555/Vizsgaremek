import api from './api';

export const getAuditLogs = (params = {}) =>
  api.get('/admin/audit-logs', { params });

export const getAuditLog = (id) =>
  api.get(`/admin/audit-logs/${id}`);