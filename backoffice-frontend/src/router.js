import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
          path: '/',
          name: 'Home',
          component: resolve => {
            require(['./components/Home.vue'], resolve)
          }
        },
        {
          path: '/login',
          name: 'Login',
          component: resolve => {
            require(['./components/Login.vue'], resolve)
          }
        },
    ],
    linkExactActiveClass: "active"
})