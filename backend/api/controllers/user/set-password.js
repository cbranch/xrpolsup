module.exports = {

  friendlyName: 'Set password',

  description: 'Set the password for a user.',

  inputs: {
    id: {
      description: 'The user ID.',
      type: 'number',
      required: true
    },
    password: {
      description: 'The new, unencrypted password.',
      example: 'abc123v2',
      required: true
    }
  },

  fn: async function (inputs) {
    // Hash the new password.
    var hashed = await sails.helpers.passwords.hashPassword(inputs.password);
    // Update the record for the logged-in user.
    await User
        .updateOne({ id: inputs.id })
        .set({ password: hashed });
  }
};
