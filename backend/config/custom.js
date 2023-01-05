/**
 * Custom configuration
 * (sails.config.custom)
 *
 * One-off settings specific to your application.
 *
 * For more information on custom configuration, visit:
 * https://sailsjs.com/config/custom
 */

module.exports.custom = {

  /***************************************************************************
  *                                                                          *
  * Any other custom config this Sails app should use during development.    *
  *                                                                          *
  ***************************************************************************/

  defaultLoginCookieMaxAge: 12*60*60*1000, // 12 hours
  rememberMeCookieMaxAge: 30*24*60*60*1000, // 30 days
  maximumReportAge: 28*24*60*60*1000, // 28 days
  killSwitchToken: "ZZZ",
  baseHostname: "arrestwatch.info",

};
