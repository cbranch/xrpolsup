<template>
  <b-container>
    <b-row class="mb-2">
      <b-col>
        <h2 class="my-3">Please let us know about your arrested and release</h2>
      </b-col>
    </b-row>
    <b-row class="mb-2">
      <b-col>
        <ArresteeDetails></ArresteeDetails>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import ArresteeDetails from '../../components/ArresteeDetails.vue'

export default {
  name: 'submitreport',
  components: {
    ArresteeDetails
  },
  data () {
    return {
      stationName: null,
      stationComplete: false,
      arresteeComplete: false,
      arrestees: null,
      witnessDetails: null,
      submitted: false,
      errors: [],
    }
  },
  computed: {
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
    submitReport () {
      if (!this.$refs.arresteeCount.validate()) {
        return
      }
      let report = {
        stationName: this.stationName,
        witnessEmail: this.witnessDetails,
        arrestees: this.arrestees.map(x => ({
          time: x.details.time,
          date: x.details.date,
          location: x.details.location,
          name: x.details.name,
          arrestingOfficerId: x.details.arrestingOfficerId,
          concerns: x.details.concerns,
          medicationName: x.details.medicationName,
          observations: x.details.observations,
        })),
      }
      this.axios.post('/api/station_report', report).then(() => {
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
