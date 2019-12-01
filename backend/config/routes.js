/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes tell Sails what to do each time it receives a request.
 *
 * For more information on configuring custom routes, check out:
 * https://sailsjs.com/anatomy/config/routes-js
 */

function setUpdatedAtMinimumTime(criteria) {
  const threshold = Date.now() - (1000*60*60*30);
  const query = {'>=': threshold};
  if ('updatedAt' in criteria.where) {
    criteria.where.and = [
      { 'updatedAt': criteria.where['updatedAt'] },
      { 'updatedAt': query },
    ]
    delete criteria.where['updatedAt']
  } else {
    criteria.where['updatedAt'] = query
  }
}

module.exports.routes = {

  /***************************************************************************
  *                                                                          *
  * Make the view located at `views/homepage.ejs` your home page.            *
  *                                                                          *
  * (Alternatively, remove this and add an `index.html` file in your         *
  * `assets` directory)                                                      *
  *                                                                          *
  ***************************************************************************/

  'POST /api/v1/station_report': 'ReportController.post',
  'POST /api/v1/arrestee_report': 'ReleaseController.post',

  'GET /api/v1/user/current': { action: 'user/current' },
  'PUT /api/v1/user/change_password': { action: 'user/change-password' },
  'POST /api/v1/login': { action: 'login' },
  'POST /api/v1/logout': { action: 'logout' },

  'PUT /api/v1/user/:id/set_password': { action: 'user/set-password' },
  'POST /api/v1/killswitch': { action: 'killswitch' },

  'GET /api/v1/report': {
    action: 'report/find',
    parseBlueprintOptions: function (req) {
      var queryOptions = req._sails.hooks.blueprints.parseBlueprintOptions(req);
      setUpdatedAtMinimumTime(queryOptions.criteria)
      return queryOptions;
    },
  },

};
