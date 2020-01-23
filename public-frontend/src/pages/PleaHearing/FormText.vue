<template>
    <b-form-group :id="id" :label="label" :label-for="labelId" label-cols-lg="3">
        <b-form-input :id="labelId" :value="value" @input="$emit('input', arguments[0])"></b-form-input>
    </b-form-group>
</template>
<script>
export default {
    props: ['value', 'id', 'label'],
    computed: {
        labelId () {
            return this.id + "-formtext-input"
        }
    }
};
</script>