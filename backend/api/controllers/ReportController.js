module.exports = {
    // A simplified report creation endpoint for public use
    post: async (req, res) => {
      const {arrestTime, station, numberOfArrestees} = req.allParams();

      const report = await Report
        .create({arrestTime, station, numberOfArrestees})
        .fetch()
        .catch(error => res.serverError(error))

      sails.log.info('New external report', report)
      Report._publishCreate(report, req)
  
      return res.ok()
    },
  }