import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import '../../plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import KillSwitch from './KillSwitch.vue'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)

new Vue({
  render: h => h(KillSwitch),
}).$mount('#app')