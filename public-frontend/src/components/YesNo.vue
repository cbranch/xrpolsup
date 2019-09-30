<template>
  <div>
    <b-button variant="outline-secondary" v-on:click="$emit('input', true); $emit('answered-yes')" v-bind:pressed="value === true">Yes</b-button>&nbsp;
    <b-button variant="outline-secondary" v-on:click="$emit('input', false); $emit('answered-no')" v-bind:pressed="value === false">No</b-button>
  </div>
</template>

<script>
export default {
  props: ['value']
}
</script>