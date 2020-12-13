<template>
  <b-container fluid>
    <h2>Post-release report list</h2>
    <b-form-group
      label-cols-sm="2"
      label-align-sm="right"
      label-size="sm"
      label-for="filterInput"
      class="mb-2"
    >
      <b-input-group size="sm" prepend="Filter">
        <b-form-input
          v-model="filter"
          type="search"
          id="filterInput"
          placeholder="Type to Search"
        ></b-form-input>
        <b-input-group-append>
          <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
          <b-form-checkbox v-model="showHidden" button>Show&nbsp;deleted</b-form-checkbox>
          <b-form-select v-model="showHS2">
            <b-form-select-option :value="null">Filter HS2?</b-form-select-option>
            <b-form-select-option :value="true">Show HS2</b-form-select-option>
            <b-form-select-option :value="false">Hide HS2</b-form-select-option>
          </b-form-select>
        </b-input-group-append>
      </b-input-group>
    </b-form-group>
    <b-pagination
      v-model="currentPage"
      :total-rows="rows"
      :per-page="perPage"
      aria-controls="release-table"
      align="center"
    ></b-pagination>
    <b-table striped hover
      id="release-table"
      :items="reportList"
      :fields="reportFields"
      :filter="filter"
      :per-page="perPage"
      :current-page="currentPage"
      primary-key="id"
      sort-by="arrestTime">
      <template v-slot:cell(createdAt)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(arrestTime)="data">
        {{ new Date(data.value).toLocaleDateString('en-GB', { month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' }) }}
      </template>
      <template v-slot:cell(comment)="data">
        <b-button v-if="data.item.comment" v-b-popover.hover.top="data.item.comment" title="Comment" size="sm">
          Show
        </b-button>
      </template>
      <template v-slot:cell(isHS2Action)="data">
        {{ data.value ? '🚄' : '' }}
      </template>
      <template v-slot:cell(isPartOfXR)="data">
        {{ data.value ? '⌛️' : '' }}
      </template>
      <template v-slot:cell(actions)="data">
        <b-button size="sm" @click="editRelease(data.item, $event.target)">Edit</b-button>
      </template>
    </b-table>
    <b-modal id="editReleaseModal" title="Edit release" size="lg" @ok="commitEditRelease" @hide="hideEditRelease" scrollable>
      <template v-slot:modal-footer="{ ok, cancel, hide }">
        <b-button variant="primary" @click="ok()">OK</b-button>
        <b-button variant="secondary" @click="cancel()">Cancel</b-button>
        <b-button variant="outline-danger" @click="hide('delete')">Delete</b-button>
      </template>
      <template v-slot:default="">
      <b-container fluid>
        <b-row>
          <b-col>
            <b-form-group label="Name" label-for="input-fullname" label-cols-md="3">
              <b-form-input id="input-fullname" v-model="editReleaseModal.name"></b-form-input>
            </b-form-group>
            <b-form-group label="Arrest time" label-for="input-time" label-cols-md="3">
              <datetime type="datetime" id="input-arrestTime" input-class="form-control" v-model="editReleaseModal.arrestTime"></datetime>
            </b-form-group>
            <b-form-group label="Arrest location" label-for="input-location" label-cols-md="3">
              <b-form-input id="input-location" v-model="editReleaseModal.location"></b-form-input>
            </b-form-group>
            <b-form-group label="Named offence at time of arrest" label-for="input-offence" label-cols-md="3">
              <b-form-input id="input-offence" v-model="editReleaseModal.offence"></b-form-input>
            </b-form-group>
            <b-form-group label="Terms of release" label-cols-md="3">
              <b-form-radio-group v-model="editReleaseModal.termsOfRelease" stacked>
                <b-form-radio value="rui">Released under investigation (RUI)</b-form-radio>
                <b-form-radio value="charge">Charge</b-form-radio>
                <b-form-group v-if="editReleaseModal.termsOfRelease == 'charge'" label="Name charges:" label-for="input-charges">
                  <b-form-input id="input-charges" v-model="editReleaseModal.charges"></b-form-input>
                </b-form-group>
                <b-form-radio value="noFurtherAction">No further action</b-form-radio>  
              </b-form-radio-group>
            </b-form-group>
            <b-form-group label="Bail conditions" label-for="input-bail-conditions" label-cols-md="3">
              <b-form-input id="input-bail-conditions" v-model="editReleaseModal.bailConditions"></b-form-input>
            </b-form-group>
            <b-form-group label="Court date" label-for="input-court-date" label-cols-md="3">
              <b-form-input id="input-court-date" v-model="editReleaseModal.courtDate"></b-form-input>
            </b-form-group>
            <b-form-group label="Court location" label-for="input-court-location" label-cols-md="3">
              <b-form-input id="input-court-location" v-model="editReleaseModal.courtLocation"></b-form-input>
            </b-form-group>
            <b-form-group label="Police Station" label-for="input-police-station" label-cols-md="3">
              <b-form-input id="input-police-station" v-model="editReleaseModal.policeStation"></b-form-input>
            </b-form-group>
            <b-form-group label="Local XR group" label-for="input-local-xr-group" label-cols-md="3">
              <b-form-input id="input-local-xr-group" v-model="editReleaseModal.localXRGroup"></b-form-input>
            </b-form-group>
            <b-form-group label="Nearest City or Region" label-for="input-nearest-city" label-cols-md="3">
              <b-form-input id="input-nearest-city" v-model="editReleaseModal.nearestCity"></b-form-input>
            </b-form-group>
            <b-form-group label="Injuries:" label-for="input-anyInjuries" label-cols-md="3">
              <b-form-input id="input-anyInjuries" v-model="editReleaseModal.injuries"></b-form-input>
            </b-form-group>
            <b-form-group label="Adverse events:" label-for="input-adverseEvents" label-cols-md="3">
              <b-form-input id="input-adverseEvents" v-model="editReleaseModal.adverseEvents"></b-form-input>
            </b-form-group>
            <b-form-checkbox v-model="editReleaseModal.heldMoreThan24Hours">Held more than 24hr?</b-form-checkbox>  
            <b-form-group label="Help needed:" label-for="input-helpNeeded" label-cols-md="3">
              <b-form-input id="input-helpNeeded" v-model="editReleaseModal.helpNeeded"></b-form-input>
            </b-form-group>
            <b-form-group label="Special request needed:" label-for="input-specialRequest" label-cols-md="3">
              <b-form-input id="input-specialRequest" v-model="editReleaseModal.specialRequest"></b-form-input>
            </b-form-group>
    
            <b-form-group label="How many rebels were you brought to this station with?" label-for="input-number-rebels" label-cols-md="3">
              <b-form-input type="number" id="input-number-rebels" v-model="editReleaseModal.numberRebels"></b-form-input>
            </b-form-group>
    
            <b-form-group label="Roughly how many rebels are still held in this station?" label-for="input-rebels-still-held" label-cols-md="3">
              <b-form-input type="number" id="input-rebels-still-held" v-model="editReleaseModal.rebelsStillHeld"></b-form-input>
            </b-form-group>
    
            <b-form-group label="E-Mail:" label-for="input-by-email" label-cols-md="3">
              <b-form-input id="input-by-email" v-model="editReleaseModal.email"></b-form-input>
            </b-form-group>
            <b-form-group label="Phone:" label-for="input-by-phone" label-cols-md="3">
              <b-form-input id="input-by-phone" v-model="editReleaseModal.phone"></b-form-input>
            </b-form-group>
            <b-form-checkbox v-model="editReleaseModal.canShareWithLocalXRGroup">Consent to share with local XR group</b-form-checkbox>
            <b-form-checkbox v-model="editReleaseModal.canShareWithXRPress">Consent to share with XR press</b-form-checkbox>
            <b-form-group label="Comment" label-for="input-comment" label-cols-md="3">
              <b-form-textarea id="input-comment" v-model="editReleaseModal.comment" rows="3" max-rows="10"></b-form-textarea>
            </b-form-group>
            <b-form-checkbox v-model="editReleaseModal.isHS2Action">Is this part of an HS2 action?</b-form-checkbox>
            <b-form-checkbox v-model="editReleaseModal.isPartOfXR">Do you consider yourself a member of XR?</b-form-checkbox>
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
      showHS2: null,
      editReleaseModal: {
        id: null,
        name: null,
        arrestTime: null,
        location: null,
        offence: null,
        termsOfRelease: null,
        charges: null,
        bailConditions: null,
        courtDate: null,
        courtLocation: null,
        policeStation: null,
        localXRGroup: null,
        nearestCity: null,
        injuries: null,
        adverseEvents: null,
        heldMoreThan24Hours: null,
        helpNeeded: null,
        specialRequest: null,
        numberRebels: null,
        rebelsStillHeld: null,
        email: null,
        phone: null,
        canShareWithLocalXRGroup: null,
        canShareWithXRPress: null,
        comment: null,
        isHidden: null,
        isHS2Action: null,
        isPartOfXR: null,
      }
    }
  },
  computed: {
    reportFields () {
      return [
        { key: 'createdAt', label: 'Reported at', sortable: true },
        { key: 'arrestTime', label: 'Arrest time', sortable: true },
        { key: 'name', sortable: true },
        { key: 'policeStation', sortable: true },
        { key: 'location', sortable: true },
        { key: 'localXRGroup', label: 'Local XR group', sortable: true },
        { key: 'numberRebels', label: 'With # Rebels', sortable: true },
        { key: 'rebelsStillHeld', labels: '# still held', sortable: true },
        { key: 'comment' },
        { key: 'isHS2Action', label: 'HS2' },
        { key: 'isPartOfXR', label: 'XR' },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      var reports = this.$store.getters.filteredReleases.filter((x) => x.isHidden == this.showHidden)
      if (this.showHS2 != null) {
        reports = reports.filter((x) => x.isHS2Action == this.showHS2)
      }
      return reports
    },
    rows () {
      return this.reportList.length
    }
  },
  methods: {
    editRelease (item, target) {
      this.editReleaseModal = Object.assign({}, item)
      this.editReleaseModal.arrestTime = new Date(item.arrestTime).toISOString()
      this.$root.$emit('bv::show::modal', 'editReleaseModal', target)
    },
    commitEditRelease () {
      var postData = Object.assign({}, this.editReleaseModal)
      this.$io.socket.put('/api/v1/release/' + this.editReleaseModal.id, postData, (resData, jwRes) => {
        if (jwRes.statusCode == 200) {
          this.$store.commit('setRelease', resData)
          this.$bvToast.toast('Release report updated!', {
            title: 'Release report management',
            variant: 'primary',
            solid: true
          })
        } else {
          this.$bvToast.toast('Failed to update release report: ' + jwRes, {
            title: 'Release report management',
            variant: 'warning',
            solid: true
          })
        }
      })
    },
    hideEditRelease (event) {
      if (event.trigger == "delete") {
        this.editReleaseModal.isHidden = true
        this.commitEditRelease()
      }
    }
  }
}
</script>