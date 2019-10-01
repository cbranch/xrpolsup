<template>
  <div>
    <b-card-body v-bind:title="cardTitle">
      <b-card-text>
        <b-form-group label="When did this arrest take place?" label-for="input-time" :invalid-feedback="isValidTime.reason" :state="isValidTime.valid">
          <b-form-input id="input-time" v-model="time" @input="update" :state="isValidTime.valid" placeholder="24-hour time, e.g. 13:00"></b-form-input>
        </b-form-group>
        <b-form-group :invalid-feedback="isValidDate.reason" :state="isValidDate.valid">
          <b-form-select id="input-date" v-model="date" @input="update" :state="isValidDate.valid" :options="dateList"></b-form-select>
        </b-form-group>
        <b-form-group label="Where did this arrest take place?" label-for="input-location" :invalid-feedback="isValidLocation.reason" :state="isValidLocation.valid">
          <b-form-input id="input-location" v-model="location" @input="update" :state="isValidLocation.valid" placeholder="Place name"></b-form-input>
        </b-form-group>
        <b-form-group label="Do you want to give a name or alias of the arrestee?" :invalid-feedback="isValidName.reason" :state="isValidName.valid">
          <YesNo v-model="nameSupplied" />
          <b-form-input v-if="nameSupplied" v-model="name" @input="update" :state="isValidName.valid" placeholder="Full name, or alias"></b-form-input>
        </b-form-group>
        <b-form-group label="Identification number of arresting officer (if known)" label-for="input-officerId">
          <b-form-input id="input-officerId" v-model="arrestingOfficerId" @input="update" placeholder="ID"></b-form-input>
        </b-form-group>
        <b-form-group label="Do you have any concerns to report regarding this arrest?" :invalid-feedback="isValidConcerns.reason" :state="isValidConcerns.valid">
          <YesNo v-model="hasConcerns" />
        </b-form-group>
        <b-form-checkbox-group v-if="hasConcerns" v-model="concerns" @input="update" stacked>
          <b-form-checkbox value="mentalDistress">Mental distress?</b-form-checkbox>
          <b-form-checkbox value="physicalDistress">Physical distress?</b-form-checkbox>
          <b-form-checkbox value="minor">Minor</b-form-checkbox>
          <b-form-checkbox value="policeBehaviour">Police behaviour?</b-form-checkbox>
          <b-form-checkbox value="policePrejudice">Police prejudice?</b-form-checkbox>
          <b-form-checkbox value="medicationNeed">Medication need stated by arrestee?</b-form-checkbox>
          <b-form-group v-if="hasMedicationNeed" label="Name of medication:" label-for="input-medicationName">
            <b-form-input id="input-medicationName" v-model="medicationName" @input="update"></b-form-input>
          </b-form-group>
        </b-form-checkbox-group>
        <b-form-group v-if="hasConcerns" label="Any other observations?" label-for="input-observations">
          <b-form-input id="input-observations" v-model="observations" @input="update"></b-form-input>
        </b-form-group>
      </b-card-text>
    </b-card-body>
  </div>
</template>

<script>
import YesNo from './YesNo.vue'

export default {
  components: {
    YesNo
  },
  props: ['value', 'index', 'initialTime', 'initialPlace'],
  data () {
    return {
      time: null,
      date: null,
      location: null,
      nameSupplied: null,
      name: null,
      arrestingOfficerId: null,
      hasConcerns: null,
      concerns: null,
      medicationName: null,
      observations: null
    }
  },
  watch: {
    value (val) {
        this.time = val.time
        this.date = val.date
        this.location = val.location
        this.name = val.name
        this.arrestingOfficerId = val.arrestingOfficerId
        this.concerns = val.concerns
        this.medicationName = val.medicationName
        this.observations = val.observations
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
        time: this.time,
        date: this.date,
        location: this.location,
        name: this.name,
        arrestingOfficerId: this.arrestingOfficerId,
        concerns: this.concerns,
        medicationName: this.medicationName,
        observations: this.observations,
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
    dateList () {
        return [
            { value: null, text: 'Select a date' },
            { value: '2019-10-07', text: '7 Oct' },
            { value: '2019-10-08', text: '8 Oct' },
            { value: '2019-10-09', text: '9 Oct' },
        ]
    },
    hasMedicationNeed () {
      return this.concerns != null && this.concerns.includes('medicationNeed')
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