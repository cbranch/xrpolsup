module.exports = {
    destroy: async (req, res) => {
        let user = await User
            .findOne({id: req.params.id})
            .catch(error => res.serverError(error));

        if (!user) {
            return res.notFound('unknown user ID');
        }

        if (user.isAdmin) {
            return res.forbidden('not allowed to delete that user');
        }

        await User
            .destroy({id: user.id})
            .catch(error => res.serverError(error))

        return res.ok()
    }
}