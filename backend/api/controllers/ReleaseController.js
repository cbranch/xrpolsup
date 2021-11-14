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
        accusedOf,
        plea,
        furtherHearings,
        solicitor,
        policeStation,
        nearestCity,
        anyInjuries,
        interviewedByPolice,
        spokeToSolicitor,
        adverseEvents,
        heldMoreThan24Hours,
        helpNeeded,
        specialRequest,
        numberRebels,
        askedToContactSCALP,
        contactRefusalReason,
        otherComments,
        contactByEmail,
        contactByPhone,
        actionGroup,
        xrRegion,
      } = req.allParams();

      if (name == "") { return res.badRequest('name is a required field'); }
      if (time.length == 4) {
        time = "0" + time
      }
      var arrestTime = date + "T" + time + ":00"

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
          accusedOf: accusedOf || "",
          plea: plea || "",
          furtherHearings: furtherHearings || "",
          solicitor: solicitor || "",
          policeStation: policeStation || "",
          nearestCity: nearestCity || "",
          injuries: anyInjuries || "",
          interviewedByPolice: interviewedByPolice || false,
          spokeToSolicitor: spokeToSolicitor || "",
          adverseEvents: adverseEvents || "",
          heldMoreThan24Hours: heldMoreThan24Hours || false,
          helpNeeded: helpNeeded || "",
          specialRequest: specialRequest || "",
          numberRebels: numberRebels || 0,
          askedToContactSCALP: askedToContactSCALP || false,
          contactRefusalReason: contactRefusalReason || "",
          otherComments: otherComments || "",
          email: contactByEmail || "",
          phone: contactByPhone || "",
          actionGroup: actionGroup || "",
          xrRegion: xrRegion || "",
        })
        .fetch()
        .catch(error => res.serverError(error))

      sails.log.info(`Published release`, release)
      Release._publishCreate(release, req)
  
      return res.ok()
    },
  }