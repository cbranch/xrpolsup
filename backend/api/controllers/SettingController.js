module.exports = {
    // Update a setting
    put: async (req, res) => {
        let {name, value} = req.allParams();
        await Setting
            .findOrCreate({name}, {name, value})
            .exec(async(err, setting, wasCreated)=> {
                if (err) { return res.serverError(err); }
                if (!wasCreated) {
                    await Setting.update({id: setting.id}).set({value});
                }
            })
        return res.ok()
    },
    get: async (req, res) => {
        let {name} = req.allParams()
        let setting = await Setting.findOne({name})
        if (!setting) {
            return res.notFound()
        } else {
            return res.ok(setting)
        }
    }
}