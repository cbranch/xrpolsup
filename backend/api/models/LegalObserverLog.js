module.exports = {
    attributes: {
      name: { type: 'string' },
      phone: { type: 'string' },
      onShift: { type: 'boolean', defaultsTo: false },
      createdBy: { model: 'user' },
      location: { type: 'string' },
      comment: { type: 'string' },
      isHidden: { type: 'boolean', defaultsTo: false },
    },
  };