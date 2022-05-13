import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

import { createStyleImportPlugin, ElementPlusResolve } from 'vite-plugin-style-import';

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    port: 3005
  },
  base: './',
  plugins: [vue(), createStyleImportPlugin({ resolves: [ElementPlusResolve()] })]
});
