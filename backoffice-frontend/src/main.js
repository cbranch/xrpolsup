import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue'
import Vuex from 'vuex'
import './plugins/bootstrap-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import sailsIO from 'sails.io.js'
import socketIO from 'socket.io-client'
import App from './App.vue'
import router from './router.js'

Vue.config.productionTip = false

Vue.use(Vuex)
Vue.use(VueAxios, axios)

const store = new Vuex.Store({
  state: {
    loggedIn: false,
    reports: []
  },
  mutations: {
    setReports(state, x) {
      state.reports = x
    },
    addReport(state, x) {
      state.reports.push(x)
    },
    logIn(state) {
      state.loggedIn = true
    },
    logOut(state) {
      state.loggedIn = false
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
