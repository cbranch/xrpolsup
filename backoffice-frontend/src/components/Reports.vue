<template>
  <b-container fluid>
    <b-tabs content-class="mt-3">
      <b-tab title="Station reports" active>
        <b-table striped hover :items="stationList" :fields="stationFields" caption-top>
          <template v-slot:table-caption>Total number of reports per station</template>
          <template v-slot:cell(station)="data">
            {{ data.value == "" ? "Unknown" : data.value }}
          </template>
        </b-table>
      </b-tab>
      <b-tab title="Release reports">
        <b-table striped hover :items="releaseStationList" :fields="releaseStationFields" caption-top>
          <template v-slot:table-caption>Total number of releases per station</template>
          <template v-slot:cell(station)="data">
            {{ data.value == "" ? "Unknown" : data.value }}
          </template>
        </b-table>
      </b-tab>
    </b-tabs>
  </b-container>
</template>

<script>
function groupBy(list, keyGetter) {
    const map = new Map();
    list.forEach((item) => {
         const key = keyGetter(item);
         const collection = map.get(key);
         if (!collection) {
             map.set(key, [item]);
         } else {
             collection.push(item);
         }
    });
    return map;
}

export default {
  data () {
    return {
      isConnected: null,
    }
  },
  computed: {
    stationFields () {
      return [
        { key: 'station', sortable: true },
        { key: 'count', sortable: true },
      ]
    },
    stationList () {
      let stations = groupBy(this.$store.getters.filteredReports, report => report.station == "" ? report.station : report.station.toString().toLowerCase().trim())
      return [...stations.entries()].map(x => ({station: x[1][0].station, count: x[1].length}))
    },
    releaseStationFields () {
      return [
        { key: 'station', sortable: true },
        { key: 'count', sortable: true },
      ]
    },
    releaseStationList () {
      let stations = groupBy(this.$store.getters.filteredReleases, release => release.policeStation == "" ? release.policeStation : release.policeStation.toString().toLowerCase().trim())
      return [...stations.entries()].map(x => ({station: x[1][0].policeStation, count: x[1].length}))
    }
  }
}
</script>