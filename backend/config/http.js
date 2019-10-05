/**
 * HTTP Server Settings
 * (sails.config.http)
 *
 * Configuration for the underlying HTTP server in Sails.
 * (for additional recommended settings, see `config/env/production.js`)
 *
 * For more information on configuration, check out:
 * https://sailsjs.com/config/http
 */

var serveStatic = require('serve-static')

module.exports.http = {

  /****************************************************************************
  *                                                                           *
  * Sails/Express middleware to run for every HTTP request.                   *
  * (Only applies to HTTP requests -- not virtual WebSocket requests.)        *
  *                                                                           *
  * https://sailsjs.com/documentation/concepts/middleware                     *
  *                                                                           *
  ****************************************************************************/

  middleware: {

    /* Route subdomains to different folders.
     * The main URL should show the public assets.
     * The backoffice domain should show the back office assets.
     */
    routedWww: (function() {
      const maxAge = 90 * 24 * 60 * 60 * 1000;
      var publicMiddleware = serveStatic('.tmp/public/public', { maxAge });
      var backofficeMiddleware = serveStatic('.tmp/public/backoffice', { maxAge });

      return function (req,res,next) {
        if (req.hostname == 'arrestwatch.info' || req.hostname == 'staging.arrestwatch.info') {
          return publicMiddleware(req, res, next);
        } else if (req.hostname == 'backoffice.arrestwatch.info' || req.hostname == 'backoffice.staging.arrestwatch.info') {
          return backofficeMiddleware(req, res, next);
        } else {
          return next();
        }
      };
    })(),

    connectHistoryApiFallback: require('connect-history-api-fallback')({
      rewrites: [
        { from: /\/arrestee$/, to: '/arrestee.html'}
      ]
    }),

    /***************************************************************************
    *                                                                          *
    * The order in which middleware should be run for HTTP requests.           *
    * (This Sails app's routes are handled by the "router" middleware below.)  *
    *                                                                          *
    ***************************************************************************/

    order: [
      'cookieParser',
      'session',
      'bodyParser',
      'compress',
      'poweredBy',
      'router',
      'connectHistoryApiFallback',
      'routedWww',
      'favicon',
    ],


    /***************************************************************************
    *                                                                          *
    * The body parser that will handle incoming multipart HTTP requests.       *
    *                                                                          *
    * https://sailsjs.com/config/http#?customizing-the-body-parser             *
    *                                                                          *
    ***************************************************************************/

    // bodyParser: (function _configureBodyParser(){
    //   var skipper = require('skipper');
    //   var middlewareFn = skipper({ strict: true });
    //   return middlewareFn;
    // })(),

  },

};
