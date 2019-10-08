module.exports = {

  friendlyName: 'Killswitch',

  description: 'Terminate the app.',

  inputs: {
    token: {
      type: 'string',
      required: true
    }
  },

  exits: {

    success: {
      description: 'Bye!'
    },

    badToken: {
      description: 'The token was incorrect.',
      responseType: 'unauthorized'
    }

  },

  fn: async function (inputs) {
    if (inputs.token !== sails.config.custom.killSwitchToken) {
      throw 'badToken'
    }
    process.exit(0)
  }

};
