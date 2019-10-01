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
        </b-input-group-append>
      </b-input-group>
    </b-form-group>
    <b-table striped hover
      :items="reportList"
      :fields="reportFields"
      :filter="filter"
      sort-by="arrestTime">
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
      filter: null
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
  }
}
</script>