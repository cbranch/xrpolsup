module.exports = {
    attributes: {
      comment: { type: 'string' },
      name: { type: 'string' },
      createdBy: { model: 'user' },
      isHidden: { type: 'boolean', defaultsTo: false },
    },
  };