module.exports = {

  friendlyName: 'Change password',

  description: 'Change the logged-in user\'s password.',

  inputs: {
    oldPassword: {
      description: 'The old, unencrypted password.',
      example: 'abc123v1',
      required: true
    },
    newPassword: {
      description: 'The new, unencrypted password.',
      example: 'abc123v2',
      required: true
    }
  },

  exits: {

    success: {
      description: 'The password was successfully changed.',
    },

    badCombo: {
      description: `The old password does not match.`,
      responseType: 'unauthorized'
    }

  },

  fn: async function (inputs) {
    // Look up again (we do this in the middleware but we strip out the password)
    var userRecord = await User.findOne({ id: this.req.me.id });

    // If there was no matching user, respond thru the "badCombo" exit.
    if(!userRecord) {
      throw 'badCombo';
    }

    // If the password doesn't match, then also exit thru "badCombo".
    await sails.helpers.passwords.checkPassword(inputs.oldPassword, userRecord.password)
    .intercept('incorrect', 'badCombo');
    // Hash the new password.
    var hashed = await sails.helpers.passwords.hashPassword(inputs.newPassword);
    // Update the record for the selected user.
    await User
        .updateOne({ id: userRecord.id })
        .set({ password: hashed });
  }
};
