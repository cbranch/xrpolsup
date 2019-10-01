module.exports = async function (req, res, proceed) {
  if (!req.me) {
    return res.unauthorized();
  }
  if (!req.me.isAdmin) {
    return res.forbidden();
  }
  return proceed();
};