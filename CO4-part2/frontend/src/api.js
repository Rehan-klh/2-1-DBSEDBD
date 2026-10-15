const API_URL = 'http://localhost:8080';

async function request(path, { token, ...options } = {}) {
  let response;
  try {
    response = await fetch(`${API_URL}${path}`, {
      ...options,
      headers: {
        ...(options.body ? { 'Content-Type': 'application/json' } : {}),
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
        ...options.headers,
      },
    });
  } catch {
    throw new Error('Cannot reach the backend. Make sure it is running on port 8080.');
  }

  const text = await response.text();
  let data;
  try {
    data = text ? JSON.parse(text) : null;
  } catch {
    data = text;
  }

  if (!response.ok) {
    if (path === '/auth/login' && (response.status === 401 || response.status === 403)) {
      throw Object.assign(new Error('Invalid username or password.'), { status: response.status });
    }
    if (token && (response.status === 401 || response.status === 403)) {
      throw Object.assign(new Error('Your session has expired. Please log in again.'), {
        status: response.status,
      });
    }

    const validationMessages = Array.isArray(data?.errors)
      ? data.errors.map((item) => item.defaultMessage || item.message || item).join(' ')
      : data?.errors && typeof data.errors === 'object'
        ? Object.values(data.errors).flat().join(' ')
        : '';
    const message = data?.error === 'USERNAME_ALREADY_EXISTS'
      ? 'That username is already registered.'
      : validationMessages || data?.detail || data?.message || data?.title || data?.error || 'Request failed. Check the information and try again.';
    throw Object.assign(new Error(message), { status: response.status });
  }

  return data;
}

export const api = {
  register: (details) => request('/auth/register', {
    method: 'POST',
    body: JSON.stringify(details),
  }),
  login: (details) => request('/auth/login', {
    method: 'POST',
    body: JSON.stringify(details),
  }),
  getStudents: (token) => request('/students', { token }),
  createStudent: (token, student) => request('/students', {
    token,
    method: 'POST',
    body: JSON.stringify(student),
  }),
  updateStudent: (token, id, student) => request(`/students/${encodeURIComponent(id)}`, {
    token,
    method: 'PUT',
    body: JSON.stringify(student),
  }),
  deleteStudent: (token, id) => request(`/students/${encodeURIComponent(id)}`, {
    token,
    method: 'DELETE',
  }),
};