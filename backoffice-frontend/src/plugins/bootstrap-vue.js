import Vue from 'vue'

import BootstrapVue from 'bootstrap-vue'
if (process.env.NODE_ENV === 'production') {
    require('./bootstrap-vue-production.scss')
} else {
    require('./bootstrap-vue-staging.scss')
}

Vue.use(BootstrapVue)
