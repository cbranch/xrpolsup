<template>
  <div>
    <b-card-body>
      <b-card-text>
        <b-form-group label="Do you want to give a name or alias of the arrestee?">
          <b-form-input v-model="name" @input="update" placeholder="Full name, or alias"></b-form-input>
        </b-form-group>
        <b-form-group label="Identification number of arresting officer (if known)" label-for="input-officerId">
          <b-form-input id="input-officerId" v-model="arrestingOfficerId" @input="update" placeholder="ID"></b-form-input>
        </b-form-group>
        <b-form-group label="Do you have any concerns to report regarding this arrest?">
          <b-form-checkbox-group v-model="concerns" @input="update" stacked>
            <b-form-checkbox value="handcuffs">Handcuffs?</b-form-checkbox>
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
        </b-form-group>
        <b-form-group v-if="hasConcerns" label="Any other observations?" label-for="input-observations">
          <b-form-input id="input-observations" v-model="observations" @input="update"></b-form-input>
        </b-form-group>
        <b-form-group label="Anything else you would like us to know about this arrestee?" label-for="input-comment">
          <b-form-input id="input-comment" v-model="comment" @input="update"></b-form-input>
        </b-form-group>
      </b-card-text>
    </b-card-body>
  </div>
</template>

<script>
export default {
  components: {
  },
  props: ['value', 'index'],
  data () {
    return {
      name: null,
      arrestingOfficerId: null,
      concerns: null,
      medicationName: null,
      observations: null,
      comment: null
    }
  },
  watch: {
    value (val) {
        this.name = val.name
        this.arrestingOfficerId = val.arrestingOfficerId
        this.concerns = val.concerns
        this.medicationName = val.medicationName
        this.observations = val.observations
        this.comment = val.comment
    }
  },
  methods: {
    update () {
      this.$emit('input', {
        name: this.name,
        arrestingOfficerId: this.arrestingOfficerId,
        concerns: this.concerns,
        medicationName: this.medicationName,
        observations: this.observations,
        comment: this.comment,
      })
    },
    validate () {
      return true
    }
  },
  computed: {
    hasConcerns () {
      return this.concerns != null && this.concerns.length > 0
    },
    hasMedicationNeed () {
      return this.concerns != null && this.concerns.includes('medicationNeed')
    }
  }
}
</script>