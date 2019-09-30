<template>
  <div>
    <b-card-body>
        <b-card-text>
            <b-form-group label="Thank you for reporting arrests. Do you know which police station the arrestees have been taken to?">
                <YesNo v-model="stationKnown" />
            </b-form-group>
            <b-form-group v-if="stationKnown === true" label="What is the station name?">
              <b-form-input v-model="stationName" placeholder="Station name"></b-form-input>
            </b-form-group>
            <b-form-group v-if="stationKnown === true">
              <b-button variant="outline-primary" v-if="stationName != ''" v-on:click="$emit('complete')">Next</b-button>
            </b-form-group>
            <b-form-group v-if="stationKnown === false" label="Can you find out?">
              <YesNo v-model="stationToBeFoundOut" @answered-no="$emit('complete')" />
            </b-form-group>
        </b-card-text>
    </b-card-body>
    <b-card-body v-if="stationKnown === false && stationToBeFoundOut === true">
        <b-card-text>
            <p><strong>Please stop this process and try again later.</strong></p>
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
  props: ['value'],
  data () {
    return {
      stationKnown: null,
      stationToBeFoundOut: null,
    }
  },
  computed: {
    stationName: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit('input', value)
      },
    },
    complete () {
      return this.value != "" || this.stationToBeFoundOut === false
    }
  }
}
</script>