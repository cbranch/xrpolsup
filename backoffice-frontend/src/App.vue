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
          <b-nav-item :to="{ name: 'Login' }">Login</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <b-container fluid>
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
    io: null
  }),
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
