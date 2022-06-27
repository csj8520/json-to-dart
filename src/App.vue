<template>
  <div class="home">
    <div class="home__config">
      <el-form inline>
        <el-form-item label="Class name">
          <el-input v-model="config.name" type="text" placeholder="class Name" />
        </el-form-item>
        <el-form-item label="required">
          <el-select v-model="config.required" placeholder="Select">
            <el-option v-for="item in requiredOption" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-checkbox v-model="config.final" label="final" size="large" />
      </el-form>
    </div>
    <div class="home__main">
      <div class="home__main__left">
        <textarea ref="codeLeft"></textarea>
      </div>
      <div class="home__main__right">
        <textarea ref="codeRight"></textarea>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
html,
body,
#app,
.home {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
:root {
  --them-dark-primary: #151718;
  --them-dark-border: #2b2d2e;
  --el-fill-color-blank: var(--them-dark-primary);
  --el-bg-color-overlay: var(--them-dark-primary);
  --el-fill-color-light: var(--them-dark-border);
  --el-border-color: var(--them-dark-border);
  --el-border-color-light: var(--them-dark-border);
  --el-text-color-regular: #eee;
}
.home {
  display: flex;
  flex-direction: column;
  background-color: var(--them-dark-primary);
  &__config {
    .el-form {
      display: flex;
      align-items: center;
      padding: 0 0 0 10px;
    }
    .el-form-item {
      margin: 0 20px 0 0;
    }
  }
  &__main {
    flex: 1;
    display: flex;
    &__left,
    &__right {
      flex: 1;
      overflow: hidden;
      .CodeMirror {
        min-height: 100%;
        .CodeMirror-vscrollbar {
          background: rgba(0, 0, 0, 0.002);
        }
      }
    }
    &__left {
      border-right: solid 1px var(--them-dark-border);
    }
  }
}
</style>

<script setup lang="ts">
import JSON5 from 'json5';
import CodeMirror from 'codemirror';
import { useDebounceFn } from '@vueuse/core';
import { onMounted, reactive, ref, watch } from 'vue';
import { ElMessage, ElInput, ElCheckbox, ElSelect, ElOption, ElFormItem, ElForm } from 'element-plus';

import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/seti.css';
import 'codemirror/mode/javascript/javascript';
import 'codemirror/mode/dart/dart';

import { example } from './example';
import { jsonToType, typeToDart, TypeToDartConfig } from './utils';

const codeLeft = ref<HTMLTextAreaElement>(null!);
const codeRight = ref<HTMLTextAreaElement>(null!);

const storageKeys = {
  config: 'json-to-dart.config',
  code: 'json-to-dart.code'
} as const;

const config = reactive<TypeToDartConfig>({ name: 'Example', required: 'auto', final: false });
try {
  const _config = JSON.parse(localStorage.getItem(storageKeys.config) || '{}') as TypeToDartConfig;
  Object.assign(config, _config);
} catch (_) {}

const requiredOption = [
  { label: '自动', value: 'auto' },
  { label: '添加', value: 'force' },
  { label: '移除', value: 'none' }
];

let codeJson: CodeMirror.EditorFromTextArea;
let codeDart: CodeMirror.EditorFromTextArea;

const handleChange = useDebounceFn(() => {
  try {
    const value = codeJson.getValue().trim();
    localStorage.setItem(storageKeys.code, value);
    if (!value) return;
    const json = JSON5.parse(value);
    try {
      const scrollInfo = codeDart.getScrollInfo();
      codeDart.setValue(typeToDart(jsonToType(json), { ...config, name: config.name || 'Example' }).join('\n'));
      codeDart.scrollTo(scrollInfo.left, scrollInfo.top);
    } catch (error) {
      console.error(error);
      ElMessage.error('解析失败');
    }
  } catch (error) {
    ElMessage.error((error as Error).message);
  }
}, 100);

const handleSaveConfig = useDebounceFn(() => {
  const { name, required, final } = config;
  const _config: TypeToDartConfig = { name, required, final };
  localStorage.setItem(storageKeys.config, JSON.stringify(_config));
}, 100);

watch(config, () => {
  handleSaveConfig();
  handleChange();
});

onMounted(() => {
  codeLeft.value.value = localStorage.getItem(storageKeys.code) || example;
  codeJson = CodeMirror.fromTextArea(codeLeft.value, { lineNumbers: true, mode: { name: 'javascript', json: true }, theme: 'seti' });
  codeJson.on('change', handleChange);
  codeDart = CodeMirror.fromTextArea(codeRight.value, { lineNumbers: true, mode: 'dart', theme: 'seti', readOnly: true });
  handleChange();
});
</script>
