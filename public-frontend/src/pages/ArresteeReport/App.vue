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
        <b-form-group id="label-datetime" label="When did this arrest take place?" label-for="input-datetime" :invalid-feedback="isValidDatetime.reason" :state="isValidDatetime.valid">
          <datetime id="input-datetime" type="datetime" input-class="form-control" v-model="datetime" :state="isValidDatetime.valid" :max-datetime="new Date().toISOString()" />
        </b-form-group>
        <b-form-group id="label-location" label="Where did this arrest take place?" label-for="input-location" :invalid-feedback="isValidLocation.reason" :state="isValidLocation.valid">
          <b-form-input id="input-location" v-model="location" :state="isValidLocation.valid" placeholder="Place name"></b-form-input>
        </b-form-group>
        <b-form-group label="Named offence at time of arrest" label-for="input-offence">
          <b-form-input id="input-offence" v-model="offence"></b-form-input>
        </b-form-group>
        <b-form-group label="Police Station" label-for="input-police-station">
          <StationSearch id="input-police-station" v-model="policeStation"></StationSearch>
        </b-form-group>
        <b-card header="Terms of release">
          <b-form-group label="Were you formally charged?">
            <YesNo v-model="formallyCharged" />
          </b-form-group>
          <b-form-group label="Name of charge" label-for="input-name-of-charge" v-if="formallyCharged">
            <b-form-input id="input-name-of-charge" v-model="charges"></b-form-input>
          </b-form-group>
          <b-form-group label="Were you:">
            <b-form-radio-group v-model="termsOfRelease" stacked>
              <b-form-radio value="released">Just released</b-form-radio>
              <b-form-radio value="report">Released and told a report would be sent to the Procurator Fiscal</b-form-radio>
              <b-form-radio value="undertaking">Released on an Undertaking (sometimes called police bail)</b-form-radio>
              <b-form-radio value="custody">Held in custody to appear at court</b-form-radio>  
            </b-form-radio-group>
          </b-form-group>
          <!-- These are undertaking conditions -->
          <b-form-group label="Date to appear at court" label-for="input-court-date" v-if="termsOfRelease == 'undertaking'">
            <b-form-input id="input-court-date" v-model="courtDate"></b-form-input>
          </b-form-group>
          <b-form-group label="Name of court" label-for="input-court-location" v-if="termsOfRelease == 'undertaking'">
            <b-form-input id="input-court-location" v-model="courtLocation"></b-form-input>
          </b-form-group>
          <b-form-group label="Any conditions?" label-for="input-bail-conditions" v-if="termsOfRelease == 'undertaking'">
            <b-form-input id="input-bail-conditions" v-model="bailConditions"></b-form-input>
          </b-form-group>
          <!-- These are custody outcomes -->
          <b-form-group label="Date you appeared in court" label-for="input-court-date" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-court-date" v-model="courtDate"></b-form-input>
          </b-form-group>
          <b-form-group label="Which court was it?" label-for="input-court-location" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-court-location" v-model="courtLocation"></b-form-input>
          </b-form-group>
          <b-form-group label="What are you accused of?" label-for="input-accused-of" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-accused-of" v-model="accusedOf"></b-form-input>
          </b-form-group>
          <b-form-group label="How did you plead?" label-for="input-plea" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-plea" v-model="plea"></b-form-input>
          </b-form-group>
          <b-form-group label="Dates set for further hearings (called diets in Scotland)" label-for="input-further-hearings" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-further-hearings" v-model="furtherHearings"></b-form-input>
          </b-form-group>
          <b-form-group label="If you were represented by a solicitor which one?" label-for="input-solicitor" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-solicitor" v-model="solicitor"></b-form-input>
          </b-form-group>
          <b-form-group label="Any bail conditions?" label-for="input-bail-conditions" v-if="termsOfRelease == 'custody'">
            <b-form-input id="input-bail-conditions" v-model="bailConditions"></b-form-input>
          </b-form-group>
        </b-card>
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

        <b-form-group label="How many protesters were you brought to this station with?" label-for="input-number-rebels">
          <b-form-input type="number" id="input-number-rebels" v-model="numberRebels"></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="my-4">
      <b-col>
        <b-form-group label="Are you a member of XR?">
          <YesNo v-model="isXRMember" />
        </b-form-group>

        <b-form-group id="label-contact" v-if="isXRMember">
          <label>If you would like XR to contact you with regards to providing post-arrest support, such as trial and ongoing court support then please provide us with your name and email (or phone number) By providing this info you consent to XR securely storing your contact info and contacting you in accordance with their privacy policy - <a href="https://extinctionrebellion.uk/privacy-policy/">https://extinctionrebellion.uk/privacy-policy/</a></label>
          <b-form-group label="Email" label-for="input-by-email">
            <b-form-input id="input-by-email" v-model="contactByEmail"></b-form-input>
          </b-form-group>
          <b-form-group label="Phone" label-for="input-by-phone">
            <b-form-input id="input-by-phone" v-model="contactByPhone"></b-form-input>
          </b-form-group>
          <b-form-group label="XR Region" label-for="input-xr-region">
            <b-form-input id="input-xr-region" v-model="xrRegion"></b-form-input>
          </b-form-group>
        </b-form-group>

        <b-form-group id="label-contact" v-if="isXRMember === false">
          <label>We may have information about ongoing post arrest support from other groups who have organised actions.
If you want us to pass this on to you then:</label>
          <b-form-group label="Which group organised the action you took part in?" label-for="input-action-group">
            <b-form-input id="input-action-group" v-model="actionGroup"></b-form-input>
          </b-form-group>
          <b-form-group label="Email" label-for="input-by-email">
            <b-form-input id="input-by-email" v-model="contactByEmail"></b-form-input>
          </b-form-group>
          <b-form-group label="Phone" label-for="input-by-phone">
            <b-form-input id="input-by-phone" v-model="contactByPhone"></b-form-input>
          </b-form-group>
        </b-form-group>
      </b-col>
    </b-row>
    <b-row class="my-4">
      <b-col>
        <p>We value and respect your personal data and privacy. By submitting this form, you agree that we may process your information in accordance with <a href="https://www.scottishactivistlegalproject.co.uk/contact/privacy-notice/" target="_blank">our privacy policy</a>.</p>
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
import YesNo from '../../components/YesNo.vue'

export default {
  name: 'ArresteeReport',
  components: {
    YesNo,
    StationSearch,
  },
  data () {
    return {
      name: null,
      datetime: null,
      location: null,
      offence: null,
      policeStation: null,
      formallyCharged: null,
      termsOfRelease: null,
      charges: null,
      bailConditions: null,
      courtDate: null,
      courtLocation: null,
      accusedOf: null,
      plea: null,
      furtherHearings: null,
      solicitor: null,
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
      contactByEmail: null,
      contactByPhone: null,
      actionGroup: null,
      isXRMember: null,
      xrRegion: null,
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
        accusedOf: this.accusedOf,
        plea: this.plea,
        furtherHearings: this.furtherHearings,
        solicitor: this.solicitor,
        policeStation: this.policeStation,
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
        contactByEmail: this.contactByEmail,
        contactByPhone: this.contactByPhone,
        actionGroup: null,
        isXRMember: null,
        xrRegion: null,
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
