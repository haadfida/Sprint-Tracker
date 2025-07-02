import axios from 'axios'

// Centralized Axios instance for the frontend
// - Reads base URL from Vite env var (VITE_API_URL) and falls back to localhost
// - Sends cookies for Devise session (`withCredentials`)
// - Sets JSON headers and Rails CSRF token automatically
// - Global 401 handler redirects to /login

const api = axios.create({
  baseURL: `${import.meta.env.VITE_API_URL ?? 'http://localhost:3000'}/api`,
  withCredentials: true,
})

// Attach default JSON headers & CSRF token
api.interceptors.request.use((config) => {
  config.headers = config.headers ?? {}
  config.headers['Accept'] = 'application/json'
  config.headers['Content-Type'] = 'application/json'

  const token = (document.querySelector('meta[name="csrf-token"]') as HTMLMetaElement | null)?.content
  if (token) config.headers['X-CSRF-Token'] = token
  return config
})

// Global response error handling
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // redirect the user to login page and preserve current location
      const current = window.location.pathname + window.location.search
      if (!current.startsWith('/login')) {
        window.location.assign(`/login?next=${encodeURIComponent(current)}`)
      }
    }
    return Promise.reject(error)
  },
)

export default api 