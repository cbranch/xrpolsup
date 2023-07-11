module.exports = {
    friendlyName: 'Format welcome message',
    description: 'Return a personalized greeting based on the provided name.',
    inputs: {
      req: {
        type: 'ref',
        description: 'The current incoming request (req).',
        required: true
      }
    },
    fn: async function (inputs, exits) {
      if (inputs.req.me) {
        if (inputs.req.me.isSuperuser) {
          return exits.success(false)
        }
      }
      let setting = await Setting.findOne({name: 'suspend'})
      return exits.success(setting && setting.value == "true")
    }
  };