/**
 * Policy Mappings
 * (sails.config.policies)
 *
 * Policies are simple functions which run **before** your actions.
 *
 * For more information on configuring policies, check out:
 * https://sailsjs.com/docs/concepts/policies
 */

module.exports.policies = {

  /***************************************************************************
  *                                                                          *
  * Default policy for all controllers and actions, unless overridden.       *
  * (`true` allows public access)                                            *
  *                                                                          *
  ***************************************************************************/

  '*': 'is-logged-in',
  // Release report view/managerment needs special permission
  'release/*': 'can-see-release',
  // User management is for admins only
  'user/*': 'is-admin',
  // ...except for seeing the current user
  'user/current': 'is-logged-in',
  'user/change-password': 'is-logged-in',

  // No login required for the following:
  'ReportController': {
    'post': true,
  },
  'ReleaseController': {
    'post': true,
  },
  'login': true,
  'logout': true,
  'killswitch': true,

};
