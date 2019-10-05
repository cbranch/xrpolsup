<template>
  <div>
    <b-navbar toggleable="md" type="dark" variant="primary">
      <b-nav-toggle target="nav_collapse"></b-nav-toggle>

      <b-navbar-brand :to="{ name: 'Home'}">
        <span>Arrestee Support</span>
      </b-navbar-brand>

      <b-collapse is-nav id="nav_collapse">
        <b-navbar-nav>
          <b-nav-item :to="{ name: 'Home' }">Home</b-nav-item>
          <b-nav-item :to="{ name: 'Reports' }">Reports</b-nav-item>
          <b-nav-item :to="{ name: 'Release' }">Post-release</b-nav-item>
          <b-nav-item :to="{ name: 'Users' }">Users</b-nav-item>
          <b-nav-item :to="{ name: 'Login' }" v-if="!$store.state.loggedIn">Login</b-nav-item>
          <b-nav-item :to="{ name: 'Login' }" v-if="$store.state.loggedIn">Logout</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <b-container fluid>
      <b-alert :show="isConnected === false" variant="warning">Connection lost with the server. Refresh to re-establish connection.</b-alert>
      <router-view class="mt-4"></router-view>
    </b-container>
    <footer class="mt-3 text-center">
      <div class="container">
        <span class="text-muted">
          <small>
            For help, contact:
          </small>
        </span>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'app',
  data: () => ({
    io: null,
    isConnected: null,
  }),
  watch: {
    '$store.state.loggedIn': 'connectState'
  },
  created () {
    this.connectState()
  },
  methods: {
    connectState () {
      if (!this.$io.socket.isConnected() && !this.$io.socket.mightBeAboutToAutoConnect()) {
        this.$io.socket.reconnect()
      }
      this.$io.socket.on('connect', () => {
        this.isConnected = true
      })
      this.$io.socket.on('disconnect', () => {
        this.isConnected = false
      })
      this.$io.socket.get('/api/v1/report', (resData, jwRes) => {
        if (jwRes.statusCode == 401) {
          this.$router.push('login')
          this.$io.socket.disconnect()
        } else if (jwRes.statusCode == 200) {
          this.$store.commit('setReports', resData)
          this.$io.socket.on('report', (e) => {
              if (e.verb === 'created') {
                  this.$store.commit('addReport', e.data)
              }
          })

          this.$io.socket.get('/api/v1/release', (resData, jwRes) => {
            if (jwRes.statusCode != 200) {
              return
            }
            this.$store.commit('setReleases', resData)
            this.$io.socket.on('release', (e) => {
              if (e.verb === 'created') {
                this.$store.commit('addRelease', e.data)
              }
            })
          })
        }
      })
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
