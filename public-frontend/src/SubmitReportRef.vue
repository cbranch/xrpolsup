<template>
<div class="container" v-if="submitted">
  <p class="py-4"><b>Thanks for your report!</b></p>
  <button class="btn btn-primary" v-on:click="submitted = false">Submit a new report</button>
</div>
<div class="container" v-else>
<form
  id="submitreport"
  @submit="checkForm"
  class="py-4"
>
  <h1>Arrestee Witness Report</h1>
  <p>Let us know when you see people arrested, so we may support them upon their release.</p>

  <p v-if="errors.length">
  <b>Please correct the following error(s):</b>
    <ul>
      <li v-for="error in errors" v-bind:key="error">{{ error }}</li>
    </ul>
  </p>

  <div class="form-group">
    <label for="arrestTime">Arrest time</label>
    <input
      id="arrestTime"
      class="form-control"
      v-model="arrestTime"
      type="text"
      name="arrestTime"
    >
  </div>

  <div class="form-group">
    <label for="numberOfArrestees">Number of people arrested</label>
    <input
      id="numberOfArrestees"
      class="form-control"
      v-model="numberOfArrestees"
      type="text"
      name="numberOfArrestees"
    >
  </div>

  <div class="form-group">
    <label for="station">Police Station</label>
    <input
      id="station"
      class="form-control"
      v-model="station"
      type="text"
      name="station"
    >
  </div>

  <p>
    <input
      type="submit"
      value="Submit"
      class="btn btn-primary"
    >
  </p>

  </form>
</div>
</template>

<script>
export default {
  name: 'submitreport',
  components: {
  },
  data: function () {
    return {
      errors: [],
      station: null,
      numberOfArrestees: null,
      arrestTime: null,
      submitted: true,
    }
  },
  methods:{
    checkForm: function (e) {
      this.errors = [];

      if (!this.station) {
        this.errors.push('Station name required.');
      }
      if (!this.numberOfArrestees) {
        this.errors.push('Number of arrestees required.');
      }
      if (!this.arrestTime) {
        this.errors.push('Arrest time required.');
      }

      e.preventDefault();

      if (this.errors.length == 0) {
        this.axios.post('/api/station_report', {
          station: this.station,
          numberOfArrestees: this.numberOfArrestees,
          arrestTime: this.arrestTime,
        }).then(() => {
          this.submitted = true
        }, error => {
          this.errors = [error.responseText]
        })
      }
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
