<template>
  <div class="container">
    <h1>Login</h1>
    <div v-if="$store.state.loggedIn">
      <p>Logged in as {{ $store.state.username }}</p>
      <b-form-group label-cols="2">
        <b-button v-on:click="logOut">Log out</b-button>
      </b-form-group>
    </div>
    <div v-else>
      <b-form-group label="Username" label-cols="2" label-align="right">
        <b-form-input v-model="username"></b-form-input>
      </b-form-group>
      <b-form-group label="Password" label-cols="2" label-align="right">
        <b-form-input v-model="password" type="password"></b-form-input>
      </b-form-group>
      <b-form-group label-cols="2">
        <b-button v-on:click="submit">Log in</b-button>
      </b-form-group>
    </div>
    <b-alert :show="error != null">{{ error }}</b-alert>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: "",
      password: "",
      error: null,
    }
  },
  methods: {
    submit () {
      this.axios.post('/api/v1/login', { username: this.username, password: this.password }).then(() => {
        this.$store.commit('logIn', this.username)
        this.$router.push('/')
      }).catch(error => {
        if (error.response.status == 401) {
          this.error = "Incorrect username and password combination."
        } else {
          this.error = error
        }
      })
      this.password = ''
    },
    logOut () {
      this.axios.post('/api/v1/logout', { }).then(() => {
        this.$store.commit('logOut')
      }).catch(error => {
        this.error = error
      })
    }
  }
}
</script>