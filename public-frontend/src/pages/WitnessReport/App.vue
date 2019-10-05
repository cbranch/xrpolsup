<template>
  <b-container>
    <b-row class="mb-2">
      <b-col>
        <h2 class="my-3">Arrestee reporting</h2>
      </b-col>
    </b-row>
    <div v-if="submitted">
    <b-row class="mb-2">
      <b-col>
        <p>Thank you for completing this form.</p>
      </b-col>
    </b-row>
    </div>
    <div v-else>
    <b-row class="mb-2">
      <b-col>
        <b-card no-body header="Report details">
          <ReportOverview ref="reportOverview" v-model="reportOverview" @complete="overviewComplete = true" />
        </b-card>
      </b-col>
    </b-row>
    <div v-if="overviewComplete" >
    <b-row class="mb-2" v-for="(arrestee, index) in populatedArrestees" :key="index">
      <b-col>
        <b-card no-body :header="'Arrestee ' + (index + 1) + ' details'">
          <ArrestDetails :index="index" v-model="arrestee.details" ref="arrestDetails" />
        </b-card>
      </b-col>
    </b-row>
    </div>
    <b-row class="my-4" v-if="overviewComplete">
      <b-col>
        <b-button block variant="primary" v-on:click="submitReport">Submit arrestee report</b-button>
      </b-col>
    </b-row>
    <b-row class="my-4" v-if="errors.length > 0">
      <b-col>
        <b-alert show variant="danger">
          <p>Your report was not submitted for the following reasons:</p>
          <ul>
            <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
          </ul>
        </b-alert>
      </b-col>
    </b-row>
    </div>
  </b-container>
</template>

<script>
import ReportOverview from '../../components/ReportOverview.vue'
import ArrestDetails from '../../components/ArrestDetails.vue'

export default {
  name: 'WitnessReport',
  components: {
    ReportOverview,
    ArrestDetails
  },
  data () {
    return {
      reportOverview: null,
      overviewComplete: false,
      arrestees: [],
      submitted: false,
      errors: [],
    }
  },
  created () {
    for (var i = 0; i < 9; i++) {
      this.arrestees.push({})
    }
  },
  computed: {
    arresteeCount () {
      if (this.reportOverview != null) {
        if (this.reportOverview.arrestCount != null) {
          return Math.max(1, Math.min(9, this.reportOverview.arrestCount))
        }
      }
      return 0
    },
    populatedArrestees () {
      return this.arrestees.slice(0, this.arresteeCount)
    },
    hasConcerns () {
      if (this.arrestees != null) {
        if (this.arrestees.some(x => (x.details.concerns != null && x.details.concerns.length > 0))) {
          return true
        }
      }
      return false
    }
  },
  methods: {
    validate () {
      if (!this.$refs.reportOverview.valid) {
        return false
      }
      if (!this.$refs.arrestDetails.every(x => {
        return x.validate()
      })) {
        return false
      }
      return true
    },
    submitReport () {
      if (!this.validate()) {
        this.errors = ["Please correct errors in the form before submitting."]
        return
      }
      let report = {
        stationName: this.reportOverview.stationName,
        witnessEmail: this.reportOverview.witnessEmail,
        arrestees: this.populatedArrestees.map(x => {
          var arrestee = x.details != null ? x.details : {}
          return {
            time: this.reportOverview.time,
            date: this.reportOverview.date,
            location: this.reportOverview.location,
            name: arrestee.name,
            arrestingOfficerId: arrestee.arrestingOfficerId,
            concerns: arrestee.concerns,
            medicationName: arrestee.medicationName,
            observations: arrestee.observations,
            comment: arrestee.comment,
          }
        }),
      }
      this.axios.post('/api/v1/station_report', report).then(() => {
        this.submitted = true
      }, error => {
        this.errors = [error]
      })
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
