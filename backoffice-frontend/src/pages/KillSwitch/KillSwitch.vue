<template>
   <b-container>
       <h2>Kill switch</h2>
       <p>Really kill?</p>
       <b-button block variant="danger" @click="shutDown">Shut it down!</b-button>
       <b-alert :show="error">{{ error }}</b-alert>
   </b-container>
</template>

<script>
export default {
    data: () => ({
        error: null,
    }),
    methods: {
        shutDown () {
            const token = window.location.pathname.replace(/^\/killswitch\//, "")
            this.axios.post('/api/v1/killswitch', {token}).then(() => {
                window.alert("Success?")
            }, error => {
                this.error = error.response.data
            })
        }
    }
}
</script>