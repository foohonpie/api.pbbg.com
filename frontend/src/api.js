import axios from 'axios'

export function apiUrl() {
  return `https://${window.location.host}/api/`
}

export const api = axios.create({
  baseURL: apiUrl(),
  headers: {
    'Content-Type': 'application/json',
  },
})
