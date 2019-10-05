module.exports = {
    attributes: {
      name: { type: 'string' },
      phone: { type: 'string' },
      onShift: { type: 'boolean', defaultsTo: false },
      createdBy: { model: 'user' },
      isHidden: { type: 'boolean', defaultsTo: false },
    },
  };