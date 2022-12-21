<template>
  <b-container fluid>
    <h2>Admin</h2>
    <p v-if="$store.state.isSuperuser">
      <b-button :pressed="$store.state.suspended" variant="danger" @click="toggleSuspend">Suspend back office</b-button>
      <span v-if="$store.state.suspended"><strong>The back office is suspended!</strong> Only superusers may view and resume operations.</span>
      <span v-else>The back office is currently available to all users.</span>
    </p>
    <b-alert :show="isAuthorized === false" variant="warning">You aren't authorized to view users</b-alert>
    <b-form-group
      label="Filter"
      label-cols-sm="1"
      label-align-sm="right"
      label-size="sm"
      label-for="filterInput"
      class="mb-2"
    >
      <b-input-group size="sm">
        <b-form-input
          v-model="filter"
          type="search"
          id="filterInput"
          placeholder="Type to Search"
        ></b-form-input>
        <b-input-group-append>
          <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
        </b-input-group-append>
      </b-input-group>
    </b-form-group>
    <b-pagination
      v-model="currentPage"
      :total-rows="rows"
      :per-page="perPage"
      aria-controls="user-table"
      align="center"
    ></b-pagination>
    <b-table striped hover
      id="user-table"
      :items="users"
      :fields="userFields"
      :filter="filter"
      :per-page="perPage"
      :current-page="currentPage"
      primary-key="id">
      <template v-slot:cell(createdAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' }) }}
      </template>
      <template v-slot:cell(updatedAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' }) }}
      </template>
      <template v-slot:cell(lastSeenAt)="data">
        {{ data.value == 0 ? "Never" : new Date(data.value).toLocaleDateString('en-GB', { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' }) }}
      </template>
      <template v-slot:cell(actions)="row">
        <b-button size="sm" @click="showEditUserModal(row.item, $event.target)" class="mr-1">
          Edit
        </b-button>
        <b-button size="sm" @click="setPassword(row.item, $event.target)" class="mr-1">
          Set password
        </b-button>
        <b-button size="sm" @click="showDeleteUserModal(row.item, $event.target)">
          Delete
        </b-button>
      </template>
    </b-table>
    <p>
      <b-button @click="showAddUserModal($event.target)">
        Add user
      </b-button>
    </p>
    <!-- Set password modal -->
    <b-modal :id="passwordModal.id" title="Set password" @ok="reallySetPassword">
      <p>Change password for {{ passwordModal.userName }}</p>
      <p><b-form-input v-model="passwordModal.newPassword" type="password"></b-form-input></p>
    </b-modal>
    <!-- Add user modal -->
    <b-modal id="addUserModal" title="Add new user" @ok="addUser">
      <b-form-group label="Username" label-for="input-username">
        <b-form-input id="input-username" v-model="addUserModal.username"></b-form-input>
      </b-form-group>
      <b-form-group label="Password" label-for="input-password">
        <b-form-input type="password" id="input-password" v-model="addUserModal.password"></b-form-input>
      </b-form-group>
      <b-form-group label="Nickname" label-for="input-nickname">
        <b-form-input id="input-nickname" v-model="addUserModal.nickname" placeholder="(optional)"></b-form-input>
      </b-form-group>
      <p><b-form-checkbox id="input-admin" v-model="addUserModal.isAdmin">Admin (can manage users)</b-form-checkbox></p>
      <p><b-form-checkbox id="input-canviewrelease" v-model="addUserModal.canViewRelease">Can view release form</b-form-checkbox></p>
    </b-modal>
    <!-- Edit user modal -->
    <b-modal id="editUserModal" title="Edit user" @ok="editUser">
      <p>Username: {{ editUserModal.username }}</p>
      <b-form-group label="Nickname" label-for="input-nickname">
        <b-form-input id="input-nickname" v-model="editUserModal.nickname" placeholder="(optional)"></b-form-input>
      </b-form-group>
      <p><b-form-checkbox id="input-canviewrelease" v-model="editUserModal.canViewRelease">Can view release form</b-form-checkbox></p>
    </b-modal>
    <!-- Edit user modal -->
    <b-modal id="deleteUserModal" title="Delete user" @ok="deleteUser">
      <p>Really delete?</p>
      <p>{{ deleteUserModal.username }}</p>
    </b-modal>
  </b-container>
</template>

<script>
export default {
  data: () => ({
    isAuthorized: null,
    perPage: 50,
    currentPage: 1,
    filter: null,
    users: [],
    passwordModal: {
      id: 'password-modal',
      userId: null,
      userName: "",
      newPassword: "",
    },
    addUserModal: {
      username: '',
      password: '',
      nickname: '',
      isAdmin: false,
      canViewRelease: false,
    },
    editUserModal: {
      id: null,
      username: '',
      nickname: '',
      canViewRelease: false,
    },
    deleteUserModal: {
      id: null,
      username: '',
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
        { key: 'isSuperuser', sortable: true },
        { key: 'canViewRelease', label: 'Post-release', sortable: true },
        { key: 'lastSeenAt', sortable: true },
        { key: 'actions' },
      ]
    },
    rows () {
      return this.users.length
    }
  },
  created () {
    this.getUsers()
  },
  methods: {
    setPassword(user, target) {
      this.passwordModal.userId = user.id
      this.passwordModal.userName = user.nickname
      this.$root.$emit('bv::show::modal', this.passwordModal.id, target)
    },
    reallySetPassword() {
      this.$io.socket.put('/api/v1/user/' + this.passwordModal.userId + '/set_password', { password: this.passwordModal.newPassword }, (resData, jwRes) => {
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
    },
    clearAddUserData() {
      this.addUserModal.username = ''
      this.addUserModal.password = ''
      this.addUserModal.nickname = ''
      this.addUserModal.isAdmin = false
      this.addUserModal.canViewRelease = false
    },
    showAddUserModal(target) {
      this.clearAddUserData()
      this.$root.$emit('bv::show::modal', 'addUserModal', target)
    },
    addUser() {
      const postData = {
        username: this.addUserModal.username,
        password: this.addUserModal.password,
        nickname: this.addUserModal.nickname,
        isAdmin: this.addUserModal.isAdmin,
        canViewRelease: this.addUserModal.canViewRelease,
      }
      this.clearAddUserData()
      this.$io.socket.post('/api/v1/user', postData, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast('New user created!', {
            title: 'User management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to create user: ' + jwRes, {
            title: 'User management',
            variant: 'warning',
            solid: true
          })
        }
        this.getUsers()
      })
    },
    getUsers() {
      this.$io.socket.get('/api/v1/user', {limit: 10000}, (resData, jwRes) => {
        if (jwRes.statusCode == 403) {
          this.isAuthorized = false
        } else {
          this.users = resData
        }
      })
    },
    showEditUserModal(user, target) {
      this.editUserModal.id = user.id
      this.editUserModal.username = user.username
      this.editUserModal.nickname = user.nickname
      this.editUserModal.canViewRelease = user.canViewRelease
      this.$root.$emit('bv::show::modal', 'editUserModal', target)
    },
    editUser() {
      const postData = {
        nickname: this.editUserModal.nickname,
        canViewRelease: this.editUserModal.canViewRelease,
      }
      this.clearAddUserData()
      this.$io.socket.patch('/api/v1/user/' + this.editUserModal.id, postData, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast('User updated!', {
            title: 'User management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to update user: ' + jwRes, {
            title: 'User management',
            variant: 'warning',
            solid: true
          })
        }
        this.getUsers()
      })
    },
    showDeleteUserModal(user, target) {
      this.deleteUserModal.id = user.id
      this.deleteUserModal.username = user.username
      this.$root.$emit('bv::show::modal', 'deleteUserModal', target)
    },
    deleteUser() {
      this.$io.socket.request({method: 'delete', url: '/api/v1/user/' + this.deleteUserModal.id}, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast('User deleted!', {
            title: 'User management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to delete user: ' + jwRes, {
            title: 'User management',
            variant: 'warning',
            solid: true
          })
        }
        this.getUsers()
      })
    },
    toggleSuspend() {
      const newState = !this.$store.state.suspended
      const suspendState = newState ? "suspended" : "unsuspended";
      this.$io.socket.put('/api/v1/setting/suspend', {value: newState}, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$bvToast.toast(`Back office ${suspendState}!`, {
            title: 'Admin',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast(`Failed to ${suspendState}: ${jwRes}`, {
            title: 'Admin',
            variant: 'warning',
            solid: true
          })
        }
        this.$store.commit('setSuspended', newState)
      })
    }
  }
}
</script>