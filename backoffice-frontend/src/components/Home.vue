<template>
  <b-container fluid>
    <h2>Report list</h2>
    <b-alert :show="isConnected === false" variant="warning">Connection lost with the server. Refresh to re-establish connection.</b-alert>
    <b-table striped hover :items="reportList" :fields="reportFields" sort-by="arrestTime">
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
    </b-table>
  </b-container>
</template>

<script>
export default {
  data () {
    return {
      isConnected: null,
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
      ]
    },
    reportList () {
      return this.$store.state.reports
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    // call the method again if the route changes
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.$io.socket.get('/report', (resData, jwRes) => {
        if (jwRes.statusCode == 401) {
          this.$router.push('login')
        } else {
          this.$store.commit('setReports', resData)
        }
      })
      if (!this.isConnected) {
        this.$io.socket.on('connect', () => {
          this.isConnected = true
        })
        this.$io.socket.on('report', (e) => {
            if (e.verb === 'created') {
                this.$store.commit('addReport', e.data)
            }
        })
        this.$io.socket.on('disconnect', () => {
          this.isConnected = false
        })
      }
    }
  }
}
</script>