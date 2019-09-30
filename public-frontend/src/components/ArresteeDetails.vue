<template>
  <div>
    <b-card-body> <!--  v-bind:title="cardTitle" -->
      <b-card-text>
        <b-form-group label="Full name / Alias" label-for="input-fullname">
          <b-form-input id="input-fullname" v-model="fullname" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="When did this arrest take place?" label-for="input-time" :invalid-feedback="isValidTime.reason" :state="isValidTime.valid">
          <b-form-input id="input-time" v-model="time" @input="update" :state="isValidTime.valid" placeholder="24-hour time, e.g. 13:00"></b-form-input>
        </b-form-group>
        <b-form-group :invalid-feedback="isValidDate.reason" :state="isValidDate.valid">
          <b-form-select id="input-date" v-model="date" @input="update" :state="isValidDate.valid" :options="dateList"></b-form-select>
        </b-form-group>
        <b-form-group label="Where did this arrest take place?" label-for="input-location" :invalid-feedback="isValidLocation.reason" :state="isValidLocation.valid">
          <b-form-input id="input-location" v-model="location" @input="update" :state="isValidLocation.valid" placeholder="Place name"></b-form-input>
        </b-form-group>
        <b-form-group label="E-Mail" label-for="input-email">
          <b-form-input id="input-email" v-model="email" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Telephone" label-for="input-telephone">
          <b-form-input id="input-telephone" v-model="telephone" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Named offence at time of arrest" label-for="input-offence">
          <b-form-input id="input-offence" v-model="offence" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Terms of release">
          <b-form-radio-group v-model="termRelease" @input="update" stacked>
            <b-form-radio value="rui">Released under investigation (RUI)</b-form-radio>
            <b-form-radio value="charge">Charge</b-form-radio>
            <b-form-group v-if="hasCharges" label="Name charges:" label-for="input-charges">
              <b-form-input id="input-charges" v-model="charges" @input="update"></b-form-input>
            </b-form-group>
            <b-form-radio value="noFurtherAction">No further action</b-form-radio>  
          </b-form-radio-group>
        </b-form-group>
        <b-form-group label="Bail conditions" label-for="input-bail-conditions">
          <b-form-input id="input-bail-conditions" v-model="bailConditions" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Court date" label-for="input-court-date">
          <b-form-input id="input-court-date" v-model="courtDate" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Court location" label-for="input-court-location">
          <b-form-input id="input-court-location" v-model="courtLocation" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Police Station" label-for="input-police-station">
          <b-form-input id="input-police-station" v-model="policeStation" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Local XR group" label-for="input-local-xr-group">
          <b-form-input id="input-local-xr-group" v-model="localXrGroup" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Nearest City or Region" label-for="input-nearest-city">
          <b-form-input id="input-nearest-city" v-model="nearestCity" @input="update"></b-form-input>
        </b-form-group>
        <b-form-checkbox-group v-model="others" @input="update" stacked>
          <b-form-checkbox value="anyInjuries">Any injuries?</b-form-checkbox>  
          <b-form-group v-if="hasAnyInjuries" label="Name injuries:" label-for="input-anyInjuries">
            <b-form-input id="input-anyInjuries" v-model="anyInjuries" @input="update"></b-form-input>
          </b-form-group>
          <b-form-checkbox value="adverseEvents">Adverse events?</b-form-checkbox>  
          <b-form-group v-if="hasAdverseEvents" label="Name adverse events:" label-for="input-adverseEvents">
            <b-form-input id="input-adverseEvents" v-model="adverseEvents" @input="update"></b-form-input>
          </b-form-group>
          <b-form-checkbox value="held24hrs">Held more than 24hr?</b-form-checkbox>  
          <b-form-checkbox value="helpNeeded">Help needed?</b-form-checkbox>  
          <b-form-group v-if="hasHelpNeeded" label="Describe help needed:" label-for="input-helpNeeded">
            <b-form-input id="input-helpNeeded" v-model="helpNeeded" @input="update"></b-form-input>
          </b-form-group>

          <b-form-checkbox value="specialRequest">Special request?</b-form-checkbox>  
          <b-form-group v-if="hasSpecialRequest" label="Special request needed:" label-for="input-specialRequest">
            <b-form-input id="input-specialRequest" v-model="specialRequest" @input="update"></b-form-input>
          </b-form-group>
        </b-form-checkbox-group>

        <b-form-group label="How many rebels were you brought to this station with?" label-for="input-number-rebels">
          <b-form-input id="input-number-rebels" v-model="numberRebels" @input="update"></b-form-input>
        </b-form-group>

        <b-form-group label="Roughly how many rebels are still held in this station?" label-for="input-rebels-still-held">
          <b-form-input id="input-rebels-still-held" v-model="rebelsStillHeld" @input="update"></b-form-input>
        </b-form-group>

        <b-form-checkbox-group v-model="beContactedBy" @input="update" stacked>
          <b-form-group label="By providing this data I consent to be contacted by" label-for="input-rebels-still-held">
            <b-form-checkbox value="byEmail">Contact by E-Mail</b-form-checkbox>  
            <b-form-group v-if="beContactedByEmail" label="E-Mail:" label-for="input-by-email">
              <b-form-input id="input-by-email" v-model="contactByEmail" @input="update"></b-form-input>
            </b-form-group>

            <b-form-checkbox value="byPhone">Contact by Phone</b-form-checkbox>  
            <b-form-group v-if="beContactedByPhone" label="Phone:" label-for="input-by-phone">
              <b-form-input id="input-by-phone" v-model="contactByPhone" @input="update"></b-form-input>
            </b-form-group>
          </b-form-group>
        </b-form-checkbox-group>
      </b-card-text>
    </b-card-body>
  </div>
</template>

<script>
// I consent for to be held GDPR blurb		Y/N	If no, wipe columns A,M,N
// If you do not want to be contacted by XR Media and Messaging please check this box			radio button
// I consent for my information to be shared with my local group in order to provide on-going arrest support			
// Thank you for completing this form			

export default {
  // components: {
  //   YesNo
  // },
  // props: ['value', 'index', 'initialTime', 'initialPlace'],
  data () {
    return {
      fullname: null,
      time: null,
      date: null,
      location: null,
      email: null,
      telephone: null,
      offence: null,
      termRelease: null,
      charges: null,
      bailConditions: null,
      courtDate: null,
      courtLocation: null,
      policeStation: null,
      localXrGroup: null,
      nearestCity: null,
      others: null,
      adverseEvents: null,
      anyInjuries: null,
      helpNeeded: null,
      specialRequest: null,
      beContactedBy: null,
      contactByEmail: null,
      contactByPhone: null,
    }
  },
  watch: {
    value (val) {
        this.time = val.time
        this.date = val.date
        this.location = val.location
        this.termRelease = val.termRelease
    },
    nameSupplied () {
      this.notifyIfComplete()
    },
    hasConcerns () {
      this.notifyIfComplete()
    }
  },
  methods: {
    update () {
      this.$emit('input', {
        fullname: this.fullname,
        time: this.time,
        date: this.date,
        email: this.email,
        location: this.location,
        telephone: this.telephone,
        offence: this.offence,
        termRelease: this.termRelease,
        charges: this.charges,
        bailConditions: this.bailConditions,
        courtDate: this.courtDate,
        courtLocation: this.courtLocation,
        policeStation: this.policeStation,
        localXrGroup: this.localXrGroup,
        nearestCity: this.nearestCity,
        others: this.others,
        adverseEvents: this.adverseEvents,
        anyInjuries: this.anyInjuries,
        helpNeeded: this.helpNeeded,
        specialRequest: this.specialRequest,
        beContactedBy: this.beContactedBy,
        contactByEmail: this.contactByEmail,
        contactByPhone: this.contactByPhone,
      })
      this.notifyIfComplete()
    },
    notifyIfComplete () {
      if (this.complete) {
        this.$emit('complete')
      }
    },
    validate () {
      if (this.time == null) {
          this.time = ""
      }
      return this.complete
    }
  },
  computed: {
    cardTitle () {
      return 'Arrestee ' + (this.index + 1)
    },
    dateList() {
        return [
            { value: null, text: 'Select a date' },
            { value: '20191007', text: '7 Oct' },
            { value: '20191008', text: '8 Oct' },
            { value: '20191009', text: '9 Oct' },
        ]
    },
    hasCharges () {
      return this.termRelease != null && this.termRelease.includes('charge')
    },
    hasAnyInjuries () {
      return this.others != null && this.others.includes('anyInjuries')
    },
    hasAdverseEvents () {
      return this.others != null && this.others.includes('adverseEvents')
    },
    hasHelpNeeded () {
      return this.others != null && this.others.includes('helpNeeded')
    },
    hasSpecialRequest () {
      return this.others != null && this.others.includes('specialRequest')
    },
    beContactedByEmail () {
      return this.beContactedBy != null && this.beContactedBy.includes('byEmail')
    },
    beContactedByPhone () {
      return this.beContactedBy != null && this.beContactedBy.includes('byPhone')
    },
    isValidTime () {
      if (this.time == null) {
        return { valid: null }
      } else if (this.time == "") {
        return { valid: false, reason: 'A valid time must be provided' }
      } else if (!this.time.match(/([01]?\d|2[0-3]):[0-5]\d/)) {
        return { valid: false, reason: 'Please enter the time in 24-hour format with a colon, hh:mm' }
      } else {
        return { valid: true }
      }
    },
    isValidDate () {
      if (this.date == null) {
        return { valid: null }
      } else if (this.date == '') {
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
    isValidName () {
      if (this.nameSupplied === false) {
        return { valid: true }
      } else if (this.name == null) {
        return { valid: null }
      } else if (this.nameSupplied === true && this.name == '') {
        return { valid: false, reason: 'Please enter a name, or confirm that you do not want to provide a name' }
      } else {
        return { valid: true }
      }
    },
    isValidConcerns () {
      if (this.hasConcerns == null) {
        return { valid: null }
      }
      if (this.hasConcerns === true) {
        if (this.concerns == null) {
            return { valid: null }
        }
        if (this.concerns.length == 0) {
            return { valid: false, reason: 'Please select the concern(s) you have, or confirm that you have no concerns' }
        }
      }
      return { valid: true }
    },
    complete () {
        return this.isValidTime.valid && this.isValidDate.valid && this.isValidLocation.valid && this.isValidName.valid && this.isValidConcerns.valid
    }
  }
}
</script>