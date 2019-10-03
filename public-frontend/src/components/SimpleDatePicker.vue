<template>
  <b-form-select ref="picker" :id="id" :value="value" @input="$emit('input', $event)" :state="state" :options="dateList"></b-form-select>
</template>

<script>
export default {
  props: ['id', 'value', 'state'],
  computed: {
    dateList () {
      var dates = [
        { value: null, text: 'Select a date' },
      ];
      var currentDate = new Date();
      for (var i = 0; i < 14; i++) {
          var date = new Date();
          date.setTime(currentDate.getTime()-(i*24*3600000));
          dates.push({
              value: date.toISOString().substring(0, 10),
              text: date.toLocaleDateString('en-GB', {month: 'long', day: 'numeric'}),
          })
      }
      return dates
    },
  }
}
</script>