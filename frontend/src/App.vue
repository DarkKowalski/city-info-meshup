<template>
  <div id="app">
    <el-container>
      <el-header>
        <h1>City Info Meshup</h1>
      </el-header>
      <el-main>
        <Meshup />
      </el-main>
      <el-footer>
        <p>SOA Homework SSE Tongji University 2020</p>
        <el-link href='https://github.com/darkkowalski' type="info" target='_blank'>Kowalski Dark</el-link>
      </el-footer>
    </el-container>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import Meshup from './components/Meshup.vue';

@Component({
  components: {
    Meshup,
  },
})
export default class App extends Vue {}
</script>

<style>
#app {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
body {
  background-color: #F5F7FA;
}
</style>
