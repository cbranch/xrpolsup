<template>
  <div class="container">
    <p>Report list</p>
    <ul>
        <li v-for="report in reportList" v-bind:key="report.id">
            {{ report.arrestTime }}: {{ report.numberOfArrestees }} at {{ report.station }}
        </li>
    </ul>
  </div>
</template>

<script>
export default {
  computed: {
    reportList () {
      return this.$store.state.reports
    }
  },
  created () {
      this.$io.socket.get('/report', (resData) => {
          this.$store.commit('setReports', resData)
      })
      this.$io.socket.on('report', (e) => {
          if (e.verb === 'created') {
              this.$store.commit('addReport', e.data)
          }
      })
  },
}
</script>