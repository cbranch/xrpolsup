import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import Vuex from 'vuex'
import '../../plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import Autocomplete from '@trevoreyre/autocomplete-vue'
import '@trevoreyre/autocomplete-vue/dist/style.css'
import WitnessReport from './App.vue'

Vue.config.productionTip = false
Vue.use(VueAxios, axios)

Vue.use(Vuex)
Vue.use(Autocomplete)

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
  render: h => h(WitnessReport),
  store,
}).$mount('#app')