module.exports = {
    // A simplified release report creation endpoint for public use
    post: async (req, res) => {
      let {
        name,
        time,
        date,
        location,
        offence,
        termsOfRelease,
        charges,
        bailConditions,
        courtDate,
        courtLocation,
        policeStation,
        localXRGroup,
        nearestCity,
        anyInjuries,
        adverseEvents,
        heldMoreThan24Hours,
        helpNeeded,
        specialRequest,
        numberRebels,
        rebelsStillHeld,
        contactByEmail,
        contactByPhone,
        canShareWithLocalXRGroup,
      } = req.allParams();

      if (name == "") { return res.badRequest('name is a required field'); }
      if (time.length == 4) {
        time = "0" + time
      }
      var arrestTime = Date.parse(date + "T" + time + ":00")
      if (isNaN(arrestTime)) { return res.badRequest('time and date must be valid'); }

      const release = await Release
        .create({
          name,
          arrestTime,
          location: location || "",
          offence: offence || "",
          termsOfRelease: termsOfRelease || "",
          charges: charges || "",
          bailConditions: bailConditions || "",
          courtDate: courtDate || "",
          courtLocation: courtLocation || "",
          policeStation: policeStation || "",
          localXRGroup: localXRGroup || "",
          nearestCity: nearestCity || "",
          injuries: anyInjuries || "",
          adverseEvents: adverseEvents || "",
          heldMoreThan24Hours: heldMoreThan24Hours || false,
          helpNeeded: helpNeeded || "",
          specialRequest: specialRequest || "",
          numberRebels: numberRebels || 0,
          rebelsStillHeld: rebelsStillHeld || 0,
          email: contactByEmail || "",
          phone: contactByPhone || "",
          canShareWithLocalXRGroup: canShareWithLocalXRGroup || false,
        })
        .fetch()
        .catch(error => res.serverError(error))

      sails.log.info(`Published release`, release)
      Release._publishCreate(release, req)
  
      return res.ok()
    },
  }