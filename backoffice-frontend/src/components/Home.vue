<template>
  <b-container fluid>
    <h2>Report list</h2>
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
      sort-by="arrestTime">
      <template v-slot:cell(createdAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(arrestTime)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(concerns)="data">
        <div v-if="data.item.concernMentalDistress">Mental distress</div>
        <div v-if="data.item.concernPhysicalDistress">Physical distress</div>
        <div v-if="data.item.concernMinor">Minor</div>
        <div v-if="data.item.concernPoliceBehaviour">Police behaviour</div>
        <div v-if="data.item.concernPolicePrejudice">Police prejudice</div>
        <div v-if="data.item.concernMedicationNeed">Medication need: {{ data.item.medicationName }}</div>
      </template>
      <template v-slot:cell(actions)="data">
        <b-button size="sm" @click="editReport(data.item, $event.target)">Edit</b-button>
      </template>
    </b-table>
    <b-modal id="editReportModal" title="Edit report" size="lg" @ok="commitEditReport">
      <b-container fluid>
        <b-row>
          <b-col>
            <b-form-group label="Station" label-for="input-station" label-cols-md="3">
              <b-form-input id="input-station" v-model="editReportModal.station"></b-form-input>
            </b-form-group>
            <b-form-group label="Arrest Time" label-for="input-arrestTime" label-cols-md="3">
              <b-form-input id="input-arrestTime" v-model="editReportModal.arrestTime"></b-form-input>
            </b-form-group>
            <b-form-group label="Location" label-for="input-location" label-cols-md="3">
              <b-form-input id="input-location" v-model="editReportModal.location"></b-form-input>
            </b-form-group>
            <b-form-group label="Name" label-for="input-name" label-cols-md="3">
              <b-form-input id="input-name" v-model="editReportModal.name"></b-form-input>
            </b-form-group>
            <b-form-group label="Officer ID" label-for="input-arrestingOfficerId" label-cols-md="3">
              <b-form-input id="input-arrestingOfficerId" v-model="editReportModal.arrestingOfficerId"></b-form-input>
            </b-form-group>
          </b-col>
        </b-row>
        <b-row>
          <b-col md="3">
            <p>Concerns</p>
          </b-col>
          <b-col>
            <b-form-checkbox v-model="editReportModal.concernMentalDistress">Mental distress?</b-form-checkbox>
            <b-form-checkbox v-model="editReportModal.concernPhysicalDistress">Physical distress?</b-form-checkbox>
            <b-form-checkbox v-model="editReportModal.concernMinor">Minor</b-form-checkbox>
            <b-form-checkbox v-model="editReportModal.concernPoliceBehaviour">Police behaviour?</b-form-checkbox>
            <b-form-checkbox v-model="editReportModal.concernPolicePrejudice">Police prejudice?</b-form-checkbox>
            <b-form-checkbox v-model="editReportModal.concernMedicationNeed">Medication need stated by arrestee?</b-form-checkbox>
          </b-col>
        </b-row>
        <b-row>
          <b-col>
            <b-form-group label="Medication Name" label-for="input-medicationName" label-cols-md="3">
              <b-form-input id="input-medicationName" v-model="editReportModal.medicationName"></b-form-input>
            </b-form-group>
            <b-form-group label="Observations" label-for="input-observations" label-cols-md="3">
              <b-form-input id="input-observations" v-model="editReportModal.observations"></b-form-input>
            </b-form-group>
            <b-form-group label="Witness" label-for="input-witness" label-cols-md="3">
              <b-form-input id="input-witness" v-model="editReportModal.witness"></b-form-input>
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
      editReportModal: {
        id: null,
        station: null,
        arrestTime: null,
        location: null,
        name: null,
        arrestingOfficerId: null,
        concernMentalDistress: false,
        concernPhysicalDistress: false,
        concernMinor: false,
        concernPoliceBehaviour: false,
        concernPolicePrejudice: false,
        concernMedicationNeed: false,
        medicationName: null,
        observations: null,
        witness: null,
      }
    }
  },
  computed: {
    reportFields () {
      return [
        { key: 'createdAt', label: 'Reported at', sortable: true },
        { key: 'arrestTime', label: 'Arrest time', sortable: true },
        { key: 'station' },
        { key: 'location' },
        { key: 'name' },
        { key: 'arrestingOfficerId', label: 'Officer ID' },
        { key: 'concerns' },
        { key: 'observations' },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      return this.$store.state.reports
    }
  },
  methods: {
    editReport (item, target) {
      this.editReportModal = Object.assign({}, item)
      this.$root.$emit('bv::show::modal', 'editReportModal', target)
    },
    commitEditReport () {
      this.$io.socket.put('/report/' + this.editReportModal.id, this.editReportModal, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$store.commit('setReport', resData)
          this.$bvToast.toast('Report updated!', {
            title: 'Report management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to update report: ' + jwRes, {
            title: 'Report management',
            variant: 'warning',
            solid: true
          })
        }
      })
    }
  }
}
</script>