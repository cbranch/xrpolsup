<template>
  <b-container fluid>
    <h2>Report list</h2>
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
          <b-form-checkbox class="mx-4" v-model="showHidden">Show deleted</b-form-checkbox>
        </b-input-group-append>
      </b-input-group>
      <b-input-group size="sm">
        <multiselect
          v-model="selectedStations"
          :options="stationList"
          :multiple="true"
          :close-on-select="true"
          placeholder="Filter by station"
          group-label="region"
          group-values="stations"
          :group-select="true"
          ></multiselect>
      </b-input-group>
    </b-form-group>
    <b-pagination
      v-model="currentPage"
      :total-rows="rows"
      :per-page="perPage"
      aria-controls="report-table"
      align="center"
    ></b-pagination>
    <b-table striped hover
      id="report-table"
      :items="reportList"
      :fields="reportFields"
      :filter="compositeFilter"
      :filter-function="filterTable"
      :per-page="perPage"
      :current-page="currentPage"
      primary-key="id"
      sort-by="arrestTime">
      <template v-slot:cell(index)="data">
        {{ data.index + 1 + ((currentPage - 1) * perPage) }}
      </template>
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
      <template v-slot:cell(comment)="data">
        <b-button v-if="data.item.comment" v-b-popover.hover.top="data.item.comment" title="Comment" size="sm">
          Show
        </b-button>
      </template>
      <template v-slot:cell(actions)="data">
        <b-button size="sm" @click="editReport(data.item, $event.target)">Edit</b-button>
      </template>
    </b-table>
    <b-modal id="editReportModal" title="Edit report" size="lg" @ok="commitEditReport" @hide="hideEditReport" scrollable>
      <template v-slot:modal-footer="{ ok, cancel, hide }">
        <b-button variant="primary" @click="ok()">OK</b-button>
        <b-button variant="secondary" @click="cancel()">Cancel</b-button>
        <b-button variant="outline-danger" @click="hide('delete')">Delete</b-button>
      </template>
      <template v-slot:default="">
      <b-container fluid>
        <b-row>
          <b-col>
            <b-form-group label="Station" label-for="input-station" label-cols-md="3">
              <b-form-input id="input-station" v-model="editReportModal.station"></b-form-input>
            </b-form-group>
            <b-form-group label="Arrest Time" label-for="input-arrestTime" label-cols-md="3">
              <datetime type="datetime" id="input-arrestTime" v-model="editReportModal.arrestTime"></datetime>
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
            <b-form-group label="Witness" label-for="input-witness" label-cols-md="3" v-if="editReportModal.witness">
              <p>Unique ID: {{ editReportModal.witness.id }}<br><b-form-input id="input-witness" v-model="editReportModal.witness.witnessEmail"></b-form-input></p>
            </b-form-group>
            <b-form-group label="Comment" label-for="input-comment" label-cols-md="3">
              <b-form-textarea id="input-comment" v-model="editReportModal.comment" rows="3" max-rows="10"></b-form-textarea>
            </b-form-group>
          </b-col>
        </b-row>
      </b-container>
      </template>
    </b-modal>
    <!-- Delete user modal -->
    <b-modal id="deleteReportModal" title="Delete report" @ok="deleteReport">
      <p>Really delete?</p>
    </b-modal>
  </b-container>
</template>

<script>
import Multiselect from 'vue-multiselect'

export default {
  components: {
    Multiselect
  },
  data () {
    return {
      perPage: 50,
      currentPage: 1,
      filter: null,
      showHidden: false,
      selectedStations: null,
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
        comment: null,
        isHidden: null,
      }
    }
  },
  computed: {
    reportFields () {
      return [
        { key: 'index', label: '' },
        { key: 'createdAt', label: 'Reported at', sortable: true },
        { key: 'arrestTime', label: 'Arrest time', sortable: true },
        { key: 'station', sortable: true },
        { key: 'location', sortable: true },
        { key: 'name', sortable: true },
        { key: 'arrestingOfficerId', label: 'Officer ID', sortable: true },
        { key: 'concerns', sortable: true },
        { key: 'observations' },
        { key: 'comment' },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      return this.$store.getters.filteredReports.filter((x) => x.isHidden == this.showHidden)
    },
    rows () {
      return this.$store.getters.filteredReports.length
    },
    compositeFilter() {
      var v = {}
      if (this.filter != null && this.filter != '') {
        v.text = this.filter
      }
      if (this.selectedStations != null && this.selectedStations.length > 0) {
        v.stations = this.selectedStations
      }
      if (Object.keys(v).length > 0) {
        return v
      } else {
        return null
      }
    }
  },
  asyncComputed: {
    stationList: {
      async get () {
        var stationList = await this.$http.get('/api/v2/station_regions');
        var options = Object.entries(stationList.data.regions).sort((a, b) => a[0].localeCompare(b[0])).flatMap(([region, stations]) => {
          return {
            region: region,
            stations: stations,
          }
        });
        return options
      },
      default: [ { value: null, text: "All stations" }]
    }
  },
  methods: {
    editReport (item, target) {
      this.editReportModal = Object.assign({}, item)
      this.editReportModal.arrestTime = new Date(item.arrestTime).toISOString()
      this.$root.$emit('bv::show::modal', 'editReportModal', target)
    },
    commitEditReport () {
      var postData = Object.assign({}, this.editReportModal)
      delete postData.witness
      this.$io.socket.put('/api/v1/report/' + this.editReportModal.id, postData, (resData, jwRes) => {
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
    },
    hideEditReport (event, target) {
      if (event.trigger == "delete") {
        this.$root.$emit('bv::show::modal', 'deleteReportModal', target)
      }
    },
    deleteReport() {
      this.editReportModal.isHidden = true
      this.commitEditReport()
    },
    filterTable(row, filter) {
      const {text, stations} = filter;
      for (var field in row) {
        if (!row.hasOwnProperty(field)) {
          continue
        }
        var value = row[field]
        if (field == 'station' && stations != null && stations.includes(value)) {
          return true
        }
        if (typeof value === 'string' && text != null && value.search(text) >= 0) {
          return true
        }
      }
      return false
    }
  }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>