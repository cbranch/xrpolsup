module.exports = async function (req, res, proceed) {
  if (!req.me) {
    return res.unauthorized();
  }
  if (!req.me.isSuperuser) {
    return res.forbidden();
  }
  return proceed();
};