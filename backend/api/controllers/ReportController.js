module.exports = {
    findOne: async (req, res) => {
      const report = await Report
        .findOne({id: req.param('id')})
        .catch(error => res.serverError(error))

      if (!report) {
        return res.notFound()
      }

      if (report.updatedAt < (Date.now() - sails.config.custom.maximumReportAge)) {
        return res.notFound()
      }

      if (req._sails.hooks.pubsub && req.isSocket) {
        Report.subscribe(req, [report.id])
      }

      return res.ok(report)
    },

    // A simplified report creation endpoint for public use
    post: async (req, res) => {
      let {stationName, witnessEmail, arrestees, actionGroup} = req.allParams();

      if (stationName == null) {
        stationName = ""
      }

      if (witnessEmail == null) {
        witnessEmail = ""
      }

      const witness = await Witness
        .create({witnessEmail})
        .fetch()
        .catch(error => res.serverError(error))

      let newRecords = arrestees.map(x => {
        let {time, date, location, name, arrestingOfficerId, concerns, medicationName, observations, comment} = x;
        concerns = concerns || []
        if (time.length == 4) {
          time = "0" + time
        }
        return {
          station: stationName,
          arrestTime: date + "T" + time + ":00",
          location: location || "",
          name: name || "",
          arrestingOfficerId: arrestingOfficerId || "",
          concernMentalDistress: concerns.includes("mentalDistress"),
          concernPhysicalDistress: concerns.includes("physicalDistress"),
          concernMinor: concerns.includes("minor"),
          concernMinorUnderSixteen: concerns.includes("minorUnderSixteen"),
          concernPoliceBehaviour: concerns.includes("policeBehaviour"),
          concernPolicePrejudice: concerns.includes("policePrejudice"),
          concernMedicationNeed: concerns.includes("medicationNeed"),
          medicationName: medicationName || "",
          concernHandcuffs: concerns.includes("handcuffs"),
          observations: observations || "",
          comment: comment || "",
          actionGroup: actionGroup || "",
          witness: witness.id,
        }
      })
      sails.log.info(`Received ${newRecords.length} reports`)

      const reports = await Report
          .createEach(newRecords)
          .fetch()
          .catch(error => res.serverError(error))

      reports.forEach(report => {
        sails.log.info(`Published report`, report)
        Report._publishCreate(report, req)
      })
  
      return res.ok()
    },
  }