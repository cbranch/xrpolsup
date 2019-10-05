module.exports = {
    // A simplified report creation endpoint for public use
    post: async (req, res) => {
      let {stationName, witnessEmail, arrestees} = req.allParams();

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
        return {
          station: stationName,
          arrestTime: Date.parse(date + "T" + time + ":00"),
          location: location || "",
          name: name || "",
          arrestingOfficerId: arrestingOfficerId || "",
          concernMentalDistress: concerns.includes("mentalDistress"),
          concernPhysicalDistress: concerns.includes("physicalDistress"),
          concernMinor: concerns.includes("minor"),
          concernPoliceBehaviour: concerns.includes("policeBehaviour"),
          concernPolicePrejudice: concerns.includes("policePrejudice"),
          concernMedicationNeed: concerns.includes("medicationNeed"),
          medicationName: medicationName || "",
          observations: observations || "",
          comment: comment || "",
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