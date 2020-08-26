<template>
  <div class="container">
    <h1>Login</h1>
    <div v-if="$store.state.loggedIn">
      <p>Logged in as <b>{{ $store.state.username }}</b></p>
      <b-form-group>
        <b-button v-on:click="logOut">Log out</b-button>
      </b-form-group>
      <h2>Change password</h2>
      <b-form @submit.prevent="changePassword">
        <b-form-group label="Current password" label-cols="2" label-align="right">
          <b-form-input v-model="password" type="password"></b-form-input>
        </b-form-group>
        <b-form-group label="New password" label-cols="2" label-align="right">
          <b-form-input v-model="newPassword" type="password"></b-form-input>
        </b-form-group>
        <b-form-group label="Repeat new password" label-cols="2" label-align="right">
          <b-form-input v-model="newPassword2" type="password" :state="isValidNewPassword"></b-form-input>
          <b-form-invalid-feedback :state="isValidNewPassword">
            The password does not match.
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group label-cols="2">
          <b-button type="submit">Change password</b-button>
        </b-form-group>
      </b-form>
    </div>
    <div v-else>
      <b-modal id="gdpr-modal" title="GDPR notice" ok-only ok-title="Agree" @ok="submitReal">
        <p class="my-4">By logging into and using the ArrestWatch backoffice, you agree to abide by our data collection and processing policies for GDPR compliance.</p>
      </b-modal>
      <b-form @submit.prevent="submit">
        <b-form-group label="Username" label-cols="2" label-align="right">
          <b-form-input v-model="username"></b-form-input>
        </b-form-group>
        <b-form-group label="Password" label-cols="2" label-align="right">
          <b-form-input v-model="password" type="password"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="2">
          <b-button type="submit">Log in</b-button>
        </b-form-group>
      </b-form>
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
      newPassword: "",
      newPassword2: "",
      error: null,
      gdprShown: false,
    }
  },
  computed: {
    isValidNewPassword() {
      if (this.newPassword2 == "") {
        return null
      }
      return this.newPassword == this.newPassword2
    }
  },
  methods: {
    submit () {
      if (!this.gdprShown) {
        this.$root.$emit('bv::show::modal', 'gdpr-modal')
        this.gdprShown = true
      } else {
        this.submitReal()
      }
    },
    submitReal() {
      const body = { username: this.username, password: this.password }
      this.password = ""
      this.axios.post('/api/v1/login', body).then((res) => {
        this.$store.commit('logIn', res.data)
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
    changePassword () {
      this.$io.socket.put('/api/v1/user/change_password', { oldPassword: this.password, newPassword: this.newPassword }, (resData, jwRes) => {
        this.password = ""
        this.newPassword = ""
        this.newPassword2 = ""
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast('Password updated', {
            title: 'User management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to update password: ' + jwRes.headers['x-exit-description'], {
            title: 'User management',
            variant: 'warning',
            solid: true
          })
        }
      })
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