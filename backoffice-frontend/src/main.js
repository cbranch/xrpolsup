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
import Datetime from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'
import AsyncComputed from 'vue-async-computed'

Vue.config.productionTip = false

Vue.use(Vuex)
Vue.use(VueAxios, axios)
Vue.use(Datetime)
Vue.use(AsyncComputed)

var filterDateStart = new Date(Date.now() - 1000*60*60*24)
filterDateStart.setMinutes(0, 0, 0)

const store = new Vuex.Store({
  state: {
    loggedIn: false,
    userId: null,
    username: null,
    nickname: null,
    filterDateStart,
    reports: [],
    releases: [],
    legalObserverLogs: [],
    callLogs: []
  },
  mutations: {
    setReport(state, x) {
      for (var i in state.reports) {
        if (state.reports[i].id == x.id) {
          Object.assign(state.reports[i], x)
          return
        }
      }
      state.reports.push(x)
    },
    setReports(state, x) {
      state.reports = x
    },
    addReport(state, x) {
      state.reports.push(x)
    },
    setRelease(state, x) {
      for (var i in state.releases) {
        if (state.releases[i].id == x.id) {
          Object.assign(state.releases[i], x)
          return
        }
      }
      state.releases.push(x)
    },
    setReleases(state, x) {
      state.releases = x
    },
    addRelease(state, x) {
      state.releases.push(x)
    },
    setLegalObserverLog(state, x) {
      for (var i in state.legalObserverLogs) {
        if (state.legalObserverLogs[i].id == x.id) {
          Object.assign(state.legalObserverLogs[i], x)
          return
        }
      }
      state.legalObserverLogs.push(x)
    },
    setLegalObserverLogs(state, x) {
      state.legalObserverLogs = x
    },
    addLegalObserverLog(state, x) {
      state.legalObserverLogs.push(x)
    },
    setCallLog(state, x) {
      for (var i in state.callLogs) {
        if (state.callLogs[i].id == x.id) {
          Object.assign(state.callLogs[i], x)
          return
        }
      }
      state.callLogs.push(x)
    },
    setCallLogs(state, x) {
      state.callLogs = x
    },
    addCallLog(state, x) {
      state.callLogs.push(x)
    },
    logIn(state, user) {
      state.loggedIn = true
      state.userId = user.id
      state.username = user.username
      state.nickname = user.nickname || user.username
    },
    logOut(state) {
      state.loggedIn = false
      state.userId = null
      state.username = null
      state.nickname = null
    },
    setFilterDateStart(state, date) {
      state.filterDateStart = date
    }
  },
  getters: {
    filteredReports(state) {
      return state.reports.filter(report => report.updatedAt > state.filterDateStart)
    },
    filteredReleases(state) {
      return state.releases.filter(release => release.updatedAt > state.filterDateStart)
    },
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
io.sails.reconnection = true
//io.sails.useCORSRouteToGetCookie = false

Vue.prototype.$io = io

new Vue({
  render: h => h(App),
  router,
  store,
}).$mount('#app')
