import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import Vuex from 'vuex'
import './plugins/bootstrap-vue'
import sailsIO from 'sails.io.js'
import socketIO from 'socket.io-client'
import App from './App.vue'
import router from './router.js'

Vue.config.productionTip = false

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    reports: []
  },
  mutations: {
    setReports(state, x) {
      state.reports = x
    },
    addReport(state, x) {
      state.reports.push(x)
    }
  }
})

const isProductionEnvironment = (process.env.NODE_ENV === 'production')
let url
if (isProductionEnvironment) {
  url = `${location.protocol}//${location.hostname}${location.port ? ':' + location.port : ''}`
} else url = 'http://localhost:1337'

let io = sailsIO(socketIO)
io.sails.url = url
io.sails.environment = process.env.NODE_ENV || 'development'
//io.sails.useCORSRouteToGetCookie = false

Vue.prototype.$io = io

new Vue({
  render: h => h(App),
  router,
  store,
}).$mount('#app')
