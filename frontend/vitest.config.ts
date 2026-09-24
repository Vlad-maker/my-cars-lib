import {defineConfig} from 'vitest/config';

// Unit tests cover pure logic (src/lib), so they don't need the Astryx/StyleX
// Vite plugins; skipping them also avoids the "close timed out" hang.
export default defineConfig({
  test: {
    environment: 'node',
    include: ['src/**/*.test.ts'],
  },
});
