<template>
  <b-container fluid>
    <h2>Call log</h2>
    <b-button block variant="primary" class="my-2" @click="addCallLog($event.target)">Add log</b-button>
    <b-form-group
      label="Filter"
      label-cols-sm="2"
      label-align-sm="right"
      label-size="sm"
      label-for="filterInput"
      class="mb-0"
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
    <b-table striped hover
      :items="reportList"
      :fields="reportFields"
      :filter="filter"
      sort-by="updatedAt">
      <template v-slot:cell(updatedAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(actions)="data">
        <b-button size="sm" @click="editCallLog(data.item, $event.target)">Edit</b-button>
      </template>
    </b-table>
    <b-modal id="callLogModal" title="Edit report" size="lg" @ok="commitCallLog">
      <b-container fluid>
        <b-row>
          <b-col>
            <b-form-group label="Comment" label-for="input-comment" label-cols-md="3">
              <b-form-textarea id="input-comment" v-model="callLogModal.comment" rows="3" max-rows="10"></b-form-textarea>
            </b-form-group>
          </b-col>
        </b-row>
      </b-container>
    </b-modal>
  </b-container>
</template>

<script>
export default {
  data () {
    return {
      filter: null,
      callLogModal: {
        id: null,
        comment: null,
      }
    }
  },
  computed: {
    reportFields () {
      return [
        { key: 'updatedAt', sortable: true },
        { key: 'comment', sortable: true },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      return this.$store.state.callLogs
    }
  },
  methods: {
    addCallLog (target) {
      this.callLogModal.id = null
      this.callLogModal.comment = ""
      this.$root.$emit('bv::show::modal', 'callLogModal', target)
    },
    editCallLog (item, target) {
      this.callLogModal.id = item.id
      this.callLogModal.comment = item.comment
      this.$root.$emit('bv::show::modal', 'callLogModal', target)
    },
    commitCallLog () {
      var postData = {comment: this.callLogModal.comment}
      if (this.callLogModal.id !== null) {
        this.$io.socket.put('/api/v1/calllog/' + this.callLogModal.id, postData, (resData, jwRes) => {
          if (jwRes.statusCode == 200) {
            this.$store.commit('setCallLog', resData)
            this.$bvToast.toast('Log updated!', {
              title: 'Call log management',
              variant: 'primary',
              solid: true
            })
          } else {
            this.$bvToast.toast('Failed to update log: ' + jwRes, {
              title: 'Call log management',
              variant: 'warning',
              solid: true
            })
          }
        })
      } else {
        this.$io.socket.post('/api/v1/calllog', postData, (resData, jwRes) => {
          if (jwRes.statusCode == 200) {
            this.$store.commit('addCallLog', resData)
            this.$bvToast.toast('Log created!', {
              title: 'Call log management',
              variant: 'primary',
              solid: true
            })
          } else {
            this.$bvToast.toast('Failed to create log: ' + jwRes, {
              title: 'Call log management',
              variant: 'warning',
              solid: true
            })
          }
        })
      }
    }
  }
}
</script>