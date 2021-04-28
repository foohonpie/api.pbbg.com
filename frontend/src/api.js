import axios from 'axios'
import store from './store'

export function apiUrl() {
  return `https://${window.location.host}/api/`
}

// Use an interceptor instead of manually setting
// because we have a circular dependency between
// the store and the API
axios.interceptors.request.use((config) => {
  config.headers['Authorization'] = `Bearer ${store.state.token}`
  return config
})

export const api = axios.create({
  baseURL: apiUrl(),
  headers: {
    'Content-Type': 'application/json',
  },
})
