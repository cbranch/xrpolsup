import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import '../../plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import PleaHearing from './App.vue'
import VueScrollTo  from 'vue-scrollto'
import Datetime from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)
Vue.use(VueScrollTo)
Vue.use(Datetime)

new Vue({
  render: h => h(PleaHearing),
}).$mount('#app')