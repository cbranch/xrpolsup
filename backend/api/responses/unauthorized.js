module.exports = function unauthorized() {
  var req = this.req;
  var res = this.res;
  if (req.wantsJSON) {
    return res.sendStatus(401);
  } else {
    if (req.session.userId) {
      delete req.session.userId;
    }
    return res.redirect('/login');
  }
};