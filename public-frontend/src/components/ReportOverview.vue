<template>
  <div>
    <b-card-body>
      <b-card-text>
        <b-form-group label="Thank you for reporting arrests. Are you reporting somebody else's arrest or your own arrest?">
          <b-button variant="outline-secondary" @click="ownArrest = false" :pressed="ownArrest === false">Somebody else's arrest</b-button>&nbsp;
          <b-button variant="outline-secondary" @click="ownArrest = true" :pressed="ownArrest">My own</b-button>
        </b-form-group>
        <p v-if="ownArrest">Please use <a href="/pss">this form for reporting your own arrest and release</a>.</p>
        <b-form-group v-if="ownArrest === false" label="Do you know which police station the arrestees have been taken to?">
          <YesNo v-model="stationKnown" />
        </b-form-group>
        <b-form-group v-if="stationKnown === true" label="What is the station name?">
          <StationSearch v-model="stationName"></StationSearch>
        </b-form-group>
        <b-form-group v-if="stationKnown === false" label="Can you find out?">
          <YesNo v-model="stationToBeFoundOut" />
        </b-form-group>
        <p v-if="stationKnown === false && stationToBeFoundOut === true">If you find out later please ring us with that information or fill out the form again, but continue for now with the info you have.</p>
        <div v-if="stationKnown === true || stationToBeFoundOut != null">
          <b-form-group label="How many arrests are you reporting?">
            <b-form-radio-group v-model="isMassArrest" :invalid-feedback="isValidArrestCount.reason" :state="isValidArrestCount.valid">
              <b-form-radio name="arrests-reported" value="1">Single arrest</b-form-radio>
              <b-form-radio name="arrests-reported" value="2">More than one</b-form-radio>
            </b-form-radio-group>
          </b-form-group>
          <b-form-group v-if="isMassArrest == '2'" label="How many?" :invalid-feedback="isValidArrestCount.reason" :state="isValidArrestCount.valid">
            <b-form-input v-model="arrestCount" type="number"></b-form-input>
          </b-form-group>
          <b-form-group label="When did this arrest take place?" label-for="input-datetime" :invalid-feedback="isValidDatetime.reason" :state="isValidDatetime.valid">
            <datetime id="input-datetime" type="datetime" input-class="form-control" v-model="datetime" :state="isValidDatetime.valid" :max-datetime="new Date().toISOString()" />
          </b-form-group>
          <b-form-group label="Where did this arrest take place?" label-for="input-location" :invalid-feedback="isValidLocation.reason" :state="isValidLocation.valid">
            <b-form-input id="input-location" v-model="location" :state="isValidLocation.valid" placeholder="Place name"></b-form-input>
          </b-form-group>
          <b-form-group label="So that we can co-ordinate support for arrested people it is helpful to know what group called the protest where the arrest took place.">
            <b-form-radio-group v-model="actionGroupChoice" :invalid-feedback="isValidActionGroup.reason" :state="isValidActionGroup.valid">
              <b-form-radio name="action-group" value="XR">XR</b-form-radio>
              <b-form-radio name="action-group" value="Other">Other Group</b-form-radio>
            </b-form-radio-group>
            <b-form-input placeholder="Which group?" v-model="actionGroupOther" v-if="actionGroupChoice == 'Other'"></b-form-input>
          </b-form-group>
          <b-form-group label="Please leave your email address if you wish to be contacted." description="By completing this field you give your consent to the Scottish Community & Activist Legal Project holding your details securely.">
            <b-form-input v-model="witnessEmail" type="email"></b-form-input>
          </b-form-group>
          <b-form-group>
            <b-button variant="outline-primary" @click="submit">Enter arrestee details</b-button>
          </b-form-group>
        </div>
      </b-card-text>
    </b-card-body>
  </div>
</template>

<script>
import YesNo from './YesNo.vue'
import StationSearch from './StationSearch.vue'

export default {
  components: {
    YesNo,
    StationSearch,
  },
  props: ['value'],
  data () {
    return {
      ownArrest: null,
      stationKnown: null,
      stationToBeFoundOut: null,
      actionGroupChoice: null,
      actionGroupOther: null,
    }
  },
  computed: {
    localValue () {
      return this.value ? this.value : {
        stationName: null,
        witnessEmail: null,
        arrestCount: null,
        datetime: null,
        location: null,
        actionGroup: null,
      }
    },
    stationName: {
      get() {
        return this.localValue.stationName
      },
      set(value) {
        this.$emit('input', { ...this.localValue, stationName: value })
      },
    },
    witnessEmail: {
      get() {
        return this.localValue.witnessEmail
      },
      set(value) {
        this.$emit('input', { ...this.localValue, witnessEmail: value })
      },
    },
    isMassArrest: {
      get() {
        return this.localValue.isMassArrest
      },
      set(value) {
        var acount = this.arrestCount
        if (value == "1") {
          acount = 1
        }
        this.$emit('input', { ...this.localValue, isMassArrest: value, arrestCount: acount })
      },
    },
    arrestCount: {
      get() {
        return this.localValue.arrestCount
      },
      set(value) {
        this.$emit('input', { ...this.localValue, arrestCount: value })
      },
    },
    isValidArrestCount () {
      if (this.arrestCount == null) {
        return { valid: null }
      } else if (this.arrestCount < 1) {
        return { valid: false, reason: 'Please enter at least 1 arrest' }
      } else {
        return { valid: true }
      }
    },
    datetime: {
      get() {
        return this.localValue.datetime
      },
      set(value) {
        this.$emit('input', { ...this.localValue, datetime: value })
      },
    },
    isValidDatetime () {
      if (this.datetime == null) {
        return { valid: null }
      } else if (this.datetime == '') {
        return { valid: false, reason: 'Please select a date and time' }
      } else {
        return { valid: true }
      }
    },
    location: {
      get() {
        return this.localValue.location
      },
      set(value) {
        this.$emit('input', { ...this.localValue, location: value })
      },
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
    actionGroup: {
      get() {
        if (this.actionGroupChoice == 'Other') {
          return this.actionGroupOther
        } else {
          return this.actionGroupChoice
        }
      },
    },
    isValidActionGroup () {
      if (this.actionGroupChoice == null) {
        return { valid: null }
      } else if (this.actionGroupChoice == '') {
        return { valid: false, reason: 'Please pick the group' }
      } else {
        return { valid: true }
      }
    },
    valid () {
      return this.isValidArrestCount.valid && this.isValidDatetime.valid && this.isValidLocation.valid
    }
  },
  watch: {
    actionGroupChoice: function () {
      this.$emit('input', { ...this.localValue, actionGroup: this.actionGroup })
    },
    actionGroupOther: function () {
      this.$emit('input', { ...this.localValue, actionGroup: this.actionGroup })
    }
  },
  methods: {
    submit () {
      var setDefaults = {}
      if (this.arrestCount == null) {
        setDefaults.arrestCount = 0
      }
      if (this.datetime == null) {
        setDefaults.datetime = ''
      }
      if (this.location == null) {
        setDefaults.location = ''
      }
      if (Object.keys(setDefaults).length > 0) {
        this.$emit('input', { ...this.localValue, ...setDefaults })
      } else if (this.valid) {
        this.$emit('complete')
      }
    }
  }
}
</script>