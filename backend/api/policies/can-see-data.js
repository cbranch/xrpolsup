module.exports = async function (req, res, proceed) {
    if (!req.me) {
      return res.unauthorized();
    }
    if (await sails.helpers.isSuspended(req)) {
      return res.forbidden();
    }
    return proceed();
  };