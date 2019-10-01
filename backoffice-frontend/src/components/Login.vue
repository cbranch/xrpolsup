<template>
  <div class="container">
    <h1>Login</h1>
    <b-form-group label="Email" label-cols="2" label-align="right">
      <b-form-input v-model="email" placeholder="rebel@example.com"></b-form-input>
    </b-form-group>
    <b-form-group label="Password" label-cols="2" label-align="right">
      <b-form-input v-model="password" type="password"></b-form-input>
    </b-form-group>
    <b-form-group label-cols="2">
      <b-button v-on:click="submit">Log in</b-button>
    </b-form-group>
    <b-alert :show="error != null">{{ error }}</b-alert>
  </div>
</template>

<script>
export default {
  data () {
    return {
      email: "",
      password: "",
      error: null,
    }
  },
  methods: {
    submit () {
      this.axios.post('/api/login', { emailAddress: this.email, password: this.password }).then(() => {
        this.$store.commit('logIn')
        this.$router.go(-1)
      }).catch(error => {
        if (error.response.status == 401) {
          this.error = "Incorrect email and password combination."
        } else {
          this.error = error
        }
      })
    }
  }
}
</script>