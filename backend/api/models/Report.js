module.exports = {
    attributes: {
      arrestTime: { type: 'string', required: true },
      station: { type: 'string', required: true },
      numberOfArrestees: { type: 'number', required: true },
      isHidden: { type: 'boolean', defaultsTo: false },
    },
  };