<template>
  <div>
    <b-card-body>
      <b-card-text>
        <p>How many arrests are you reporting?</p>
        <b-form-input v-model="arresteeCount" type="number"></b-form-input>
      </b-card-text>
    </b-card-body>
    <ArrestDetails v-for="(arrestee, index) in value" :key="index" v-bind:index="index" v-model="arrestee.details" @input="checkIfComplete" ref="arrestDetails" />
  </div>
</template>

<script>
import ArrestDetails from './ArrestDetails.vue'

export default {
  components: {
    ArrestDetails
  },
  props: ['value'],
  created () {
    if (this.value == null || this.value.length == 0) {
      this.$emit('input', [{ details: {} }])
    }
  },
  computed: {
    arresteeCount: {
      get() {
        return this.value != null ? this.value.length : 0
      },
      set(value) {
        let arrestees = this.value.splice(length)
        while (value > arrestees.length) {
          arrestees.push({ details: {} })
        }
        this.$emit('input', arrestees)
      }
    },
    complete () {
      return this.$refs.arrestDetails.every(x => x.complete)
    }
  },
  methods: {
    validate () {
      return this.$refs.arrestDetails.every(x => {
        return x.validate()
      })
    },
    checkIfComplete () {
      if (this.complete) {
        this.$emit('complete')
      }
    }
  }
}
</script>