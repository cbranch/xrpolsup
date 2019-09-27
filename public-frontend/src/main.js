import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import './plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import SubmitReport from './SubmitReport.vue'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)

new Vue({
  render: h => h(SubmitReport),
}).$mount('#app')
