import {defineConfig} from 'vite';
import react from '@vitejs/plugin-react';
import {astryxStylex} from '@astryxdesign/build/vite';

export default defineConfig({
  plugins: [...astryxStylex(), react()],
  server: {
    port: 5173,
    // In dev, forward API calls to the Go backend so no CORS is needed.
    proxy: {
      '/api': 'http://localhost:8080',
    },
  },
});
