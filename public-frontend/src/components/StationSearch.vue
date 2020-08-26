<template>
  <autocomplete placeholder="Station name" :search="searchStations" @submit="selectStation"></autocomplete>
</template>
<script>
import FuzzySearch from 'fuzzy-search'

export default {
  props: ['value'],
  data () {
    return {
      stationSearcher: null,
    }
  },
  methods: {
    async searchStations(input) {
      if (input.length < 1) { return [] }
      if (this.stationSearcher === null) {
        var stationList = await this.$http.get('/api/v2/stations');
        this.stationSearcher = new FuzzySearch(stationList.data.stations, [], { sort: true })
      }
      return this.stationSearcher.search(input)
    },
    selectStation(station) {
      this.$emit('input', station)
    }
  }
}
</script>