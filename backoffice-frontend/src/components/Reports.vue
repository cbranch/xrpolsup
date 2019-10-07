<template>
  <b-container fluid>
    <h2>Station reports</h2>
    <b-table striped hover :items="stationList" :fields="stationFields" caption-top>
      <template v-slot:table-caption>Total number of reports per station</template>
      <template v-slot:cell(station)="data">
        {{ data.value == "" ? "Unknown" : data.value }}
      </template>
    </b-table>
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
      let stations = groupBy(this.$store.state.reports, report => report.station == "" ? report.station : report.station.toString().toLowerCase())
      return [...stations.entries()].map(x => ({station: x[0], count: x[1].length}))
    }
  }
}
</script>