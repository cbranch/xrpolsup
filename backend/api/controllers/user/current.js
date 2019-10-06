module.exports = {

  friendlyName: 'Get current user',

  description: 'Get the currently logged-in user.',

  fn: async function () {
    var sanitizedUser = _.extend({}, this.req.me);
    for (let attrName in User.attributes) {
      if (User.attributes[attrName].protect) {
        delete sanitizedUser[attrName];
      }
    }
    return sanitizedUser
  }
};
