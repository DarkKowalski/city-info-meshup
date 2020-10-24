// @ts-nocheck
import Vue from 'vue';
import App from './App.vue';
import store from './store';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

const locale: any = require('element-ui/lib/locale/lang/en');
Vue.use(ElementUI, { locale });
Vue.config.productionTip = false;

new Vue({
  store,
  render: (h) => h(App),
}).$mount('#app');
