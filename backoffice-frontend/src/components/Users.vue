<template>
  <b-container fluid>
    <h2>Users</h2>
    <b-alert :show="isAuthorized === false" variant="warning">You aren't authorized to view users</b-alert>
    <b-table striped hover :items="users" :fields="userFields">
      <template v-slot:cell(createdAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' }) }}
      </template>
      <template v-slot:cell(updatedAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' }) }}
      </template>
      <template v-slot:cell(actions)="row">
        <b-button size="sm" @click="setPassword(row.item, $event.target)" class="mr-1">
          Set password
        </b-button>
        <b-button size="sm" @click="deleteUser(row.item)">
          Delete
        </b-button>
      </template>
    </b-table>
    <!-- Set password modal -->
    <b-modal :id="passwordModal.id" title="Set password" @ok="reallySetPassword">
      <p>Change password for {{ passwordModal.userName }}</p>
      <p><b-form-input v-model="passwordModal.newPassword" type="password"></b-form-input></p>
    </b-modal>
  </b-container>
</template>

<script>
export default {
  data: () => ({
    isAuthorized: null,
    users: [],
    passwordModal: {
      id: 'password-modal',
      userId: null,
      userName: "",
      newPassword: "",
    }
  }),
  computed: {
    userFields () {
      return [
        { key: 'id', sortable: true },
        { key: 'createdAt', sortable: true },
        { key: 'updatedAt', sortable: true },
        { key: 'username', sortable: true },
        { key: 'nickname', sortable: true },
        { key: 'isAdmin', sortable: true },
        { key: 'actions' },
      ]
    }
  },
  created () {
    this.$io.socket.get('/user', (resData, jwRes) => {
      if (jwRes.statusCode == 401) {
        this.isAuthorized = false
      } else {
        this.users = resData
      }
    })
  },
  methods: {
    setPassword(user, target) {
      this.passwordModal.userId = user.id
      this.passwordModal.userName = user.nickname
      this.$root.$emit('bv::show::modal', this.passwordModal.id, target)
    },
    reallySetPassword() {
      this.$io.socket.put('/user/' + this.passwordModal.userId + '/set_password', { password: this.passwordModal.newPassword }, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast('Password updated', {
            title: 'User management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to update password: ' + jwRes, {
            title: 'User management',
            variant: 'warning',
            solid: true
          })
        }
      })
    }
  }
}
</script>