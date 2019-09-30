<template>
  <b-card no-body v-bind:header="cardTitle">
    <slot></slot>
  </b-card>
</template>

<script>
export default {
  props: ['index', 'title'],
  computed: {
    cardTitle () {
      return this.index + '. ' + this.title
    }
  }
}
</script>