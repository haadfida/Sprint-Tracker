import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      },
      '/accounts': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      },
      '/projects': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      },
      '/issues': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      },
      '/sprints': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      }
    }
  }
})
