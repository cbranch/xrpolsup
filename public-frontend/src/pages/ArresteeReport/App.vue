<template>
  <b-container>
    <b-row class="mb-2">
      <b-col>
        <h2 class="my-3">Please let us know about your arrest and release</h2>
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
        <b-form-group id="label-fullname" label="Full name / Alias" label-for="input-fullname" :invalid-feedback="isValidName.reason" :state="isValidName.valid">
          <b-form-input id="input-fullname" v-model="name" :state="isValidName.valid"></b-form-input>
        </b-form-group>
        <b-form-group id="label-datetime" label="When did this arrest take place?" label-for="input-time" :invalid-feedback="isValidDatetime.reason" :state="isValidDatetime.valid">
          <datetime id="input-datetime" type="datetime" v-model="datetime" :state="isValidDatetime.valid" :max-datetime="new Date().toISOString()" />
        </b-form-group>
        <b-form-group id="label-location" label="Where did this arrest take place?" label-for="input-location" :invalid-feedback="isValidLocation.reason" :state="isValidLocation.valid">
          <b-form-input id="input-location" v-model="location" :state="isValidLocation.valid" placeholder="Place name"></b-form-input>
        </b-form-group>
        <b-form-group label="Named offence at time of arrest" label-for="input-offence">
          <b-form-input id="input-offence" v-model="offence"></b-form-input>
        </b-form-group>
        <b-form-group label="Terms of release">
          <b-form-radio-group v-model="termsOfRelease" stacked>
            <b-form-radio value="rui">Released under investigation (RUI)</b-form-radio>
            <b-form-radio value="charge">Charge</b-form-radio>
            <b-form-group v-if="hasCharges" label="Name charges:" label-for="input-charges">
              <b-form-input id="input-charges" v-model="charges"></b-form-input>
            </b-form-group>
            <b-form-radio value="noFurtherAction">No further action</b-form-radio>  
          </b-form-radio-group>
        </b-form-group>
        <b-form-group label="Bail conditions" label-for="input-bail-conditions">
          <b-form-input id="input-bail-conditions" v-model="bailConditions"></b-form-input>
        </b-form-group>
        <b-form-group label="Court date" label-for="input-court-date">
          <b-form-input id="input-court-date" v-model="courtDate"></b-form-input>
        </b-form-group>
        <b-form-group label="Court location" label-for="input-court-location">
          <b-form-input id="input-court-location" v-model="courtLocation"></b-form-input>
        </b-form-group>
        <b-form-group label="Police Station" label-for="input-police-station">
          <StationSearch id="input-police-station" v-model="policeStation"></StationSearch>
        </b-form-group>
        <b-form-group label="Local XR group" label-for="input-local-xr-group">
          <b-form-input id="input-local-xr-group" v-model="localXrGroup"></b-form-input>
        </b-form-group>
        <b-form-group label="Nearest City or Region" label-for="input-nearest-city">
          <b-form-input id="input-nearest-city" v-model="nearestCity"></b-form-input>
        </b-form-group>
        <b-form-checkbox v-model="hasAnyInjuries">Any injuries?</b-form-checkbox>  
        <b-form-group v-if="hasAnyInjuries" label="Name injuries:" label-for="input-anyInjuries">
          <b-form-input id="input-anyInjuries" v-model="anyInjuries"></b-form-input>
        </b-form-group>
        <b-form-checkbox v-model="hasAdverseEvents">Adverse events?</b-form-checkbox>  
        <b-form-group v-if="hasAdverseEvents" label="Name adverse events:" label-for="input-adverseEvents">
          <b-form-input id="input-adverseEvents" v-model="adverseEvents"></b-form-input>
        </b-form-group>
        <b-form-checkbox v-model="heldMoreThan24Hours">Held more than 24hr?</b-form-checkbox>  
        <b-form-checkbox v-model="hasHelpNeeded">Help needed?</b-form-checkbox>  
        <b-form-group v-if="hasHelpNeeded" label="Describe help needed:" label-for="input-helpNeeded">
          <b-form-input id="input-helpNeeded" v-model="helpNeeded"></b-form-input>
        </b-form-group>

        <b-form-checkbox value="specialRequest">Special request?</b-form-checkbox>  
        <b-form-group v-if="hasSpecialRequest" label="Special request needed:" label-for="input-specialRequest">
          <b-form-input id="input-specialRequest" v-model="specialRequest"></b-form-input>
        </b-form-group>

        <b-form-group label="How many rebels were you brought to this station with?" label-for="input-number-rebels">
          <b-form-input type="number" id="input-number-rebels" v-model="numberRebels"></b-form-input>
        </b-form-group>

        <b-form-group label="Roughly how many rebels are still held in this station?" label-for="input-rebels-still-held">
          <b-form-input type="number" id="input-rebels-still-held" v-model="rebelsStillHeld"></b-form-input>
        </b-form-group>

        <b-form-group id="label-contact">
          <label>We request your contact details so that we can contact you regarding post arrest support such as trial support, PALS, and access to crowd justice funds.
            By providing this data, you consent to be contacted by:
          </label>
          <b-form-checkbox v-model="wantContactByEmail">E-mail</b-form-checkbox>
          <b-form-group v-if="wantContactByEmail" label="Please enter your email address:" label-for="input-by-email">
            <b-form-input id="input-by-email" v-model="contactByEmail"></b-form-input>
          </b-form-group>

          <b-form-checkbox v-model="wantContactByPhone">Phone</b-form-checkbox>
          <b-form-group v-if="wantContactByPhone" label="Please enter your phone number:" label-for="input-by-phone">
            <b-form-input id="input-by-phone" v-model="contactByPhone"></b-form-input>
          </b-form-group>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="my-4">
      <b-col>
        <h4>Further XR Support</h4>

        <p><b-form-checkbox id="canShareWithXRPress" v-model="canShareWithXRPress">If you would be happy for members of the XR-Press team to contact you in the future to discuss your options around press engagement then please tick here.</b-form-checkbox></p>

        <b-form-group label="In order to help us provide ongoing arrest support, can we share your contact details with your local XR group?" label-for="input-canShareWithLocalXRGroup">
          <b-form-checkbox id="canShareWithLocalXRGroup" v-model="canShareWithLocalXRGroup">I consent to sharing with my local XR group</b-form-checkbox>
        </b-form-group>

        <p>Contact us at xr-legal@riseup.net &amp; XR-ArrestWelfare@protonmail.com for further support.</p>
      </b-col>
    </b-row>
    <b-row class="my-4">
      <b-col>
        <p>We value and respect your personal data and privacy. By submitting this form, you agree that we may process your information in accordance with <a href="https://rebellion.earth/privacy-policy/" target="_blank">our privacy policy</a>.</p>
        <b-button block variant="primary" v-on:click="submitReport" :disabled="isSubmitting">Submit post-arrest report <b-spinner v-if="isSubmitting" label="Spinning"></b-spinner></b-button>
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
import StationSearch from '../../components/StationSearch.vue'

export default {
  name: 'ArresteeReport',
  components: {
    StationSearch,
  },
  data () {
    return {
      name: null,
      datetime: null,
      location: null,
      offence: null,
      termsOfRelease: null,
      charges: null,
      bailConditions: null,
      courtDate: null,
      courtLocation: null,
      policeStation: null,
      localXrGroup: null,
      nearestCity: null,
      hasAdverseEvents: false,
      adverseEvents: null,
      hasAnyInjuries: false,
      anyInjuries: null,
      heldMoreThan24Hours: false,
      hasHelpNeeded: false,
      helpNeeded: null,
      hasSpecialRequest: false,
      specialRequest: null,
      numberRebels: null,
      rebelsStillHeld: null,
      wantContactByEmail: false,
      contactByEmail: null,
      wantContactByPhone: false,
      contactByPhone: null,
      canShareWithLocalXRGroup: false,
      canShareWithXRPress: false,
      submitted: false,
      isSubmitting: false,
      errors: [],
    }
  },
  computed: {
    hasCharges () {
      return this.termsOfRelease != null && this.termsOfRelease.includes('charge')
    },
    isValidName () {
      if (this.name == null) {
        return { valid: null }
      } else if (this.name == '') {
        return { valid: false, reason: 'A name must be provided.' }
      } else {
        return { valid: true }
      }
    },
    isValidDatetime () {
      if (this.datetime == null) {
        return { valid: null }
      } else if (this.datetime == '') {
        return { valid: false, reason: 'Please select a date' }
      } else {
        return { valid: true }
      }
    },
    isValidLocation () {
      if (this.location == null) {
        return { valid: null }
      } else if (this.location == '') {
        return { valid: false, reason: 'Please enter a location' }
      } else {
        return { valid: true }
      }
    },
  },
  methods: {
    validate () {
      this.name = this.name || ''
      this.datetime = this.datetime || ''
      this.location = this.location || ''
      this.station = this.station || ''
      this.name = this.name || ''
      this.contactByEmail = this.contactByEmail || ''
      this.contactByPhone = this.contactByPhone || ''
      if (!this.isValidName.valid) {
        this.$scrollTo('#label-fullname')
      } else if (!this.isValidDatetime.valid) {
        this.$scrollTo('#label-datetime')
      } else if (!this.isValidLocation.valid) {
        this.$scrollTo('#label-location')
      }
      return this.isValidDatetime.valid && this.isValidLocation.valid && this.isValidName.valid
    },
    submitReport () {
      if (this.isSubmitting) {
        return
      }
      if (!this.validate()) {
        this.errors = ["Please correct errors in the form before submitting."]
        return
      }
      const dateParts = /([\d-]*)T(\d+:\d+):.*Z/.exec(this.datetime)
      const date = dateParts[1]
      const time = dateParts[2]
      let report = {
        name: this.name,
        time: time,
        date: date,
        location: this.location,
        offence: this.offence,
        termsOfRelease: this.termsOfRelease,
        charges: this.hasCharges ? this.charges : '',
        bailConditions: this.bailConditions,
        courtDate: this.courtDate,
        courtLocation: this.courtLocation,
        policeStation: this.policeStation,
        localXRGroup: this.localXrGroup,
        nearestCity: this.nearestCity,
        hasAdverseEvents: this.hasAdverseEvents,
        adverseEvents: this.adverseEvents,
        hasAnyInjuries: this.hasAnyInjuries,
        anyInjuries: this.anyInjuries,
        heldMoreThan24Hours: this.heldMoreThan24Hours,
        hasHelpNeeded: this.hasHelpNeeded,
        helpNeeded: this.helpNeeded,
        hasSpecialRequest: this.hasSpecialRequest,
        specialRequest: this.specialRequest,
        numberRebels: this.numberRebels,
        rebelsStillHeld: this.rebelsStillHeld,
        contactByEmail: this.wantContactByEmail ? this.contactByEmail : '',
        contactByPhone: this.wantContactByPhone ? this.contactByPhone : '',
        canShareWithXRPress: this.canShareWithXRPress,
        canShareWithLocalXRGroup: this.canShareWithLocalXRGroup,
        submitted: this.submitted,
      }
      this.isSubmitting = true
      this.axios.post('/api/v1/arrestee_report', report).then(() => {
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
