import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

import { createStyleImportPlugin, ElementPlusResolve } from 'vite-plugin-style-import';

// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  plugins: [vue(), createStyleImportPlugin({ resolves: [ElementPlusResolve()] })]
});
