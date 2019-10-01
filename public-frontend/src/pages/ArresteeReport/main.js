import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import Vuex from 'vuex'
import '../../plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import ArresteeReport from './App.vue'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    stationName: "",
    witnessEmail: "",
    arresteeCount: 0,
  },
  mutations: {
    setStationName(state, x) {
      state.stationName = x
    },
    setWitnessEmail(state, x) {
      state.witnessEmail = x
    },
    setArresteeCount(state, x) {
      state.arresteeCount = x
    }
  }
})

new Vue({
  render: h => h(ArresteeReport),
  store,
}).$mount('#app')