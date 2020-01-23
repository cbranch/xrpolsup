<template>
  <b-container>
    <b-row class="mb-2">
      <b-col>
        <h2 class="my-3">XR Legal Support Plea Hearing</h2>
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
        <FormText id="input-name" v-model="name" label="Name" />
        <FormText id="input-email" v-model="email" label="Email address" />
        <FormText id="input-phone" v-model="phone" label="Phone number" />
        <FormText id="input-hometown" v-model="hometown" label="Home town" />
        <FormText id="input-charge" v-model="charge" label="Charge" />
        <FormText id="input-lawfirm" v-model="lawFirm" label="Law firm (or self rep)" />
        <b-form-group id="input-consent-to-contact" label="Are you happy for us to contact you by phone/email?">
          <b-form-radio-group v-model="consentToContact" :state="cannotBeNull(consentToContact)">
            <b-form-radio :value="true">Yes</b-form-radio>
            <b-form-radio :value="false">No</b-form-radio>
            <b-form-invalid-feedback :state="cannotBeNull(consentToContact)">Please select a value.</b-form-invalid-feedback>
          </b-form-radio-group>
        </b-form-group>
        <b-form-group id="input-can-share-with-local-group" label="May we share your details with your local XR group?">
          <b-form-radio-group v-model="canShareWithLocalXRGroup" :state="cannotBeNull(canShareWithLocalXRGroup)">
            <b-form-radio :value="true">Yes</b-form-radio>
            <b-form-radio :value="false">No</b-form-radio>
            <b-form-invalid-feedback :state="cannotBeNull(canShareWithLocalXRGroup)">Please select a value.</b-form-invalid-feedback>
          </b-form-radio-group>
        </b-form-group>
        <b-form-group id="input-consent-to-record" label="We are keeping a record of plea hearing outcomes to organise support for future trial dates, keep track of events, and inform you of any updates">
          <b-form-radio-group v-model="consentToRecord" label="Are you happy to be on this database?" :state="cannotBeNull(consentToRecord)">
            <b-form-radio :value="true">Yes</b-form-radio>
            <b-form-radio :value="false">No</b-form-radio>
            <b-form-invalid-feedback :state="cannotBeNull(consentToRecord)">Please select a value.</b-form-invalid-feedback>
          </b-form-radio-group>
        </b-form-group>
        <b-form-group id="input-consent-to-press" label="The XR PRESS TEAM can offer advice on dealing with media attention, and can facilitate getting your story heard if that is what you want">
          <b-form-radio-group v-model="consentToPress" label="Are you happy for the Press Team to contact you?" :state="cannotBeNull(consentToPress)">
            <b-form-radio :value="true">Yes</b-form-radio>
            <b-form-radio :value="false">No</b-form-radio>
            <b-form-invalid-feedback :state="cannotBeNull(consentToPress)">Please select a value.</b-form-invalid-feedback>
          </b-form-radio-group>
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
import FormText from './FormText.vue'

function requireValue(x, emptyReason) {
  if (x === undefined) {
    return { valid: null }
  } else if (x === null) {
    return { valid: false, reason: emptyReason }
  } else {
    return { valid: true }
  }
}
export default {
  name: 'PleaHearing',
  components: {
    FormText
  },
  data () {
    return {
      name: null,
      email: null,
      phone: null,
      hometown: null,
      charge: null,
      lawFirm: null,
      consentToContact: undefined,
      canShareWithLocalXRGroup: undefined,
      consentToRecord: undefined,
      consentToPress: undefined,
      submitted: false,
      isSubmitting: false,
      errors: [],
    }
  },
  computed: {
    isConsentToContactValid () {
      return requireValue(this.consentToContact, 'A court name must be provided.')
    },
  },
  methods: {
    cannotBeNull (x) {
      if (x === undefined) {
        return null
      } else if (x === null) {
        return false
      } else {
        return true
      }
    },
    ensureDefined (propName, defaultValue) {
      if (this[propName] === undefined) {
        this[propName] = defaultValue
      }
      return this.cannotBeNull(this[propName])
    },
    validate () {
      this.ensureDefined('name', '')
      this.ensureDefined('email', '')
      this.ensureDefined('phone', '')
      this.ensureDefined('hometown', '')
      this.ensureDefined('charge', '')
      this.ensureDefined('lawFirm', '')
      return this.checkValues([
        [this.ensureDefined('consentToContact', null), '#input-consent-to-contact'],
        [this.ensureDefined('canShareWithLocalXRGroup', null), '#input-can-share-with-local-group'],
        [this.ensureDefined('consentToRecord', null), '#input-consent-to-record'],
        [this.ensureDefined('consentToPress', null), '#input-consent-to-press'],
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
        name: this.name,
        email: this.email,
        phone: this.phone,
        hometown: this.hometown,
        charge: this.charge,
        lawFirm: this.lawFirm,
        consentToContact: this.consentToContact,
        canShareWithLocalXRGroup: this.canShareWithLocalXRGroup,
        consentToRecord: this.consentToRecord,
        consentToPress: this.consentToPress,
      }
      this.isSubmitting = true
      this.axios.post('/api/v2/plea_hearing', report).then(() => {
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
