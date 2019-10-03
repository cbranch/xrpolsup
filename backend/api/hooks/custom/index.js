/**
 * @description :: The conventional "custom" hook.  Extends this app with custom server-start-time and request-time logic.
 * @docs        :: https://sailsjs.com/docs/concepts/extending-sails/hooks
 */

module.exports = function defineCustomHook(sails) {

  return {

    /**
     * Runs when a Sails app loads/lifts.
     */
    initialize: async function () {

      sails.log.info('Initializing project hook... (`api/hooks/custom/`)');

      // ... Any other app-specific setup code that needs to run on lift,
      // even in production, goes here ...

    },


    routes: {

      /**
       * Runs before every matching route.
       *
       * @param {Ref} req
       * @param {Ref} res
       * @param {Function} next
       */
      before: {
        '/*': {
          skipAssets: true,
          fn: async function(req, res, next){

            var url = require('url');

            // First, if this is a GET request (and thus potentially a view),
            // attach a couple of guaranteed locals.
            if (req.method === 'GET') {

              // The  `_environment` local lets us do a little workaround to make Vue.js
              // run in "production mode" without unnecessarily involving complexities
              // with webpack et al.)
              if (res.locals._environment !== undefined) {
                throw new Error('Cannot attach Sails environment as the view local `_environment`, because this view local already exists!  (Is it being attached somewhere else?)');
              }
              res.locals._environment = sails.config.environment;

              // The `me` local is set explicitly to `undefined` here just to avoid having to
              // do `typeof me !== 'undefined'` checks in our views/layouts/partials.
              // > Note that, depending on the request, this may or may not be set to the
              // > logged-in user record further below.
              if (res.locals.me !== undefined) {
                throw new Error('Cannot attach view local `me`, because this view local already exists!  (Is it being attached somewhere else?)');
              }
              res.locals.me = undefined;
            }//ﬁ

            // Next, if we're running in our actual "production" or "staging" Sails
            // environment, check if this is a GET request via some other host,
            // for example a subdomain like `webhooks.` or `click.`.  If so, we'll
            // automatically go ahead and redirect to the corresponding path under
            // our base URL, which is environment-specific.
            // > Note that we DO NOT redirect virtual socket requests and we DO NOT
            // > redirect non-GET requests (because it can confuse some 3rd party
            // > platforms that send webhook requests.)  We also DO NOT redirect
            // > requests in other environments to allow for flexibility during
            // > development (e.g. so you can preview an app running locally on
            // > your laptop using a local IP address or a tool like ngrok, in
            // > case you want to run it on a real, physical mobile/IoT device)
            var configuredBaseHostname;
            try {
              configuredBaseHostname = url.parse(sails.config.custom.baseUrl).host;
            } catch (unusedErr) { /*…*/}
            if ((sails.config.environment === 'staging' || sails.config.environment === 'production') && !req.isSocket && req.method === 'GET' && req.hostname !== configuredBaseHostname) {
              sails.log.info('Redirecting GET request from `'+req.hostname+'` to configured expected host (`'+configuredBaseHostname+'`)...');
              return res.redirect(sails.config.custom.baseUrl+req.url);
            }//•

            // No session? Proceed as usual.
            // (e.g. request for a static asset)
            if (!req.session) { return next(); }

            // Not logged in? Proceed as usual.
            if (!req.session.userId) { return next(); }

            // Otherwise, look up the logged-in user.
            var loggedInUser = await User.findOne({
              id: req.session.userId
            });

            // If the logged-in user has gone missing, log a warning,
            // wipe the user id from the requesting user agent's session,
            // and then send the "unauthorized" response.
            if (!loggedInUser) {
              sails.log.warn('Somehow, the user record for the logged-in user (`'+req.session.userId+'`) has gone missing....');
              delete req.session.userId;
              return res.unauthorized();
            }

            // Expose the user record as an extra property on the request object (`req.me`).
            // > Note that we make sure `req.me` doesn't already exist first.
            if (req.me !== undefined) {
              throw new Error('Cannot attach logged-in user as `req.me` because this property already exists!  (Is it being attached somewhere else?)');
            }
            req.me = loggedInUser;

            // Prevent the browser from caching logged-in users' pages.
            // (including w/ the Chrome back button)
            // > • https://mixmax.com/blog/chrome-back-button-cache-no-store
            // > • https://madhatted.com/2013/6/16/you-do-not-understand-browser-history
            res.setHeader('Cache-Control', 'no-cache, no-store');

            return next();
          }
        }
      }
    }


  };

};
