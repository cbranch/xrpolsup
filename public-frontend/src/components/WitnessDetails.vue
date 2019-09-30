<template>
  <b-card-body>
    <b-card-text>
      <b-form-group :label="emailLabel" description="By completing this field you give your consent to Extinction Rebellion to hold your details securely.">
        <b-form-input v-model="witnessEmail" placeholder="rebel@example.com"></b-form-input>
      </b-form-group>
    </b-card-text>
  </b-card-body>
</template>

<script>
export default {
  props: ['value', 'hasConcerns'],
  computed: {
    emailLabel () {
      if (this.hasConcerns) {
        return 'You noted concerns about one or more arrests. Please give your email address in case you are called to be a witness.'
      } else {
        return 'Please leave your email address if you wish.'
      }
    },
    witnessEmail: {
      get() {
        return this.value;
      },
      set(value) {
        this.$emit('input', value)
      },
    },
    complete () {
      return true
    }
  }
}
</script>