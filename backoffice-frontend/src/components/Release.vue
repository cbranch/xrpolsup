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
      <template v-slot:cell(actionGroup)="data">
        {{ data.value }}
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
            <b-form-group label="Police Station" label-for="input-police-station">
              <b-form-input id="input-police-station" v-model="editReleaseModal.policeStation"></b-form-input>
            </b-form-group>
            <b-form-group label="Name of charge" label-for="input-name-of-charge">
              <b-form-input id="input-name-of-charge" v-model="editReleaseModal.charges"></b-form-input>
            </b-form-group>
            <b-form-radio-group v-model="editReleaseModal.termsOfRelease" stacked>
              <b-form-radio value="released">Just released</b-form-radio>
              <b-form-radio value="report">Released and told a report would be sent to the Procurator Fiscal</b-form-radio>
              <b-form-radio value="undertaking">Released on an Undertaking (sometimes called police bail)</b-form-radio>
              <b-form-radio value="recordedWarning">Released with a Recorded Police Warning</b-form-radio>
              <b-form-radio value="custody">Held in custody to appear at court</b-form-radio>  
            </b-form-radio-group>
            <!-- These are undertaking conditions -->
            <b-form-group label="Date to appear at court" label-for="input-court-date" v-if="editReleaseModal.termsOfRelease == 'undertaking'" label-cols-md="3">
              <b-form-input id="input-court-date" v-model="editReleaseModal.courtDate"></b-form-input>
            </b-form-group>
            <b-form-group label="Name of court" label-for="input-court-location" v-if="editReleaseModal.termsOfRelease == 'undertaking'" label-cols-md="3">
              <b-form-input id="input-court-location" v-model="editReleaseModal.courtLocation"></b-form-input>
            </b-form-group>
            <b-form-group label="Any conditions?" label-for="input-bail-conditions" v-if="editReleaseModal.termsOfRelease == 'undertaking'" label-cols-md="3">
              <b-form-input id="input-bail-conditions" v-model="editReleaseModal.bailConditions"></b-form-input>
            </b-form-group>
            <!-- These are custody outcomes -->
            <b-form-group label="Date you appeared in court" label-for="input-court-date" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-court-date" v-model="editReleaseModal.courtDate"></b-form-input>
            </b-form-group>
            <b-form-group label="Which court was it?" label-for="input-court-location" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-court-location" v-model="editReleaseModal.courtLocation"></b-form-input>
            </b-form-group>
            <b-form-group label="What are you accused of?" label-for="input-accused-of" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-accused-of" v-model="editReleaseModal.accusedOf"></b-form-input>
            </b-form-group>
            <b-form-group label="How did you plead?" label-for="input-plea" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-plea" v-model="editReleaseModal.plea"></b-form-input>
            </b-form-group>
            <b-form-group label="Dates set for further hearings (called diets in Scotland)" label-for="input-further-hearings" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-further-hearings" v-model="editReleaseModal.furtherHearings"></b-form-input>
            </b-form-group>
            <b-form-group label="If you were represented by a solicitor which one?" label-for="input-solicitor" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-solicitor" v-model="editReleaseModal.solicitor"></b-form-input>
            </b-form-group>
            <b-form-group label="Any bail conditions?" label-for="input-bail-conditions" v-if="editReleaseModal.termsOfRelease == 'custody'" label-cols-md="3">
              <b-form-input id="input-bail-conditions" v-model="editReleaseModal.bailConditions"></b-form-input>
            </b-form-group>
            <!-- These are fixed penalty fine outcomes -->
            <b-form-group v-if="termsOfRelease == 'fine'" label="How much?" label-for="input-fixed-penalty-fine">
              <b-form-input id="input-fixed-penalty-fine" v-model="editReleaseModal.fixedPenaltyFine"></b-form-input>
            </b-form-group>
            <!-- End of release-specific outcomes -->
            <b-form-group label="Injuries:" label-for="input-anyInjuries" label-cols-md="3">
              <b-form-input id="input-anyInjuries" v-model="editReleaseModal.injuries"></b-form-input>
            </b-form-group>
            <b-form-checkbox v-model="editReleaseModal.interviewedByPolice">Interviewed by police?</b-form-checkbox>
            <b-form-group label="Speak to a solicitor?" label-for="input-spokeToSolicitor" label-cols-md="3">
              <b-form-input id="input-spokeToSolicitor" v-model="editReleaseModal.spokeToSolicitor"></b-form-input>
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
            <b-form-checkbox v-model="editReleaseModal.askedForDoctor">Asked for doctor?</b-form-checkbox>
            <b-form-checkbox v-model="editReleaseModal.seenByDoctor" v-if="editReleaseModal.askedForDoctor">Seen by doctor?</b-form-checkbox>
            <b-form-checkbox v-model="editReleaseModal.askedForMedication">Asked for medication?</b-form-checkbox>
            <b-form-checkbox v-model="editReleaseModal.givenMedication" v-if="editReleaseModal.askedForMedication">Given medication?</b-form-checkbox>
    
            <b-form-group label="How many protesters were you brought to this station with?" label-for="input-number-rebels" label-cols-md="3">
              <b-form-input type="number" id="input-number-rebels" v-model="editReleaseModal.numberRebels"></b-form-input>
            </b-form-group>

            <b-form-checkbox v-model="editReleaseModal.askedToContactSCALP">Asked the police to contact SCALP</b-form-checkbox>
            <b-form-group label="If police refused, reason given:" label-for="input-refusal-reason" label-cols-md="3">
              <b-form-input id="input-refusal-reason" v-model="editReleaseModal.contactRefusalReason"></b-form-input>
            </b-form-group>
            <b-form-group label="Arrestee comments" label-for="input-arrestee-comments" label-cols-md="3">
              <b-form-textarea id="input-arrestee-comments" v-model="editReleaseModal.otherComments" rows="3" max-rows="10"></b-form-textarea>
            </b-form-group>

            <b-form-group label="Action Group" label-for="input-action-group" label-cols-md="3">
              <b-form-input id="input-action-group" v-model="editReleaseModal.actionGroup"></b-form-input>
            </b-form-group>
            <b-form-group label="XR Region (if XR)" label-for="input-xr-region" label-cols-md="3">
              <b-form-input id="input-xr-region" v-model="editReleaseModal.xrRegion"></b-form-input>
            </b-form-group>
    
            <b-form-group label="E-Mail:" label-for="input-by-email" label-cols-md="3">
              <b-form-input id="input-by-email" v-model="editReleaseModal.email"></b-form-input>
            </b-form-group>
            <b-form-group label="Phone:" label-for="input-by-phone" label-cols-md="3">
              <b-form-input id="input-by-phone" v-model="editReleaseModal.phone"></b-form-input>
            </b-form-group>
            <b-form-group label="Comment" label-for="input-comment" label-cols-md="3">
              <b-form-textarea id="input-comment" v-model="editReleaseModal.comment" rows="3" max-rows="10"></b-form-textarea>
            </b-form-group>
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
      editReleaseModal: {
        id: null,
        name: null,
        arrestTime: null,
        location: null,
        offence: null,
        termsOfRelease: null,
        fixedPenaltyFine: null,
        charges: null,
        accusedOf: null,
        plea: null,
        furtherHearings: null,
        solicitor: null,
        bailConditions: null,
        courtDate: null,
        courtLocation: null,
        policeStation: null,
        nearestCity: null,
        injuries: null,
        interviewedByPolice: null,
        spokeToSolicitor: null,
        adverseEvents: null,
        heldMoreThan24Hours: null,
        helpNeeded: null,
        specialRequest: null,
        askedForDoctor: false,
        seenByDoctor: false,
        askedForMedication: false,
        givenMedication: false,
        numberRebels: null,
        rebelsStillHeld: null,
        askedToContactSCALP: null,
        contactRefusalReason: null,
        otherComments: null,
        email: null,
        phone: null,
        comment: null,
        isHidden: null,
        xrRegion: null,
        actionGroup: null,
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
        { key: 'comment' },
        { key: 'actionGroup', label: 'Group' },
        { key: 'actions', label: '' },
      ]
    },
    reportList () {
      var reports = this.$store.getters.filteredReleases.filter((x) => x.isHidden == this.showHidden)
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