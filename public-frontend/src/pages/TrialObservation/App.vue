<template>
  <b-container>
    <b-row class="mb-2">
      <b-col>
        <h2 class="my-3">XR Legal Support Trial Observation</h2>
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
        <b-form-group id="label-court" label="Court" label-for="input-court" :invalid-feedback="isValidCourt.reason" :state="isValidCourt.valid" label-cols-lg="3">
          <b-form-input id="input-court" v-model="court" :state="isValidCourt.valid"></b-form-input>
        </b-form-group>
        <b-form-group id="label-date" label="Hearing date" label-for="input-date" :invalid-feedback="isValidDate.reason" :state="isValidDate.valid" label-cols-lg="3">
          <datetime id="input-date" type="date" input-class="form-control" v-model="date" :state="isValidDate.valid" :max-datetime="new Date().toISOString()" />
        </b-form-group>
        <b-form-group id="label-bench" label="Bench (DJ or JPs)" label-for="input-bench" :invalid-feedback="isValidBench.reason" :state="isValidBench.valid" label-cols-lg="3">
          <b-form-input id="input-bench" v-model="bench" :state="isValidBench.valid"></b-form-input>
        </b-form-group>
        <b-form-group id="label-defendant-name" label="Defendant name" label-for="input-defendant-name" :invalid-feedback="isValidDefendantName.reason" :state="isValidDefendantName.valid" label-cols-lg="3">
          <b-form-input id="input-defendant-name" v-model="defendantName" :state="isValidDefendantName.valid"></b-form-input>
        </b-form-group>
        <b-form-group id="label-defendant-number" label="Defendant number" label-for="input-defendant-number" :invalid-feedback="isValidDefendantNumber.reason" :state="isValidDefendantNumber.valid" label-cols-lg="3">
          <b-form-input id="input-defendant-number" type="number" v-model="defendantNumber" :state="isValidDefendantNumber.valid"></b-form-input>
        </b-form-group>
        <p><i>Below, please avoid name and refer only to defendant number</i></p>
        <b-form-group label="Charged with" label-for="input-charges" label-cols-lg="3">
          <b-form-input id="input-charges" v-model="charges"></b-form-input>
        </b-form-group>
        <b-form-group label="Represented by" label-for="input-representation" label-cols-lg="3">
          <b-form-input id="input-representation" v-model="representation"></b-form-input>
        </b-form-group>
        <b-form-group label="Please outline key points in prosecution and defence cases" label-for="input-outline" label-cols-lg="3">
          <b-form-textarea id="input-outline" v-model="outline" rows="3" max-rows="10"></b-form-textarea>
        </b-form-group>
        <b-form-group label="Was defence evidence submitted in writing?" label-cols-lg="3">
          <b-form-input id="input-evidence-submitted" v-model="evidenceSubmitted"></b-form-input>
        </b-form-group>
        <b-form-group label="Did defence witness(es) give evidence in person? Were they cross-examined?" label-for="input-evidence-in-person" label-cols-lg="3">
          <b-form-textarea id="input-evidence-in-person" v-model="evidenceInPerson" rows="3" max-rows="10"></b-form-textarea>
        </b-form-group>
        <b-form-group label="What was the verdict?" label-cols-lg="3">
          <b-form-input id="input-verdict" v-model="verdict"></b-form-input>
        </b-form-group>
        <b-form-group label="What was the sentence?" label-cols-lg="3">
          <b-form-input id="input-sentence" v-model="sentence"></b-form-input>
        </b-form-group>
        <b-form-group label="What costs were awarded?" label-cols-lg="3">
          <b-form-input id="input-costs" v-model="costs"></b-form-input>
        </b-form-group>
        <b-form-group label="Please add anything else relevant." label-for="input-notes" label-cols-lg="3">
          <b-form-textarea id="input-notes" v-model="notes" rows="3" max-rows="10"></b-form-textarea>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="my-4">
      <b-col>
        <b-button block variant="primary" v-on:click="submitReport" :disabled="isSubmitting">Submit report <b-spinner v-if="isSubmitting" label="Spinning"></b-spinner></b-button>
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
function requireValue(x, emptyReason) {
  if (x == null) {
    return { valid: null }
  } else if (x == '') {
    return { valid: false, reason: emptyReason }
  } else {
    return { valid: true }
  }
}
export default {
  name: 'TrialObservation',
  data () {
    return {
      court: null,
      date: new Date().toISOString(),
      bench: null,
      defendantName: null,
      defendantNumber: null,
      charges: null,
      representation: null,
      outline: null,
      evidenceSubmitted: null,
      evidenceInPerson: null,
      verdict: null,
      sentence: null,
      costs: null,
      notes: null,
      submitted: false,
      isSubmitting: false,
      errors: [],
    }
  },
  computed: {
    isValidCourt () {
      return requireValue(this.court, 'A court name must be provided.')
    },
    isValidDate () {
      return requireValue(this.date, 'Please select a date.')
    },
    isValidBench () {
      return requireValue(this.bench, 'Please enter the bench.')
    },
    isValidDefendantName () {
      return requireValue(this.defendantName, 'Please enter the defendant\'s name.')
    },
    isValidDefendantNumber () {
      if (this.defendantNumber == null) {
        return { valid: null }
      } else if (this.defendantNumber == 0) {
        return { valid: false, reason: 'Please enter the defendant\'s number.' }
      } else {
        return { valid: true }
      }
    },
  },
  methods: {
    validate () {
      this.court = this.court || ''
      this.date = this.date || ''
      this.bench = this.bench || ''
      this.defendantName = this.defendantName || ''
      this.defendantNumber = this.defendantNumber || ''
      return this.checkValues([
        [this.isValidCourt.valid, '#label-court'],
        [this.isValidDate.valid, '#label-date'],
        [this.isValidBench.valid, '#label-bench'],
        [this.isValidDefendantName.valid, '#label-defendant-name'],
        [this.isValidDefendantNumber.valid, '#label-defendant-number'],
      ])
    },
    checkValues(v) {
      for (const [result, label] of v) {
        if (!result) {
          this.$scrollTo(label)
          return false
        }
      }
      return true
    },
    submitReport () {
      if (this.isSubmitting) {
        return
      }
      if (!this.validate()) {
        this.errors = ["Please correct errors in the form before submitting."]
        return
      }
      let report = {
        court: this.court,
        date: this.date,
        bench: this.bench,
        defendantName: this.defendantName,
        defendantNumber: this.defendantNumber,
        charges: this.charges,
        representation: this.representation,
        outline: this.outline,
        evidenceSubmitted: this.evidenceSubmitted,
        evidenceInPerson: this.evidenceInPerson,
        verdict: this.verdict,
        sentence: this.sentence,
        costs: this.costs,
        notes: this.notes,
      }
      this.isSubmitting = true
      this.axios.post('/api/v2/trial_observation', report).then(() => {
        this.isSubmitting = false
        this.submitted = true
      }, error => {
        this.isSubmitting = false
        this.errors = [error, error.response.data]
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
