<template>
  <div class="home">
    <div class="home__config">
      <el-form inline>
        <el-form-item label="Class name">
          <el-input v-model="config.name" type="text" placeholder="class Name" />
        </el-form-item>
        <el-form-item label="required">
          <el-select v-model="required" placeholder="Select">
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
.home {
  display: flex;
  flex-direction: column;
  // background-color: #151718;
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
      overflow-y: auto;
      border-right: solid 1px #ccc;
      .CodeMirror {
        min-height: 100%;
      }
    }
    &__right {
      border: none;
    }
  }
}
</style>

<script setup lang="ts">
import CodeMirror from 'codemirror';
import { onMounted, reactive, ref, watch } from 'vue';
import { useDebounceFn } from '@vueuse/core';
import { ElMessage, ElInput, ElCheckbox, ElSelect, ElOption, ElFormItem, ElForm } from 'element-plus';

import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/seti.css';
import 'codemirror/mode/javascript/javascript';
import 'codemirror/mode/dart/dart';

import { example } from './example';
import { jsonToType, typeToDart, TypeToDartConfig } from './utils';

const codeLeft = ref<HTMLTextAreaElement>(null!);
const codeRight = ref<HTMLTextAreaElement>(null!);

const config = reactive<TypeToDartConfig>({ name: 'Root', auto: true, required: false, final: false });
try {
  const _config = JSON.parse(localStorage.getItem('config') || '{}');
  Object.assign(config, _config);
} catch (_) {}

const required = ref(config.auto ? 'auto' : config.required ? 'add' : 'remove');
const requiredOption = [
  { label: '自动', value: 'auto' },
  { label: '添加', value: 'add' },
  { label: '移除', value: 'remove' }
];

let codeJson: CodeMirror.EditorFromTextArea;
let codeDart: CodeMirror.EditorFromTextArea;

const handleChange = useDebounceFn(() => {
  try {
    const value = codeJson.getValue().trim();
    if (!value) return;
    const json = JSON.parse(value);
    try {
      codeDart.setValue(typeToDart(jsonToType(json), { ...config, name: config.name || 'Root' }).join('\n'));
    } catch (error) {
      console.error(error);
      ElMessage.error('解析失败');
    }
  } catch (error) {
    console.error(error);
    ElMessage.error('json 格式有误');
  }
}, 500);

watch(config, () => {
  localStorage.setItem('config', JSON.stringify(config));
  handleChange();
});

watch(required, () => {
  if (required.value === 'auto') {
    config.auto = true;
  } else if (required.value === 'add') {
    config.auto = false;
    config.required = true;
  } else {
    config.auto = false;
    config.required = false;
  }
});

onMounted(() => {
  codeLeft.value.value = example;
  codeJson = CodeMirror.fromTextArea(codeLeft.value, { lineNumbers: true, mode: { name: 'javascript', json: true }, theme: 'seti' });
  codeJson.on('change', handleChange);
  codeDart = CodeMirror.fromTextArea(codeRight.value, { lineNumbers: true, mode: 'dart', theme: 'seti' });
  handleChange();
});
</script>
