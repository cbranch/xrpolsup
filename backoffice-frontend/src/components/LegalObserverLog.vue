<template>
  <b-container fluid>
    <h2>Legal Observer log</h2>
    <b-button block variant="primary" class="my-2" @click="addCallLog($event.target)">Add log</b-button>
    <b-form-group
      label="Filter"
      label-cols-sm="2"
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
          <b-form-checkbox class="mx-4" v-model="showHidden">Show deleted</b-form-checkbox>
        </b-input-group-append>
      </b-input-group>
    </b-form-group>
    <b-pagination
      v-model="currentPage"
      :total-rows="rows"
      :per-page="perPage"
      aria-controls="calllog-table"
      align="center"
    ></b-pagination>
    <b-table striped hover
      id="calllog-table"
      :items="reportList"
      :fields="reportFields"
      :filter="filter"
      :per-page="perPage"
      :current-page="currentPage"
      :tbody-tr-class="rowClass"
      primary-key="id"
      sort-by="createdAt"
      sort-desc>
      <template v-slot:cell(createdAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(onShift)="data">
        {{ data.value ? "On shift" : "Off shift" }}
      </template>
      <template v-slot:cell(actions)="data">
        <b-button size="sm" @click="editCallLog(data.item, $event.target)">Edit</b-button>
      </template>
    </b-table>
    <b-modal id="callLogModal" title="Edit legal observer log" size="lg" @ok="commitCallLog" @hide="hideCallLog">
      <template v-slot:modal-footer="{ ok, cancel, hide }">
        <b-button variant="primary" @click="ok()">OK</b-button>
        <b-button variant="secondary" @click="cancel()">Cancel</b-button>
        <b-button variant="outline-danger" @click="hide('delete')">Delete</b-button>
      </template>
      <template v-slot:default="">
      <b-container fluid>
        <b-row>
          <b-col>
            <b-form-group label="Name" label-for="input-name" label-cols-md="3">
              <b-form-input id="input-name" v-model="callLogModal.name"></b-form-input>
            </b-form-group>
            <b-form-group label="Phone" label-for="input-phone" label-cols-md="3">
              <b-form-input id="input-phone" v-model="callLogModal.phone"></b-form-input>
            </b-form-group>
            <b-form-radio-group v-model="callLogModal.onShift">
              <b-form-radio value="true">Going on shift</b-form-radio>
              <b-form-radio value="false">Off shift</b-form-radio>
            </b-form-radio-group>
          </b-col>
        </b-row>
      </b-container>
      </template>
    </b-modal>
  </b-container>
</template>

<script>
export default {
  data () {
    return {
      perPage: 50,
      currentPage: 1,
      filter: null,
      showHidden: false,
      callLogModal: {
        id: null,
        name: null,
        phone: null,
        onShift: null,
        isHidden: null,
      }
    }
  },
  computed: {
    reportFields () {
      return [
        { key: 'createdAt', sortable: true },
        { key: 'name', sortable: true },
        { key: 'phone', sortable: true },
        { key: 'onShift', label: 'Shift', sortable: true },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      return this.$store.state.legalObserverLogs.filter((x) => x.isHidden == this.showHidden)
    },
    rows () {
      return this.reportList.length
    }
  },
  methods: {
    rowClass (item) {
      if (!item) return
      if (item.onShift) return 'table-success'
      return 'table-danger'
    },
    addCallLog (target) {
      this.callLogModal.id = null
      this.callLogModal.name = ""
      this.callLogModal.phone = ""
      this.callLogModal.onShift = true
      this.callLogModal.isHidden = false
      this.$root.$emit('bv::show::modal', 'callLogModal', target)
    },
    editCallLog (item, target) {
      this.callLogModal = Object.assign({}, item)
      this.$root.$emit('bv::show::modal', 'callLogModal', target)
    },
    commitCallLog () {
      if (this.callLogModal.id !== null) {
        this.$io.socket.put('/api/v1/legalobserverlog/' + this.callLogModal.id, this.callLogModal, (resData, jwRes) => {
          if (jwRes.statusCode == 200) {
            this.$store.commit('setLegalObserverLog', resData)
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
        this.$io.socket.post('/api/v1/legalobserverlog', this.callLogModal, (resData, jwRes) => {
          if (jwRes.statusCode == 200) {
            this.$store.commit('addLegalObserverLog', resData)
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
    },
    hideCallLog (event) {
      if (event.trigger == "delete") {
        this.callLogModal.isHidden = true
        this.commitCallLog()
      }
    }
  }
}
</script>