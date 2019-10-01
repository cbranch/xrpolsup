/**
 * A user who can log in to this application.
 */

module.exports = {
  attributes: {
    emailAddress: {
      type: 'string',
      required: true,
      unique: true,
      isEmail: true,
      maxLength: 200,
      example: 'rebel@example.com'
    },
    password: {
      type: 'string',
      required: true,
      description: 'Securely hashed representation of the user\'s login password.',
      protect: true,
      example: '2$28a8eabna301089103-13948134nad'
    },
    nickname: {
      type: 'string',
      required: true,
      description: 'Nickname for this user.',
      maxLength: 120,
      example: 'Rebel'
    },
    expires: {
      type: 'number',
      description: 'An expiry time after which this user cannot log in.',
      example: 1502844074211
    },
    isAdmin: {
      type: 'boolean',
      description: 'Whether this user is an admin that can change other users.',
    },
  },
};