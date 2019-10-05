<template>
  <div>
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