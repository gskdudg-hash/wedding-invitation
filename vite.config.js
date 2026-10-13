import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Relative base keeps public images and built assets working at the site root
// and under a repository subpath (for example, GitHub Pages).
export default defineConfig({
  base: './',
  plugins: [react()],
});
